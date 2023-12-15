using GucAdvisingSystem.pages.Admin.add;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GucAdvisingSystem.pages.Student.Slots
{
    public partial class InputSlot : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void ViewSlot(object sender, EventArgs e)
        {

            try
            {
                String courseID = courseIDInput.Text;
                String instructorid = InstructorInput.Text;

                if (courseID == "" || instructorid == "")
                {
                    throw new Exception();
                }

                int Course = Int16.Parse(courseIDInput.Text);
                int instructor = Int16.Parse(InstructorInput.Text);

                Session["course"] = Course;
                Session["instructor"] = instructor;


                Response.Redirect("../Slots/ViewSlot.aspx");
            }

            catch (Exception)
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('Error!', 'Please enter Valid Data and Do not leave anything blank!', 'error');", true);
            }
        }

        
    }
}