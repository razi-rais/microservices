using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace BusinessLayer
{
    public class HistoricEvent
    {
        public string Date { get; set; }
        public string Description { get; set; }
    }
    public class Data
    {
        public static IList<HistoricEvent> GetHistoricEventsTest()
        {
            IList<HistoricEvent> lstHistoricEvents = new List<HistoricEvent>();
            lstHistoricEvents.Add(new HistoricEvent() { Date = "1/1/1", Description = "safasfsadf" });

            return lstHistoricEvents;
        }

        public static IList<HistoricEvent> GetHistoricEvent(string tableName)
        {
            string connectionString = ConfigurationManager.AppSettings["ConnectionString"] as string;

          
            // Provide the query string with a parameter placeholder.
            string queryString =
               string.Format("SELECT [DATE] AS DATE,DESCRIPTION FROM {0} WHERE[DATE] IS NOT NULL AND DESCRIPTION IS NOT NULL", tableName);
                

            IList<HistoricEvent> lstHistoricEvents = new List<HistoricEvent>();
          
            // Create and open the connection in a using block. This
            // ensures that all resources will be closed and disposed
            // when the code exits.
            using (SqlConnection connection =
                new SqlConnection(connectionString))
            {
                // Create the Command and Parameter objects.
                SqlCommand command = new SqlCommand(queryString, connection);
                
                // Open the connection in a try/catch block. 
                // Create and execute the DataReader, writing the result
                // set to the console window.
                try
                {
                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();
                    while (reader.Read())
                    {

                        lstHistoricEvents.Add(new HistoricEvent() {
                                                         Date = (string)reader[0],
                                                         Description = (string)reader[1]
                        });

                       
                    }
                    reader.Close();
                }
                catch (Exception ex)
                {
                 
                }

                return lstHistoricEvents;
            }

        }
    }
}
