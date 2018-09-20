using System;
using System.Data;
using System.Data.SqlClient;
//引入命名空间

/// <summary>
/// DB操作类简单封装
/// </summary>


namespace CommonDB {

	public class DBOper {
		private SqlConnection conn;
		private string _DBcommand;
		private SqlCommand _ads;
		private SqlDataAdapter _da;
		public DBOper(string source, string DBcommand) {//普通命令
			conn = new SqlConnection(source);
			_DBcommand = DBcommand;
			_ads = new SqlCommand(_DBcommand, conn);
			_da = new SqlDataAdapter(_DBcommand, conn);
		}
		public string ReturnRows() {
			int rows;
			try {
				conn.Open();
				rows = _ads.ExecuteNonQuery();

			}
			catch (Exception ex) {
				return (ex.Message);
			}
			finally {
				conn.Close();
			}
			return rows.ToString();
		}
		public string ReturnJson() {
			string ret;
			try {
				conn.Open();
				DataSet ds = new DataSet();
				_da.Fill(ds, "Res");
				ret = JSONConvertHelper.JsonConvertHelper.SerializeObject(ds.Tables["Res"]);
			}
			catch (Exception ex) {
				return (ex.Message);
			}
			finally {
				conn.Close();
				
			}
			return ret;
		}
		public static string ReturnJson(string source, string DBcommand) {
			SqlConnection conn = new SqlConnection(source);
			SqlCommand ads = new SqlCommand(DBcommand, conn);
			SqlDataAdapter da = new SqlDataAdapter(DBcommand, conn);
			string ret;
			try {
				conn.Open();
				DataSet ds = new DataSet();
				da.Fill(ds, "Res");
				ret = JSONConvertHelper.JsonConvertHelper.SerializeObject(ds.Tables["Res"]);
			}
			catch (Exception ex) {
				return (ex.Message);
			}
			finally {
				conn.Close();
			}
			return ret;
		}
		public static string ReturnRows(string source, string DBcommand) {
			int rows;
			SqlConnection conn = new SqlConnection(source);
			SqlCommand ads = new SqlCommand(DBcommand, conn);
			try {
				conn.Open();
				rows = ads.ExecuteNonQuery();
			}
			catch (Exception ex) {
				return (ex.Message);
			}
			finally {
				conn.Close();
			}
			return rows.ToString();
		}

		public DataTable ReturnDataSet() {
			try {
				conn.Open();
				DataSet ds = new DataSet();
				_da.Fill(ds, "Res");
				return ds.Tables["Res"];
			}
			catch (Exception ex) {
				return null;
			}
			finally {
				conn.Close();
			}
			
		}

		public string ProcedureReturnJSON(SqlParameter[] value1){
			string ret;

			SqlConnection userConnection =conn;
			SqlCommand userCommand = _ads;
			userCommand.CommandType = CommandType.StoredProcedure;//采用存储过程
			for (var i = 0; i < value1.Length; i++) {
				userCommand.Parameters.Add(value1[i]);				
			}
				userCommand.Connection.Open();
			SqlDataAdapter adapter = new SqlDataAdapter(userCommand);
			DataSet ds = new DataSet();
			adapter.Fill(ds);
			ret = JSONConvertHelper.JsonConvertHelper.SerializeObject(ds.Tables[0]);		
			return  ret;
		}
		public string ProcedureReturnJSON() {
			string ret;
			SqlConnection userConnection = conn;
			SqlCommand userCommand = _ads;
			userCommand.CommandType = CommandType.StoredProcedure;//采用存储过程
			userCommand.Connection.Open();
			SqlDataAdapter adapter = new SqlDataAdapter(userCommand);
			DataSet ds = new DataSet();
			adapter.Fill(ds);
			ret = JSONConvertHelper.JsonConvertHelper.SerializeObject(ds.Tables[0]);
			//try {
			//	_ads.CommandType = CommandType.StoredProcedure;
			//	_ads.Parameters.AddWithValue(val1name, val1val);//添加参数
			//	conn.Open();				
			//	SqlDataAdapter adapter = new SqlDataAdapter(_ads);
			//	DataSet ds = new DataSet();
			//	adapter.Fill(ds);
			//	ret = JSONConvertHelper.JsonConvertHelper.SerializeObject(ds.Tables["Res"]);
			//}
			//catch (Exception ex) {
			//	return ("出错 " + ex.Message);
			//}			
			return ret;
		}
	}
}