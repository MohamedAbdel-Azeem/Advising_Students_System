using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GucAdvisingSystem.pages.Admin.link
{
    public partial class StudentAdvisor : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void LinkStudentAdvisor(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand Link = new SqlCommand("dbo.Procedures_AdminLinkStudentToAdvisor", conn);
            try
            {
                int studentID = Int16.Parse(StudentIDInput.Text);
                int AdvisorID = Int16.Parse(AdvisorIDInput.Text);

                Link.CommandType = CommandType.StoredProcedure;
                Link.Parameters.AddWithValue("@studentID", studentID);
                Link.Parameters.AddWithValue("@advisorID", AdvisorID);

                conn.Open();
                Link.ExecuteNonQuery();
                conn.Close();
                ClientScript.RegisterStartupScript(this.GetType(), "alert", $@"
                        swal({{
                            title: 'Success!',
                            text: 'Student Linked to Advisor',
                            icon: 'success',
                            closeOnClickOutside: true,
                            closeOnEsc: true,
                        }});
                    ", true);
            }
            catch(Exception)
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(),
                "alert", "swal('Error!', 'Invalid Data', 'error');", true);
            }
        }

    }
}