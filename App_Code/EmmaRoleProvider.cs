using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Configuration.Provider;
using System.Collections;
using System.Collections.Specialized;
using MySql.Data.MySqlClient;

/// <summary>
/// Summary description for EmmaRoleProvider
/// </summary>
public class EmmaRoleProvider : RoleProvider
{
  private string fConnString;

  public EmmaRoleProvider()
	{
		//
		// TODO: Add constructor logic here
		//
	}

  public override void Initialize(string name, NameValueCollection config)
  {
    if (config == null)
      throw new ArgumentNullException("config");
    if (String.IsNullOrEmpty(name))
      name = "AccessRoleProvider";
    if (string.IsNullOrEmpty(config["description"]))
    {
      config.Remove("description");
      config.Add("description", "EmmaRoleProvider");
    }
    fConnString = config["connectionString"];
    base.Initialize(name, config);
  }

  public override void AddUsersToRoles(string[] usernames, string[] roleNames)
  {
    throw new Exception("The method or operation is not implemented.");
  }

  public override string ApplicationName
  {
    get
    {
      throw new Exception("The method ApplicationName Get or operation is not implemented.");
    }
    set
    {
      throw new Exception("The method ApplicationName set or operation is not implemented.");
    }
  }

  public override void CreateRole(string roleName)
  {
    throw new Exception("The method CreateRole or operation is not implemented.");
  }

  public override bool DeleteRole(string roleName, bool throwOnPopulatedRole)
  {
    throw new Exception("The method DeleteRole or operation is not implemented.");
  }

  public override string[] FindUsersInRole(string roleName, string usernameToMatch)
  {
    throw new Exception("The method  FindUsersInRole or operation is not implemented.");
  }

  private int getCountRoles()
  {
    MySqlCommand cmd = new MySqlCommand("select count(*) from z_profilo", DALRuntime.getConnection());
    object result = cmd.ExecuteScalar();
    cmd.Connection.Close();
    if (result != null)
    {
      int r = Convert.ToInt32(result);
      return r;
    }
    else
      return -1;
  }

  /// <summary>
  /// Ritorna il contenuto di z_profilo
  /// </summary>
  /// <returns></returns>
  public override string[] GetAllRoles()
  {
    int ctrRoles = getCountRoles();
    if (ctrRoles > 0)
    {
      string[] emmaRoles = new string[ctrRoles];
      MySqlCommand cmd = new MySqlCommand("select dd_descrizione from z_profilo", DALRuntime.getConnection());
      int i = 0;
      MySqlDataReader r = cmd.ExecuteReader();
      while (r.Read())
        emmaRoles[i++] = r[0].ToString();
      r.Close();
      return emmaRoles;
    }
    else
      return new string[1] {""};
  }

  private string getProfiloUtente(string username)
  {
    MySqlCommand cmd = new MySqlCommand(
      @"  select z.dd_descrizione
      from z_profilo z
     where z.id = (
       select u.cz_profilo
         from z_utente u
        where u.dd_login = @ddLogon)", DALRuntime.getConnection());
 
    cmd.Parameters.AddWithValue("@ddLogon", username);
    object result = cmd.ExecuteScalar();
    cmd.Connection.Close();
    if (result != null)
      return result.ToString();
    else
      return string.Empty;
  }

  // Per ora gestisce solo un ruolo per username
  public override string[] GetRolesForUser(string username)
  {
    return new string[1] { getProfiloUtente(username) };
  }

  public override string[] GetUsersInRole(string roleName)
  {
    throw new Exception("The method GetUsersInRole or operation is not implemented.");
  }

  public override bool IsUserInRole(string username, string roleName)
  {
    string roleUser = getProfiloUtente(username);
    return string.Compare(roleName, roleUser, true) == 0;
  }

  public override void RemoveUsersFromRoles(string[] usernames, string[] roleNames)
  {
    throw new Exception("The method RemoveUsersFromRoles or operation is not implemented.");
  }

  public override bool RoleExists(string roleName)
  {
    throw new Exception("The method RoleExists or operation is not implemented.");
  }
}
