using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Questionari_FmTestataLettera : System.Web.UI.Page
{
  protected void Page_Load(object sender, EventArgs e)
  {
    if (!IsPostBack)
    {
      memTestata.Text = DALRuntime.getTestata();
    }
  }

  protected void btnSalva_Click(object sender, EventArgs e)
  {
    DALRuntime.setTestata(DALRuntime.IdUtente, memTestata.Text);
  }

  protected void btnIndietro_Click(object sender, EventArgs e)
  {
    Response.Redirect(string.Format("~/Questionari/FmLettera.aspx?IdMQuest={0}", DALRuntime.IdMQuest));
  }
}
