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
    public partial class ApprRejCHRequest : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Apprejreq(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();
            try
            {
                SqlConnection conn = new SqlConnection(connStr);
                SqlCommand View = new SqlCommand("Procedures_AdvisorApproveRejectCHRequest", conn);
                View.CommandType = CommandType.StoredProcedure;
                int request_Id = Int16.Parse(RequestId.Text);
                View.Parameters.AddWithValue("@requestID", request_Id);
                View.Parameters.AddWithValue("@current_sem_code", Session["Cur_sem"]);
                conn.Open();
                View.ExecuteNonQuery();
                conn.Close();
                RequestId.Text = string.Empty;

            }

            catch (Exception)
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('Error!', 'Please enter Valid Data and Do not leave anything blank!', 'error');", true);
            }
        }
    }
}