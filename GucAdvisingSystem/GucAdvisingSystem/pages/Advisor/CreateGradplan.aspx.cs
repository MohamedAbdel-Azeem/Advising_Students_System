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
    public partial class CreateGradplan : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Insertgradplan(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();
           try

            { 
                SqlConnection conn = new SqlConnection(connStr);
                SqlCommand View = new SqlCommand("Procedures_AdvisorCreateGP", conn);
                View.CommandType = CommandType.StoredProcedure;
            
                string semester_code1 = sem_code.Text;
                string graduation_date = grad_date.Text;
                int credit_hours = Int16.Parse(sem_credit_hours.Text);
                int student_Id = Int16.Parse(studentId.Text);
            
          
                if (semester_code1 == "" || graduation_date == "" )
                {
                    throw new Exception();
                }
                View.Parameters.AddWithValue("@advisor_iD", Session["id"]);
                View.Parameters.AddWithValue("@expected_graduation_date", graduation_date);
                View.Parameters.AddWithValue("@sem_credit_hours", credit_hours);
                View.Parameters.AddWithValue("@student_id", student_Id);
                View.Parameters.AddWithValue("@Semester_code", semester_code1);
                conn.Open();
                View.ExecuteNonQuery();
                conn.Close();
                
                SqlCommand Check = new SqlCommand($"Select * from Graduation_Plan where student_id={student_Id} and Semester_code='{semester_code1}'", conn);
                grad_date.Text = string.Empty;
                sem_code.Text = string.Empty;
                sem_credit_hours.Text = string.Empty;
                studentId.Text = string.Empty;
                conn.Open();
                SqlDataReader reader = Check.ExecuteReader();

                if (!reader.HasRows)
               
                {
                    throw new Exception();
                    
                }
               
                else {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", $@"
                        swal({{
                            title: 'Success!',
                            text: 'New Graduation Plan Created',
                            icon: 'success',
                            closeOnClickOutside: true,
                            closeOnEsc: true,
                        }});
                    ", true);
                }

                conn.Close();

            }

            catch (Exception)
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('Error!', 'Please enter Valid Data and Do not leave anything blank!', 'error');", true);
            }


        }
    }
}