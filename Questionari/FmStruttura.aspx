<%@ Page Title="" Language="C#" MasterPageFile="~/MasterEmma.master" AutoEventWireup="true" CodeFile="FmStruttura.aspx.cs" Inherits="Questionari_FmStruttura" %>

<%@ Register Assembly="DevExpress.Web.ASPxGridView.v9.3, Version=9.3.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
  Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>

<%@ Register assembly="DevExpress.Web.ASPxEditors.v9.3, Version=9.3.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxEditors" tagprefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
  <dx:ASPxGridView ID="grdAQuest" runat="server" AutoGenerateColumns="False" 
    KeyFieldName="id" onrowdeleting="grdAQuest_RowDeleting" 
    onrowinserting="grdAQuest_RowInserting" 
    onrowupdating="grdAQuest_RowUpdating">
    <SettingsEditing Mode="EditFormAndDisplayRow" />
    <SettingsBehavior ConfirmDelete="True" />
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
      <dx:GridViewDataTextColumn Caption="Descrizione breve" 
        FieldName="dd_descr_breve" VisibleIndex="3">
      </dx:GridViewDataTextColumn>
    </Columns>
    <Templates>
    <DetailRow>
      <dx:ASPxGridView ID="grdAQuestSezioni" runat="server" 
        AutoGenerateColumns="False" 
        KeyFieldName="id"
        ondatabinding="grdAQuestSezioni_DataBinding" 
        onrowdeleting="grdAQuestSezioni_RowDeleting" 
        onrowinserting="grdAQuestSezioni_RowInserting" 
        onrowupdating="grdAQuestSezioni_RowUpdating">
        <SettingsEditing Mode="EditFormAndDisplayRow" />        
        <SettingsBehavior ConfirmDelete="True" />
        <SettingsText ConfirmDelete="Confermi la cancellazione ?" />
        <Templates>
          <DetailRow>
            <dx:ASPxGridView ID="grdAQuestItem" runat="server" 
              AutoGenerateColumns="False" 
              KeyFieldName="id" 
              ondatabinding="grdAQuestItem_DataBinding" 
              onrowdeleting="grdAQuestItem_RowDeleting" 
              onrowinserting="grdAQuestItem_RowInserting" 
              onrowupdating="grdAQuestItem_RowUpdating"
              onhtmlrowcreated="grdAQuestItem_HtmlRowCreated" >
              <SettingsEditing Mode="EditFormAndDisplayRow" />        
              <SettingsDetail IsDetailGrid="True" />
              <SettingsBehavior ConfirmDelete="True" />
              <SettingsText ConfirmDelete="Confermi la cancellazione ?" />
              <Templates>
          <EditForm>
      <div style="padding:4px 4px 3px 4px">
      <table>
      <tr>
      <td rowspan="6">
            <dx:ASPxImage ID="imgDomanda" runat="server">
            </dx:ASPxImage>
      </td>
      <td>
        <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="Domanda">
        </dx:ASPxLabel>
      </td>
      </tr>
      <tr>
      <td>
        <dx:ASPxTextBox ID="edtDdDomanda" runat="server" Width="600px" Text='<%# Bind("dd_domanda") %>'>
        </dx:ASPxTextBox>
      </td>
      </tr>
      <tr>
      <td>
        <dx:ASPxLabel ID="ASPxLabel2" runat="server" Text="Risposte">
        </dx:ASPxLabel>
      </td>
      </tr>
      <tr>
      <td>
        <dx:ASPxTextBox ID="edtRisposte" runat="server" Width="600px" Text='<%# Bind("dd_risposte") %>'>
        </dx:ASPxTextBox>
      </td>
      </tr>
      <tr>
      <td>
        <dx:ASPxLabel ID="ASPxLabel3" runat="server" Text="Num. ordine">
        </dx:ASPxLabel>
        <dx:ASPxTextBox ID="edtNrOrder" runat="server" Width="50px"  Text='<%# Bind("nr_order") %>'>
        </dx:ASPxTextBox>
      </td>
      </tr>
      </table>
      </div>          
     <div style="text-align:right; padding:2px 2px 2px 2px">
         <dx:ASPxGridViewTemplateReplacement ID="UpdateButton" ReplacementType="EditFormUpdateButton" runat="server"></dx:ASPxGridViewTemplateReplacement>
         <dx:ASPxGridViewTemplateReplacement ID="CancelButton" ReplacementType="EditFormCancelButton" runat="server"></dx:ASPxGridViewTemplateReplacement>
     </div>
          </EditForm>
          </Templates>
              <Columns>
                <dx:GridViewCommandColumn VisibleIndex="0">
                  <EditButton Visible="True">
                  </EditButton>
                  <NewButton Visible="True">
                  </NewButton>
                  <DeleteButton Visible="True">
                  </DeleteButton>
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn Caption="Codice" FieldName="id" 
                  VisibleIndex="1" EditFormSettings-Visible="False">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Domanda" FieldName="dd_domanda" 
                  VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Risposte" FieldName="dd_risposte" 
                  VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Immagine" FieldName="dd_immagine" 
                  VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Posizione" 
                  FieldName="nr_order" VisibleIndex="5">
                </dx:GridViewDataTextColumn>
              </Columns>
            </dx:ASPxGridView>
          </DetailRow>
        </Templates>
        <Columns>
          <dx:GridViewCommandColumn VisibleIndex="0">
            <EditButton Visible="True">
            </EditButton>
            <NewButton Visible="True">
            </NewButton>
            <DeleteButton Visible="True">
            </DeleteButton>
          </dx:GridViewCommandColumn>
          <dx:GridViewDataTextColumn Caption="Codice" FieldName="id" VisibleIndex="1"
           EditFormSettings-Visible="False" >
            <EditFormSettings Visible="False" />
          </dx:GridViewDataTextColumn>
          <dx:GridViewDataTextColumn Caption="Descrizione breve" FieldName="dd_descrizione1" 
            VisibleIndex="2">
          </dx:GridViewDataTextColumn>
          <dx:GridViewDataTextColumn Caption="Descrizione completa" FieldName="dd_descrizione2" 
            VisibleIndex="3">
          </dx:GridViewDataTextColumn>
          <dx:GridViewDataTextColumn Caption="# scelte" 
            FieldName="nr_num_scelte_possibili" VisibleIndex="4">
          </dx:GridViewDataTextColumn>
        </Columns>
        <SettingsDetail IsDetailGrid="True" ShowDetailRow="True" />
      </dx:ASPxGridView>
    </DetailRow>
    </Templates>
    <SettingsDetail ShowDetailRow="True" />
  </dx:ASPxGridView>
</asp:Content>

