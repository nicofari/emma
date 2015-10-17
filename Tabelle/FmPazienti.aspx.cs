using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web.ASPxEditors;
using DevExpress.Web.ASPxGridView;
using DevExpress.Web.Data;
using System.Collections.Specialized;
using DevExpress.Web.ASPxUploadControl;

// Finito l'upload chiude editform lato client (da js)
// In insert nascosto controllo di upload perché, se si fa insert di un nuovo record
// e, contemporaneamente, l'upload di un'immagine il post fallisce.
// Per ora se la grid è in insert il controllo di upload viene nascosto.
// Upload quindi possibile solo in update

public partial class Tabelle_FmPazienti : System.Web.UI.Page
{
  private object getPropValue(OrderedDictionary NewValues, OrderedDictionary OldValues, string propName)
  {
    return NewValues[propName] != null ? NewValues[propName] : OldValues[propName] != null ? OldValues[propName] : null;
  }

  private string getPropValueAsString(OrderedDictionary NewValues, OrderedDictionary OldValues, string propName)
  {
    object obj = getPropValue(NewValues, OldValues, propName);
    return obj == null ? string.Empty : obj.ToString();
  }

  /// <summary>
  /// Compila e ritorna recPaziente leggendo da NewValues o, se null, da OldValues
  /// </summary>
  /// <param name="NewValues"></param>
  /// <param name="OldValues"></param>
  /// <returns></returns>
  private DALRuntime.TRecPaziente getRecPaziente(OrderedDictionary NewValues, OrderedDictionary OldValues)
  {
    DALRuntime.TRecPaziente recPaziente = DALRuntime.getRecPaziente(0);
    recPaziente.Cognome = getPropValueAsString(NewValues, OldValues, "dd_cognome");
    recPaziente.Nome = getPropValueAsString(NewValues, OldValues, "dd_nome");
    recPaziente.CdFiscale = getPropValueAsString(NewValues, OldValues, "cd_fiscale");
    System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
    dtfi.ShortDatePattern = "MM/dd/yyyy";
    string sDtNascita = getPropValueAsString(NewValues, OldValues, "dt_nascita");
    if (sDtNascita != string.Empty)
      recPaziente.DataNascita = Convert.ToDateTime(sDtNascita, dtfi);
    recPaziente.Sesso = getPropValueAsString(NewValues, OldValues, "cd_sesso");
    recPaziente.MedicoCognome = getPropValueAsString(NewValues, OldValues, "dd_medico_cognome");
    recPaziente.MedicoNome = getPropValueAsString(NewValues, OldValues, "dd_medico_nome");
    recPaziente.MedicoMail = getPropValueAsString(NewValues, OldValues, "dd_medico_email");
    recPaziente.Note = getPropValueAsString(NewValues, OldValues, "bl_nota");
    return recPaziente;
  } /* getRecPaziente */

  /// <summary>
  /// Legge valori di ct_stato_civile e ct_titolo dai controlli (combobox) e li
  /// scrive in recPaziente
  /// </summary>
  /// <param name="recPaziente"></param>
  /// <param name="grdSender"></param>
  private void readComboBox(DALRuntime.TRecPaziente recPaziente, ASPxGridView grdSender)
  {
    ASPxComboBox cbxStatoCivile = (ASPxComboBox)grdSender.FindEditFormTemplateControl("cbxStatoCivile");
    if (cbxStatoCivile != null && cbxStatoCivile.Value != null)
      recPaziente.CtStatoCivile = Convert.ToInt32(cbxStatoCivile.Value.ToString());
    ASPxComboBox cbxTitolo = (ASPxComboBox)grdSender.FindEditFormTemplateControl("cbxTitoloStudio");
    if (cbxTitolo != null && cbxTitolo.Value != null)
      recPaziente.CtTitolo = Convert.ToInt32(cbxTitolo.Value.ToString());
    ASPxComboBox cbxSesso = (ASPxComboBox)grdSender.FindEditFormTemplateControl("cbxSesso");
    if (cbxSesso != null && cbxSesso.Value != null)
      recPaziente.Sesso = cbxSesso.Value.ToString();
  } /* readTitoloEStatoCivile */

  protected void grdDataBind(bool setDatasource, bool doDatabind)
  {
    if (setDatasource)
    {
      setTblPazienti();
      grdPazienti.DataSource = DALRuntime.tblPazienti;
    }
    if (doDatabind)
    {
      grdPazienti.KeyFieldName = "id";
      grdPazienti.DataBind();
    }
  }

  /*
  protected override void InitializeCulture()
  {
    base.InitializeCulture();
    System.Globalization.CultureInfo culture = new System.Globalization.CultureInfo(System.Threading.Thread.CurrentThread.CurrentCulture.LCID);
    culture.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
    System.Threading.Thread.CurrentThread.CurrentCulture = culture;
  }
   */

  protected void Page_Init(object sender, EventArgs e)
  {
    grdDataBind(true, false);
  }

  protected void Page_Load(object sender, EventArgs e)
  {
    if (!IsPostBack && !IsCallback)
    {
      // Reset recPaziente
      DALRuntime.RecPaziente = null;
      grdDataBind(false, true);
    }
  }


  private static void setTblPazienti()
  {
    DALRuntime.tblPazienti = DALRuntime.getPazienti2();
  }

  protected void grdPazienti_HtmlRowCreated(object sender, DevExpress.Web.ASPxGridView.ASPxGridViewTableRowEventArgs e)
  {
    if (e.RowType == DevExpress.Web.ASPxGridView.GridViewRowType.EditForm)
    {
      ASPxGridView grdSender = (sender as ASPxGridView);
      ASPxImage img = (ASPxImage)grdSender.FindEditFormTemplateControl("imgPaziente");
      System.Data.DataRow r = DALRuntime.tblPazienti.Rows.Find(e.KeyValue);
      if (r != null)
      {
        int idPaziente = Convert.ToInt32(r["id"].ToString());
        DALRuntime.setRecPaziente(idPaziente);
        string sImage = DALRuntime.fImagePazientiPath;
        if (r["dd_foto"] == null || r["dd_foto"].ToString() == string.Empty)
          sImage += DALRuntime.fImageNotPresent;
        else
          sImage = DALRuntime.checkAndGetImagePath(DALRuntime.fImagePazientiPath, r["dd_foto"].ToString());
        img.ImageUrl = sImage;
      }

      // Data bind del combo dello stato civile ...
      ASPxComboBox cbxStatoCivile = (ASPxComboBox)grdSender.FindEditFormTemplateControl("cbxStatoCivile");
      if (cbxStatoCivile != null)
      {
        cbxStatoCivile.DataSource = DALRuntime.getStatoCivile();
        cbxStatoCivile.DataBindItems();
        if (r != null)
          cbxStatoCivile.Value = r["ct_stato_civile"];
      }

      // .. e di quello dei titoli di studio ...
      ASPxComboBox cbxTitolo = (ASPxComboBox)grdSender.FindEditFormTemplateControl("cbxTitoloStudio");
      if (cbxTitolo != null)
      {
        cbxTitolo.DataSource = DALRuntime.getTitoli();
        cbxTitolo.DataBindItems();
        if (r != null)
          cbxTitolo.Value = r["ct_titolo"];
      }

      // .. e del sesso
      ASPxComboBox cbxSesso = (ASPxComboBox)grdSender.FindEditFormTemplateControl("cbxSesso");
      if (cbxSesso != null && r != null)
        cbxSesso.Value = r["cd_sesso"];
      // Databind delle note
      ASPxMemo memNote = (ASPxMemo)grdSender.FindEditFormTemplateControl("memNote");
      if (memNote != null && r != null)
        memNote.Text = r["bl_nota"].ToString();

      /* non c'è la property TempFile ...
      ASPxUploadControl uploadImage = (ASPxUploadControl)grdSender.FindEditFormTemplateControl("uploadImage");
      if (uploadImage != null)
        ;
       */
    }
  }

  protected void grdPazienti_RowUpdating(object sender, ASPxDataUpdatingEventArgs e)
  {
    int id = Convert.ToInt32(e.Keys[0].ToString());
    DALRuntime.TRecPaziente recPaziente = getRecPaziente(e.NewValues, e.OldValues);
    ASPxGridView grdSender = (sender as ASPxGridView);
    // Legge i valori di ct_titolo e ct_stato_civile e li scrive in recPaziente
    readComboBox(recPaziente, grdSender);
    // Imposta id
    recPaziente.idPaziente = id;
    recPaziente.updatePaziente();
    e.Cancel = true;
    endEditAndRefresh();
  }

  private void endEditAndRefresh()
  {
    grdPazienti.CancelEdit();
    grdDataBind(true, true);
  }

  protected void grdPazienti_RowInserting(object sender, ASPxDataInsertingEventArgs e)
  {
    DALRuntime.TRecPaziente recPaziente = getRecPaziente(e.NewValues, null);
    ASPxGridView grdSender = (sender as ASPxGridView);
    // Legge i valori di ct_titolo e ct_stato_civile e li scrive in recPaziente
    readComboBox(recPaziente, grdSender);
    recPaziente.insertPaziente();
    e.Cancel = true;
    endEditAndRefresh();
  }

  protected void grdPazienti_RowDeleting(object sender, ASPxDataDeletingEventArgs e)
  {
    int id = Convert.ToInt32(e.Keys[0].ToString());
    DALRuntime.deletePazienteById(id);
    e.Cancel = true;
    grdDataBind(true, true);
  }

  protected void uploadImage_FileUploadComplete(object sender, DevExpress.Web.ASPxUploadControl.FileUploadCompleteEventArgs e)
  {
    if (e.IsValid)
    {
      string sFilename = e.UploadedFile.FileName;
      string sPath = DALRuntime.getAbsolutePath(DALRuntime.fImagePazientiPath, sFilename);
      e.UploadedFile.SaveAs(sPath);
      e.CallbackData = sFilename;
      // Salva in sessione.recPaziente il nome file. 
      // Sarà poi salvato assieme agli altri campi
      DALRuntime.TRecPaziente recPaziente = DALRuntime.getRecPaziente(0);
      recPaziente.ddFoto = sFilename;
      recPaziente.updatePaziente();
      endEditAndRefresh();
    }
  }
}
