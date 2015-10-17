<%@ Page Title="" Language="C#" MasterPageFile="~/MasterEmma.master" AutoEventWireup="true" CodeFile="FmStatoCivile.aspx.cs" Inherits="Tabelle_FmStatoCivile" %>

<%@ Register Assembly="DevExpress.Web.ASPxGridView.v9.3, Version=9.3.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
  Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>

<%@ Register assembly="DevExpress.Web.ASPxEditors.v9.3, Version=9.3.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxEditors" tagprefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
  <dx:ASPxGridView ID="grdStatoCivile" runat="server" AutoGenerateColumns="False" 
    KeyFieldName="id" onrowdeleting="grdStatoCivile_RowDeleting" 
    onrowinserting="grdStatoCivile_RowInserting" 
    onrowupdating="grdStatoCivile_RowUpdating">
      <SettingsBehavior ConfirmDelete="True" />
      <SettingsEditing Mode="EditForm" />
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
          <dx:GridViewDataTextColumn Caption="Codice" FieldName="id" VisibleIndex="1" ReadOnly="true">
            <EditFormSettings Visible="False" />
          </dx:GridViewDataTextColumn>
          <dx:GridViewDataTextColumn Caption="Descrizione" FieldName="dd_descrizione" 
              VisibleIndex="2">
          </dx:GridViewDataTextColumn>
      </Columns>
      <Paddings PaddingBottom="150px" PaddingLeft="250px" PaddingRight="250px" 
            PaddingTop="50px"  />
  </dx:ASPxGridView>
</asp:Content>

