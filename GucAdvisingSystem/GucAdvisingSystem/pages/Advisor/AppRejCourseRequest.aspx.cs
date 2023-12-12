using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GucAdvisingSystem.pages.Advisor
{
    public partial class ApprRejCourseRequest : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ApprejreqC(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();
            try
            {
                SqlConnection conn = new SqlConnection(connStr);
                SqlCommand View = new SqlCommand("Procedures_AdvisorApproveRejectCourseRequest", conn);
                View.CommandType = CommandType.StoredProcedure;
                int request_Id = Int16.Parse(req.Text);
                View.Parameters.AddWithValue("@requestID", request_Id);
                View.Parameters.AddWithValue("@current_semester_code", Session["Cur_sem"]);
                conn.Open();
                View.ExecuteNonQuery();
                conn.Close();
                req.Text = string.Empty;

            }

            catch (Exception)
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('Error!', 'Please enter Valid Data and Do not leave anything blank!', 'error');", true);
            }
        }
    }
}