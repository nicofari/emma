using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web.ASPxGridView;
using DevExpress.Web.ASPxMenu;

public partial class Tabelle_FmArchivio : System.Web.UI.Page
{
  protected void Page_Init(object sender, EventArgs e)
  {
    grdMQuest.DataSource = DALRuntime.getMQuest();
  }

  /*
  protected void grdMQuestBind()
  {
    grdMQuest.DataSource = DALRuntime.getMQuest();
    grdMQuest.KeyFieldName = "IdMQuest";
    grdMQuest.DataBind();
  }
   */

  protected void Page_Load(object sender, EventArgs e)
  {
    //DevExUtility.GridApplyTheme(grdMQuest, DALRuntime.globalTheme);
    if (!IsPostBack)
    {
      grdMQuest.DataSource = DALRuntime.getMQuest();
      grdMQuest.KeyFieldName = "IdMQuest";
      grdMQuest.DataBind();
      // grdMQuestBind();
    }
//    if (!IsPostBack)
//      grdMQuestBind();
  }

  protected void Page_PreInit(object sender, EventArgs e)
  {
//    this.Theme = "Glass";
  }

  /*
  protected void grdMQuestItem_BeforePerformDataSelect(object sender, EventArgs e)
  {
    ASPxGridView grdDetail = sender as ASPxGridView;
    int idMQuest = Convert.ToInt32(grdDetail.GetMasterRowKeyValue().ToString());
    grdDetail.DataSource = DALRuntime.getMQuestItem(idMQuest);
    //grdDetail.DataBind();
  }
   */

  protected void popMnuGridMQuest_ItemClick(object source, DevExpress.Web.ASPxMenu.MenuItemEventArgs e)
  {
    ASPxGridViewExporter.WriteXlsToResponse();
  }
}
