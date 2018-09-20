using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System;
using CommonDB;
//引入命名空间
using System.Configuration;

/// <summary>
/// OperRecord 的摘要说明
/// </summary>
namespace OperRecord {
	public class OperRecord {
		public OperRecord() {

			//
			// TODO: 在此处添加构造函数逻辑
			//
		}
		public static void SaveOper(string action, string username, string ip) {
			string ret;
			string source = ConfigurationManager.ConnectionStrings["EPInfoSys"].ConnectionString.ToString();
			string DBcommand = @"INSERT INTO [EPInfoSystem].[dbo].[OperRecord]
									   ([时间]
									   ,[ip]
									   ,[用户名]
									   ,[操作])
								 VALUES
									   ('"+DateTime.Now.ToString()+@"'
									   ,'"+ip+@"'
									   ,'"+username+@"'
									   ,'"+action+"')";
			ret = DBOper.ReturnJson(source, DBcommand);
		}
	}
}