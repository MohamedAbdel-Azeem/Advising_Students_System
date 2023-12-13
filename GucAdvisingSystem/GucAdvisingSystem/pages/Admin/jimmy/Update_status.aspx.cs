using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Admin
{
    public partial class Update_status : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string connStr = ConfigurationManager.ConnectionStrings["Advising_System"].ConnectionString;
                SqlConnection con = new SqlConnection(connStr);
                {
                    SqlCommand cmd = new SqlCommand("SELECT student_id FROM Student", con);
                    con.Open();
                    DropDownList1.DataTextField = "student_id";
                    DropDownList1.DataValueField = "student_id";
                    DropDownList1.DataSource = cmd.ExecuteReader();
                    DropDownList1.DataBind();

                }
            }
        }
        protected void status_update(object sender, EventArgs e)
        {
            string conStr = ConfigurationManager.ConnectionStrings["Advising_System"].ConnectionString;
            SqlConnection conn = new SqlConnection(conStr);
            int s_id = Int16.Parse(DropDownList1.Text);

            SqlCommand updstatproc = new SqlCommand("Procedure_AdminUpdateStudentStatus", conn);
            updstatproc.CommandType = CommandType.StoredProcedure;

            // Add parameters to the stored procedure
            updstatproc.Parameters.Add(new SqlParameter("@student_id", s_id));


            //deleteproc.Parameters.Add(new SqlParameter("@courseID", c_id));
            conn.Open();
            updstatproc.ExecuteNonQuery();
            conn.Close();
        }
    }
}