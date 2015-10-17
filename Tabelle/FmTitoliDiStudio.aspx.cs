using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web.Data;

public partial class Tabelle_FmTitoliDiStudio : System.Web.UI.Page
{
  protected void grdDataBind(bool setDatasource, bool doDatabind)
  {
    if (setDatasource)
      grdTitoliDiStudio.DataSource = DALRuntime.getTitoli();
    if (doDatabind)
      grdTitoliDiStudio.DataBind();
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

  protected void grdTitoliDiStudio_RowDeleting(object sender, ASPxDataDeletingEventArgs e)
  {
    int id = Convert.ToInt32(e.Keys[0].ToString());
    DALRuntime.deleteTitolo(id);
    e.Cancel = true;
    grdDataBind(true, true);
  }

  protected void grdTitoliDiStudio_RowInserting(object sender, ASPxDataInsertingEventArgs e)
  {
    string ddDescr = e.NewValues["dd_descrizione"].ToString();
    DALRuntime.insertTitolo(ddDescr);
    e.Cancel = true;
    grdTitoliDiStudio.CancelEdit();
    grdDataBind(true, true);
  }

  protected void grdTitoliDiStudio_RowUpdating(object sender, ASPxDataUpdatingEventArgs e)
  {
    int id = Convert.ToInt32(e.Keys[0].ToString());
    string ddDescr = e.NewValues["dd_descrizione"].ToString();
    DALRuntime.updateTitolo(id, ddDescr);
    e.Cancel = true;
    grdTitoliDiStudio.CancelEdit();
    grdDataBind(true, true);
  }
}
