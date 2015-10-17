using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Security.Permissions;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Collections.Specialized;
using MySql.Data.MySqlClient;

/// <summary>
/// Summary description for EmmaSitemapProvider
/// </summary>
[AspNetHostingPermission(SecurityAction.Demand, Level = AspNetHostingPermissionLevel.Minimal)]
public class EmmaSitemapProvider : StaticSiteMapProvider
{
  private SiteMapNode fRootNode = null;
  private int fIdProfilo = 1; // default profilo pubblico
  private string fConnString;

	public EmmaSitemapProvider() {}

  public override void Initialize(string name, System.Collections.Specialized.NameValueCollection attributes)
  {
    fConnString = attributes["connectionString"];
    base.Initialize(name, attributes);
  }

  private int DoBuildSiteMap(
    SiteMapNode CurrRoot, 
    DataTable TblMenu, 
    int CurrRowMenu, 
    int PrecLevel, 
    int idProfilo)
  {
    NameValueCollection Attributes = new NameValueCollection();
// Uncomment per usare window separata
//    Attributes.Add("target", "_blank");
    int i = CurrRowMenu;
    while (i < TblMenu.Rows.Count)
    {
      DataRow RowMenu = TblMenu.Rows[i];
      if (i < TblMenu.Rows.Count)
      {
        string DescrNodo = RowMenu["DD_DESCRIZIONE"].ToString();
        int IdNodo = Convert.ToInt32(RowMenu["ID"].ToString());
        string sUrl = RowMenu["DD_URL"].ToString();

        SiteMapNode NewNode = new SiteMapNode(this, IdNodo.ToString(), sUrl, DescrNodo);

        if (CurrRoot == null)
        {
          CurrRoot = NewNode;
          fRootNode = CurrRoot;
          AddNode(NewNode, null);
        }
        else
        {
          AddNode(NewNode, fRootNode);
          // Se Url è vuoto => è un parent => cerca figli
          if (sUrl == string.Empty)
          {
            DataTable t = openSubMenu(idProfilo, IdNodo);
            for (int r = 0; r <= t.Rows.Count - 1; r++)
            {
              string DescrNodo2 = t.Rows[r]["DD_DESCRIZIONE"].ToString();
              string sIdNodo2 = t.Rows[r]["ID"].ToString();
              string sUrl2 = t.Rows[r]["DD_URL"].ToString();
              AddNode(new SiteMapNode(this, sIdNodo2, sUrl2, DescrNodo2), NewNode);
            }
          }
        }
        i++;
      }
      /*******************
            DataRow RowMenu = TblMenu.Rows[i];

            string DescrNodo = RowMenu["DD_DESCRIZIONE"].ToString();
            decimal IdNodo = decimal.Parse(RowMenu["ID"].ToString());
            string Url = ""; // IdNodo.ToString(); // forza qualcosa nell'url altrimenti il nodo viene ignorato

            SiteMapNode NewNode = new SiteMapNode(this, IdNodo.ToString(), Url, DescrNodo);
            if (CurrRoot == null)
            {
              CurrRoot = NewNode;
              fRootNode = CurrRoot;
            }
            else
              AddNode(NewNode, CurrRoot);

            i++;
            // Se non siamo sull'ultimo record guarda se il prossimo livello è inferiore
            if (i < TblMenu.Rows.Count)
            {
              int NextLevel = int.Parse(TblMenu.Rows[i]["LEVEL"].ToString());
              if (CurrLevel < NextLevel)
              {
                i = DoBuildSiteMap(NewNode, TblMenu, i, CurrLevel);
              }
              else
                // Se invece il nodo successivo ha livello inferiore risali
                if (NextLevel < CurrLevel)
                  return i;
            }
       **************/
    }
    return i;
  } /* DoBuildSiteMap */

  protected override void Clear()
  {
    lock (this)
    {
      fRootNode = null;
      base.Clear();
    }
  }

  private bool isProfiloChanged()
  {
    if (DALRuntime.IdProfilo != 0)
      return fIdProfilo != DALRuntime.IdProfilo;
    else
      return true;
  }

  public override SiteMapNode RootNode
  {
    get
    {
      SiteMapNode temp = null;
      temp = BuildSiteMap();
      return temp;
    }
  }

  private DataTable openMenu(int idProfilo)
  {
    MySqlCommand cmd = new MySqlCommand(
      @"select * 
          from z_funzione 
         where cz_profilo <= @CzProfilo
           and id_parent < 0", DALRuntime.getConnection());
    cmd.Parameters.AddWithValue("@CzProfilo", idProfilo);
    MySqlDataAdapter adapter = new MySqlDataAdapter(cmd);
    DataSet dataset = new DataSet();
    adapter.Fill(dataset);
    return dataset.Tables[0];
  }

  private DataTable openSubMenu(int idProfilo, int idParent)
  {
    MySqlCommand cmd = new MySqlCommand(
      @"select * 
          from z_funzione 
         where cz_profilo <= @CzProfilo
           and id_parent = @IdParent", DALRuntime.getConnection());
    cmd.Parameters.AddWithValue("@CzProfilo", idProfilo);
    cmd.Parameters.AddWithValue("@IdParent", idParent);
    MySqlDataAdapter adapter = new MySqlDataAdapter(cmd);
    DataSet dataset = new DataSet();
    adapter.Fill(dataset);
    return dataset.Tables[0];
  }

  public override SiteMapNode BuildSiteMap()
  {
    lock (this)
    {
      // Costruisce sitemap se RootNode è null OPPURE se è cambiato il profilo
      if (null == fRootNode || isProfiloChanged()) {

        fIdProfilo = DALRuntime.IdProfilo;

        // Start with a clean state
        Clear();

        DataTable TblMenu = openMenu(fIdProfilo);
        DoBuildSiteMap(fRootNode, TblMenu, 0, 0, fIdProfilo);
      }
      return fRootNode;
    }
  }

  protected override SiteMapNode GetRootNodeCore()
  {
    throw new Exception("The method or operation is not implemented.");
  }
}
