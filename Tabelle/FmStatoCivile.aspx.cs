using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web.Data;

public partial class Tabelle_FmStatoCivile : System.Web.UI.Page
{
  protected void grdDataBind(bool setDatasource, bool doDatabind)
  {
    if (setDatasource)
      grdStatoCivile.DataSource = DALRuntime.getStatoCivile();
    if (doDatabind)
      grdStatoCivile.DataBind();
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

  protected void grdStatoCivile_RowDeleting(object sender, ASPxDataDeletingEventArgs e)
  {
    int id = Convert.ToInt32(e.Keys[0].ToString());
    DALRuntime.deleteStatoCivile(id);
    e.Cancel = true;
    grdDataBind(true, true);
  }

  protected void grdStatoCivile_RowInserting(object sender, ASPxDataInsertingEventArgs e)
  {
    string ddDescr = e.NewValues["dd_descrizione"].ToString();
    DALRuntime.insertStatoCivile(ddDescr);
    e.Cancel = true;
    grdStatoCivile.CancelEdit();
    grdDataBind(true, true);
  }

  protected void grdStatoCivile_RowUpdating(object sender, ASPxDataUpdatingEventArgs e)
  {
    int id = Convert.ToInt32(e.Keys[0].ToString());
    string ddDescr = e.NewValues["dd_descrizione"].ToString();
    DALRuntime.updateStatoCivile(id, ddDescr);
    e.Cancel = true;
    grdStatoCivile.CancelEdit();
    grdDataBind(true, true);
  }
}
