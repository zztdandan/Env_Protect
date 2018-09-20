using CommonDB;
using System;
//引入命名空间
using System.Configuration;

public partial class ajax_DRMHandler : System.Web.UI.Page {
	protected void Page_Load(object sender, EventArgs e) {
		switch (Request["action"]) {

			case ("DRMRead"): {//DRMRead操作，从数据库里读取数据

					string sRes = DRM.DRMReadProduce();
					Response.Write(sRes);
					Response.End();
					break;
				}
			case ("DRMChange"): {
				OperRecord.OperRecord.SaveOper(Request["action"], Request.Cookies["username"].Value, Request.UserHostAddress);
				string sRes = DRM.DRMChange(Request["name"], Request["time"]);
					Response.Write(sRes);
					Response.End();
					break;
				}
			default: { break; }
		}
	}
}
public class DRM {
	public static string DRMReadProduce() {
		string ret;
		string source = ConfigurationManager.ConnectionStrings["EPInfoSys"].ConnectionString.ToString();
		string DBcommand = "[dbo].[LoadDRM]";
		DBOper DBop = new DBOper(source, DBcommand);
		ret = DBop.ProcedureReturnJSON();
		return ret;

	}
	public static string DRMChange(string name,string time) {
		string ret;
		string source = ConfigurationManager.ConnectionStrings["EPInfoSys"].ConnectionString.ToString();
		string DBcommand = @"UPDATE [EPInfoSystem].[dbo].[DRMStatus]
								SET 
								[状态] = ([状态]+1)%2
							WHERE [位置]='"+name+"'";
		DBOper DBop = new DBOper(source, DBcommand);
		ret = DBop.ReturnRows();
		return ret;
	}
}