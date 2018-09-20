using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;
using System.Text;

/// <summary>
/// Class1 的摘要说明
/// </summary>
namespace FileIO {
	public class WebsiteFileIO {
		/// <summary>
		///返回的字串前面要加@才能正常使用，因为没有转义符
		/// </summary>
		public static string FileAbsUrl(string fileRelativeUrl) {			
			string fileurl = System.Web.HttpContext.Current.Server.MapPath("~/") + @fileRelativeUrl;//前面加@才能正常使用，注意
			return fileurl;
		}
		/// <summary>
		/// 删除文件
		/// </summary>
		/// <param name="fileName">文件的完整路径</param>
		/// <returns></returns>
		public static bool DeleteFile(string fileName) {
			if (Exists(fileName)) {
				File.Delete(fileName);
				return true;
			}
			return false;
		}

		/// <summary>
		/// 判断文件是否存在
		/// </summary>
		/// <param name="fileName"></param>
		/// <returns></returns>
		public static bool Exists(string fileName) {
			if (fileName == null || fileName.Trim() == "") {
				return false;
			}

			if (File.Exists(fileName)) {
				return true;
			}

			return false;
		}
		/// <summary>
		/// 创建文件
		/// </summary>
		/// <param name="fileName"></param>
		/// <returns></returns>
		public static bool CreateFile(string fileName) {
			if (!File.Exists(fileName)) {
				FileStream fs = File.Create(fileName);
				fs.Close();
				fs.Dispose();
			}
			return true;

		}
		/// <summary>
		/// 写文件
		/// </summary>
		/// <param name="fileName">文件名</param>
		/// <param name="content">文件内容</param>
		/// <returns></returns>
		public static bool Write(string fileName, string content) {
			if (!Exists(fileName) || content == null) {
				return false;
			}

			//将文件信息读入流中
			using (FileStream fs = new FileStream(fileName, FileMode.OpenOrCreate)) {
				lock (fs)//锁住流
               {
					if (!fs.CanWrite) {
						throw new System.Security.SecurityException("文件fileName=" + fileName + "是只读文件不能写入!");
					}

					byte[] buffer = Encoding.GetEncoding("UTF-8").GetBytes(content);
					fs.Write(buffer, 0, buffer.Length);
					return true;
				}
			}
		}
			
	}
}