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
    public partial class UpdateGradplan : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void UpdateGP(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand View = new SqlCommand("Procedures_AdvisorUpdateGP", conn);
            View.CommandType = CommandType.StoredProcedure;
            try
            {
                string graduation_date = grad_date1.Text;
                int student_Id = Int16.Parse(studentId2.Text);
                View.Parameters.AddWithValue("@studentId", student_Id);
                View.Parameters.AddWithValue("@expected_grad_date", graduation_date);
                conn.Open();
                View.ExecuteNonQuery();
                conn.Close();
                SqlCommand Check = new SqlCommand($"Select * from Graduation_Plan where student_id={student_Id} and expected_grad_date='{graduation_date}'", conn);
                grad_date1.Text = string.Empty;
                studentId2.Text = string.Empty;
                conn.Open();
                SqlDataReader reader = Check.ExecuteReader();

                if (!reader.HasRows)

                {
                    throw new Exception();

                }

                else
                {

                    ClientScript.RegisterStartupScript(this.GetType(), "alert", $@"
                        swal({{
                            title: 'Success!',
                            text: 'Graduation Plan Updated',
                            icon: 'success',
                            closeOnClickOutside: true,
                            closeOnEsc: true,
                        }});
                    ", true);
                }
            }

            catch (Exception)
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('Error!', 'Please enter Valid Data and Do not leave anything blank!', 'error');", true);
            }
        }
    }
}