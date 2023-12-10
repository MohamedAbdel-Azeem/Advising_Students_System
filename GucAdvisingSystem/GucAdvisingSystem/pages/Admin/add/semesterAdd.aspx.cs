using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GucAdvisingSystem.pages.Admin.add
{
    public partial class semesterAdd : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void addSemester(object sender, EventArgs e)
        {
            try
            {
                string connStr = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();
                SqlConnection conn = new SqlConnection(connStr);
                SqlCommand addSemester = new SqlCommand("dbo.AdminAddingSemester", conn);
                String semCode = SemesterCodeInput.Text;
                String startDate = Request.Form["SemesterStartInput"];
                String endDate = Request.Form["SemesterEndInput"];
                if (semCode.Trim() == "" | startDate == "" | endDate == "" )
                {
                    throw new Exception();
                }
                addSemester.CommandType = CommandType.StoredProcedure;
                addSemester.Parameters.AddWithValue("@semester_code", semCode);
                addSemester.Parameters.AddWithValue("@start_date", startDate);
                addSemester.Parameters.AddWithValue("@end_date", endDate);
                conn.Open();
                addSemester.ExecuteNonQuery();
                conn.Close();
                ClientScript.RegisterStartupScript(this.GetType(), "alert", $@"
                        swal({{
                            title: 'Success!',
                            text: 'Semester Added Successfully',
                            icon: 'success',
                            closeOnClickOutside: true,
                            closeOnEsc: true,
                        }});
                    ", true);
            }
            catch (Exception) {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('Error!', 'Please enter Valid Data and Do not leave anything blank!', 'error');", true);
            }


        }

        
    }
}