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
    public partial class Studentmajor : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {


        }

        protected void Viewadvstud(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();
            try
            {
                SqlConnection conn = new SqlConnection(connStr);
                SqlCommand View = new SqlCommand("Procedures_AdvisorViewAssignedStudents", conn);
                string major = Major.Text;
                View.Parameters.AddWithValue("@AdvisorID", Session["id"]);
                View.Parameters.AddWithValue("@major", major);
                DataTable dtTable = new DataTable();

                View.CommandType = CommandType.StoredProcedure;
                SqlDataAdapter adp = new SqlDataAdapter(View);
                conn.Open();
                adp.Fill(dtTable);
                conn.Close();
                GridV.DataSource = dtTable;
                GridV.DataBind();

            }

            catch (Exception)
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('Error!', 'Please enter Valid Data and Do not leave anything blank!', 'error');", true);
            }
        }
    }
}