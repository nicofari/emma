<%@ Page Title="" Language="C#" MasterPageFile="~/MasterEmma.master" AutoEventWireup="true" CodeFile="FmTitoliDiStudio.aspx.cs" Inherits="Tabelle_FmTitoliDiStudio" %>

<%@ Register Assembly="DevExpress.Web.ASPxGridView.v9.3, Version=9.3.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
  Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <dx:ASPxGridView ID="grdTitoliDiStudio" runat="server" KeyFieldName="id" 
    AutoGenerateColumns="False" onrowdeleting="grdTitoliDiStudio_RowDeleting" 
      onrowinserting="grdTitoliDiStudio_RowInserting" 
      onrowupdating="grdTitoliDiStudio_RowUpdating">
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
          <dx:GridViewDataTextColumn Caption="Codice" FieldName="id" VisibleIndex="1">
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

