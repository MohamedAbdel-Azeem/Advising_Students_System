using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GucAdvisingSystem.pages.Student
{
    public partial class telephone_number : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Add_number(object sender, EventArgs e)
        {
            try
            {
                string connStr = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();
                SqlConnection conn = new SqlConnection(connStr);
                SqlCommand requestCourse = new SqlCommand("dbo.Procedures_StudentaddMobile", conn);
                String number = mobile_number.Text;
                if (number == "")
                {
                    throw new Exception();
                }
                requestCourse.CommandType = System.Data.CommandType.StoredProcedure;
                requestCourse.Parameters.AddWithValue("@StudentID", Session["id"]);
                requestCourse.Parameters.AddWithValue("@mobile_number",number);
                conn.Open();
                requestCourse.ExecuteNonQuery();
                conn.Close();
                ClientScript.RegisterStartupScript(this.GetType(), "alert", $@"
                        swal({{
                            title: 'Success!',
                            text: 'Request Sent Successfully',
                            icon: 'success',
                            closeOnClickOutside: true,
                            closeOnEsc: true,
                        }});
                    ", true);

            }
            catch (Exception)
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('Error!', 'Please enter Valid Data and Do not leave anything blank!', 'error');", true);
            }
        }
    }
    }
