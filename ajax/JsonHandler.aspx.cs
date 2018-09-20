using CommonDB;
using FileIO;
using System;
//引入命名空间
using System.Configuration;
//引入命名空间
using System.Data;
public partial class ajax_JsonHandler : System.Web.UI.Page {
	protected void Page_Load(object sender, EventArgs e) {

		switch (Request["action"]) {
			case ("SaveJsonToDB"): {//将json存入固定的数据库位置，提供用户名和存入时间
				OperRecord.OperRecord.SaveOper(Request["action"], Request.Cookies["username"].Value, Request.UserHostAddress);
					SaveJson save = new SaveJson(Request["name"], Request["JSONDATA"]);
					string saveDB = save.SaveDB();
					Response.Write(saveDB);
					Response.End();
					break;
				}
			case ("SaveJsonWithTime"): {//将json存入固定的数据库位置，提供用户名和存入时间
				OperRecord.OperRecord.SaveOper(Request["action"], Request.Cookies["username"].Value, Request.UserHostAddress);
					SaveJson save = new SaveJson(Request["name"], Request["JSONDATA"]);
					string saveDB = save.SaveDBWithTime(Request["time"]);
					Response.Write(saveDB);
					Response.End();
					break;
				}
			case ("SaveJsonToFile"): {//将json存入指定的文件位置，提供存储名，存储地址
				OperRecord.OperRecord.SaveOper(Request["action"], Request.Cookies["username"].Value, Request.UserHostAddress);
					SaveJson save = new SaveJson(Request["name"], Request["url"], Request["JSONDATA"]);
					string saveFile = save.Savefile();
					Response.Write(saveFile);
					Response.End();
					break;
				}
			case ("LoadJsonLikeTime"): {
					LoadJson load = new LoadJson(Request["name"], Request["time"], "");
					string sRes = load.LoadJsonLikeTime();
					Response.Write(sRes);
					Response.End();
					break;
				}
			default: { break; }
		}
	}
}
public class SaveJson {
	private string _name;
	private string _url;
	private string _jsonobj;
	public SaveJson(string name, string url, string jsonobj) {
		_name = name;
		_url = url;
		_jsonobj = jsonobj;
	}
	public SaveJson(string name, string jsonobj) {
		_name = name;
		_jsonobj = jsonobj;
	}
	public string SaveDB() {
		string ret;
		string time = DateTime.Now.ToString();
		string source = ConfigurationManager.ConnectionStrings["EPInfoSys"].ConnectionString.ToString();
		string DBcommand =
			@"INSERT INTO [EPInfoSystem].[dbo].[JsonTable]
            ([表名]
            ,[时间]
           ,[类型]
           ,[内容])
     VALUES
           ('" + _name + "','" + time + "','json','" + _jsonobj + "')";
		DBOper DBop = new DBOper(source, DBcommand);
		ret = DBop.ReturnRows();
		return "数据库备份录入成功，影响" + ret;
	}
	public string SaveDBWithTime(string time) {
		LoadJson load = new LoadJson(this._name, time, "");
		string sRes = load.LoadJsonLikeTime();
		string DBcommand = "";
		if (sRes != "[]") {//已经有数据
			DBcommand =
				@"UPDATE [EPInfoSystem].[dbo].[JsonTable]
					SET 
						
						[内容] ='" + _jsonobj + @"'
					where [时间]= '" + time + "' AND [表名]='" + this._name + "'";
		}
		else {
			 DBcommand =
				@"INSERT INTO [EPInfoSystem].[dbo].[JsonTable]
            ([表名]
            ,[时间]
           ,[类型]
           ,[内容])
     VALUES
           ('" + _name + "','" + time + "','json','" + _jsonobj + "')";
		}
		string ret;
		string source = ConfigurationManager.ConnectionStrings["EPInfoSys"].ConnectionString.ToString();

		DBOper DBop = new DBOper(source, DBcommand);
		ret = DBop.ReturnRows();
		return "数据库录入成功，影响" + ret;
	}
	public string Savefile() {
		string absUrl = WebsiteFileIO.FileAbsUrl(_url);
		if (WebsiteFileIO.Exists(absUrl)) {
			Boolean bDel = WebsiteFileIO.DeleteFile(absUrl);
			if (bDel) {
				bool bCreate = WebsiteFileIO.CreateFile(absUrl);
				if (bCreate) {
					bool bWrite = WebsiteFileIO.Write(absUrl, _jsonobj);
					if (bWrite) return "文件写入成功";
					else return "不能写入";
				}
				else return "文件不能创建";
			}
			else return "文件不能删除";
		}
		else return "文件写入失败，不存在";
	}
}
public class LoadJson {
	private string _Name;
	private string _Time;
	private string _Jsonobj;
	public LoadJson(string name, string time, string jsonobj) {
		_Name = name;
		_Time = time;
		_Jsonobj = jsonobj;
	}
	public string LoadJsonLikeTime() {
		string _ret;
		string source = ConfigurationManager.ConnectionStrings["EPInfoSys"].ConnectionString.ToString();
		string DBcommand = @"SELECT     
				[内容]
				FROM [EPInfoSystem].[dbo].[JsonTable]
				where [时间] LIKE '" + this._Time + "%' AND [表名]='" + this._Name + "'";
		DBOper dbcom = new DBOper(source, DBcommand);
		_ret = dbcom.ReturnJson();
		return _ret;
	}

}
