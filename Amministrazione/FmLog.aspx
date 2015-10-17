<%@ Page Title="" Language="C#" MasterPageFile="~/MasterEmma.master" AutoEventWireup="true" CodeFile="FmLog.aspx.cs" Inherits="Amministrazione_FmLog" %>

<%@ Register Assembly="DevExpress.Web.ASPxGridView.v9.3, Version=9.3.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
  Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
  <dx:ASPxGridView ID="grdLog" runat="server" AutoGenerateColumns="False">
    <Columns>
      <dx:GridViewDataTextColumn Caption="Operazione" FieldName="dd_op" 
        VisibleIndex="0">
      </dx:GridViewDataTextColumn>
      <dx:GridViewDataTextColumn Caption="Messaggio" FieldName="dd_msg" 
        VisibleIndex="1">
      </dx:GridViewDataTextColumn>
      <dx:GridViewDataTextColumn Caption="Utente" FieldName="dd_login" 
        VisibleIndex="2">
      </dx:GridViewDataTextColumn>
      <dx:GridViewDataTextColumn Caption="Data e ora" FieldName="dt_now" 
        VisibleIndex="3">
      </dx:GridViewDataTextColumn>
    </Columns>
    <Settings ShowFilterRow="True" ShowGroupPanel="True" />
  </dx:ASPxGridView>
</asp:Content>

