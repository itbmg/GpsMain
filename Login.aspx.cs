using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Data.SqlClient;
using System.Data;

public partial class Login1 : System.Web.UI.Page
{
    MySqlCommand cmd;
    VehicleDBMgr vdm;
    SqlCommand a_cmd;
    AccessControldbmanger Accescontrol_db = new AccessControldbmanger();
    protected void Page_Load(object sender, EventArgs e)
    {
        //vdm = new VehicleDBMgr();
        //var Empid = Request.QueryString["id"];
        //try
        //{
        //    Session["allvehicles"] = null;
        //    vdm.InitializeDB();
        //    String UN = "";
        //    String UserName = txtUserName.Text, PassWord = txtPassword.Text;
        //    a_cmd = new SqlCommand("SELECT   main_user,sno, username, password, emp_refno, leveltype, empid FROM gps_login where empid=@empid");
        //    a_cmd.Parameters.Add("@empid", Empid);
        //    DataTable dtgpscheck = Accescontrol_db.SelectQuery(a_cmd).Tables[0];//"ManageData", "UserName", new string[] { "UserName=@UserName" }, new string[] { UserName }, new string[] { "" }).Tables[0];
        //    if (dtgpscheck.Rows.Count > 0)
        //    {
        //        Session["field1"] = dtgpscheck.Rows[0]["username"].ToString();
        //        Session["field2"] = true;
        //        Session["UserType"] = dtgpscheck.Rows[0]["leveltype"].ToString();
        //        Session["field3"] = dtgpscheck.Rows[0]["sno"].ToString();
        //        Session["main_user"] = dtgpscheck.Rows[0]["main_user"].ToString();
        //        string UserType = dtgpscheck.Rows[0]["leveltype"].ToString();
        //        if (UserType == "Admin")
        //        {
        //            Response.Redirect("Default.aspx", false);
        //        }
        //        else
        //        {
        //            Response.Redirect("Default.aspx", false);
        //        }
        //    }
        //    else
        //    {

        //    }
        //}
        //catch (Exception ex)
        //{

        //}
    }

    private DateTime GetLowDate(DateTime dt)
    {
        double Hour, Min, Sec;
        DateTime DT = DateTime.Now;
        DT = dt;
        Hour = -dt.Hour;
        Min = -dt.Minute;
        Sec = -dt.Second;
        DT = DT.AddHours(Hour);
        DT = DT.AddMinutes(Min);
        DT = DT.AddSeconds(Sec);
        return DT;

    }

    private DateTime GetHighDate(DateTime dt)
    {
        double Hour, Min, Sec;
        DateTime DT = DateTime.Now;
        Hour = 23 - dt.Hour;
        Min = 59 - dt.Minute;
        Sec = 59 - dt.Second;
        DT = dt;
        DT = DT.AddHours(Hour);
        DT = DT.AddMinutes(Min);
        DT = DT.AddSeconds(Sec);
        return DT;
    }
    protected void btnLogIn_Click(object sender, EventArgs e)
    {
        try
        {
            Session["allvehicles"] = null;
            vdm = new VehicleDBMgr();
            vdm.InitializeDB();

            String UN = "";
            String UserName = txtUserName.Text, PassWord = txtPassword.Text;
            cmd = new MySqlCommand("SELECT refno, main_user, loginid as UserName, pwd, usertype FROM loginstable WHERE (loginid = @UN) and (pwd=@Pwd)");
            cmd.Parameters.Add("@UN", UserName);
            cmd.Parameters.Add("@Pwd", PassWord);
            DataTable dt = vdm.SelectQuery(cmd).Tables[0];//"ManageData", "UserName", new string[] { "UserName=@UserName" }, new string[] { UserName }, new string[] { "" }).Tables[0];
            if (dt.Rows.Count > 0)
            {
                Session["field1"] = dt.Rows[0]["UserName"].ToString();
                Session["field2"] = true;
                Session["UserType"] = dt.Rows[0]["usertype"].ToString();
                Session["field3"] = dt.Rows[0]["refno"].ToString();
                Session["main_user"] = dt.Rows[0]["main_user"].ToString();
                string UserType = dt.Rows[0]["UserType"].ToString();
                DateTime Currentdate = VehicleDBMgr.GetTime(vdm.conn);
                //cmd = new MySqlCommand("insert into logininfo(username,doe) values(@username,@doe)");
                //cmd.Parameters.Add("@username", UserName);
                //cmd.Parameters.Add("@doe", Currentdate);
                //vdm.insert(cmd);
                Session["TitleName"] = "SRI VYSHNAVI DAIRY SPECIALITIES (P) LTD";
                Session["Address"] = "R.S.No:381/2,Punabaka village Post,Pellakuru Mandal,Nellore District -524129., ANDRAPRADESH (State).Phone: 9440622077, Fax: 044 – 26177799.,";
                if (UserType == "Admin")
                {
                   // Response.Redirect("WelcomePage.aspx", false);
                    Response.Redirect("Default.aspx", false);
                }
                else
                {
                    //Response.Redirect("WelcomePage.aspx", false);
                    Response.Redirect("Default.aspx", false);

                }
            }
            else
            {
                //MessageBox.Show("Please enter Correct User ID",this);
                MessageBox.Show("Please enter Correct User ID and Password", this);
            }
        }
        catch (Exception ex)
        {
            lbl_validation.Text = ex.ToString();
        }
    }
}