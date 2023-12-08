using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GucAdvisingSystem
{
    public partial class registerPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Register(object sender, EventArgs e)
        {
            string type = Request.Form["role"];
            string connStr = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand reg;
            SqlParameter id;

            string pass = passwordInput.Text.Trim();
            string email = emailInput.Text.Trim();

            if (type == "student")
            {
                reg = new SqlCommand("dbo.Procedures_StudentRegistration", conn);
                try {
                    string fn = FnameInput.Text.Trim();
                    string ln = LnameInput.Text.Trim();
                    string major = majorInput.Text.Trim();
                    int sem = Int16.Parse(semesterInput.Text);
                    string faculty = Request.Form["facultyInput"];
                    if (fn == "" || ln == "" | major == "" | pass == "" | email == "") { 
                        throw new Exception();
                    }
                    reg.Parameters.AddWithValue("@first_name", fn);
                    reg.Parameters.AddWithValue("@last_name", ln);
                    reg.Parameters.AddWithValue("@faculty", faculty);
                    reg.Parameters.AddWithValue("@major", major);
                    reg.Parameters.AddWithValue("@Semester", sem);
                    id = reg.Parameters.Add("@Student_id", SqlDbType.Int);
                    
                    reg.CommandType = CommandType.StoredProcedure;
                    reg.Parameters.AddWithValue("@email", email);
                    reg.Parameters.AddWithValue("@password", pass);
                    id.Direction = ParameterDirection.Output;

                    conn.Open();
                    reg.ExecuteNonQuery();
                    conn.Close();
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", $@"
                        swal({{
                            title: 'Success!',
                            text: 'Your User Id is {id.Value} !',
                            icon: 'success',
                            closeOnClickOutside: false,
                            closeOnEsc: false,
                        }}).then(() => {{
                        window.location.href = 'LoginPage.aspx';
                        }});
                    ", true);
                }
                catch (Exception)
                {
                    ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('Error!', 'Please enter Valid Data and Do not leave anything blank!', 'error');", true);
                }
            }
            else // Advisor Registering
            {
                try {
                    string An = AdvisornameInput.Text;
                    string office = officeInput.Text;

                    if (An == "" || office == "" | pass == "" | email == "")
                    {
                        throw new Exception();
                    }

                    reg = new SqlCommand("dbo.Procedures_AdvisorRegistration", conn);
                    reg.Parameters.AddWithValue("@advisor_name", An);
                    reg.Parameters.AddWithValue("@office", office);
                    id = reg.Parameters.Add("@Advisor_id", SqlDbType.Int);
                    reg.CommandType = CommandType.StoredProcedure;
                    reg.Parameters.AddWithValue("@email", email);
                    reg.Parameters.AddWithValue("@password", pass);
                    id.Direction = ParameterDirection.Output;

                    conn.Open();
                    reg.ExecuteNonQuery();
                    conn.Close();
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", $@"
                        swal({{
                            title: 'Success!',
                            text: 'Your User Id is {id.Value} !',
                            icon: 'success',
                            closeOnClickOutside: false,
                            closeOnEsc: false,
                        }}).then(() => {{
                        window.location.href = 'LoginPage.aspx';
                        }});
                    ", true);
                }
                catch (Exception)
                {
                    ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('Error!', 'Please Do not leave anything blank!', 'error');", true);
                }
            }


        }
    }

}