﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GucAdvisingSystem.pages.Admin.link
{
    public partial class InstructorCourseSlot : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }


        protected void LinkInstructorCourseSlot(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand Link = new SqlCommand("dbo.Procedures_AdminLinkInstructor", conn);
            try
            {
                int courseID = Int16.Parse(CourseIDInput.Text);
                int InstructorID = Int16.Parse(InstructorIDInput.Text);
                int slotID = Int16.Parse(SlotIDInput.Text);

                Link.CommandType = CommandType.StoredProcedure;
                Link.Parameters.AddWithValue("@cours_id", courseID);
                Link.Parameters.AddWithValue("@instructor_id", InstructorID);
                Link.Parameters.AddWithValue("@slot_id", slotID);

                conn.Open();
                Link.ExecuteNonQuery();
                conn.Close();
                ClientScript.RegisterStartupScript(this.GetType(), "alert", $@"
                        swal({{
                            title: 'Success!',
                            text: 'Instructor Linked to Course on this Slot',
                            icon: 'success',
                            closeOnClickOutside: true,
                            closeOnEsc: true,
                        }});
                    ", true);

            }
            catch (Exception) {
                ClientScript.RegisterClientScriptBlock(this.GetType(),
                    "alert", "swal('Error!', 'Invalid Data', 'error');", true);
            }
        }


    }
}