<%@ Page Title="" Language="C#" MasterPageFile="~/MasterEmma.master" AutoEventWireup="true" CodeFile="FmArchivio.aspx.cs" Inherits="Tabelle_FmArchivio" %>

<%@ Register Assembly="DevExpress.Web.v9.3, Version=9.3.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
  Namespace="DevExpress.Web.ASPxMenu" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.ASPxGridView.v9.3.Export, Version=9.3.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
  Namespace="DevExpress.Web.ASPxGridView.Export" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v9.3, Version=9.3.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
  Namespace="DevExpress.Web.ASPxPopupControl" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.ASPxGridView.v9.3, Version=9.3.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
  Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>

<%@ Register assembly="DevExpress.Web.ASPxEditors.v9.3, Version=9.3.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxEditors" tagprefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
  <dx:ASPxGridView ID="grdMQuest" runat="server" AutoGenerateColumns="False">
    <SettingsPager PageSize="20">
    </SettingsPager>
    <Columns>
      <dx:GridViewDataTextColumn FieldName="IdMQuest" Visible="False" 
        VisibleIndex="0">
      </dx:GridViewDataTextColumn>
      <dx:GridViewDataTextColumn FieldName="IdAQuest" Visible="False" 
        VisibleIndex="0">
      </dx:GridViewDataTextColumn>
      <dx:GridViewDataTextColumn FieldName="IdPaziente" Visible="False" 
        VisibleIndex="0">
      </dx:GridViewDataTextColumn>
      <dx:GridViewDataTextColumn Caption="Cognome" FieldName="Cognome" 
        VisibleIndex="0">
      </dx:GridViewDataTextColumn>
      <dx:GridViewDataTextColumn Caption="Nome" FieldName="Nome" VisibleIndex="1">
      </dx:GridViewDataTextColumn>
      <dx:GridViewDataDateColumn Caption="Data" FieldName="Data" VisibleIndex="2">
        <PropertiesDateEdit DisplayFormatString="">
        </PropertiesDateEdit>
      </dx:GridViewDataDateColumn>
      <dx:GridViewDataTextColumn Caption="Risultato 1" FieldName="nr_risultato1" 
        VisibleIndex="3">
      </dx:GridViewDataTextColumn>
      <dx:GridViewDataTextColumn Caption="Risultato 2" FieldName="nr_risultato2" 
        VisibleIndex="4">
      </dx:GridViewDataTextColumn>
      <dx:GridViewDataTextColumn Caption="Risultato 3" FieldName="nr_risultato3" 
        VisibleIndex="5">
      </dx:GridViewDataTextColumn>
      <dx:GridViewDataTextColumn Caption="Medico di famiglia" FieldName="dd_medico_famiglia" 
        VisibleIndex="6">
      </dx:GridViewDataTextColumn>
      <dx:GridViewDataTextColumn Caption="Somministrato da" FieldName="dd_utente" 
        VisibleIndex="7">
      </dx:GridViewDataTextColumn>
      <dx:GridViewDataHyperLinkColumn Caption="Lettera" VisibleIndex="8" 
        FieldName="IdMQuest">
        <PropertiesHyperLinkEdit NavigateUrlFormatString="~/Questionari/FmLettera.aspx?IdMQuest={0}" 
          Text="Lettera">
        </PropertiesHyperLinkEdit>
      </dx:GridViewDataHyperLinkColumn>
      <dx:GridViewDataHyperLinkColumn Caption="Grafico" VisibleIndex="9" 
        FieldName="IdMQuest">
        <PropertiesHyperLinkEdit NavigateUrlFormatString="javascript:ShowGraficoPopup('{0}');"
          Text="Grafico">
        </PropertiesHyperLinkEdit>
      </dx:GridViewDataHyperLinkColumn>
    </Columns>
    <Settings ShowFilterRow="True" 
      ShowGroupPanel="True" />
  </dx:ASPxGridView>
  <dx:ASPxGridViewExporter ID="ASPxGridViewExporter" runat="server" 
    FileName="Archivio questionari" GridViewID="grdMQuest">
  </dx:ASPxGridViewExporter>
  <dx:ASPxPopupMenu ID="popMnuGridMQuest" runat="server" 
    onitemclick="popMnuGridMQuest_ItemClick" PopupElementID="grdMQuest">
    <Items>
      <dx:MenuItem Name="mniEsportaInExcel" Text="Esporta in Excel">
      </dx:MenuItem>
    </Items>
  </dx:ASPxPopupMenu>
  <dx:ASPxPopupControl ID="ASPxPopupControl1" runat="server" 
    ClientInstanceName="popupGrafico" Width="800px" Height="600px" 
    AllowDragging="True" HeaderText="Grafico risultati test" Modal="True" 
    PopupHorizontalAlign="Center" AllowResize="True">
  <ContentCollection>
  <dx:PopupControlContentControl runat="server">
  </dx:PopupControlContentControl>
  </ContentCollection>
  </dx:ASPxPopupControl>
</asp:Content>

