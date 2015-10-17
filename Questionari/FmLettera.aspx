<%@ Page Title="" Language="C#" MasterPageFile="~/MasterEmma.master" AutoEventWireup="true" CodeFile="FmLettera.aspx.cs" Inherits="Questionari_FmLettera" %>

<%@ Register Assembly="DevExpress.Web.ASPxEditors.v9.3, Version=9.3.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
  Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
  <style type="text/css">
    #TextArea1
    {
      height: 233px;
    }
  </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">

<table>
<tr>
<td rowspan="4">
<table>
<tr>
<td><dx:ASPxLabel ID="lblIstruz1" runat="server" Text="Lettera al medico curante" Font-Size="10px"></dx:ASPxLabel></td>
</tr>
<tr>
<td><dx:ASPxLabel ID="lblIstruz2" runat="server" Text="Funzioni disponibili:" Font-Size="10px"></dx:ASPxLabel></td>
</tr>
<tr>
<td><dx:ASPxLabel ID="lblIstruz3" runat="server" Text="o Modificare e salvare il testo con il pulsante Salva" Font-Size="10px"></dx:ASPxLabel></td>
</tr>
<tr>
<td><dx:ASPxLabel ID="lblIstruz4" runat="server" Text="o Spedirla come mail con il pulsante Invia mail" Font-Size="10px"></dx:ASPxLabel></td>
</tr>
<tr>
<td><dx:ASPxLabel ID="lblIstruz5" runat="server" Text="o Salvarla in PDF con il pulsante Genera PDF" Font-Size="10px"></dx:ASPxLabel></td>
</tr>
</table>
</td>
<td>
  <dx:ASPxLabel ID="lblAvviso" runat="server" 
    Text="eventuale messaggio di errore" ForeColor="Red" Visible="False" Font-Bold="true" Font-Size="14px">
  </dx:ASPxLabel>
</td>
</tr>
<tr>
<td>
  <dx:ASPxLabel ID="lblLettera" runat="server" Text="Lettera per il medico curante del paziente: " Font-Bold="true" Font-Size="14px">
  </dx:ASPxLabel>
</td>
</tr>
<tr>
<td>
  <dx:ASPxMemo ID="memLettera" runat="server" Height="400px" Width="700px">
  </dx:ASPxMemo>
</td>
</tr>
<tr>
<td>
  <table>
  <tr>
  <td>
    <dx:ASPxButton ID="btnGeneraPDF" runat="server" Text="Genera PDF" ToolTip="Genera una copia in pdf della lettera"
        onclick="btnGeneraPDF_Click">
    </dx:ASPxButton>
  </td>
  <td>
    <dx:ASPxButton ID="btnSendMail" runat="server" Text="Invia mail" ToolTip="Spedisce la lettera per email al medico curante"
        onclick="btnSendMail_Click">
    </dx:ASPxButton>
  </td>  
  <td>
    <dx:ASPxButton ID="btnSalvaLettera" runat="server" Text="Salva"  ToolTip="Salva la lettera nel database"
        onclick="btnSalvaLettera_Click">
    </dx:ASPxButton>
  </td>    
  <td>
    <dx:ASPxButton ID="btnTestata" runat="server" Text="Intestazione"  
      ToolTip="Modifica l'intestazione della lettera" onclick="btnTestata_Click"
        >
    </dx:ASPxButton>
  </td>    
  </tr>
  </table>  
</td>
</tr>
</table>
</asp:Content>

