using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GucAdvisingSystem.pages.Student.Instructor
{
    public partial class InputInstructor : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void Choose(object sender, EventArgs e)
        {

            try
           {
                String courseID = courseIDInput.Text;
                String instructorid = InstructorInput.Text;

                if (courseID == "" || instructorid == "")
                {
                    throw new Exception();
               }

                string connStr = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();
                SqlConnection conn = new SqlConnection(connStr);

                SqlCommand chooseIns = new SqlCommand("Procedures_Chooseinstructor", conn);
                
                int courseint = Int16.Parse(courseIDInput.Text);
                int instructor = Int16.Parse(InstructorInput.Text);

                chooseIns.CommandType = System.Data.CommandType.StoredProcedure;

                chooseIns.Parameters.AddWithValue("@StudentID", Session["id"]);
                chooseIns.Parameters.AddWithValue("@instrucorID", instructor);
                chooseIns.Parameters.AddWithValue("@courseID", courseint);
                chooseIns.Parameters.AddWithValue("@current_semester_code", Session["SEM"]);

                conn.Open();
                chooseIns.ExecuteNonQuery();
                conn.Close();
                ClientScript.RegisterStartupScript(this.GetType(), "alert", $@"
                        swal({{
                            title: 'Success!',
                            text: 'Instructor Chosen Successfully',
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