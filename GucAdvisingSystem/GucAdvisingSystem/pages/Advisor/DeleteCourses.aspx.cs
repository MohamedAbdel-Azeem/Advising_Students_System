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
    public partial class DeleteCourses : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }


        protected void Deletecourses(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand View = new SqlCommand("Procedures_AdvisorDeleteFromGP", conn);
            View.CommandType = CommandType.StoredProcedure;
            try
            {
                string semester_code = sem_code2.Text;
                string Course_name = courseID.Text;
                int student_Id = Int16.Parse(studentId3.Text);
                View.Parameters.AddWithValue("@courseID", Course_name);
                View.Parameters.AddWithValue("@studentID", student_Id);
                View.Parameters.AddWithValue("@sem_code", semester_code);
                conn.Open();
                View.ExecuteNonQuery();
                conn.Close();
                sem_code2.Text = string.Empty;
                courseID.Text = string.Empty;
                studentId3.Text = string.Empty;
                ClientScript.RegisterStartupScript(this.GetType(), "alert", $@"
                        swal({{
                            title: 'Success!',
                            text: 'Course Deleted From Grad Plan',
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