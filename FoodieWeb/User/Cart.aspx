<%@ Page Title="" Language="C#" MasterPageFile="~/User/User.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="FoodieWeb.User.Cart" %>
<%@ Import Namespace="FoodieWeb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="book_section layout_padding">
        <div class="container">
            <div class="heading_container">
                <div class="align-self-end">
                    <asp:Label ID="lblMsg" runat="server" Visible="false"></asp:Label>
                </div>
                <h2>Giỏ hàng của tôi</h2>
            </div>
        </div>

        <div class="container">
            <asp:Repeater ID="rCartItem" runat="server" OnItemCommand="rCartItem_ItemCommand"
                OnItemDataBound="rCartItem_ItemDataBound" >
                <HeaderTemplate>
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Sản phẩm</th>
                                <th>Hình ảnh</th>
                                <th>Đơn giá</th>
                                <th>Số lượng</th>
                                <th>Thành tiền</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>                    
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td>
                            <asp:Label ID="lblName" runat="server" Text='<%# Eval("ProductName") %>' ></asp:Label>
                        </td>
                        <td>
                            <img width="60" src="<%# Utils.GetImgUrl(Eval("ImgUrl")) %>" alt="" />
                        </td>
                        <td>
                            <asp:Label ID="lblPrice" runat="server" Text='<%# Eval("Price") %>' ></asp:Label> đ
                            <asp:HiddenField ID="hdnProductId" runat="server" Value='<%# Eval("ProductID") %>' />
                            <asp:HiddenField ID="hdnQuantity" runat="server" Value='<%# Eval("Qty") %>' />
                            <asp:HiddenField ID="hdnPrdQuantity" runat="server" Value='<%# Eval("pQty") %>' />
                        </td>
                        <td>
                            <div class="product__details__option">
                                <div class="quantity">
                                    <div class="pro-qty">
                                        <asp:TextBox ID="txtQuantity"  runat="server" TextMode="Number" Text='<%# Eval("Qty") %>'></asp:TextBox>
                                        <asp:RegularExpressionValidator ID="revQuantity" runat="server" ErrorMessage="*" ForeColor="Red" Font-Size="Small"
                                            ValidationExpression="[1-9]*" ControlToValidate="txtQuantity"
                                            Display="Dynamic" SetFocusOnError="true" EnableClientScript="true" ></asp:RegularExpressionValidator>
                                    </div>
                                </div>
                            </div>
                        </td>
                        <td>
                           <asp:Label ID="lblTotalPrice" runat="server" ></asp:Label> đ  
                        </td>
                        <td>
                            <asp:LinkButton ID="lbDelete" Text="Xóa" CommandName="remove"
                                OnClientClick="return comfirm('Bạn có muốn xóa sản phẩm này khỏi giỏ hàng?');" CommandArgument='<%# Eval("ProductID") %>' runat="server">
                                <i class="fa fa-close"></i>
                            </asp:LinkButton>
                        </td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                    <tr>
                        <td colspan="3"></td>
                        <td class="pl-lg-5">
                            <b>Tổng tiền: </b>
                        </td>
                        <td><% Response.Write(Session["grandTotalPrice"]); %>đ</td>
                        <td></td>
                    </tr>
                    <tr>
                        <td colspan="2" class="continue__btn">
                            <a href="Menu.aspx" class="btn btn-info"><i class="fa fa-arrow-circle-left mr-2"></i> Tiếp tục mua hàng</a>
                        </td>
                        <td>
                            <asp:LinkButton ID="lbUpdateCart" CommandName="updateCart" CssClass="btn btn-warning" runat="server">
                                <i class="fa fa-refesh mr-2"></i>Cập nhật
                            </asp:LinkButton>
                        </td>
                        <td>
                            <asp:LinkButton ID="lbCheckout" CommandName="checkout" CssClass="btn btn-success" runat="server">
                                <i class="fa fa-arrow-circle-right mr-2"></i>Thanh toán
                            </asp:LinkButton>
                        </td>
                    </tr>
                    </tbody>
                    </table>
                </FooterTemplate>
            </asp:Repeater>
        </div>
    </section>
</asp:Content>
