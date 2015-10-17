<%@ Page Title="" Language="C#" MasterPageFile="~/MasterEmma.master" AutoEventWireup="true" CodeFile="FmPazienti.aspx.cs" Inherits="Tabelle_FmPazienti" %>

<%@ Register Assembly="DevExpress.Web.v9.3, Version=9.3.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
  Namespace="DevExpress.Web.ASPxUploadControl" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.ASPxGridView.v9.3, Version=9.3.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
  Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>

<%@ Register assembly="DevExpress.Web.ASPxEditors.v9.3, Version=9.3.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxEditors" tagprefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
  <dx:ASPxGridView ID="grdPazienti" runat="server" AutoGenerateColumns="False" ClientInstanceName="grdPazienti"
    KeyFieldName="ID" Width="800px" onhtmlrowcreated="grdPazienti_HtmlRowCreated" 
    onrowupdating="grdPazienti_RowUpdating" 
    onrowdeleting="grdPazienti_RowDeleting" 
    onrowinserting="grdPazienti_RowInserting">
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
        <ClearFilterButton Visible="True">
        </ClearFilterButton>
      </dx:GridViewCommandColumn>
      <dx:GridViewDataTextColumn Caption="Cognome" FieldName="dd_cognome" 
        Name="Cognome" VisibleIndex="1">
      </dx:GridViewDataTextColumn>
      <dx:GridViewDataTextColumn Caption="Nome" FieldName="dd_nome" VisibleIndex="2">
      </dx:GridViewDataTextColumn>
      <dx:GridViewDataTextColumn Caption="Codice fiscale" FieldName="cd_fiscale" 
        VisibleIndex="3">
      </dx:GridViewDataTextColumn>
      <dx:GridViewDataDateColumn Caption="Data nascita" FieldName="dt_nascita" 
        VisibleIndex="4">
        <PropertiesDateEdit DisplayFormatString="d" DisplayFormatInEditMode="True">
        </PropertiesDateEdit>
      </dx:GridViewDataDateColumn>
      <dx:GridViewDataTextColumn Caption="Titolo di studio" FieldName="dd_titolo" 
        VisibleIndex="5">
      </dx:GridViewDataTextColumn>
      <dx:GridViewDataTextColumn Caption="Stato civile" FieldName="dd_stato_civile" 
        VisibleIndex="6">
      </dx:GridViewDataTextColumn>
      <dx:GridViewDataTextColumn Caption="Nome medico" FieldName="dd_medico_nome" Visible="false"
        VisibleIndex="7">
      </dx:GridViewDataTextColumn>
      <dx:GridViewDataTextColumn Caption="Medico" FieldName="dd_medico_cognome" 
        VisibleIndex="8">
      </dx:GridViewDataTextColumn>
      <dx:GridViewDataTextColumn Caption="Mail medico" FieldName="dd_medico_email" 
        VisibleIndex="9">
      </dx:GridViewDataTextColumn>
    </Columns>
    <Templates>
    <EditForm>
    <div style="padding:4px 4px 3px 4px">
     <table>
     <tr>
     <td>&nbsp;</td>
     <td colspan="4" align="center" style="border-bottom: solid 1px black">
     Dati anagrafici
     </td>
     </tr>
     <tr>
         <td rowspan="9">
             <div style="border: solid 1px #C2D4DA; padding: 2px;">
         <% if (!grdPazienti.IsNewRowEditing)
            { %>
             <dx:ASPxImage ID="imgPaziente" runat="server" Width="225px" Height="225px"></dx:ASPxImage>
         <% } %>
             </div>
         </td>
<td>
<table>
         <tr>
           <td>
             Nome</td>
           <td>
             <dx:ASPxTextBox ID="edFirst" runat="server" Text='<%# Bind("dd_nome") %>' 
               Width="150px">
             </dx:ASPxTextBox>
           </td>
           <td>
             Cognome</td>
           <td>
             <dx:ASPxTextBox ID="edLast" runat="server" Text='<%# Bind("dd_cognome") %>' 
               Width="150px">
             </dx:ASPxTextBox>
           </td>
         </tr>
</table>                
</td>  
     </tr>

<tr>
<td>
  <table>
    <tr>
       <td style="white-space:nowrap">Data di nascita</td>
       <td style="width: 40px">
       <dx:ASPxDateEdit runat="server" ID="edtDtNascita" Value='<%# Bind("dt_nascita") %>' Width="100px">
       </dx:ASPxDateEdit> </td>
       <td style="white-space:nowrap">Sesso</td>
       <td>
       <dx:ASPxComboBox ID="cbxSesso" runat="server" ValueType="System.String" Text='<%# Bind("cd_sesso") %>' Width="100px">
         <Items>
           <dx:ListEditItem Text="Non specificato" Value="" />
           <dx:ListEditItem Text="Femminile" Value="F" />
           <dx:ListEditItem Text="Maschile" Value="M" />
         </Items>
       </dx:ASPxComboBox>
       </td>              
       <td style="white-space:nowrap">Codice fiscale</td>
       <td><dx:ASPxTextBox runat="server" ID="edtCdFiscale" Text='<%# Bind("cd_fiscale") %>' Width="150px">
       </dx:ASPxTextBox>   </td>       
       </tr>
    </table>
  </td>   
</tr>

     <tr>
     <td colspan="4">
     <table>
      <tr>
         <td style="white-space:nowrap">Titolo di studio</td>
         <td>
           <dx:ASPxComboBox ID="cbxTitoloStudio" runat="server" TextField="dd_descrizione" 
             ValueField="id" ValueType="System.Int32" Text='<%# Bind("ct_titolo") %>'>
           </dx:ASPxComboBox>
         </td>
         <td style="white-space:nowrap">Stato civile</td>
         <td>
           <dx:ASPxComboBox ID="cbxStatoCivile" runat="server" TextField="dd_descrizione" 
             ValueField="id" ValueType="System.Int32" Text='<%# Bind("ct_stato_civile") %>'>
           </dx:ASPxComboBox>
         </td>
      </tr> 
     </table>
     </td>
     </tr>
     <tr>
     <tr>
     <td colspan="4" align="center" style="border-bottom: solid 1px black" >Medico curante</td>
     </tr>
       <tr>
         <td colspan="4">
           <div style="border: solid 1px #C2D4DA; padding: 2px;">
             <table>
               <tr>
                 <td>
                   Nome</td>
                 <td>
                   <dx:ASPxTextBox ID="edtNomeMedico" runat="server" 
                     Text='<%# Bind("dd_medico_nome") %>' Width="150px">
                   </dx:ASPxTextBox>
                 </td>
                 <td>
                   Cognome</td>
                 <td>
                   <dx:ASPxTextBox ID="edtCognomeMedico" runat="server" 
                     Text='<%# Bind("dd_medico_cognome") %>' Width="150px">
                   </dx:ASPxTextBox>
                 </td>
                 <td>
                   Email</td>
                 <td>
                   <dx:ASPxTextBox ID="edtMailMedico" runat="server" 
                     Text='<%# Bind("dd_medico_email") %>' Width="150px">
                   </dx:ASPxTextBox>
                 </td>
               </tr>
             </table>
           </div>
         </td>
       </tr>
       <tr>
         <td align="center" colspan="4" style="border-bottom: solid 1px black">
           Note
         </td>
       </tr>
       <tr>
         <td colspan="4">
           <dx:ASPxMemo ID="memNote" runat="server" Height="100px" 
             Text='<%# Bind("bl_nota")%>' Width="100%">
           </dx:ASPxMemo>
         </td>
       </tr>
     </tr>
     </table>
     <% if (!grdPazienti.IsNewRowEditing)
        { %>
     <table>
     <tr>
       <td valign="top">Carica foto
       </td>
       <td>
       <dx:ASPxUploadControl ID="uploadImage" runat="server" ShowProgressPanel="True" Size="30"
         ShowUploadButton="True" 
         onfileuploadcomplete="uploadImage_FileUploadComplete" 
           ClientInstanceName="uploadImage">
         <ClientSideEvents FileUploadComplete="function(s, e) {
	grdPazienti.CancelEdit();
}" />
       </dx:ASPxUploadControl>
     </td>
     </tr>
     </table>
     </table>    
         <% } %>
     </div>
     <div style="text-align:right; padding:2px 2px 2px 2px">
         <dx:ASPxGridViewTemplateReplacement ID="UpdateButton" ReplacementType="EditFormUpdateButton" runat="server"></dx:ASPxGridViewTemplateReplacement>
         <dx:ASPxGridViewTemplateReplacement ID="CancelButton" ReplacementType="EditFormCancelButton" runat="server"></dx:ASPxGridViewTemplateReplacement>
     </div>
    </EditForm>
    </Templates>
    <Settings ShowFilterRow="True" />
  </dx:ASPxGridView>
</asp:Content>

