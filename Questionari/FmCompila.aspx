<%@ Page Title="" Language="C#" MasterPageFile="~/MasterEmma.master" AutoEventWireup="true" CodeFile="FmCompila.aspx.cs" Inherits="Tabelle_FmCompila" %>

<%@ Register Assembly="DevExpress.Web.v9.3, Version=9.3.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
  Namespace="DevExpress.Web.ASPxRoundPanel" TagPrefix="dx" %>

<%@ Register assembly="DevExpress.Web.ASPxEditors.v9.3, Version=9.3.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxEditors" tagprefix="dx" %>
<%@ Register assembly="DevExpress.Web.v9.3, Version=9.3.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxPanel" tagprefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
  <style type="text/css">
    .style1
    {
      text-align: left;
    }
  </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
  <dx:ASPxRoundPanel ID="pnlInizio" runat="server" Width="600px" 
    Height="300px" style="margin-left: 0px" 
    HeaderText="Somministra questionario" HeaderStyle-HorizontalAlign="Center">
    <PanelCollection>
    <dx:PanelContent ID="pnlSceltaPaziente" runat="server">
    <table width="100%">
    <tr>
    <td rowspan="6">
    <dx:ASPxPanel ID="ASPxPanel1" runat="server" Width="200px" Height="100%">
    <PanelCollection>
    <dx:PanelContent>
    <div>
      <ul>
        <li class="style1">Scelga il questionario </li>
        <li class="style1">il paziente e poi </li>
        <li class="style1">prema il tasto &quot;Avanti&quot; </li>
      </ul>
    </div>
    </dx:PanelContent>
    </PanelCollection>
    </dx:ASPxPanel>
    </td>
    <td>
    <dx:ASPxLabel ID="lblQuestionario" runat="server" Text="Scelga il questionario">
    </dx:ASPxLabel> 
    </td>
    </tr>
    <tr>
    <td>
    <dx:ASPxListBox ID="lstQuestionari" runat="server" TextField="dd_descr_completa" 
        ValueField="id" Height="60px">
    </dx:ASPxListBox>
    </td>
    </tr>
    <tr>
    <td>
    <dx:ASPxLabel ID="lblAvviso1" runat="server" Text="" Visible="false" ForeColor="Red">
    </dx:ASPxLabel> 
    </td>
    </tr>
    <tr>
    <td>
    <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="Scelga il paziente">
    </dx:ASPxLabel>
    </td>
    </tr>
    <tr>
    <td>
    <dx:ASPxListBox ID="lstPazienti" runat="server" TextField="CognomeNome" 
        ValueField="id" Width="100%" Height="350px">
    </dx:ASPxListBox>
    </td>
    </tr>
    <tr>
    <td align="center">
    <dx:ASPxButton ID="btnAvanti1" runat="server" Text="Avanti" Width="100%"
        OnClick="btnAvanti1_Click">
    </dx:ASPxButton>
    </td>
    </tr>
    </table>
    </dx:PanelContent>
    </PanelCollection>
  </dx:ASPxRoundPanel>
  <dx:ASPxRoundPanel ID="pnlDomanda" runat="server" Width="900px" Visible="false">
    <HeaderTemplate>
    </HeaderTemplate>
  <PanelCollection>
  <dx:PanelContent>
  <table width="100%" cellpadding="0px" cellspacing="0px">
  <tr>
  <td rowspan="11">
    <dx:ASPxLabel ID="lblIstruzioni" runat="server" 
      Text="Cliccare sul pallino accanto alla risposta scelta e premere il tasto &quot;Avanti&quot;" 
      Width="150px">
    </dx:ASPxLabel>
  </td>
  <td style="background-color: #006699" align="left">
    <dx:ASPxLabel ID="lblIntesta1" runat="server" 
      Text="LblIntesta1" ForeColor="White">
    </dx:ASPxLabel>
  </td>
  </tr>
  <tr>
  <td style="background-color: #006699" align="left">
  <table width="50%">
  <tr>
  <td valign="middle" align="left">
    <dx:ASPxLabel ID="lblPaziente" runat="server" Text="sig. a Martha Argerich" 
      ForeColor="White" Font-Bold="true" Font-Size="14px">
    </dx:ASPxLabel>
  </td>
  <td align="left">
    <dx:ASPxImage ID="imgPaziente" runat="server" 
      ImageUrl="~/Immagini/Pazienti/MarthaArgerich.jpeg" Height="60px" 
      Width="60px"></dx:ASPxImage>
   </td>
   </tr>
  </table>      
  </td>
  </tr>
  <tr>
  <td style="background-color: Gray">&nbsp;</td>
  </tr>
  <tr>
  <td style="background-color: Gray">
    <dx:ASPxLabel ID="lblIntesta2" runat="server" Text="" ForeColor="White" 
      Font-Size="14px" Font-Bold="true">
    </dx:ASPxLabel>
   </td>
  </tr>
  <tr>
  <td style="background-color: Gray">&nbsp;</td>
  </tr>
  <tr>
  <td style="background-color: Gray" align="center">
    <dx:ASPxLabel ID="lblDomanda" runat="server" Text="" ForeColor="White" 
      Font-Size="16px" Font-Bold="true">
    </dx:ASPxLabel>
  </td>
  </tr>
  <tr>
  <td style="background-color: Gray" align="right">
    <dx:ASPxLabel ID="lblNumDomanda" runat="server" Text="lblNumDomanda" 
      ForeColor="White" Font-Size="12px">
    </dx:ASPxLabel>
   </td>
  </tr>
  <tr>
  <td align="center">
    <dx:ASPxImage ID="imgDomanda" runat="server">
    </dx:ASPxImage>
  </td>
  </tr>
    <tr>
      <td>
        <dx:ASPxLabel ID="lblAvviso" runat="server" ForeColor="Red" Text="lblAvviso" 
          Visible="False" Font-Size="14px" Font-Bold="true">
        </dx:ASPxLabel>
      </td>
    </tr>
    <tr>
      <td align="center">
        <dx:ASPxRadioButtonList ID="rblRisposta" runat="server" Width="100%">
        </dx:ASPxRadioButtonList>
      </td>
    </tr>
    <tr>
      <td align="center">
        <table width="100%">
        <tr>
        <td>
        <dx:ASPxButton ID="btnAvanti2" runat="server" OnClick="btnAvanti2_Click" 
          Text="Avanti" ToolTip="Domanda successiva" Width="100%">
        </dx:ASPxButton>
        </td>
        <td>
        <dx:ASPxButton ID="btnLettera" runat="server" Text="Lettera" 
            ToolTip="Vai alla lettera" Visible="false" OnClick="btnLettera_Click"></dx:ASPxButton>
        </td>
        <td>
        <dx:ASPxButton ID="btnNuovo" runat="server" Text="Nuovo questionario" 
            ToolTip="Somministra nuovo questionario" Visible="false" 
            OnClick="btnNuovo_Click"></dx:ASPxButton>
        </td>
        </tr>
        </table>
      </td>
    </tr>
    </table>
  </dx:PanelContent>
  </PanelCollection>
  </dx:ASPxRoundPanel>
  <dx:ASPxPanel ID="pnlCompletato" runat="server" Width="200px" Visible="false">
  <PanelCollection>
  <dx:PanelContent>
    <dx:ASPxLabel ID="lblCompletato" runat="server" Text="ASPxLabel">
    </dx:ASPxLabel>
    <dx:ASPxButton runat="server" ID="btnNuovoOld">
    </dx:ASPxButton>
    <dx:ASPxButton runat="server" ID="btnLetteraOld">
    </dx:ASPxButton>
  </dx:PanelContent>
  </PanelCollection>
  </dx:ASPxPanel>
</asp:Content>

