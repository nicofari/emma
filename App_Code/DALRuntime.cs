using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.SessionState;
using MySql.Data.MySqlClient;
using System.Data;
using System.Configuration;

/// <summary>
/// Summary description for DALRuntime
/// </summary>
public class DALRuntime
{
  #region COSTANTI
  public static string fImageNotPresent = "ImmagineNonDisponibile.jpg";
  public static string fImagePazientiPath = "~/public/Immagini/Pazienti/";
  public static string fImageQuestionariPath = "~/public/Immagini/Questionari/";
  #endregion COSTANTI

  #region PRIVATE
  // numero domande
  private const string spNumDomande = "spNumDomande";
  // global theme 
  private const string spGlobalTheme = "globalTheme";
  // client id txtLettera
  private const string spLetteraClientId = "clientIdLettera";
  // id profilo
  private const string spIdProfilo = "idProfilo";
  // id utente
  private const string spIdUtente = "idUtente";
  // tengo in sessione il numero della domanda corrente usato in FmCompila
  private const string spIdDomanda = "idDomanda";
  // tengo in sessione anche il dataset delle domande
  private const string spTblDomande = "tblDomande";
  // pazienti
  private const string spTblPazienti = "tblPazienti";
  // tabella utenti
  private const string spTblUtenti = "tblUtenti";
  // tblAQuestItem
  private const string spTblAQuestItem = "tblAQuestItem";
  // Salvo in sessione anche la connessione al db
  private const string spMainConnection = "MainConnection";
  // id m_quest
  private const string spIdMQuest = "idMQuest";
  // id a_quest
  private const string spIdAQuest = "idAQuest";
  // id a_quest_sezione
  private const string spIdAQuestSezione = "idAQuestSezione";
  // rec paziente
  private const string spRecPaziente = "recPaziente";
  // rec utente
  private const string spRecUtente = "recUtente";
  // rec mquest
  private const string spRecMQuest = "recMQuest";
  #endregion PRIVATE

  #region CONSTRUCTOR
  public DALRuntime()
	{
		//
		// TODO: Add constructor logic here
		//
  }
  #endregion CONSTRUCTOR

  #region DB
  /// <summary>
  /// Ritorna la connessione principale al db
  /// </summary>
  /// <param name="connString"></param>
  /// <returns></returns>
  public static MySqlConnection getConnection(string connString)
  {
    // Quando richiamato da SitemapProvider
    if (HttpSession == null)
    {
      MySqlConnection c = new MySqlConnection(connString != string.Empty ? connString : getConnectionString());
      c.Open();
      return c;
    }
    else
    {
      if (MainConnection == null)
        MainConnection = new MySqlConnection(connString != string.Empty ? connString : getConnectionString());
      if (MainConnection.State == ConnectionState.Closed)
        MainConnection.Open();
      return MainConnection;
    }
  }

  public static MySqlConnection getConnection()
  {
    return getConnection(string.Empty);
  }

  public static MySqlCommand buildCommand(string sSQL)
  {
    MySqlConnection conn = getConnection(getConnectionString());
    MySqlCommand cmd = new MySqlCommand(sSQL, conn);
    return cmd;
  }

  public static string getConnectionString()
  {
    string fConnString = ConfigurationManager.ConnectionStrings["MySQLEmma"].ToString();
    return fConnString;
  }
  #endregion DB

  #region SESSIONE
  private static HttpSessionState HttpSession
  {
    get { return HttpContext.Current.Session; }
  }

  public static MySqlConnection MainConnection
  {
    get { if (HttpSession[spMainConnection] == null) return null; else return (MySqlConnection)(HttpSession[spMainConnection]); }
    set { HttpSession[spMainConnection] = value; }
  }

  public static TRecPaziente RecPaziente
  {
    get { if (HttpSession[spRecPaziente] == null) return null; else return (TRecPaziente)(HttpSession[spRecPaziente]); }
    set { HttpSession[spRecPaziente] = value; }
  }

  public static TRecUtente RecUtente
  {
    get { if (HttpSession[spRecUtente] == null) return null; else return (TRecUtente)(HttpSession[spRecUtente]); }
    set { HttpSession[spRecUtente] = value; }
  }

  public static TRecMQuest RecMQuest
  {
    get { if (HttpSession[spRecMQuest] == null) return null; else return (TRecMQuest)(HttpSession[spRecMQuest]); }
    set { HttpSession[spRecMQuest] = value; }
  }

  public static int IdProfilo
  {
    get { if (HttpSession[spIdProfilo] == null) return 1; else return (int)(HttpSession[spIdProfilo]); }
    set { HttpSession[spIdProfilo] = value; }
  }

  public static int IdUtente
  {
    get { if (HttpSession[spIdUtente] == null) return 1; else return (int)(HttpSession[spIdUtente]); }
    set { HttpSession[spIdUtente] = value; }
  }

  public static int IdAQuest
  {
    get { if (HttpSession[spIdAQuest] == null) return 1; else return (int)(HttpSession[spIdAQuest]); }
    set { HttpSession[spIdAQuest] = value; }
  }

  public static int IdAQuestSezione
  {
    get { if (HttpSession[spIdAQuestSezione] == null) return 1; else return (int)(HttpSession[spIdAQuestSezione]); }
    set { HttpSession[spIdAQuestSezione] = value; }
  }

  public static int IdMQuest
  {
    get { if (HttpSession[spIdMQuest] == null) return 1; else return (int)(HttpSession[spIdMQuest]); }
    set { HttpSession[spIdMQuest] = value; }
  }

  public static int iDomanda
  {
    get { if (HttpSession[spIdDomanda] == null) return 0; else return (int)(HttpSession[spIdDomanda]); }
    set { HttpSession[spIdDomanda] = value; }
  }

  public static int iNumDomande
  {
    get { if (HttpSession[spNumDomande] == null) return 0; else return (int)(HttpSession[spNumDomande]); }
    set { HttpSession[spNumDomande] = value; }
  }

  public static bool isLastDomanda
  {
    get { return iDomanda == tblDomande.Rows.Count - 1; }
  }

  public static DataTable tblDomande
  {
    get { return (DataTable)(HttpSession[spTblDomande]); }
    set { HttpSession[spTblDomande] = value; }
  }

  public static DataTable tblUtenti
  {
    get { return (DataTable)(HttpSession[spTblUtenti]); }
    set { HttpSession[spTblUtenti] = value; }
  }

  public static DataTable tblPazienti
  {
    get { return (DataTable)(HttpSession[spTblPazienti]); }
    set { HttpSession[spTblPazienti] = value; }
  }

  public static DataTable tblAQuestItems
  {
    get { return (DataTable)(HttpSession[spTblAQuestItem]); }
    set { HttpSession[spTblAQuestItem] = value; }
  }

  public static string letteraClientId
  {
    get { return HttpSession[spLetteraClientId] == null ? string.Empty : HttpSession[spLetteraClientId].ToString(); }
    set { HttpSession[spLetteraClientId] = value; }
  }

  public static string globalTheme
  {
    get { return HttpSession[spGlobalTheme] == null ? string.Empty : HttpSession[spGlobalTheme].ToString(); }
    set { HttpSession[spGlobalTheme] = value; }
  }
  #endregion SESSIONE

  #region LETTERA
  /// <summary>
  /// Esegue CalcolaLettera(IdMQuest, IdUtente)
  /// </summary>
  /// <param name="cmQuest"></param>
  /// <param name="idUtente"></param>
  public static void calcolaLettera(int cmQuest, int idUtente)
  {
    MySqlCommand cmd = buildCommand(
      @"call CalcolaLettera(@cmQuest, @idUtente)");
    cmd.Parameters.AddWithValue("@cmQuest", cmQuest);
    cmd.Parameters.AddWithValue("@idUtente", idUtente);
    cmd.ExecuteNonQuery();
  } /* calcolaLettera */

  /// <summary>
  /// Salva sLettera nel questionario idMQuest
  /// </summary>
  /// <param name="idMQuest"></param>
  /// <param name="sLettera"></param>
  public static void saveLettera(int idMQuest, string sLettera)
  {
    MySqlCommand cmd = buildCommand("call setLettera(@idMQuest, @ddLettera);");
    cmd.Parameters.AddWithValue("@idMQuest", idMQuest);
    cmd.Parameters.AddWithValue("@ddLettera", sLettera);
    cmd.ExecuteNonQuery();
  }

  /// <summary>
  /// Ritorna la testata associata all'utente in questo momento in sessione
  /// </summary>
  /// <returns></returns>
  public static string getTestata()
  {
    MySqlConnection conn = getConnection();
    MySqlCommand cmd = new MySqlCommand("select getTestata(@idUtente)", conn);
    cmd.Parameters.AddWithValue("@idUtente", IdUtente);

    object result = cmd.ExecuteScalar();
    if (result != null)
      return result.ToString();
    else
      return string.Empty;
  } /* getTestata */

  public static void setTestata(int idUtente, string sTestata)
  {
    MySqlConnection conn = getConnection();
    MySqlCommand cmd = new MySqlCommand("call setTestata(@idUtente, @blTesto)", conn);
    cmd.Parameters.AddWithValue("@idUtente", IdUtente);
    cmd.Parameters.AddWithValue("@blTesto", sTestata);
    cmd.ExecuteNonQuery();
  } /* setTestata */

  /// <summary>
  /// Ritorna la lettera del quest idMQuest
  /// </summary>
  /// <param name="idMQuest"></param>
  /// <returns></returns>
  public static string getLettera(int idMQuest)
  {
    MySqlConnection conn = getConnection();
    MySqlCommand cmd = new MySqlCommand("select getLettera(@idMQuest)", conn);
    cmd.Parameters.AddWithValue("@idMQuest", idMQuest);

    object result = cmd.ExecuteScalar();
    if (result != null)
      return result.ToString();
    else
      return string.Empty;
  }

  public static string getNomePazienteConSaluto(int idMQuest)
  {
    MySqlConnection conn = getConnection();
    MySqlCommand cmd = new MySqlCommand("select getNomePazienteConSaluto(@idMQuest)", conn);
    cmd.Parameters.AddWithValue("@idMQuest", idMQuest);

    object result = cmd.ExecuteScalar();
    if (result != null)
      return result.ToString();
    else
      return string.Empty;
  } /* getNomePazienteConSaluto */

  /// <summary>
  /// Ritorna l'indirizzo mail del medico del paziente associato a idMQuest
  /// </summary>
  /// <param name="idMQuest"></param>
  /// <returns></returns>
  public static string getMailAddressMedico(int idMQuest)
  {
    MySqlConnection conn = getConnection();
    MySqlCommand cmd = new MySqlCommand("select getMailAddressMedico(@idMQuest)", conn);
    cmd.Parameters.AddWithValue("@idMQuest", idMQuest);

    object result = cmd.ExecuteScalar();
    if (result != null)
      return result.ToString();
    else
      return string.Empty;
  } /* getMailAddressMedico */

  public static DataTable getMQuest()
  {
    MySqlConnection conn = getConnection();
    MySqlCommand cmd = new MySqlCommand(
      @"select IdPaziente, IdMQuest, IdAQuest, Questionario, Data, Cognome, Nome, Risultato,
               nr_risultato1, nr_risultato2, nr_risultato3, 
               dd_medico_cognome as dd_medico_famiglia, dd_medico_email, 
               dd_utente_cognome as dd_utente
          from v_m_quest
      order by Cognome", conn);
    MySqlDataAdapter adapter = new MySqlDataAdapter(cmd);
    DataSet dataset = new DataSet();
    adapter.Fill(dataset);
    conn.Close();
    return dataset.Tables[0];
  }
  #endregion LETTERA

  #region TABELLE
  public static DataTable getTitoli()
  {
    MySqlConnection conn = getConnection();
    MySqlCommand cmd = new MySqlCommand(
      @"select id, dd_descrizione from t_titolo", conn);
    MySqlDataAdapter adapter = new MySqlDataAdapter(cmd);
    DataSet dataset = new DataSet();
    adapter.Fill(dataset);
    conn.Close();
    return dataset.Tables[0];
  }

  public static void updateTitolo(int id, string sDescr)
  {
    MySqlConnection conn = getConnection();
    MySqlCommand cmd = new MySqlCommand(
      @"update t_titolo
           set dd_descrizione = @ddDescr
         where id=@id", conn);
    cmd.Parameters.AddWithValue("@ddDescr", sDescr);
    cmd.Parameters.AddWithValue("@id", id);
    cmd.ExecuteNonQuery();
  } /* updateTitolo */

  public static void deleteTitolo(int id)
  {
    MySqlConnection conn = getConnection();
    MySqlCommand cmd = new MySqlCommand(
      @"delete from t_titolo
         where id=@id", conn);
    cmd.Parameters.AddWithValue("@id", id);
    cmd.ExecuteNonQuery();
  } /* deleteTitolo */

  public static int insertTitolo(string sDescr)
  {
    MySqlConnection conn = getConnection();
    MySqlCommand cmd = new MySqlCommand(
      @"insert into t_titolo(dd_descrizione) 
                           values (@ddDescr)", conn);
    cmd.Parameters.AddWithValue("@ddDescr", sDescr);
    cmd.ExecuteNonQuery();
    MySqlCommand cmdLastId = new MySqlCommand("select last_insert_id()", conn);
    cmdLastId.ExecuteScalar();
    object result = cmdLastId.ExecuteScalar();
    if (result != null)
      return Convert.ToInt32(result.ToString());
    else
      return 0;
  } /* insertTitolo */

  public static DataTable getStatoCivile()
  {
    MySqlConnection conn = getConnection();
    MySqlCommand cmd = new MySqlCommand(
      @"select id, dd_descrizione from t_stato_civile", conn);
    MySqlDataAdapter adapter = new MySqlDataAdapter(cmd);
    DataSet dataset = new DataSet();
    adapter.Fill(dataset);
    conn.Close();
    return dataset.Tables[0];
  }

  public static void deleteStatoCivile(int id)
  {
    MySqlConnection conn = getConnection();
    MySqlCommand cmd = new MySqlCommand(
      @"delete from t_stato_civile
         where id=@id", conn);
    cmd.Parameters.AddWithValue("@id", id);
    cmd.ExecuteNonQuery();
  } /* deleteStatoCivile */

  public static void updateStatoCivile(int id, string sDescr)
  {
    MySqlConnection conn = getConnection();
    MySqlCommand cmd = new MySqlCommand(
      @"update t_stato_civile
           set dd_descrizione = @ddDescr
         where id=@id", conn);
    cmd.Parameters.AddWithValue("@ddDescr", sDescr);
    cmd.Parameters.AddWithValue("@id", id);
    cmd.ExecuteNonQuery();
  } /* updateStatoCivile */

  public static int insertStatoCivile(string sDescr)
  {
    MySqlConnection conn = getConnection();
    MySqlCommand cmd = new MySqlCommand(
      @"insert into t_stato_civile(dd_descrizione) 
                           values (@ddDescr)", conn);
    cmd.Parameters.AddWithValue("@ddDescr", sDescr);
    cmd.ExecuteNonQuery();
    MySqlCommand cmdLastId = new MySqlCommand("select last_insert_id()", conn);
    cmdLastId.ExecuteScalar();
    object result = cmdLastId.ExecuteScalar();
    if (result != null)
      return Convert.ToInt32(result.ToString());
    else
      return 0;
  } /* insertStatoCivile */
  #endregion TABELLE

  #region QUESTIONARI
  public static void setRecMQuest(int idMQuest)
  {
    if (DALRuntime.RecMQuest == null)
      DALRuntime.RecMQuest = new DALRuntime.TRecMQuest();
    DALRuntime.RecMQuest.readMQuest(idMQuest);
  }

  public class TRecMQuest
  {
    public int IdMQuest { get; set; }
    public string DdRisultato { get; set; }
    public int CaQuest { get; set; }
    public int CaPaziente { get; set; }
    public string DdQuestionario { get; set; }
    public DateTime Data { get; set; }

    public void readMQuest(int idMQuest)
    {
      this.IdMQuest = idMQuest;
      MySqlCommand cmd = buildCommand(
     @"select IdPaziente, IdAQuest, Questionario, Data, Risultato
          from v_m_quest
         where IdMQuest = @idMQuest");
      cmd.Parameters.AddWithValue("@idMQuest", idMQuest);
      MySqlDataReader r = cmd.ExecuteReader();
      if (r.Read())
      {
        this.DdRisultato = r["Risultato"].ToString();
        this.DdQuestionario = r["Questionario"].ToString();
        this.CaQuest = Convert.ToInt32(r["IdAQuest"].ToString());
        this.CaPaziente = Convert.ToInt32(r["IdPaziente"].ToString());
        this.Data = Convert.ToDateTime(r["Data"].ToString());
      }
      else
      {
        this.DdRisultato = string.Empty;
        this.DdQuestionario = string.Empty;
        this.CaQuest = 0;
        this.CaPaziente = 0;
        // TODO: cosa faccio con la data  ??
      }
      r.Close();
    }
  }

  /// <summary>
  /// Inserisce un nuovo record in M_QUEST e ritorna l'id generato
  /// </summary>
  /// <param name="caQuest"></param>
  /// <param name="caPaziente"></param>
  /// <returns></returns>
  public static int insertMQuest(int caQuest, int caPaziente, int czUtente)
  {
    MySqlCommand cmdInsert = buildCommand(
      "select insertMQuest(@caQuest, @caPaziente, @czUtente, now())");
    cmdInsert.Parameters.AddWithValue("@caQuest", caQuest);
    cmdInsert.Parameters.AddWithValue("@caPaziente", caPaziente);
    cmdInsert.Parameters.AddWithValue("@czUtente", czUtente);
    cmdInsert.ExecuteScalar();
    object result = cmdInsert.ExecuteScalar();
    if (result != null)
      return Convert.ToInt32(result.ToString());
    else
      return 0;
  }

  public static void insertMQuestItem(int cmQuest, int caQuestItem, int iNrScelta)
  {
    MySqlCommand cmdInsert = buildCommand(
      @"insert into m_quest_item(cm_quest, ca_quest_item, nr_scelta) 
        values (@cmQuest, @caQuestItem, @nrScelta)");
    cmdInsert.Parameters.AddWithValue("@cmQuest", cmQuest);
    cmdInsert.Parameters.AddWithValue("@caQuestItem", caQuestItem);
    cmdInsert.Parameters.AddWithValue("@nrScelta", iNrScelta);
    cmdInsert.ExecuteNonQuery();
  }

  /// <summary>
  /// Richiama CalcolaRisultato
  /// </summary>
  /// <param name="cmQuest"></param>
  /// <returns></returns>
  public static string calcolaRisultato(int cmQuest)
  {
    MySqlCommand cmd = buildCommand(
      @"select CalcolaRisultato(@cmQuest)");
    cmd.Parameters.AddWithValue("@cmQuest", cmQuest);
    object result = cmd.ExecuteScalar();
    // TODO: chiudere la connessione ?
    if (result != null)
      return result.ToString();
    else
      return string.Empty;
  } /* calcolaRisultato */

  public static DataTable getQuestionari()
  {
    MySqlConnection conn = getConnection(getConnectionString());
    MySqlCommand cmd = new MySqlCommand("select * from v_a_quest", conn);
    MySqlDataAdapter adapter = new MySqlDataAdapter(cmd);
    DataSet dataset = new DataSet();
    adapter.Fill(dataset);
    conn.Close();
    return dataset.Tables[0];
  }

  public static DataTable getMQuestItem(int CmQuest)
  {
    MySqlConnection conn = getConnection();
    MySqlCommand cmd = new MySqlCommand(
      @"select IdMQuestItem, IdAQuestItem, CmQuest, dd_domanda Domanda,
               dd_risposte Risposte, nr_scelta Scelta, nr_order
          from v_m_quest_item
         where CmQuest = @CmQuest", conn);
    cmd.Parameters.AddWithValue("@CmQuest", CmQuest);
    MySqlDataAdapter adapter = new MySqlDataAdapter(cmd);
    DataSet dataset = new DataSet();
    adapter.Fill(dataset);
    conn.Close();
    return dataset.Tables[0];
  }

  public class TRecQuestItem
  {
    public int idAQuestItem { get; set; }
    public int caQuestSezione { get; set; }
    public int caQuest { get; set; }
    public int nrOrder { get; set; }
    public string ddDomanda { get; set; }
    public string ddRisposte { get; set; }
    public string ddImmagine { get; set; }
    
    public void init(int idAQuestItem, int caQuest, int nrOrder, 
      string ddDomanda, string ddRisposte, string ddImmagine, int caQuestSezione)
    {
      this.idAQuestItem = idAQuestItem;
      this.caQuest = caQuest;
      this.nrOrder = nrOrder;
      this.ddDomanda = ddDomanda;
      this.ddRisposte = ddRisposte;
      this.ddImmagine = ddImmagine;
      this.caQuestSezione = caQuestSezione;
    }

    public void updateAQuestItem()
    {
      MySqlCommand cmd = buildCommand(
       @"update a_quest_item
             set dd_domanda = @ddDomanda, dd_risposte = @ddRisposte, 
                 dd_immagine = @ddImmagine, nr_order = @nrOrder
           where id = @idAQuestItem");
      cmd.Parameters.AddWithValue("@ddDomanda", this.ddDomanda);
      cmd.Parameters.AddWithValue("@ddRisposte", this.ddRisposte);
      cmd.Parameters.AddWithValue("@ddImmagine", this.ddImmagine);
      cmd.Parameters.AddWithValue("@nrOrder", this.nrOrder);
      cmd.Parameters.AddWithValue("@idAQuestItem", this.idAQuestItem);
      cmd.ExecuteNonQuery();
    } /* updateAQuestItem */

    public void insertAQuestItem()
    {
      MySqlCommand cmd = buildCommand(
       @"insert into a_quest_item(ca_quest, dd_domanda, dd_risposte, dd_immagine, nr_order, ca_quest_sezione)
              values (@caQuest, @ddDomanda, @ddRisposte, @ddImmagine, @nrOrder, @caQuestSezione)");
      cmd.Parameters.AddWithValue("@ddDomanda", this.ddDomanda);
      cmd.Parameters.AddWithValue("@ddRisposte", this.ddRisposte);
      cmd.Parameters.AddWithValue("@ddImmagine", this.ddImmagine);
      cmd.Parameters.AddWithValue("@nrOrder", this.nrOrder);
      cmd.Parameters.AddWithValue("@caQuest", this.caQuest);
      cmd.Parameters.AddWithValue("@caQuestSezione", this.caQuestSezione);
      cmd.ExecuteNonQuery();
    } /* insertAQuestItem */

    /// <summary>
    /// Cancella da a_quest_item il record con id=idQuestItem
    /// </summary>
    /// <param name="idQuestItem"></param>
    public void deleteAQuestItem(int idQuestItem)
    {
      MySqlCommand cmd = buildCommand(
        @"delete from a_quest_item
         where id=@id");
      cmd.Parameters.AddWithValue("@id", idQuestItem);
      cmd.ExecuteNonQuery();
    } /* deleteAQuestItem */

  }

  /// <summary>
  /// Ritorna tutti i questionari definiti
  /// </summary>
  /// <returns></returns>
  public static DataTable getAQuest()
  {
    MySqlConnection conn = getConnection();
    MySqlCommand cmd = new MySqlCommand(
      @"select id, dd_descrizione, dd_descr_breve from a_quest", conn);
    MySqlDataAdapter adapter = new MySqlDataAdapter(cmd);
    DataSet dataset = new DataSet();
    adapter.Fill(dataset);
    conn.Close();
    return dataset.Tables[0];
  }

  public static void updateAQuest(int id, string sDescr, string sDescrBreve)
  {
    MySqlConnection conn = getConnection();
    MySqlCommand cmd = new MySqlCommand(
      @"update a_quest
           set dd_descrizione = @ddDescr,
               dd_descr_breve = @ddDescrBreve
         where id=@id", conn);
    cmd.Parameters.AddWithValue("@ddDescr", sDescr);
    cmd.Parameters.AddWithValue("@ddDescrBreve", sDescrBreve);
    cmd.Parameters.AddWithValue("@id", id);
    cmd.ExecuteNonQuery();
  } /* updateAQuest */

  public static int insertAQuest(string sDescr, string sDescrBreve)
  {
    MySqlConnection conn = getConnection();
    MySqlCommand cmd = new MySqlCommand(
      @"insert into a_quest(dd_descrizione, dd_descr_breve) 
                           values (@ddDescr, @ddDescrBreve)", conn);
    cmd.Parameters.AddWithValue("@ddDescr", sDescr);
    cmd.Parameters.AddWithValue("@ddDescrBreve", sDescrBreve);
    cmd.ExecuteNonQuery();
    MySqlCommand cmdLastId = new MySqlCommand("select last_insert_id()", conn);
    cmdLastId.ExecuteScalar();
    object result = cmdLastId.ExecuteScalar();
    if (result != null)
      return Convert.ToInt32(result.ToString());
    else
      return 0;
  } /* insertAQuest */

  /// <summary>
  /// Cancella da a_quest il record con id=idQuest
  /// </summary>
  /// <param name="idQuest"></param>
  public static void deleteAQuest(int idQuest)
  {
    MySqlConnection conn = getConnection();
    MySqlCommand cmd = new MySqlCommand(
      @"delete from a_quest
         where id=@id", conn);
    cmd.Parameters.AddWithValue("@id", idQuest);
    cmd.ExecuteNonQuery();
  } /* deleteAQuest */ 

  /// <summary>
  /// Ritorna le sezioni di DALRuntime.idAQuest
  /// </summary>
  /// <returns>Datatable delle sezioni</returns>
  public static DataTable getAQuestSezione()
  {
    MySqlConnection conn = getConnection();
    MySqlCommand cmd = new MySqlCommand(
      @"select id, dd_descrizione1, dd_descrizione2, nr_num_scelte_possibili 
        from a_quest_sezione
        where ca_quest = @idAQuest", conn);
    cmd.Parameters.AddWithValue("@idAQuest", DALRuntime.IdAQuest);
    MySqlDataAdapter adapter = new MySqlDataAdapter(cmd);
    DataSet dataset = new DataSet();
    adapter.Fill(dataset);
    conn.Close();
    // Forza id come pk
    dataset.Tables[0].PrimaryKey = new DataColumn[1] { dataset.Tables[0].Columns["id"] };
    return dataset.Tables[0];
  } /* getAQuestSezione */

  public static void updateAQuestSezione(int id, string sDescr1, string sDescr2, int caQuest, int nrNumSceltePossibili)
  {
    MySqlConnection conn = getConnection();
    MySqlCommand cmd = new MySqlCommand(
      @"update a_quest_sezione
           set dd_descrizione1 = @ddDescr1,
               dd_descrizione2 = @ddDescr2,
               ca_quest = @caQuest,
               nr_num_scelte_possibili = @nrNumSceltePossibili
         where id=@id", conn);
    cmd.Parameters.AddWithValue("@ddDescr1", sDescr1);
    cmd.Parameters.AddWithValue("@ddDescr2", sDescr2);
    cmd.Parameters.AddWithValue("@caQuest", caQuest);
    cmd.Parameters.AddWithValue("@nrNumSceltePossibili", nrNumSceltePossibili);
    cmd.Parameters.AddWithValue("@id", id);
    cmd.ExecuteNonQuery();
  } /* updateAQuestSezione */

  public static int insertAQuestSezione(string sDescr1, string sDescr2, int caQuest, int nrNumSceltePossibili)
  {
    MySqlConnection conn = getConnection();
    MySqlCommand cmd = new MySqlCommand(
      @"insert into a_quest_sezione(dd_descrizione1, dd_descrizione2, ca_quest, nr_num_scelte_possibili) 
                           values (@ddDescr1, @ddDescr1, @caQuest, @nrNumSceltePossibili)", conn);
    cmd.Parameters.AddWithValue("@ddDescr1", sDescr1);
    cmd.Parameters.AddWithValue("@ddDescr2", sDescr2);
    cmd.Parameters.AddWithValue("@caQuest", caQuest);
    cmd.Parameters.AddWithValue("@nrNumSceltePossibili", nrNumSceltePossibili);
    cmd.ExecuteNonQuery();
    MySqlCommand cmdLastId = new MySqlCommand("select last_insert_id()", conn);
    cmdLastId.ExecuteScalar();
    object result = cmdLastId.ExecuteScalar();
    if (result != null)
      return Convert.ToInt32(result.ToString());
    else
      return 0;
  } /* insertAQuestSezione */

  /// <summary>
  /// Cancella da a_quest_sezione il record con id=idQuestSezione
  /// </summary>
  /// <param name="idQuestSezione"></param>
  public static void deleteAQuestSezione(int idQuestSezione)
  {
    MySqlConnection conn = getConnection();
    MySqlCommand cmd = new MySqlCommand(
      @"delete from a_quest_sezione
         where id=@id", conn);
    cmd.Parameters.AddWithValue("@id", idQuestSezione);
    cmd.ExecuteNonQuery();
  } /* deleteAQuestSezione */

  /// <summary>
  /// Ritorna il record di a_quest_item con id = idAQuestItem
  /// </summary>
  /// <param name="idAQuestItem"></param>
  /// <returns></returns>
  public static DataTable getAQuestItem(int idAQuestItem)
  {
    MySqlConnection conn = getConnection(getConnectionString());
    MySqlCommand cmd = new MySqlCommand(
      @"select *
          from a_quest_item 
         where id = @idAQuestItem", conn);
    cmd.Parameters.AddWithValue("@idAQuestItem", idAQuestItem);
    MySqlDataAdapter adapter = new MySqlDataAdapter(cmd);
    DataSet dataset = new DataSet();
    adapter.Fill(dataset);
    conn.Close();
    return dataset.Tables[0];
  } /* getAQuestItem */

  /// <summary>
  /// Ritorna a_quest_item per idAQuest e idAQuestSezione
  /// </summary>
  /// <param name="idAQuest"></param>
  /// <returns></returns>
  public static DataTable getAQuestItemsSezione(int idAQuest, int idAQuestSezione)
  {
    MySqlConnection conn = getConnection(getConnectionString());
    MySqlCommand cmd = new MySqlCommand(
      @"select *
          from a_quest_item 
         where ca_quest = @caQuest
           and ca_quest_sezione = @caQuestSezione", conn);
    cmd.Parameters.AddWithValue("@caQuest", idAQuest);
    cmd.Parameters.AddWithValue("@caQuestSezione", idAQuestSezione);
    MySqlDataAdapter adapter = new MySqlDataAdapter(cmd);
    DataSet dataset = new DataSet();
    adapter.Fill(dataset);
    conn.Close();
    // Forza id come pk
    dataset.Tables[0].PrimaryKey = new DataColumn[1] { dataset.Tables[0].Columns["id"] };
    return dataset.Tables[0];
  } /* getAQuestItemsSezione */

  /// <summary>
  /// Ritorna le domande del questionario idQuest
  /// </summary>
  /// <param name="idQuest"></param>
  /// <returns></returns>
  public static DataTable getQuestItems(int idQuest)
  {
    MySqlConnection conn = getConnection(getConnectionString());
    MySqlCommand cmd = new MySqlCommand(
      @"select * 
          from v_a_quest_item 
         where ca_quest = @caQuest
      order by nr_order", conn);
    cmd.Parameters.AddWithValue("@caQuest", idQuest);
    MySqlDataAdapter adapter = new MySqlDataAdapter(cmd);
    DataSet dataset = new DataSet();
    adapter.Fill(dataset);
    conn.Close();
    return dataset.Tables[0];
  } /* getQuestItems */

  /// <summary>
  /// Ritorna il numero di domande per idQuest
  /// </summary>
  /// <param name="idQuest"></param>
  /// <returns></returns>
  public static int getNumDomande(int idQuest)
  {
    MySqlCommand cmd = buildCommand(
      @"select count(*)
          from a_quest_item
         where ca_quest = @idQuest");
    cmd.Parameters.AddWithValue("@idQuest", idQuest);
    cmd.ExecuteScalar();
    object result = cmd.ExecuteScalar();
    if (result != null)
      return Convert.ToInt32(result.ToString());
    else
      return 0;
  } /* getNumDomande */
  #endregion QUESTIONARI

  #region GRAFICO

  /// <summary>
  /// Ritorna DataTable di tutti i questionari del paziente associato
  /// al questionario idMQuest. 
  /// </summary>
  /// <param name="idMQuest"></param>
  /// <returns></returns>
  public static DataTable getRisultatiPaziente(int idMQuest)
  {
    MySqlConnection conn = getConnection();
    MySqlCommand cmd = new MySqlCommand(
      @"select Data, nr_risultato1, nr_risultato2, nr_risultato3
          from v_m_quest
         where IdPaziente = ( select ca_paziente from m_quest where id = @idMQuest )
      order by Data
      limit 20", conn);
    cmd.Parameters.AddWithValue("@idMQuest", idMQuest);
    MySqlDataAdapter adapter = new MySqlDataAdapter(cmd);
    DataSet dataset = new DataSet();
    adapter.Fill(dataset);
    conn.Close();
    return dataset.Tables[0];
  } /* getRisultatiPaziente */
  #endregion GRAFICO

  #region AMMINISTRAZIONE
  /// <summary>
  /// Inserisce un record in z_log
  /// </summary>
  /// <param name="ddOp"></param>
  /// <param name="ddMsg"></param>
  /// <param name="czUtente"></param>
  public static void insertZLog(string ddOp, string ddMsg, int czUtente)
  {
    MySqlCommand cmdInsert = buildCommand(
     @"insert into z_log(dd_op, dd_msg, cz_utente, dt_now) 
        values (@ddOp, @ddMsg, @czUtente, now())");
    cmdInsert.Parameters.AddWithValue("@ddOp", ddOp);
    cmdInsert.Parameters.AddWithValue("@ddMsg", ddMsg);
    cmdInsert.Parameters.AddWithValue("@czUtente", czUtente);
    cmdInsert.ExecuteNonQuery();
  } /* insertZLog */

  public static DataTable getLog()
  {
    MySqlConnection conn = getConnection(getConnectionString());
    MySqlCommand cmd = new MySqlCommand(
      @"select 
            id, dd_op, dd_msg, cz_utente, dt_now, dd_login
          from v_log
      order by id desc", conn);
    MySqlDataAdapter adapter = new MySqlDataAdapter(cmd);
    DataSet dataset = new DataSet();
    adapter.Fill(dataset);
    conn.Close();
    // Forza id come pk
    dataset.Tables[0].PrimaryKey = new DataColumn[1] { dataset.Tables[0].Columns["id"] };
    return dataset.Tables[0];
  } /* getLog */

  public static void updateUtente(
    int id,
    string ddLogin, string ddPassword, string ddNome, string ddCognome,
    string ddMail, int czProfilo)
  {
    MySqlConnection conn = getConnection();
    MySqlCommand cmd = new MySqlCommand(
      @"update z_utente
          set dd_login = @ddLogin, 
              dd_password = @ddPassword, 
              dd_nome = @ddNome, 
              dd_cognome = @ddCognome, 
              dd_mail = @ddMail, 
              cz_profilo =  @czProfilo
          where id=@id", conn);
    cmd.Parameters.AddWithValue("@ddLogin", ddLogin);
    cmd.Parameters.AddWithValue("@ddPassword", ddPassword);
    cmd.Parameters.AddWithValue("@ddNome", ddNome);
    cmd.Parameters.AddWithValue("@ddCognome", ddCognome);
    cmd.Parameters.AddWithValue("@ddMail", ddMail);
    cmd.Parameters.AddWithValue("@czProfilo", czProfilo);
    cmd.Parameters.AddWithValue("@id", id);
    cmd.ExecuteNonQuery();
  } /* updateUtente */

  public static void deleteUtente(int id)
  {
    MySqlConnection conn = getConnection();
    MySqlCommand cmd = new MySqlCommand(
      @"delete from z_utente
         where id=@id", conn);
    cmd.Parameters.AddWithValue("@id", id);
    cmd.ExecuteNonQuery();
  } /* deleteUtente */

  public static int insertUtente(
    string ddLogin, string ddPassword, string ddNome, string ddCognome,
    string ddMail, int czProfilo)
  {
    MySqlConnection conn = getConnection();
    MySqlCommand cmd = new MySqlCommand(
      @"insert into z_utente(dd_login, dd_password, dd_nome, dd_cognome,
          dd_mail, cz_profilo) 
        values (@ddLogin, @ddPassword, @ddNome, @ddCognome, @ddMail, @czProfilo)", conn);
    cmd.Parameters.AddWithValue("@ddLogin", ddLogin);
    cmd.Parameters.AddWithValue("@ddPassword", ddPassword);
    cmd.Parameters.AddWithValue("@ddNome", ddNome);
    cmd.Parameters.AddWithValue("@ddCognome", ddCognome);
    cmd.Parameters.AddWithValue("@ddMail", ddMail);
    cmd.Parameters.AddWithValue("@czProfilo", czProfilo);
    cmd.ExecuteNonQuery();
    MySqlCommand cmdLastId = new MySqlCommand("select last_insert_id()", conn);
    cmdLastId.ExecuteScalar();
    object result = cmdLastId.ExecuteScalar();
    if (result != null)
      return Convert.ToInt32(result.ToString());
    else
      return 0;
  } /* insertUtente */
  
  public static DataTable getUtenti()
  {
    MySqlConnection conn = getConnection(getConnectionString());
    MySqlCommand cmd = new MySqlCommand(
      @"select id, dd_login, dd_nome, dd_cognome, dd_mail, dd_profilo, dd_password, cz_profilo
          from v_utenti_profilo
      order by id", conn);
    MySqlDataAdapter adapter = new MySqlDataAdapter(cmd);
    DataSet dataset = new DataSet();
    adapter.Fill(dataset);
    conn.Close();
    // Forza id come pk
    dataset.Tables[0].PrimaryKey = new DataColumn[1] { dataset.Tables[0].Columns["id"] };
    return dataset.Tables[0];
  } /* getUtenti */

  public static DataTable getProfili()
  {
    MySqlConnection conn = getConnection(getConnectionString());
    MySqlCommand cmd = new MySqlCommand(
      @"select 
            id, dd_descrizione
          from z_profilo
      order by id", conn);
    MySqlDataAdapter adapter = new MySqlDataAdapter(cmd);
    DataSet dataset = new DataSet();
    adapter.Fill(dataset);
    conn.Close();
    return dataset.Tables[0];
  } /* getProfili */

  #endregion AMMINISTRAZIONE

  #region PAZIENTI
  public static void setRecPaziente(int idPaziente)
  {
    if (DALRuntime.RecPaziente == null)
      DALRuntime.RecPaziente = new DALRuntime.TRecPaziente();
    if (idPaziente > 0)
      DALRuntime.RecPaziente.readPaziente(idPaziente);
  }

  public static TRecPaziente getRecPaziente(int idPaziente)
  {
    if (DALRuntime.RecPaziente == null)
      setRecPaziente(idPaziente);
    return DALRuntime.RecPaziente;
  }

  /// <summary>
  /// Ritorna cognome e nome concatenato. Usata all'inizio della compilazione dei questionari
  /// </summary>
  /// <returns></returns>
  public static DataTable getPazienti()
  {
    MySqlConnection conn = getConnection(getConnectionString());
    MySqlCommand cmd = new MySqlCommand("select concat(dd_cognome, ' ', dd_nome) CognomeNome, id from a_paziente order by dd_cognome", conn);
    MySqlDataAdapter adapter = new MySqlDataAdapter(cmd);
    DataSet dataset = new DataSet();
    adapter.Fill(dataset);
    conn.Close();
    return dataset.Tables[0];
  } /* getPazienti */

  /// <summary>
  /// Usata in FmPazienti
  /// </summary>
  /// <returns></returns>
  public static DataTable getPazienti2()
  {
    MySqlConnection conn = getConnection(getConnectionString());
    MySqlCommand cmd = new MySqlCommand(
      @"select 
          id, dd_cognome, dd_nome, ct_titolo, cd_sesso, dt_nascita, 
          cd_fiscale, ct_stato_civile, dd_titolo, dd_stato_civile,
          dd_medico_nome, dd_medico_cognome, dd_medico_email, dd_foto,
          bl_nota
          from v_a_paziente 
      order by dd_cognome", conn);
    MySqlDataAdapter adapter = new MySqlDataAdapter(cmd);
    DataSet dataset = new DataSet();
    adapter.Fill(dataset);
    conn.Close();
    // Forza id come pk
    dataset.Tables[0].PrimaryKey = new DataColumn[1] { dataset.Tables[0].Columns["id"] };
    return dataset.Tables[0];
  } /* getPazienti2 */

  /// <summary>
  /// Ritorna datatable vuota su a_pazienti. Usata per insert
  /// </summary>
  /// <returns></returns>
  public static DataTable getPazientiEmpty()
  {
    MySqlConnection conn = getConnection(getConnectionString());
    MySqlCommand cmd = new MySqlCommand(
      @"select 
          id, dd_cognome, dd_nome, ct_titolo, cd_sesso, cast(dt_nascita as date) dt_nascita, 
          cd_fiscale, ct_stato_civile, dd_titolo, dd_stato_civile
          from v_a_paziente 
          where 0=1", conn);
    MySqlDataAdapter adapter = new MySqlDataAdapter(cmd);
    DataSet dataset = new DataSet();
    adapter.Fill(dataset);
    conn.Close();
    return dataset.Tables[0];
  } /* getPazientiEmpty */

  /// <summary>
  /// Apre a_paziente su id=idPaziente
  /// </summary>
  /// <param name="idPaziente"></param>
  /// <returns></returns>
  public static DataTable getPazienteById(int idPaziente)
  {
    MySqlConnection conn = getConnection(getConnectionString());
    MySqlCommand cmd = new MySqlCommand(
      @"select 
          id, dd_cognome, dd_nome, ct_titolo, cd_sesso, dt_nascita, 
          cd_fiscale, ct_stato_civile, dd_titolo, dd_stato_civile
          from v_a_paziente 
         where id = @idPaziente", conn);
    cmd.Parameters.AddWithValue("@idPaziente", idPaziente);
    MySqlDataAdapter adapter = new MySqlDataAdapter(cmd);
    DataSet dataset = new DataSet();
    adapter.Fill(dataset);
    conn.Close();
    return dataset.Tables[0];
  } /* getPazienteById */

  /// <summary>
  /// Cancella il record idPaziente
  /// </summary>
  /// <param name="idPaziente"></param>
  /// <returns></returns>
  public static void deletePazienteById(int idPaziente)
  {
    MySqlConnection conn = getConnection(getConnectionString());
    MySqlCommand cmd = new MySqlCommand(
      @"delete
          from a_paziente 
         where id = @idPaziente", conn);
    cmd.Parameters.AddWithValue("@idPaziente", idPaziente);
    cmd.ExecuteNonQuery();
    conn.Close();
  } /* deletePazienteById */

  public class TRecPaziente
  {
    public int idPaziente { get; set; }
    public string Cognome { get; set; }
    public string Nome { get; set; }
    public DateTime DataNascita { get; set; }
    public string Sesso { get; set; }
    public string CdFiscale { get; set; }
    public int CtTitolo { get; set; }
    public int CtStatoCivile { get; set; }
    public string ddFoto { get; set; }
    public string MedicoCognome { get; set; }
    public string MedicoNome { get; set; }
    public string MedicoMail { get; set; }
    public string Note { get; set; }

    public string getSaluto()
    {
      if (Sesso == "F")
        return "sig.a " + Nome + " " + Cognome;
      else
        return "sig. " + Nome + " " + Cognome;
    }

    /// <summary>
    /// Si compila leggendo da a_paziente dove id=idPaziente
    /// </summary>
    /// <param name="idPaziente"></param>
    public void readPaziente(int idPaziente)
    {
      this.idPaziente = idPaziente;
      MySqlCommand cmd = buildCommand(
      @"select id, dd_nome, dd_cognome, cd_sesso, dt_nascita, cd_fiscale, ct_titolo,
               ct_stato_civile, dd_foto
          from a_paziente
         where id = @idPaziente");
      cmd.Parameters.AddWithValue("@idPaziente", idPaziente);
      MySqlDataReader r = cmd.ExecuteReader();
      if (r.Read())
      {
        this.Cognome = r["DD_COGNOME"].ToString();
        this.Nome = r["DD_NOME"].ToString();
        this.Sesso = r["CD_SESSO"].ToString();
        this.DataNascita = Convert.ToDateTime(r["DT_NASCITA"].ToString());
        this.CdFiscale = r["CD_FISCALE"].ToString();
        this.CtTitolo = Convert.ToInt32(r["CT_TITOLO"].ToString());
        this.CtStatoCivile = Convert.ToInt32(r["CT_STATO_CIVILE"].ToString());
        this.ddFoto = r["DD_FOTO"].ToString();
      }
      else
      {
        this.Cognome = string.Empty;
        this.Nome = string.Empty;
        this.Sesso = string.Empty;
        this.CdFiscale = string.Empty;
        this.CtTitolo = 0;
        this.CtStatoCivile = 0;
        // TODO: cosa faccio con la data di nascita ??
        this.ddFoto = string.Empty;
      }
      r.Close();
    } /* readPaziente */

    public void updatePaziente()
    {
      MySqlCommand cmd = buildCommand(
      @"update a_paziente
           set dd_nome = @ddNome, dd_cognome = @ddCognome, 
               cd_sesso = @cdSesso, dt_nascita = @dtNascita, 
               cd_fiscale = @cdFiscale, ct_titolo = @ctTitolo,
               ct_stato_civile = @tStatoCivile,
               dd_medico_nome = @ddMedicoNome, 
               dd_medico_cognome = @ddMedicoCognome, 
               dd_medico_email = @ddMedicoEmail, 
               dd_foto = @ddFoto,
               bl_nota = @blNota
         where id = @idPaziente");
      cmd.Parameters.AddWithValue("@ddNome", this.Nome);
      cmd.Parameters.AddWithValue("@ddCognome", this.Cognome);
      cmd.Parameters.AddWithValue("@cdSesso", this.Sesso);
      cmd.Parameters.AddWithValue("@dtNascita", this.DataNascita);
      cmd.Parameters.AddWithValue("@cdFiscale", this.CdFiscale);
      cmd.Parameters.AddWithValue("@ctTitolo", this.CtTitolo);
      cmd.Parameters.AddWithValue("@tStatoCivile", this.CtStatoCivile);
      cmd.Parameters.AddWithValue("@idPaziente", this.idPaziente);
      cmd.Parameters.AddWithValue("@ddMedicoNome", this.MedicoNome);
      cmd.Parameters.AddWithValue("@ddMedicoCognome", this.MedicoCognome);
      cmd.Parameters.AddWithValue("@ddMedicoEmail", this.MedicoMail);
      cmd.Parameters.AddWithValue("@ddFoto", this.ddFoto);
      cmd.Parameters.AddWithValue("@blNota", this.Note);
      cmd.ExecuteNonQuery();
    } /* updatePaziente */

    public void insertPaziente()
    {
      MySqlCommand cmd = buildCommand(
      @"insert into a_paziente
          (dd_nome, dd_cognome, cd_sesso, dt_nascita, cd_fiscale,
           ct_titolo, ct_stato_civile, dd_medico_nome, dd_medico_cognome, dd_medico_email, dd_foto,
           bl_nota, cz_utente)
        values (@ddNome, @ddCognome, @cdSesso, @dtNascita, 
                @cdFiscale, @ctTitolo, @ctStatoCivile,
                @ddMedicoNome, @ddMedicoCognome, @ddMedicoEmail, @ddFoto,
                @blNota, @czUtente)");
      cmd.Parameters.AddWithValue("@ddNome", this.Nome);
      cmd.Parameters.AddWithValue("@ddCognome", this.Cognome);
      cmd.Parameters.AddWithValue("@cdSesso", this.Sesso);
      cmd.Parameters.AddWithValue("@dtNascita", this.DataNascita);
      cmd.Parameters.AddWithValue("@cdFiscale", this.CdFiscale);
      cmd.Parameters.AddWithValue("@ctTitolo", this.CtTitolo);
      cmd.Parameters.AddWithValue("@ctStatoCivile", this.CtStatoCivile);
      cmd.Parameters.AddWithValue("@ddMedicoNome", this.MedicoNome);
      cmd.Parameters.AddWithValue("@ddMedicoCognome", this.MedicoCognome);
      cmd.Parameters.AddWithValue("@ddMedicoEmail", this.MedicoMail);
      cmd.Parameters.AddWithValue("@ddFoto", this.ddFoto);
      cmd.Parameters.AddWithValue("@blNota", this.Note);
      cmd.Parameters.AddWithValue("@czUtente", DALRuntime.IdUtente);
      cmd.ExecuteNonQuery();
    } /* insertPaziente */

  }
  #endregion PAZIENTI

  #region UTENTI
  public class TRecUtente
  {
    public int idUtente { get; set; }
    public int czProfilo { get; set; }
    string Nome { get; set; }
    string Cognome { get; set; }
    string DdProfilo { get; set; }

    public void init(int idUtente, int czProfilo, string Nome, string Cognome, string DdProfilo)
    {
      this.czProfilo = czProfilo;
      this.idUtente = idUtente;
      this.Nome = Nome;
      this.Cognome = Cognome;
      this.DdProfilo = DdProfilo;
    }

    public string getDescrizione()
    {
      return "utente: " + this.Nome + " " + this.Cognome + " - profilo: " + this.DdProfilo;
    }
  }
  
  public static void setRecUtente(int idUtente, int czProfilo, string Nome, string Cognome, string DdProfilo)
  {
    if (DALRuntime.RecUtente == null)
      DALRuntime.RecUtente = new DALRuntime.TRecUtente();
    DALRuntime.RecUtente.init(idUtente, czProfilo, Nome, Cognome, DdProfilo);
    DALRuntime.IdUtente = RecUtente.idUtente;
    DALRuntime.IdProfilo = RecUtente.czProfilo;
  }
  #endregion

  #region UTILITY
  public static string getAbsolutePath(string sImagePath, string sFilename)
  {
    string relAppPath = HttpContext.Current.Server.MapPath("~/");
    if (!relAppPath.EndsWith("/"))
      relAppPath += "/";
    return (sImagePath.Replace("~/", relAppPath) + sFilename).Replace('/', '\\');
  }

  public static string checkAndGetImagePath(string sImagePath, string sFoto)
  {
    string sImage = sImagePath;
    // espande la tilde nel percorso fisico per verificare l'esistenza del file
    string sPath = getAbsolutePath(sImagePath, sFoto);
    if (System.IO.File.Exists(sPath))
      sImage += sFoto;
    else
      sImage += fImageNotPresent;
    return sImage;
  }
  #endregion
}