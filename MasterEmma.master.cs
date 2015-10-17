using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MasterEmma : System.Web.UI.MasterPage
{
  protected void Page_Load(object sender, EventArgs e)
  {
    // TODO: impostare questo parametro in un posto piu' "giusto"
//    DALRuntime.globalTheme = "Glass"; 
    //DevExUtility.MenuApplyTheme(mnuMain, DALRuntime.globalTheme);
    // Aggiorna label in footer con utente e profilo
    if (DALRuntime.RecUtente != null)
      lblUtenteProfilo.Text = DALRuntime.RecUtente.getDescrizione();
  }

  protected void LoginStatus_LoggedOut(object sender, EventArgs e)
  {
    // Forza logout
    Session.Abandon();
    // Redirect to home
    Response.Redirect("~/Default.aspx");
  }
}
