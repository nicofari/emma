using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using MySql.Data.MySqlClient;

/// <summary>
/// Summary description for EmmaMembershipProvider
/// </summary>
public class EmmaMembershipProvider : MembershipProvider
{
  private string fConnString;

  public override void Initialize(string name, System.Collections.Specialized.NameValueCollection config)
  {
    fConnString = config["connectionString"];
    base.Initialize(name, config);
  }

  private bool emmaIsValidLogon(string Login, string Passw)
  {
    MySqlCommand cmd = new MySqlCommand(
      @"select id, dd_password, dd_nome, dd_cognome, cz_profilo, dd_profilo
          from v_utenti_profilo 
         where upper(dd_login) = upper(@ddLogon)",
      DALRuntime.getConnection());
    cmd.Parameters.AddWithValue("@ddLogon", Login);
    MySqlDataReader r = cmd.ExecuteReader();
    bool userFound = false;
    while (r.Read())
    {
      userFound = true;
      // TODO: cifrare la password
      // check password
      userFound = string.Compare(r["dd_password"].ToString(), Passw, false) == 0;
      if (userFound)
      {
        // Salva in sessione IdUtente e IdProfilo
        int idUtente = Convert.ToInt32(r["id"]);
        int idProfilo = Convert.ToInt32(r["cz_profilo"]);
        string nome = r["dd_nome"].ToString();
        string cognome = r["dd_cognome"].ToString();
        string ddProfilo = r["dd_profilo"].ToString();
        DALRuntime.setRecUtente(idUtente, idProfilo, nome, cognome, ddProfilo);
      }
    }
    r.Close();
    // Log del login :)
    if (userFound)
      DALRuntime.insertZLog("login", Login, DALRuntime.IdUtente);
    else
      DALRuntime.insertZLog("login_attempt", Login, 0);
    return userFound;
  } /* emmaIsValidLogon */

  public override bool ValidateUser(string username, string password)
  {
    bool isGood = emmaIsValidLogon(username, password);
    return isGood;
  }

	public EmmaMembershipProvider()
	{
		//
		// TODO: Add constructor logic here
		//
	}

  public override string ApplicationName
  {
    get
    {
      throw new Exception("The method or operation is not implemented.");
    }
    set
    {
      throw new Exception("The method or operation is not implemented.");
    }
  }

  public override bool ChangePassword(string username, string oldPassword, string newPassword)
  {
    throw new Exception("The method or operation is not implemented.");
  }

  public override bool ChangePasswordQuestionAndAnswer(string username, string password, string newPasswordQuestion, string newPasswordAnswer)
  {
    throw new Exception("The method or operation is not implemented.");
  }

  public override MembershipUser CreateUser(string username, string password, string email, string passwordQuestion, string passwordAnswer, bool isApproved, object providerUserKey, out MembershipCreateStatus status)
  {
    throw new Exception("The method or operation is not implemented.");
  }

  public override bool DeleteUser(string username, bool deleteAllRelatedData)
  {
    throw new Exception("The method or operation is not implemented.");
  }

  public override bool EnablePasswordReset
  {
    get { throw new Exception("The method or operation is not implemented."); }
  }

  public override bool EnablePasswordRetrieval
  {
    get { throw new Exception("The method or operation is not implemented."); }
  }

  public override MembershipUserCollection FindUsersByEmail(string emailToMatch, int pageIndex, int pageSize, out int totalRecords)
  {
    throw new Exception("The method or operation is not implemented.");
  }

  public override MembershipUserCollection FindUsersByName(string usernameToMatch, int pageIndex, int pageSize, out int totalRecords)
  {
    throw new Exception("The method or operation is not implemented.");
  }

  public override MembershipUserCollection GetAllUsers(int pageIndex, int pageSize, out int totalRecords)
  {
    throw new Exception("The method or operation is not implemented.");
  }

  public override int GetNumberOfUsersOnline()
  {
    throw new Exception("The method or operation is not implemented.");
  }

  public override string GetPassword(string username, string answer)
  {
    throw new Exception("The method or operation is not implemented.");
  }

  public override MembershipUser GetUser(string username, bool userIsOnline)
  {
    throw new Exception("The method or operation is not implemented.");
  }

  public override MembershipUser GetUser(object providerUserKey, bool userIsOnline)
  {
    throw new Exception("The method or operation is not implemented.");
  }

  public override string GetUserNameByEmail(string email)
  {
    throw new Exception("The method or operation is not implemented.");
  }

  public override int MaxInvalidPasswordAttempts
  {
    get { throw new Exception("The method or operation is not implemented."); }
  }

  public override int MinRequiredNonAlphanumericCharacters
  {
    get { throw new Exception("The method or operation is not implemented."); }
  }

  public override int MinRequiredPasswordLength
  {
    get { throw new Exception("The method or operation is not implemented."); }
  }

  public override int PasswordAttemptWindow
  {
    get { throw new Exception("The method or operation is not implemented."); }
  }

  public override MembershipPasswordFormat PasswordFormat
  {
    get { throw new Exception("The method or operation is not implemented."); }
  }

  public override string PasswordStrengthRegularExpression
  {
    get { throw new Exception("The method or operation is not implemented."); }
  }

  public override bool RequiresQuestionAndAnswer
  {
    get { throw new Exception("The method or operation is not implemented."); }
  }

  public override bool RequiresUniqueEmail
  {
    get { throw new Exception("The method or operation is not implemented."); }
  }

  public override string ResetPassword(string username, string answer)
  {
    throw new Exception("The method or operation is not implemented.");
  }

  public override bool UnlockUser(string userName)
  {
    throw new Exception("The method or operation is not implemented.");
  }

  public override void UpdateUser(MembershipUser user)
  {
    throw new Exception("The method or operation is not implemented.");
  }
}
