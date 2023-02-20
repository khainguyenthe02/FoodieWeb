<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="User.aspx.cs" Inherits="FoodieWeb.Admin.User" %>
<%@ Import Namespace="FoodieWeb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script>

        //Disappearing alert masage
        window.onload = function () {
            var seconds = 5;
            setTimeout(function () {
                document.getElementById("<%=lblMsg.ClientID%>").style.display = "none";
            }, seconds * 1000);
        };
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="pcoded-inner-content pt-0">
        <div class="align-align-self-end">
            <asp:Label ID="lblMsg" runat="server" Visible="false"></asp:Label>
        </div>
        <div class="main-body">
            <div class="page-wrapper">
                <div class="page-body">
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="card">
                                <div class="card-header">
                                </div>
                                <div class="card-block">
                                    <div class="row">


                                        <div class="col-12 mobile-inputs">
                                            <h4 class="sub-title">Danh sách người dùng</h4>
                                            <div class="card-block table-border-style">
                                                <div class="table-responsive">
                                                    <asp:Repeater ID="rUser" runat="server" OnItemCommand="rUser_ItemCommand"
                                                        >
                                                        <HeaderTemplate>
                                                            <table class="table data-table-export table-hover nowrap">
                                                                <thead>
                                                                    <tr>
                                                                        <th class="table-plus">Mã</th>
                                                                        <th>Họ tên</th>
                                                                        <th>Tài khoản</th>
                                                                        <th>Email</th>
                                                                        <th>Ngày lập</th>
                                                                        <th class="datatable-nosort">Xóa</th>
                                                                    </tr>
                                                                </thead>                                                              
                                                        <tbody>   
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <tr>
                                                                <td class="table-plus"> <%# Eval("SrNo") %></td>
                                                                <td><%# Eval("FullName") %> </td>
                                                                <td><%# Eval("UserName") %> </td>
                                                                <td><%# Eval("Email") %> </td>
                                                                <td> <%# Eval("CreatedDate") %></td>
                                                                <td>
                                                                    <asp:LinkButton ID="lnkDelete" Text="Xóa" runat="server"
                                                                        CssClass="badge badge-danger"
                                                                        CommandArgument='<%# Eval("UserID") %>' CommandName="Delete"
                                                                        OnClientClick="return confirm('Bạn xác nhận xóa người dùng này?');">
                                                                        <i class="ti-trash"></i>
                                                                    </asp:LinkButton>
                                                                </td>
                                                            </tr>
                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            </tbody>
                                                            </table>
                                                        </FooterTemplate>
                                                        
                                                    </asp:Repeater>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</asp:Content>
