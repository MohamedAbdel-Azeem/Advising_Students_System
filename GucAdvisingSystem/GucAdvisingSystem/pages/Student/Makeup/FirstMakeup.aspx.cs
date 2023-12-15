using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GucAdvisingSystem.pages.Student.Makeup
{
    public partial class FirstMakeup : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void Register(object sender, EventArgs e)
        {

            try
            {
                string connStr = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();
                SqlConnection conn = new SqlConnection(connStr);

                SqlCommand requestCourse = new SqlCommand("Procedures_StudentRegisterFirstMakeup", conn);
                String courseID = courseIDInput.Text;
                if (courseID == "")
                {
                    throw new Exception();
                }

                int courseint = Int16.Parse(courseIDInput.Text);

                SqlCommand log = new SqlCommand("Select dbo.FN_StudentCheckFMEligibility(@CourseID, @StudentID)", conn);

                log.Parameters.AddWithValue("@courseID", courseint);
                log.Parameters.AddWithValue("@StudentID", Session["id"]);
                log.CommandType = CommandType.Text;

                conn.Open();
                bool result = (bool)log.ExecuteScalar();
                conn.Close();
                if (result == true)
                {
                    requestCourse.CommandType = System.Data.CommandType.StoredProcedure;
                    requestCourse.Parameters.AddWithValue("@StudentID", Session["id"]);
                    requestCourse.Parameters.AddWithValue("@courseID", courseint);
                    requestCourse.Parameters.AddWithValue("@studentCurr_sem", Session["SEM"]);
                    conn.Open();
                    requestCourse.ExecuteNonQuery();
                    conn.Close();
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", $@"
                        swal({{
                            title: 'Success!',
                            text: 'Registration Complete',
                            icon: 'success',
                            closeOnClickOutside: true,
                            closeOnEsc: true,
                        }});
                    ", true);
                }
                else
                {
                    ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('Error!', 'You are not eligible for this Makeup', 'error');", true);
                }


            }
            catch (Exception)
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('Error!', 'Please enter Valid Data and Do not leave anything blank!', 'error');", true);
            }
        }
    }
}