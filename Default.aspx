<%@ Page Title="" Language="C#" MasterPageFile="~/MasterEmma.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<%@ Register Assembly="DevExpress.Web.ASPxEditors.v9.3, Version=9.3.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
  Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
<div style="height: 600px; float: left;" class="testo">
  <div style="float: right;">
  <asp:Image ID="imgIpad" runat="server" ImageUrl="~/public/Immagini/MedicoConIPad.jpg" />
  </div>
<p>
<b>Emma</b> è un sito dedicato alla somministrazione di questionari clinici.
</p>
Al momento l'unico questionario disponibile è il <b><i>PRO-CLARA</i></b> ma ne possono essere definiti infiniti altri.
<br />
  Il sistema è fruibile da personal computer, desktop o portatili, e da dispositivi mobili
di ogni tipo quali, ad esempio:
<ul>
<li>iphone, ipad</li>
<li>smartphone di altre marche </li>
<li>qualunque dispositivo in grado di navigare su web</li>
</ul>
<p>
<b>Emma</b> mantiene in archivio, e consente di interrogare, i dati dei questionari somministrati
e dei pazienti.
<br />
Per garantire la riservatezza e la sicurezza dei dati, per accedere al sistema è necessario
<a href="Account/Login.aspx">autenticarsi</a> fornendo un codice utente e una password, che possono essere richiesti per mail all'<a href="mailto:software@kotik.it">amministratore del sistema</a>.
</p>
</div>
</asp:Content>

