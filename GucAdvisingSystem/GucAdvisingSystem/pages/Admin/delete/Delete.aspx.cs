using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Admin
{
    public partial class Delete : System.Web.UI.Page
    {

        String courseName;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string connStr = ConfigurationManager.ConnectionStrings["Advising_System"].ConnectionString;
                SqlConnection con = new SqlConnection(connStr);
                {
                    SqlCommand cmd = new SqlCommand("SELECT course_id , name FROM Course", con);
                    con.Open();
                    DropDownList1.DataTextField = "name";
                    courseName = DropDownList1.DataTextField;
                    DropDownList1.DataValueField = "course_id";
                    DropDownList1.DataSource = cmd.ExecuteReader();
                    DropDownList1.DataBind();
                    con.Close();
                }
            }
        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            string conStr = ConfigurationManager.ConnectionStrings["Advising_System"].ConnectionString;
            SqlConnection conn = new SqlConnection(conStr);
            int c_id = Int16.Parse(DropDownList1.Text);

            SqlCommand deleteproc = new SqlCommand("Procedures_AdminDeleteCourse", conn);
            deleteproc.CommandType = CommandType.StoredProcedure;

            // Add parameters to the stored procedure
            deleteproc.Parameters.Add(new SqlParameter("@courseID", c_id));


            //deleteproc.Parameters.Add(new SqlParameter("@courseID", c_id));
            conn.Open();
            deleteproc.ExecuteNonQuery();
            conn.Close();
            ClientScript.RegisterStartupScript(this.GetType(), "alert", $@"
                        swal({{
                            title: 'Success!',
                            text: 'Course Deleted Successfully',
                            icon: 'success',
                            closeOnClickOutside: true,
                            closeOnEsc: true,
                        }}).then(() => {{
                        window.location.href = 'Delete.aspx';
                        }});
                    ", true);
        }
    }
}