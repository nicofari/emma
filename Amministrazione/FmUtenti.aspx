<%@ Page Title="" Language="C#" MasterPageFile="~/MasterEmma.master" AutoEventWireup="true" CodeFile="FmUtenti.aspx.cs" Inherits="Amministrazione_FmUtenti" %>

<%@ Register Assembly="DevExpress.Web.ASPxGridView.v9.3, Version=9.3.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
  Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>

<%@ Register assembly="DevExpress.Web.ASPxEditors.v9.3, Version=9.3.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxEditors" tagprefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
  <dx:ASPxGridView ID="grdUtenti" runat="server" AutoGenerateColumns="False" 
    onhtmlrowcreated="grdUtenti_HtmlRowCreated"  KeyFieldName="id" 
    onrowdeleting="grdUtenti_RowDeleting" onrowinserting="grdUtenti_RowInserting" 
    onrowupdating="grdUtenti_RowUpdating">
    <Templates>
      <EditForm>
      <table>
      <tr>
      <td><dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="Codice utente"></dx:ASPxLabel></td>
      <td>
        <dx:ASPxTextBox ID="edtLogin" runat="server" Text='<%# Bind("dd_login") %>'></dx:ASPxTextBox>
      </td>
      <td><dx:ASPxLabel ID="ASPxLabel2" runat="server" Text="Password"></dx:ASPxLabel></td>
      <td>
        <dx:ASPxTextBox ID="edtPassword" runat="server" Text='<%# Bind("dd_password") %>'></dx:ASPxTextBox>
      </td>
      </tr>
      <tr>
      <td><dx:ASPxLabel ID="ASPxLabel3" runat="server" Text="Nome"></dx:ASPxLabel></td>
      <td>
        <dx:ASPxTextBox ID="edtNome" runat="server" Text='<%# Bind("dd_nome") %>'></dx:ASPxTextBox>
      </td>
      <td><dx:ASPxLabel ID="ASPxLabel4" runat="server" Text="Cognome"></dx:ASPxLabel></td>
      <td>
        <dx:ASPxTextBox ID="edtCognome" runat="server" Text='<%# Bind("dd_cognome") %>'></dx:ASPxTextBox>
      </td>
      </tr>
      <tr>
      <td><dx:ASPxLabel ID="ASPxLabel5" runat="server" Text="Indirizzo mail"></dx:ASPxLabel></td>
      <td>
        <dx:ASPxTextBox ID="edtMail" runat="server" Text='<%# Bind("dd_mail") %>'></dx:ASPxTextBox>
      </td>
      <td><dx:ASPxLabel ID="ASPxLabel6" runat="server" Text="Profilo"></dx:ASPxLabel></td>
      <td>
        <dx:ASPxComboBox ID="cbxProfilo" runat="server" TextField="dd_descrizione" 
             ValueField="id" ValueType="System.Int32" Text='<%# Bind("cz_profilo") %>'>
        </dx:ASPxComboBox>
      </td>
      </tr>
        </table>
     <div style="text-align:right; padding:2px 2px 2px 2px">
         <dx:ASPxGridViewTemplateReplacement ID="UpdateButton" ReplacementType="EditFormUpdateButton" runat="server"></dx:ASPxGridViewTemplateReplacement>
         <dx:ASPxGridViewTemplateReplacement ID="CancelButton" ReplacementType="EditFormCancelButton" runat="server"></dx:ASPxGridViewTemplateReplacement>
     </div>
      </EditForm>
    </Templates>
  <SettingsBehavior ConfirmDelete="True" />
  <SettingsEditing Mode="EditFormAndDisplayRow" />
  <SettingsText ConfirmDelete="Confermi la cancellazione ?" />
    <Columns>
      <dx:GridViewCommandColumn VisibleIndex="0">
        <EditButton Visible="True">
        </EditButton>
        <NewButton Visible="True">
        </NewButton>
        <DeleteButton Visible="True">
        </DeleteButton>
      </dx:GridViewCommandColumn>
      <dx:GridViewDataTextColumn Caption="Cognome" FieldName="dd_cognome" 
        VisibleIndex="1">
      </dx:GridViewDataTextColumn>
      <dx:GridViewDataTextColumn Caption="Nome" FieldName="dd_nome" VisibleIndex="2">
      </dx:GridViewDataTextColumn>
      <dx:GridViewDataTextColumn Caption="Codice utente" FieldName="dd_login" 
        VisibleIndex="3">
      </dx:GridViewDataTextColumn>
      <dx:GridViewDataTextColumn Caption="Indirizzo di posta" FieldName="dd_mail" 
        VisibleIndex="4">
      </dx:GridViewDataTextColumn>
      <dx:GridViewDataTextColumn Caption="Profilo" FieldName="dd_profilo" 
        ToolTip="Profilo" VisibleIndex="5">
      </dx:GridViewDataTextColumn>
      <dx:GridViewDataTextColumn Caption="Password" FieldName="dd_password" 
        Visible="False" VisibleIndex="6">
      </dx:GridViewDataTextColumn>
    </Columns>
  </dx:ASPxGridView>
</asp:Content>

