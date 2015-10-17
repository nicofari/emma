using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using iTextSharp.text;
using iTextSharp.text.pdf;
using System.Net.Mail;

public partial class Questionari_FmLettera : System.Web.UI.Page
{
  /// TODO: aggiungere controllo client side se lettera cambiata e non salvata

  protected void setAvviso(string sAvviso)
  {
    lblAvviso.Visible = sAvviso != string.Empty;
    lblAvviso.Text = sAvviso;
  }

  /// <summary>
  /// Costruisce e spedisce PDF con lettera corrente
  /// </summary>
  protected void buildPDF()
  {
    string fileName = "Visita " + DALRuntime.getNomePazienteConSaluto(DALRuntime.IdMQuest) +  ".pdf";
    fileName = fileName.Replace(' ', '_');
    Document pdfDoc = new Document();

    this.Response.Clear();
    this.Response.AddHeader("content-disposition", string.Format("attachment;filename={0}", System.IO.Path.GetFileName(fileName)));
    this.Response.ContentType = "application/pdf";

    PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
    pdfDoc.Open();
    // Aggiunge l'intestazione dell'utente
    string sIntestazione = DALRuntime.getTestata();
    // Definisce un font piu' piccolo
    BaseFont bfTimes = BaseFont.CreateFont(BaseFont.TIMES_ROMAN, BaseFont.CP1252, true);
    Font ftTimes10Italic = new Font(bfTimes, 10, Font.ITALIC);
    Paragraph pIntestazione = new Paragraph(sIntestazione, ftTimes10Italic);
    pdfDoc.Add(pIntestazione);
    Font ftTimes10Normal = new Font(bfTimes, 10, Font.NORMAL);
    string sLettera = memLettera.Text;
    Paragraph pBody = new Paragraph(sLettera, ftTimes10Normal);
    pdfDoc.Add(pBody);
    pdfDoc.Close();
    this.Response.Flush();
    this.Response.End();
  } /* buildPDF() */

  /// <summary>
  /// Spedisce la lettera corrente via mail al medico di famiglia del paziente
  /// </summary>
  protected void sendMail()
  {
    string sMailMedico = DALRuntime.getMailAddressMedico(DALRuntime.IdMQuest);
    string sSubject = "Visita " + DALRuntime.getNomePazienteConSaluto(DALRuntime.IdMQuest);
    string sFrom = "emma@kotik.it";
    MailMessage mmMessage = new MailMessage(sFrom, sMailMedico);
    // Cerca di mettere l'intestazione dell'utente come una specie di signature
    mmMessage.Body = memLettera.Text + "\n--\n" + DALRuntime.getTestata();
    mmMessage.Subject = sSubject;
    SmtpClient smtpClient = new SmtpClient();
    smtpClient.Send(mmMessage);
  } /* sendMail() */

  protected void Page_Load(object sender, EventArgs e)
  {
    if (!IsPostBack)
    {
      // Se è stato passato IdMQuest come parametro ...
      if (Request.Params["IdMQuest"] != null && Request.Params["IdMQuest"].ToString() != string.Empty)
      {
        DALRuntime.IdMQuest = Convert.ToInt32(Request.Params["IdMQuest"].ToString());
        // .. legge lettera associata a IdMquest e ...
        string sLettera = DALRuntime.getLettera(DALRuntime.IdMQuest);
        // .. la mette in memLettera
        memLettera.Text = sLettera;

        // Controlla che sia compilata la mail del medico
        string sMailMedico = DALRuntime.getMailAddressMedico(DALRuntime.IdMQuest);

        if (sMailMedico == string.Empty)
        {
          btnSendMail.Enabled = false;
          setAvviso("Manca la mail del medico: impossibile spedire la lettera via mail");
        }

        // Compone lblLettera: "lettera al medico curante (mail) del paziente: sig ..."
        lblLettera.Text = "Lettera al medico curante (" + sMailMedico + ") del paziente " + DALRuntime.getNomePazienteConSaluto(DALRuntime.IdMQuest);
      }
    }
  }

  /// <summary>
  /// Salva il contenuto di memLettera in M_QUEST.
  /// </summary>
  /// <param name="sender"></param>
  /// <param name="e"></param>
  protected void btnSalvaLettera_Click(object sender, EventArgs e)
  {
    DALRuntime.saveLettera(DALRuntime.IdMQuest, memLettera.Text);
    setAvviso("Lettera salvata");
  }

  protected void btnGeneraPDF_Click(object sender, EventArgs e)
  {
    buildPDF();
  }

  protected void btnSendMail_Click(object sender, EventArgs e)
  {
    try
    {
      sendMail();
      setAvviso("Mail spedita!");
    }
    catch (Exception ex)
    {
      setAvviso("Si è verificato l'errore: " + ex.Message);
    }
  }

  protected void btnTestata_Click(object sender, EventArgs e)
  {
    Response.Redirect("~/Questionari/FmTestataLettera.aspx");
  }
}
