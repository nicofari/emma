<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FmGrafico.aspx.cs" Inherits="Questionari_FmGrafico" %>

<%@ Register Assembly="DevExpress.Web.ASPxEditors.v9.3, Version=9.3.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
  Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
  Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
      <asp:Chart ID="chartTest" runat="server" Height="500px" Width="750px">
        <Series>
          <asp:Series Name="Series1">
          </asp:Series>
        </Series>
        <ChartAreas>
          <asp:ChartArea Name="ChartArea1">
          </asp:ChartArea>
        </ChartAreas>
      </asp:Chart>
      <dx:ASPxCheckBox ID="chkShow3D" runat="server" AutoPostBack="True" 
        Text="Abilita 3D">
      </dx:ASPxCheckBox>
    </div>
    </form>
</body>
</html>
