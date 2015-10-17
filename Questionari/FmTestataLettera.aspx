<%@ Page Title="" Language="C#" MasterPageFile="~/MasterEmma.master" AutoEventWireup="true" CodeFile="FmTestataLettera.aspx.cs" Inherits="Questionari_FmTestataLettera" %>

<%@ Register Assembly="DevExpress.Web.ASPxEditors.v9.3, Version=9.3.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
  Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
<div style="padding-top: 20px; padding-left: 20px;">
  <dx:ASPxMemo ID="memTestata" runat="server" Height="200px" Width="800px">
  </dx:ASPxMemo>
  <table>
  <tr>
  <td>
  <dx:ASPxButton ID="btnSalva" runat="server" Text="Salva" onclick="btnSalva_Click" ToolTip="Salva l'intestazione">
  </dx:ASPxButton>
  </td>
  <td>
  <dx:ASPxButton ID="btnIndietro" runat="server" Text="Indietro" ToolTip="Torna alla lettera"
      onclick="btnIndietro_Click">
  </dx:ASPxButton>
  </td>
  </tr>
  </table>
</div>  
</asp:Content>

