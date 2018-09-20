using System;
using CommonDB;
//引入命名空间
using System.Configuration;
//引入命名空间

public partial class ajax_UserHandler : System.Web.UI.Page {
	protected void Page_Load(object sender, EventArgs e) {
		
		switch (Request["action"]) {
			case ("checkpw"): {//核对密码
					UserInfo uinfo = new UserInfo(Request["username"], Request["password"]);
					bool istrue = uinfo.IsTrue;
					Response.Write(istrue);
					Response.End();
					break;
				}
			case ("userdetail"): {//返回详情
					UserInfo uinfo = new UserInfo(Request["username"]);
					bool istrue = uinfo.IsTrue;
					if (istrue) {
						Response.Write(uinfo.detail);
					}
					else {
						Response.Write("用户没找到");
					}
					Response.End();
					break;
				}
			default: { break; }
		}
	}
}
class UserInfo {
	private string uname;
	private string upw;
	public bool IsTrue;
	public string detail;
	public UserInfo(string name) {
		this.uname = name;
		string ret;
		string source = ConfigurationManager.ConnectionStrings["EPInfoSys"].ConnectionString.ToString();
		string DBcommand = @"SELECT    [中文名],
										[快捷导航]
								  FROM [EPInfoSystem].[dbo].[UserInfo]
								  WHERE [账号名]='" + name + "'";
		ret = DBOper.ReturnJson(source, DBcommand);
		this.detail = ret;
		if (ret == "[]") { //没有这个用户		
			this.IsTrue = false;
			
		}
		else {
			this.IsTrue = true;
		}

	}
	public UserInfo(string name, string pw) {
		this.uname = name;
		this.upw = pw;
		string ret;
		string source = ConfigurationManager.ConnectionStrings["EPInfoSys"].ConnectionString.ToString();
		string DBcommand = @"SELECT    [账号名]
									  ,[口令]
								  FROM [EPInfoSystem].[dbo].[UserInfo]
								  WHERE [账号名]='"+name+"' AND 口令='"+pw+"'";
		ret = DBOper.ReturnJson(source, DBcommand);
		if (ret == "[]") { //没有这个用户		
			this.IsTrue = false;
		}
		else {
			this.IsTrue = true;
		}

	}
}