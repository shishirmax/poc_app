using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;
using System.IO;
using System.Web.Script.Services;

namespace SeedData
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        string conn = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        { }
            [WebMethod]
        public static bool InsertAddressData(string formattedAddress, string latitude, string longitude)
        {
            bool InsertData;
            using (SqlConnection con = new SqlConnection(conn))
            {
                using (SqlCommand cmd = new SqlCommand("spInsertAddressData", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@formattedAddress", formattedAddress);
                    cmd.Parameters.AddWithValue("@latitude", latitude);
                    cmd.Parameters.AddWithValue("@longitude", longitude);

                    if (con.State == ConnectionState.Closed)
                    {
                        con.Open();
                    }
                    int Result = cmd.ExecuteNonQuery();
                    if (Result > 0)
                    {
                        InsertData = true;
                    }
                    else
                    {
                        InsertData = false;
                    }
                    return InsertData;
                }
            }
        }
    }
}