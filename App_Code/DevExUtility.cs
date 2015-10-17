using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DevExpress.Web.ASPxGridView;
using DevExpress.Web.ASPxEditors;
using DevExpress.Web.ASPxMenu;
using DevExpress.Web.ASPxPanel;

/// <summary>
/// Summary description for DevExUtility
/// </summary>
public class DevExUtility
{
	public DevExUtility()
	{
		//
		// TODO: Add constructor logic here
		//
	}

  public static void GridApplyTheme(ASPxGridView Grid, string theTheme)
  {
    Grid.CssFilePath = "~/App_Themes/Glass/{0}/styles.css";
    Grid.CssPostfix = "Glass";
    Grid.Styles.CssFilePath = "~/App_Themes/Glass/{0}/styles.css";
    Grid.Styles.CssPostfix = "Glass";
    Grid.Styles.Header.SortingImageSpacing = 5;
  }

  public static void MenuApplyTheme(ASPxMenu Menu, string theTheme)
  {
    Menu.CssFilePath = "~/App_Themes/Glass/{0}/styles.css";
    Menu.CssPostfix = "Glass";
    Menu.ImageFolder = "~/App_Themes/Glass/{0}/";
  }

  public static void LabelApplyTheme(ASPxLabel Label, string theTheme)
  {
    Label.CssFilePath = "~/App_Themes/Glass/{0}/styles.css";
    Label.CssPostfix = "Glass";
  }

  public static void EditorApplyTheme(ASPxEditBase Editor, string theTheme)
  {
    Editor.CssFilePath = "~/App_Themes/Glass/{0}/styles.css";
    Editor.CssPostfix = "Glass";
  }

  public static void PanelApplyTheme(ASPxPanelBase Panel, string theTheme)
  {
    Panel.CssFilePath = "~/App_Themes/Glass/{0}/styles.css";
    Panel.CssPostfix = "Glass";
  }
}
