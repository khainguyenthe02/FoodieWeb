using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FoodieWeb.Admin
{
    public partial class Product : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["breadCrum"] = "Product";
                if (Session["admin"] == null)
                {
                    Response.Redirect("../User/Login.aspx");
                }
                else
                {
                    getProducts();
                }
                
            }
        }

        protected void btnAddOrUpdate_Click(object sender, EventArgs e)
        {
            string actionName = string.Empty, imagePath = string.Empty, fileExtension = string.Empty;
            bool isValidToExcute = false;
            int productId = Convert.ToInt32(hdnId.Value);
            con = new SqlConnection(Connection.ConnectionString());
            cmd = new SqlCommand("Product_Crud", con);
            cmd.Parameters.AddWithValue("@Action", productId == 0 ? "INSERT" : "UPDATE");
            cmd.Parameters.AddWithValue("@ProductId", productId);
            cmd.Parameters.AddWithValue("@Name", txtName.Text.Trim());
            cmd.Parameters.AddWithValue("@Description", txtDescription.Text.Trim());
            cmd.Parameters.AddWithValue("@Price", txtPrice.Text.Trim());
            cmd.Parameters.AddWithValue("@Quantity", txtQuantity.Text.Trim());
            cmd.Parameters.AddWithValue("@CategoryId", ddlCategories.SelectedValue) ;
            cmd.Parameters.AddWithValue("@IsActive", cbIsActive.Checked);

            if (fuProductImage.HasFile)
            {
                if (Utils.IsValidExtension(fuProductImage.FileName))
                {
                    Guid obj = Guid.NewGuid();
                    fileExtension = Path.GetExtension(fuProductImage.FileName);
                    imagePath = "Images/Product/" + obj.ToString() + fileExtension;
                    fuProductImage.PostedFile.SaveAs(Server.MapPath("~/Images/Product/") + obj.ToString() + fileExtension);
                    cmd.Parameters.AddWithValue("@ImageUrl", imagePath);
                    isValidToExcute = true;
                }
                else
                {
                    lblMsg.Visible = true;
                    lblMsg.Text = "Vui lòng chọn định dạng ảnh: .jpg, .jpeg hoặc .png";
                    lblMsg.CssClass = "alert alert-danger";
                    isValidToExcute = false;
                }
            }
            else
            {
                isValidToExcute = true;
            }

            if (isValidToExcute)
            {
                cmd.CommandType = CommandType.StoredProcedure;
                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    actionName = productId == 0 ? "inserted" : "updated";
                    lblMsg.Visible = true;
                    lblMsg.Text = "Sản phẩm " + actionName + " successfully";
                    lblMsg.CssClass = "alert alert-success";
                    getProducts();
                    clear();
                }
                catch (Exception ex)
                {
                    lblMsg.Visible = true;
                    lblMsg.Text = "Error: " + ex.Message;
                    lblMsg.CssClass = "alert alert-danger";
                    if(ex.Message.Contains("String or binary data would be truncated"))
                    {
                        lblMsg.Visible = true;
                        lblMsg.Text = "Lỗi: Phần mô tả quá dài, vui lòng bỏ bớt ";
                        lblMsg.CssClass = "alert alert-danger";
                    }
                    else
                    {
                        lblMsg.Visible = true;
                        lblMsg.Text = "Lỗi: " + ex.Message;
                        lblMsg.CssClass = "alert alert-danger";
                    }
                }
                finally
                {
                    con.Close();
                }

            }

        }
        private void getProducts()
        {
            con = new SqlConnection(Connection.ConnectionString());
            cmd = new SqlCommand("Product_Crud", con);
            cmd.Parameters.AddWithValue("@Action", "SELECT");
            cmd.CommandType = CommandType.StoredProcedure;
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            rProduct.DataSource = dt;
            rProduct.DataBind();
        }
        private void clear()
        {
            txtName.Text = txtDescription.Text = txtQuantity.Text = txtPrice.Text =  string.Empty;
            cbIsActive.Checked = false;
            hdnId.Value = "0";
            btnAddOrUpdate.Text = "Thêm";
            ddlCategories.ClearSelection();
            imgProduct.ImageUrl = String.Empty;

        }
        protected void btnClear_Click(object sender, EventArgs e)
        {
            clear();
        }

        protected void rProduct_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            lblMsg.Visible = false;
            con = new SqlConnection(Connection.ConnectionString());
            if (e.CommandName == "Edit")
            {

                cmd = new SqlCommand("Product_Crud", con);
                cmd.Parameters.AddWithValue("@Action", "GETBYID");
                cmd.Parameters.AddWithValue("@ProductId", e.CommandArgument);
                cmd.CommandType = CommandType.StoredProcedure;
                sda = new SqlDataAdapter(cmd);
                dt = new DataTable();
                sda.Fill(dt);
                txtName.Text = dt.Rows[0]["ProductName"].ToString();
                txtDescription.Text = dt.Rows[0]["ProductDescription"].ToString();
                txtPrice.Text = dt.Rows[0]["Price"].ToString();
                ddlCategories.SelectedValue = dt.Rows[0]["CategoryID"].ToString();
                txtQuantity.Text = dt.Rows[0]["Quantity"].ToString();
                cbIsActive.Checked = Convert.ToBoolean(dt.Rows[0]["IsActive"]);
                imgProduct.ImageUrl = string.IsNullOrEmpty(dt.Rows[0]["ImgUrl"].ToString()) ? "../Images/No_image.png" : "../" + dt.Rows[0]["ImgUrl"].ToString();
                imgProduct.Height = 200;
                imgProduct.Width = 200;
                hdnId.Value = dt.Rows[0]["ProductId"].ToString();
                btnAddOrUpdate.Text = "Cập nhật";
                LinkButton btn = e.Item.FindControl("lnkEdit") as LinkButton;
                btn.CssClass = "badge badge-warning";
            }
            else if (e.CommandName == "Delete")
            {

                cmd = new SqlCommand("Product_Crud", con);
                cmd.Parameters.AddWithValue("@Action", "DELETE");
                cmd.Parameters.AddWithValue("@ProductId", e.CommandArgument);
                cmd.CommandType = CommandType.StoredProcedure;
                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    lblMsg.Visible = true;
                    lblMsg.Text = "Sản phẩm đã được xóa!!";
                    lblMsg.CssClass = "alert alert-success";
                    getProducts();
                }
                catch (Exception ex)
                {
                    lblMsg.Visible = true;
                    lblMsg.Text = "Error: " + ex.Message;
                    lblMsg.CssClass = "alert alert-danger";
                }
                finally
                {
                    con.Close();
                }
            }
        }

        protected void rProduct_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            //if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            //{
            //    Label lbl = e.Item.FindControl("lblIsActive") as Label;
            //    Label lblQuantity = e.Item.FindControl("lblQuantity") as Label;
            //    if (lbl.Text == "True")//
            //    {
            //        lbl.Text = "Active";
            //        lbl.CssClass = "badge badge-success";
            //    }
            //    if (Convert.ToInt32(lblQuantity.Text) <= 5)
            //    {
            //        lblQuantity.CssClass = "badge badge-danger";
            //        lblQuantity.ToolTip = "Item about to be 'Out of stock'!";
            //    }
            //    else
            //    {
            //        lbl.Text = "In-Active";
            //        lbl.CssClass = "badge badge-danger";
            //    }
            //}
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Label lbl = e.Item.FindControl("lblIsActive") as Label;
                if (lbl.Text == "True")
                {
                    lbl.Text = "Khả dụng";
                    lbl.CssClass = "badge badge-success";
                }
                else
                {
                    lbl.Text = "Không khả dụng";
                    lbl.CssClass = "badge badge-danger";
                }
            }
        }

        protected void ddlCategories_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}