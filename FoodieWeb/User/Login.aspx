<%@ Page Title="" Language="C#" MasterPageFile="~/User/User.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="FoodieWeb.User.Login" %>
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
    <section class="book_section layout_padding">
        <div class="container" >
            <div class="heading_container">
                <div class="align-self-end">
                    <asp:Label runat="server" ID="lblMsg" ></asp:Label>
                </div>
                <h2>Đăng nhập</h2>
            </div>
            <div class="row">
                <div class="col-md-6">
                    <div class="form-container">
                        <img id="userLogin" src="../Images/login.png" class="img-thumbnail" />
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form_container">
                        <div>  
                            <asp:RequiredFieldValidator ID="rfvUsername" runat="server" ErrorMessage="Tài khoản bắt buộc" ControlToValidate="txtUsername"
                                ForeColor="Red" Display="Dynamic" SetFocusOnError="true" Font-Size="Small" ></asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtUsername" runat="server" placeholder="Nhập tài khoản" CssClass="form-control"></asp:TextBox>
                        </div>
                         <div>  
                            <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ErrorMessage="Mật khẩu bắt buộc" ControlToValidate="txtPassword"
                                ForeColor="Red" Display="Dynamic" SetFocusOnError="true" Font-Size="Small" ></asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtPassword" runat="server" placeholder="Nhập mật khẩu" TextMode="Password" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="btn-box">
                            <asp:Button ID="btnLogin" runat="server" Text="Đăng nhập" CssClass="btn btn-success rounded-pill pl-4 pr-4 text-white"
                                OnClick="btnLogin_Click" />
                            <span class="pl-3 text-info">Bạn chưa có tài khoản? <a href="Registration.aspx" class="badge badge-info"> Đăng ký tại đây...</a></span>
                        </div> 
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
