using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GucAdvisingSystem.pages.Advisor
{
    public partial class AdvisorPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            String Aid = Session["id"] + "";
            String query = $"Select * from Advisor where advisor_id = {Aid};";
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.CommandType = System.Data.CommandType.Text;

            conn.Open();
            using (SqlDataReader rdr = cmd.ExecuteReader())
            {
                if (rdr.Read())
                {
                    id.InnerText = Aid;
                    name.InnerText = rdr["advisor_name"] + "";
                    email.InnerText = rdr["email"] + "";
                    office.InnerText = rdr["office"] + "";
                }
            }
        }
    }
}