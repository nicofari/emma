using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Tabelle_FmCompila : System.Web.UI.Page
{
  protected void Page_Load(object sender, EventArgs e)
  {
    if (!IsPostBack)
      resetData();
  }

  private void resetData()
  {
    DALRuntime.iDomanda = 0;
    DALRuntime.tblDomande = null;
    DALRuntime.IdMQuest = 0;
    DALRuntime.IdAQuest = 0;
    lstPazienti.DataSource = DALRuntime.getPazienti();
    lstPazienti.DataBind();
    lstQuestionari.DataSource = DALRuntime.getQuestionari();
    lstQuestionari.DataBind();
    DevExUtility.PanelApplyTheme(pnlInizio, DALRuntime.globalTheme);
    DevExUtility.PanelApplyTheme(pnlDomanda, DALRuntime.globalTheme);
    DevExUtility.PanelApplyTheme(pnlCompletato, DALRuntime.globalTheme);
    // Forza selezione primo questionario
    lstQuestionari.SelectedIndex = 0;
    showPanelCompletato(false);
  }

  /// <summary>
  /// Inizio questionario
  /// </summary>
  /// <param name="sender"></param>
  /// <param name="e"></param>
  protected void btnAvanti1_Click(object sender, EventArgs e)
  {
    if (lstPazienti.SelectedIndex < 0)
      setAvviso1("Selezionare un paziente!");
    else
    {
      // Salva in sessione id questionario scelto
      DALRuntime.IdAQuest = Convert.ToInt32(lstQuestionari.SelectedItem.Value.ToString());
      // Salva in sessione numero di domande del questionario idAQuest
      DALRuntime.iNumDomande = DALRuntime.getNumDomande(DALRuntime.IdAQuest);
      DALRuntime.setRecPaziente(Convert.ToInt32(lstPazienti.SelectedItem.Value.ToString()));
      // Salva in sessione elenco delle domande del questionario
      if (DALRuntime.iDomanda == 0)
        DALRuntime.tblDomande = DALRuntime.getQuestItems(DALRuntime.IdAQuest);
      // Crea testata in m_quest per il nuovo questionario che sta per essere compilato
      // e salva in sessione il nuovo id
      // TODO: se possibile non salvare questionario se non alla fine (si potrebbe tenere tutto in sessione)
      DALRuntime.IdMQuest = DALRuntime.insertMQuest(DALRuntime.IdAQuest, DALRuntime.RecPaziente.idPaziente, DALRuntime.IdUtente);
      // Prepara la prima domanda
      fillQuestion(DALRuntime.iDomanda);
      // Nasconde panel iniziale
      pnlInizio.Visible = false;
      // Mostra panel per le domande
      pnlDomanda.Visible = true;
    }
  } /* btnAvanti1_Click */

  /// <summary>
  /// Passa da una domanda alla successiva
  /// </summary>
  /// <param name="sender"></param>
  /// <param name="e"></param>
  protected void btnAvanti2_Click(object sender, EventArgs e)
  {
    // Check che risposta sia compilata
    if (rblRisposta.SelectedIndex == -1)
    {
      lblAvviso.Text = "Risposta non compilata";
      lblAvviso.Visible = true;
    }
    else
    {
      // Salva risposta prima di proseguire alla domanda successiva
      DALRuntime.insertMQuestItem(DALRuntime.IdMQuest, getCurrIdAQuestItem(DALRuntime.iDomanda), rblRisposta.SelectedIndex);
      // Passa alla domanda successiva
      incDomanda();
      if (DALRuntime.iDomanda < DALRuntime.tblDomande.Rows.Count)
      {
        fillQuestion(DALRuntime.iDomanda);
        if (DALRuntime.iDomanda == DALRuntime.tblDomande.Rows.Count - 1)
          btnAvanti2.Text = "Fine";
      }
      else
      {
        showPanelCompletato(true);
        string sRisultato = DALRuntime.calcolaRisultato(DALRuntime.IdMQuest);
        DALRuntime.calcolaLettera(DALRuntime.IdMQuest, DALRuntime.IdUtente);
        lblDomanda.Text = "Questionario completato. Risultato: " + sRisultato;
      }
    }
  } /* btnAvanti2_Click */

  private string getFieldDomanda(string sFieldName, int iDomanda)
  {
    return DALRuntime.tblDomande.Rows[iDomanda][sFieldName].ToString();
  }

  /// <summary>
  /// Compila i controlli della pagina con i dati della domanda iDomand-esima
  /// </summary>
  /// <param name="iDomanda"></param>
  private void fillQuestion(int iDomanda)
  {
    // Compila dati paziente
    lblPaziente.Text = "Paziente " + DALRuntime.RecPaziente.getSaluto();
    imgPaziente.ImageUrl = DALRuntime.fImagePazientiPath + DALRuntime.RecPaziente.ddFoto;
    pnlDomanda.HeaderText = lstQuestionari.SelectedItem.Text;
    // Dati sezione
    lblIntesta1.Text = getFieldDomanda("dd_sezione_descr1", iDomanda);
    lblIntesta2.Text = getFieldDomanda("dd_sezione_descr2", iDomanda);
    // Nasconde lblAvviso 
    lblAvviso.Visible = false;
    // Imposta testo domanda
    lblDomanda.Text = DALRuntime.tblDomande.Rows[iDomanda]["DD_DOMANDA"].ToString();
    lblNumDomanda.Text = "Domanda n. " + (iDomanda + 1).ToString() + " di " + DALRuntime.iNumDomande.ToString();
    // Imposta immagine associata alla domanda iDomanda
    setImmagine(iDomanda);
    string sRisposte = DALRuntime.tblDomande.Rows[iDomanda]["DD_RISPOSTE"].ToString();
    string[] arrRisposte = sRisposte.Split('|');
    rblRisposta.Items.Clear();
    for (int i = 0; i < arrRisposte.Length; i++)
      rblRisposta.Items.Add(arrRisposte[i]);
    // Forza stato di risposta non selezionata (altrimenti resta da domanda precedente)
    rblRisposta.SelectedIndex = -1;
    // Legge nr scelte della sezione corrente e 
    int iNumScelte = Convert.ToInt32(getFieldDomanda("nr_num_scelte_possibili", iDomanda));
    // Imposta repeatcolumns di conseguenza 
    rblRisposta.RepeatColumns = iNumScelte;
  }

  private void setImmagine(int iDomanda)
  {
    string sImmagineDb = DALRuntime.tblDomande.Rows[iDomanda]["DD_IMMAGINE"].ToString();
    if (sImmagineDb != string.Empty)
      imgDomanda.ImageUrl = DALRuntime.fImageQuestionariPath + sImmagineDb;
    else
      imgDomanda.ImageUrl = DALRuntime.fImageQuestionariPath + DALRuntime.fImageNotPresent;
  } /* setImmagine */

  protected void setAvviso1(string sMsg)
  {
    lblAvviso1.Text = sMsg;
    lblAvviso1.Visible = sMsg != string.Empty;
  }

  private void showPanelCompletato(bool isFinish)
  {
    // Valutare se il caso di modificare le istruzioni per l'ultima pagina
    // (tasto lettera ecc..). Per ora metto semplicemente invisibile
    lblIstruzioni.Visible = !isFinish;
    imgDomanda.Visible = !isFinish;
    rblRisposta.Visible = !isFinish;
    btnAvanti2.Visible = !isFinish;
    btnLettera.Visible = isFinish;
    btnNuovo.Visible = isFinish;
    lblNumDomanda.Visible = !isFinish;
    lblIntesta1.Visible = !isFinish;
    lblIntesta2.Visible = !isFinish;
    lblAvviso.Visible = !isFinish;
  }

  protected int getCurrIdAQuestItem(int iDomanda)
  {
    return Convert.ToInt32(DALRuntime.tblDomande.Rows[iDomanda]["ID"].ToString());
  }

  private static void incDomanda()
  {
    DALRuntime.iDomanda = DALRuntime.iDomanda + 1;
  }

  protected void btnLettera_Click(object sender, EventArgs e)
  {
    Response.Redirect(
      string.Format("~/Questionari/FmLettera.aspx?" +
      "IdMQuest={0}", DALRuntime.IdMQuest.ToString()));
  }

  protected void btnNuovo_Click(object sender, EventArgs e)
  {
    resetData();
    Response.Redirect("~/Questionari/FmCompila.aspx");
  }
}
