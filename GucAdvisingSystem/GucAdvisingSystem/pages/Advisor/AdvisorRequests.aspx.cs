using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GucAdvisingSystem.pages.Advisor
{
    public partial class AdvisorRequests : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand View = new SqlCommand("Select * from FN_Advisors_Requests(@advisor_id)", conn);
            View.Parameters.AddWithValue("@advisor_id", Session["id"]);
            DataTable dtTable = new DataTable();
            SqlDataAdapter adp = new SqlDataAdapter(View);
            conn.Open();
            adp.Fill(dtTable);
            conn.Close();
            GridView1.DataSource = dtTable;
            GridView1.DataBind();
        }
        
    }
}