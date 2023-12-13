using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Admin
{
    public partial class Grad_advisor : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string conStr = ConfigurationManager.ConnectionStrings["Advising_System"].ConnectionString;
            SqlConnection conn = new SqlConnection(conStr);
            conn.Open();
            using (SqlCommand cmd = new SqlCommand("SELECT * FROM Advisors_Graduation_Plan", conn))
            {
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    GridView1.DataSource = reader;
                    GridView1.DataBind();
                }
            }
            conn.Close();
            ApplyStylingForOddRows();
        }


        protected void ApplyStylingForOddRows()
        {
            foreach (GridViewRow row in GridView1.Rows)
            {
                if (row.RowType == DataControlRowType.DataRow)
                {
                    if (row.RowIndex % 2 == 1) // Odd row
                    {
                        row.CssClass = "myAltRowClass";
                    }
                }
            }
        }

    }
}