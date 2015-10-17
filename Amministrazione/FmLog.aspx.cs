using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Amministrazione_FmLog : System.Web.UI.Page
{
  protected void grdDataBind(bool setDatasource, bool doDatabind)
  {
    if (setDatasource)
      grdLog.DataSource = DALRuntime.getLog();
    if (doDatabind)
      grdLog.DataBind();
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
}
