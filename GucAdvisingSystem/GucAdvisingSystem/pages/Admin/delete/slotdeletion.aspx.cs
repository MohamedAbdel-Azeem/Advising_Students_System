using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Admin
{
    public partial class slotdeletion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string connStr = ConfigurationManager.ConnectionStrings["Advising_System"].ConnectionString;
                SqlConnection con = new SqlConnection(connStr);
                {
                    String Cur_Sem = Session["Cur_Sem"].ToString();
                    SqlCommand cmd = new SqlCommand($"SELECT semester_code FROM Course_Semester WHERE semester_code <> '{Cur_Sem}'", con);
                    con.Open();
                    slotdellist.DataTextField = "semester_code";
                    slotdellist.DataSource = cmd.ExecuteReader();
                    slotdellist.DataBind();
                    con.Close();
                }
            }

        }
        protected void slotdelbut(object sender, EventArgs e)
        {
            string conStr = ConfigurationManager.ConnectionStrings["Advising_System"].ConnectionString;
            SqlConnection conn = new SqlConnection(conStr);
            string c_id = slotdellist.Text;

            SqlCommand deleteproc = new SqlCommand("Procedures_AdminDeleteSlots", conn);
            deleteproc.CommandType = CommandType.StoredProcedure;

            // Add parameters to the stored procedure
            deleteproc.Parameters.Add(new SqlParameter("@current_semester", c_id));


            //deleteproc.Parameters.Add(new SqlParameter("@courseID", c_id));
            conn.Open();
            deleteproc.ExecuteNonQuery();
            conn.Close();

            ClientScript.RegisterStartupScript(this.GetType(), "alert", $@"
                        swal({{
                            title: 'Success!',
                            text: 'Slots Deleted Successfully',
                            icon: 'success',
                            closeOnClickOutside: true,
                            closeOnEsc: true,
                        }}).then(() => {{
                        window.location.href = 'slotdeletion.aspx';
                        }});
                    ", true);

        }
    }
}