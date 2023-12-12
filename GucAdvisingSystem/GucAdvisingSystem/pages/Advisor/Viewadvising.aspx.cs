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
    public partial class Viewadvising : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            string query = "Select * from  Student where advisor_id=(@value)";
            SqlCommand View = new SqlCommand(query, conn);
            View.Parameters.AddWithValue("@value", Session["id"]);
            SqlDataAdapter adp2 = new SqlDataAdapter(View);
            DataTable dtTable = new DataTable();
            conn.Open();
            adp2.Fill(dtTable);
            conn.Close();
            GridView3.DataSource = dtTable;
            GridView3.DataBind();
        }
        
    }
}