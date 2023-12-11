using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GucAdvisingSystem.pages.Student.Requests
{
    public partial class Course_Request : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Course_requested(object sender, EventArgs e)
        {

                try
                {
                    string connStr = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();
                    SqlConnection conn = new SqlConnection(connStr);
                    SqlCommand requestCourse = new SqlCommand("dbo.Procedures_StudentSendingCourseRequest", conn);
                    String  courseID = courseIDInput.Text;
                    String Comment = CommentInput.Text;
                    if (courseID == "")
                    {
                        throw new Exception();
                    }
                    int courseint = Int16.Parse(courseIDInput.Text);
                requestCourse.CommandType = System.Data.CommandType.StoredProcedure;
                requestCourse.Parameters.AddWithValue("@courseID", courseint);
                requestCourse.Parameters.AddWithValue("@StudentID", Session["id"]);
                requestCourse.Parameters.AddWithValue("@comment",Comment);
                    requestCourse.Parameters.AddWithValue("@type","Course");
                    conn.Open();
                    requestCourse.ExecuteNonQuery();
                    conn.Close();
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", $@"
                        swal({{
                            title: 'Success!',
                            text: 'Request Sent Successfully',
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
