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
    public partial class Issue_installment : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string connStr = ConfigurationManager.ConnectionStrings["Advising_System"].ConnectionString;
                SqlConnection con = new SqlConnection(connStr);
                {
                    SqlCommand cmd = new SqlCommand("SELECT payment_id FROM Payment", con);
                    con.Open();
                    DropDownList1.DataTextField = "payment_id";
                    DropDownList1.DataValueField = "payment_id";
                    DropDownList1.DataSource = cmd.ExecuteReader();
                    DropDownList1.DataBind();

                }
            }
        }
        protected void issue_installments(object sender, EventArgs e)
        {
            string conStr = ConfigurationManager.ConnectionStrings["Advising_System"].ConnectionString;
            SqlConnection conn = new SqlConnection(conStr);
            int p_id = Int16.Parse(DropDownList1.Text);

            SqlCommand issinstproc = new SqlCommand("Procedures_AdminIssueInstallment", conn);
            issinstproc.CommandType = CommandType.StoredProcedure;

            // Add parameters to the stored procedure
            issinstproc.Parameters.Add(new SqlParameter("@payment_id", p_id));


            //deleteproc.Parameters.Add(new SqlParameter("@courseID", c_id));
            conn.Open();
            issinstproc.ExecuteNonQuery();
            conn.Close();

            ClientScript.RegisterStartupScript(this.GetType(), "alert", $@"
                        swal({{
                            title: 'Success!',
                            text: 'Installments Issued!',
                            icon: 'success',
                            closeOnClickOutside: true,
                            closeOnEsc: true,
                        }});
                    ", true);

        }
    }
}