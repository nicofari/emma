using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web.ASPxGridView;
using DevExpress.Web.Data;
using DevExpress.Web.ASPxEditors;

public partial class Questionari_FmStruttura : System.Web.UI.Page
{
  protected void grdDataBind(bool setDatasource, bool doDatabind)
  {
    if (setDatasource)
      grdAQuest.DataSource = DALRuntime.getAQuest();
    if (doDatabind)
      grdAQuest.DataBind();
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

  protected void grdAQuestSezioni_DataBinding(object sender, EventArgs e)
  {
    ASPxGridView grdSezioni = (sender as ASPxGridView);
    DALRuntime.IdAQuest = Convert.ToInt32(grdSezioni.GetMasterRowKeyValue().ToString());
    grdSezioni.DataSource = DALRuntime.getAQuestSezione();
  }

  protected void grdAQuest_RowDeleting(object sender, ASPxDataDeletingEventArgs e)
  {
    int id = Convert.ToInt32(e.Keys[0].ToString());
    DALRuntime.deleteAQuest(id);
    e.Cancel = true;
    grdDataBind(true, true);
  }

  protected void grdAQuest_RowUpdating(object sender, ASPxDataUpdatingEventArgs e)
  {
    int id = Convert.ToInt32(e.Keys[0].ToString());
    string ddDescr = e.NewValues["dd_descrizione"].ToString();
    string ddDescrBreve = e.NewValues["dd_descr_breve"].ToString();
    DALRuntime.updateAQuest(id, ddDescr, ddDescrBreve);
    e.Cancel = true;
    grdAQuest.CancelEdit();
    grdDataBind(true, true);
  } /* grdAQuest_RowUpdating */

  protected void grdAQuest_RowInserting(object sender, ASPxDataInsertingEventArgs e)
  {
    string ddDescr = e.NewValues["dd_descrizione"].ToString();
    string ddDescrBreve = e.NewValues["dd_descr_breve"].ToString();
    DALRuntime.insertAQuest(ddDescr, ddDescrBreve);
    e.Cancel = true;
    grdAQuest.CancelEdit();
    grdDataBind(true, true);
  } /* grdAQuest_RowInserting */

  #region A_QUEST_SEZIONE
  protected void grdAQuestSezioni_RowDeleting(object sender, ASPxDataDeletingEventArgs e)
  {
    int id = Convert.ToInt32(e.Keys[0].ToString());
    DALRuntime.deleteAQuestSezione(id);
    e.Cancel = true;
//    grdDataBind(true, true);
  }

  protected void grdAQuestSezioni_RowInserting(object sender, ASPxDataInsertingEventArgs e)
  {
    ASPxGridView grdAQuestSezione = sender as ASPxGridView;
    string ddDescr1 = e.NewValues["dd_descrizione1"].ToString();
    string ddDescr2 = e.NewValues["dd_descrizione2"].ToString();
    int caQuest = DALRuntime.IdAQuest;
    int nrNumScelte = Convert.ToInt32(e.NewValues["nr_num_scelte_possibili"].ToString());
    DALRuntime.insertAQuestSezione(ddDescr1, ddDescr2, caQuest, nrNumScelte);
    e.Cancel = true;
    grdAQuestSezione.CancelEdit();
  }

  protected void grdAQuestSezioni_RowUpdating(object sender, ASPxDataUpdatingEventArgs e)
  {
    int id = Convert.ToInt32(e.Keys[0].ToString());
    ASPxGridView grdAQuestSezione = sender as ASPxGridView;
    string ddDescr1 = e.NewValues["dd_descrizione1"].ToString();
    string ddDescr2 = e.NewValues["dd_descrizione2"].ToString();
    int caQuest = DALRuntime.IdAQuest;
    int nrNumScelte = Convert.ToInt32(e.NewValues["nr_num_scelte_possibili"].ToString());
    DALRuntime.updateAQuestSezione(id, ddDescr1, ddDescr2, caQuest, nrNumScelte);
    e.Cancel = true;
    grdAQuestSezione.CancelEdit();
  }
  #endregion A_QUEST_SEZIONE

  #region A_QUEST_ITEM
  protected void grdAQuestItem_DataBinding(object sender, EventArgs e)
  {
    ASPxGridView grdQuestItem = (sender as ASPxGridView);
    DALRuntime.IdAQuestSezione = Convert.ToInt32(grdQuestItem.GetMasterRowKeyValue().ToString());
    DALRuntime.tblAQuestItems = DALRuntime.getAQuestItemsSezione(DALRuntime.IdAQuest, DALRuntime.IdAQuestSezione);
    grdQuestItem.DataSource = DALRuntime.tblAQuestItems;
  }

  protected void grdAQuestItem_RowDeleting(object sender, ASPxDataDeletingEventArgs e)
  {
    int id = Convert.ToInt32(e.Keys[0].ToString());
    DALRuntime.TRecQuestItem recQuestItem = new DALRuntime.TRecQuestItem();
    recQuestItem.deleteAQuestItem(id);
    e.Cancel = true;
  }

  protected void grdAQuestItem_RowInserting(object sender, ASPxDataInsertingEventArgs e)
  {
    ASPxGridView grdAQuestItem = sender as ASPxGridView;
    DALRuntime.TRecQuestItem recQuestItem = new DALRuntime.TRecQuestItem();
    recQuestItem.ddDomanda = e.NewValues["dd_domanda"].ToString();
    recQuestItem.ddRisposte = e.NewValues["dd_risposte"].ToString();
    if (e.NewValues["dd_immagine"] != null)
      recQuestItem.ddImmagine = e.NewValues["dd_immagine"].ToString();
    if (e.NewValues["nr_order"] != null)
      recQuestItem.nrOrder = Convert.ToInt32(e.NewValues["nr_order"].ToString());
    recQuestItem.caQuestSezione = DALRuntime.IdAQuestSezione;
    recQuestItem.caQuest = DALRuntime.IdAQuest;
    recQuestItem.insertAQuestItem();
    e.Cancel = true;
    grdAQuestItem.CancelEdit();
  }

  protected void grdAQuestItem_RowUpdating(object sender, ASPxDataUpdatingEventArgs e)
  {
    ASPxGridView grdAQuestItem = sender as ASPxGridView;
    DALRuntime.TRecQuestItem recQuestItem = new DALRuntime.TRecQuestItem();
    recQuestItem.idAQuestItem = Convert.ToInt32(e.Keys[0].ToString());
    recQuestItem.ddDomanda = e.NewValues["dd_domanda"].ToString();
    recQuestItem.ddRisposte = e.NewValues["dd_risposte"].ToString();
    if (e.NewValues["dd_immagine"] != null)
      recQuestItem.ddImmagine = e.NewValues["dd_immagine"].ToString();
    if (e.NewValues["nr_order"] != null)
      recQuestItem.nrOrder = Convert.ToInt32(e.NewValues["nr_order"].ToString());
    recQuestItem.caQuestSezione = DALRuntime.IdAQuestSezione;
    recQuestItem.caQuest = DALRuntime.IdAQuest;
    recQuestItem.updateAQuestItem();
    e.Cancel = true;
    grdAQuestItem.CancelEdit();
  }

  protected void grdAQuestItem_HtmlRowCreated(object sender, DevExpress.Web.ASPxGridView.ASPxGridViewTableRowEventArgs e)
  {
    if (e.RowType == DevExpress.Web.ASPxGridView.GridViewRowType.EditForm)
    {
      ASPxGridView grdSender = (sender as ASPxGridView);
      ASPxImage img = (ASPxImage)grdSender.FindEditFormTemplateControl("imgDomanda");
      System.Data.DataRow r = DALRuntime.tblAQuestItems.Rows.Find(e.KeyValue);
      if (r != null)
      {
        int idAQuestItem = Convert.ToInt32(r["id"].ToString());
        string sImage = DALRuntime.fImageQuestionariPath;
        if (r["dd_immagine"] == null || r["dd_immagine"].ToString() == string.Empty)
          sImage += DALRuntime.fImageNotPresent;
        else
          sImage = DALRuntime.checkAndGetImagePath(DALRuntime.fImageQuestionariPath, r["dd_immagine"].ToString());
        img.ImageUrl = sImage;
      }
    }
  }
  #endregion A_QUEST_ITEM
}
