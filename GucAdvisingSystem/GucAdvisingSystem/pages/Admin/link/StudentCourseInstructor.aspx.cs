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
    public partial class StudentCourseInstructor : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }


        protected void LinkSICT(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand Link = new SqlCommand("dbo.Procedures_AdminLinkStudent", conn);
            try
            {
                int CourseID = Int16.Parse(CourseIDInput.Text);
                int InstructorID = Int16.Parse(InstructorIDInput.Text);
                int StudentID = Int16.Parse(StudentIDInput.Text);
                String semCode = SemesterCodeInput.Text;
                
                if (semCode.Trim() == "") { 
                    throw new Exception();
                }

                Link.CommandType = CommandType.StoredProcedure;
                Link.Parameters.AddWithValue("@cours_id", CourseID);
                Link.Parameters.AddWithValue("@instructor_id", InstructorID);
                Link.Parameters.AddWithValue("@studentID", StudentID);
                Link.Parameters.AddWithValue("@semester_code", semCode);

                conn.Open();
                Link.ExecuteNonQuery();
                conn.Close();

                ClientScript.RegisterStartupScript(this.GetType(), "alert", $@"
                        swal({{
                            title: 'Success!',
                            text: 'Student Linked to Course and Instructor',
                            icon: 'success',
                            closeOnClickOutside: true,
                            closeOnEsc: true,
                        }});
                    ", true);
            }
            catch(Exception)
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(),
                "alert", "swal('Error!', 'Invalid Data or Incomplete Data', 'error');", true);
            }
        }

    }
}