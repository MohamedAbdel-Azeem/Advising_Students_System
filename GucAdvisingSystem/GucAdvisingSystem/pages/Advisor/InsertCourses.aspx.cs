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
    public partial class InsertCourses : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Insertcourses(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand View = new SqlCommand("Procedures_AdvisorAddCourseGP", conn);
            View.CommandType = CommandType.StoredProcedure;
            try
            {
                string semester_code = sem_code1.Text;
                string Course_name = course_name.Text;
                int student_Id = Int16.Parse(studentId1.Text);
                View.Parameters.AddWithValue("@course_name", Course_name);
                View.Parameters.AddWithValue("@student_id", student_Id);
                View.Parameters.AddWithValue("@Semester_code", semester_code);
                conn.Open();
                View.ExecuteNonQuery();
                conn.Close();
                sem_code1.Text = string.Empty;
                course_name.Text = string.Empty;
                studentId1.Text = string.Empty;
                ClientScript.RegisterStartupScript(this.GetType(), "alert", $@"
                        swal({{
                            title: 'Success!',
                            text: 'New Course Added',
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