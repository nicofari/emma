using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Questionari_FmGrafico : System.Web.UI.Page
{
  protected void doAddSerie(int iNum)
  {
    string sNomeSerie = "Risultato sezione " + iNum.ToString();
    chartTest.Series.Add(sNomeSerie);
    chartTest.Series[sNomeSerie].XValueMember = "Data";
    // chartTest.Series[sNomeSerie].YValueType = System.Web.UI.DataVisualization.Charting.ChartValueType.Date;
    chartTest.Series[sNomeSerie].YValueMembers = "nr_risultato" + iNum.ToString();
    chartTest.Series[sNomeSerie].ChartType = System.Web.UI.DataVisualization.Charting.SeriesChartType.Line;
    chartTest.Series[sNomeSerie].IsValueShownAsLabel = true;
    switch (iNum)
    {
      case 1:
        chartTest.Series[sNomeSerie].MarkerStyle = System.Web.UI.DataVisualization.Charting.MarkerStyle.Circle;
        break;
      case 2:
        chartTest.Series[sNomeSerie].MarkerStyle = System.Web.UI.DataVisualization.Charting.MarkerStyle.Cross;
        break;
      case 3:
        chartTest.Series[sNomeSerie].MarkerStyle = System.Web.UI.DataVisualization.Charting.MarkerStyle.Diamond;
        break;
      default:
        break;
    }
  }

  protected void Page_Load(object sender, EventArgs e)
  {
//    if (!IsPostBack) {
      // Se è stato passato IdMQuest come parametro ...
      if (Request.Params["IdMQuest"] != null && Request.Params["IdMQuest"].ToString() != string.Empty)
      {
        int idMQuest = Convert.ToInt32(Request.Params["IdMQuest"].ToString());
        DALRuntime.setRecMQuest(idMQuest);
        DALRuntime.setRecPaziente(DALRuntime.RecMQuest.CaPaziente);
        chartTest.Titles.Add(DALRuntime.RecMQuest.DdQuestionario);
        chartTest.Titles.Add(DALRuntime.RecPaziente.getSaluto());
        chartTest.ChartAreas[0].AxisX.MajorGrid.Enabled = true;
        chartTest.ChartAreas[0].AxisX.MinorGrid.Enabled = true;
        chartTest.ChartAreas[0].AxisY.Minimum = 0;
        chartTest.ChartAreas[0].AxisY.Maximum = 10;
        chartTest.Series.Clear();
        doAddSerie(1);
        doAddSerie(2);
        doAddSerie(3);
        chartTest.Legends.Clear();
        chartTest.Legends.Add("Grafico");
        chartTest.Legends["Grafico"].Title = "Risultati test 2010";
        chartTest.Legends["Grafico"].Docking = System.Web.UI.DataVisualization.Charting.Docking.Bottom;
        // abilita 3d
        chartTest.ChartAreas[0].Area3DStyle.Enable3D = chkShow3D.Checked;

        chartTest.DataSource = DALRuntime.getRisultatiPaziente(idMQuest);
        chartTest.DataBind();
      }
    }
//  } // if !IsPostback
}
