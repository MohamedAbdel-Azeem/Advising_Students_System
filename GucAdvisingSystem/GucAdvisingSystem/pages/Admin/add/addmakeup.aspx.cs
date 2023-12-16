using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Admin
{
    public partial class addmakeup : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        
        }
        protected void add_makeup(object sender, EventArgs e)
        {
            try
            {
                string conStr = ConfigurationManager.ConnectionStrings["Advising_System"].ConnectionString;
                SqlConnection conn = new SqlConnection(conStr);
                String type = Request.Form["ExamTypeInput"];
                System.Diagnostics.Debug.WriteLine(type);
                String date = Request.Form["ExamDateInput"];
                int id = Int16.Parse(TextBox3.Text);

                SqlCommand addmakeupproc = new SqlCommand("Procedures_AdminAddExam", conn);
                addmakeupproc.CommandType = CommandType.StoredProcedure;

                // Add parameters to the stored procedure
                addmakeupproc.Parameters.Add(new SqlParameter("@Type", type));
                addmakeupproc.Parameters.Add(new SqlParameter("@date", date));
                addmakeupproc.Parameters.Add(new SqlParameter("@courseID", id));



                //deleteproc.Parameters.Add(new SqlParameter("@courseID", c_id));
                conn.Open();
                addmakeupproc.ExecuteNonQuery();
                conn.Close();

                ClientScript.RegisterStartupScript(this.GetType(), "alert", $@"
                        swal({{
                            title: 'Success!',
                            text: 'Exam Added Successfully',
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