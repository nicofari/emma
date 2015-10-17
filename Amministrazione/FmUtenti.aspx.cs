using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web.ASPxEditors;
using DevExpress.Web.ASPxGridView;
using DevExpress.Web.Data;

public partial class Amministrazione_FmUtenti : System.Web.UI.Page
{
  protected void grdDataBind(bool setDatasource, bool doDatabind)
  {
    if (setDatasource)
    {
      DALRuntime.tblUtenti = DALRuntime.getUtenti();
      grdUtenti.DataSource = DALRuntime.tblUtenti;
    }
    if (doDatabind)
      grdUtenti.DataBind();
  }

  protected void Page_Init(object sender, EventArgs e)
  {
    grdDataBind(true, false);
  }

  protected void Page_Load(object sender, EventArgs e)
  {
    if (!IsPostBack && !IsCallback)
      grdDataBind(false, true);
  }

  protected void grdUtenti_HtmlRowCreated(object sender, ASPxGridViewTableRowEventArgs e)
  {
    if (e.RowType == DevExpress.Web.ASPxGridView.GridViewRowType.EditForm)
    {
      ASPxGridView grdSender = (sender as ASPxGridView);
      System.Data.DataRow r = DALRuntime.tblUtenti.Rows.Find(e.KeyValue);
      // Data bind del combo del profilo
      ASPxComboBox cbxProfilo = (ASPxComboBox)grdSender.FindEditFormTemplateControl("cbxProfilo");
      if (cbxProfilo != null)
      {
        cbxProfilo.DataSource = DALRuntime.getProfili();
        cbxProfilo.DataBindItems();
        if (r != null)
          cbxProfilo.Value = r["cz_profilo"];
      }
    }
  }

  protected void grdUtenti_RowDeleting(object sender, ASPxDataDeletingEventArgs e)
  {
    int id = Convert.ToInt32(e.Keys[0].ToString());
    DALRuntime.deleteUtente(id);
    e.Cancel = true;
    grdDataBind(true, true);
  }

  protected void grdUtenti_RowInserting(object sender, ASPxDataInsertingEventArgs e)
  {
    string ddLogin = e.NewValues["dd_login"].ToString();
    string ddNome = e.NewValues["dd_nome"].ToString();
    string ddCognome = e.NewValues["dd_cognome"].ToString();
    string ddPassword = e.NewValues["dd_password"].ToString();
    int czProfilo = getCzProfilo();
    string ddMail = e.NewValues["dd_mail"].ToString();
    DALRuntime.insertUtente(ddLogin, ddPassword, ddNome, ddCognome, ddMail, czProfilo);
    e.Cancel = true;
    grdUtenti.CancelEdit();
    grdDataBind(true, true);
  }

  private int getCzProfilo()
  {
    ASPxComboBox cbxProfilo = (ASPxComboBox)grdUtenti.FindEditFormTemplateControl("cbxProfilo");
    int czProfilo = 0;
    if (cbxProfilo != null && cbxProfilo.Value != null)
      czProfilo = Convert.ToInt32(cbxProfilo.Value.ToString());
    return czProfilo;
  }

  protected void grdUtenti_RowUpdating(object sender, ASPxDataUpdatingEventArgs e)
  {
    int id = Convert.ToInt32(e.Keys[0].ToString());
    string ddLogin = e.NewValues["dd_login"].ToString();
    string ddNome = e.NewValues["dd_nome"].ToString();
    string ddCognome = e.NewValues["dd_cognome"].ToString();
    string ddPassword = e.NewValues["dd_password"].ToString();
    int czProfilo = getCzProfilo();
    string ddMail = e.NewValues["dd_mail"].ToString();
    DALRuntime.updateUtente(id, ddLogin, ddPassword, ddNome, ddCognome, ddMail, czProfilo);
    e.Cancel = true;
    grdUtenti.CancelEdit();
    grdDataBind(true, true);
  }
}
