using ConsoleApplication1.Aspects;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace ConsoleApplication1
{
    class Program
    {




        static void Main(string[] args)
        {
            Calc();
            LongRunningCalc();

            //Adding records using a method
            //which is run in a Transaction
            AddRecord("Reza", "Ahmadi", "r_ahmadi_1983@yahoo.com");
            AddRecord("Reza", "Ahmadi", "rahmadey@gmail.com");
            AddRecord("X", "Y", "r_ahmadi_1983@yahoo.com"); //here an Exception will be thrown

            Console.WriteLine("Press any key to continue");
            Console.ReadKey();
        }

        [ExceptionAspect]
        [LogAspect]
        static void Calc()
        {
            throw new DivideByZeroException("A Math Error Occurred...");
        }

        [LogAspect]
        //[TimingAspect]
        static void LongRunningCalc()
        {
            //wait for 1000 milliseconds
            Thread.Sleep(1000);
        }

        //[RunInTransactionAspect]
        [LogAspect]
        static void AddRecord(string firstName, string lastName, string email)
        {
            Console.WriteLine(string.Format("adding a record {0} {1} {2} ", firstName, lastName, email));// any key to continue");
       //     using (var cn = new SqlConnection
       //(ConfigurationManager.ConnectionStrings["TestConnectionString"].ConnectionString))
       //     {
       //         using (var command = cn.CreateCommand())
       //         {
       //             if (cn.State != ConnectionState.Open) cn.Open();
       //             //command.Transaction = cn.BeginTransaction();

       //             try
       //             {
       //                 command.CommandText =
       //     "insert into person values(@f,@l) select @@identity";
       //                 command.Parameters.AddWithValue("@f", firstName);
       //                 command.Parameters.AddWithValue("@l", lastName);
       //                 var personId = command.ExecuteScalar();

       //                 command.CommandText = "insert into emailAddress values(@p,@e)";
       //                 command.Parameters.AddWithValue("@p", personId);
       //                 command.Parameters.AddWithValue("@e", email);
       //                 command.ExecuteNonQuery();

       //                 //command.Transaction.Commit();
       //             }
       //             catch (Exception ex)
       //             {
       //                 Trace.WriteLine("Exception during person-saving transaction: " +
       //         ex.ToString());
       //                 //command.Transaction.Rollback();
       //                 throw;
       //             }
       //         }
       //     }
        }
    }
}
