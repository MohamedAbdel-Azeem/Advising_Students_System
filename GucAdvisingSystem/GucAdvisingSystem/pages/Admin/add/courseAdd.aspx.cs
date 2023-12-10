using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GucAdvisingSystem.pages.Admin.add
{
    public partial class courseAdd : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void addCourse(object sender, EventArgs e) {
            try {
                string connStr = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();
                SqlConnection conn = new SqlConnection(connStr);
                SqlCommand addCourse = new SqlCommand("dbo.Procedures_AdminAddingCourse", conn);
                String courseName = coursenInput.Text;
                int sem = Int16.Parse(SemesterInput.Text);
                int creditHours = Int16.Parse(CredHrsInput.Text);
                int isOfferedValue = (Request.Form["isOfferedInput"] == "on") ? 1 : 0;
                String major = Request.Form["majorInput"];
                if (courseName.Trim() == "")
                {
                    throw new Exception();
                }

                addCourse.CommandType = System.Data.CommandType.StoredProcedure;
                addCourse.Parameters.AddWithValue("@name", courseName);
                addCourse.Parameters.AddWithValue("@credit_hours", creditHours);
                addCourse.Parameters.AddWithValue("@semester", sem);
                addCourse.Parameters.AddWithValue("@major", major);
                addCourse.Parameters.AddWithValue("@is_offered", isOfferedValue);

                conn.Open();
                addCourse.ExecuteNonQuery();
                conn.Close();
                ClientScript.RegisterStartupScript(this.GetType(), "alert", $@"
                        swal({{
                            title: 'Success!',
                            text: 'Course Added Successfully',
                            icon: 'success',
                            closeOnClickOutside: true,
                            closeOnEsc: true,
                        }});
                    ", true);

            } catch (Exception)
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('Error!', 'Please enter Valid Data and Do not leave anything blank!', 'error');", true);
            }
        }

    }
}