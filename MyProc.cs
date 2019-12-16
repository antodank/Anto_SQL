using System;
using System.Data.SqlTypes;
using System.Data.SqlClient;
using Microsoft.SqlServer.Server;




/// <summary>
/// This is my first .NET routine.
/// </summary>

public class MyProc
{
    [Microsoft.SqlServer.Server.SqlProcedure]
    public static void PriceSum(out SqlMoney value)
    {
        using (SqlConnection connection = new SqlConnection("context connection=true"))
        {
            
            value = 0;
            connection.Open();
            SqlCommand command = new SqlCommand("SELECT ListPrice FROM Production.Product where ProductID=755", connection);
            SqlDataReader reader = command.ExecuteReader();
           
                using (reader)
            {
                while (reader.Read())
                {
                    value += reader.GetSqlMoney(0);
                }

            }
        }
    }

    [Microsoft.SqlServer.Server.SqlProcedure]
   public static void ExecuteToClient()
   {
   using(SqlConnection connection = new SqlConnection("context connection=true")) 
   {
      connection.Open();
      SqlCommand command = new SqlCommand("select @@version", connection);
      SqlContext.Pipe.ExecuteAndSend(command);
      }
   }

    [Microsoft.SqlServer.Server.SqlProcedure]
    public static void HelloWorld()
    {
        SqlContext.Pipe.Send("Hello world! It's now " + System.DateTime.Now.ToString() + "\n");
        using (SqlConnection connection = new SqlConnection("context connection=true"))
        {
            connection.Open();
            SqlCommand command = new SqlCommand("SELECT Name FROM Production.ProductCategory", connection);
            SqlDataReader reader = command.ExecuteReader();
            SqlContext.Pipe.Send(reader);
        }
    }


}




