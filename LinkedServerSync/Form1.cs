
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;


namespace LinkedServerSync
{


    public partial class Form1 : Form
    {

        public static SQL Source = new SourceSql();
        public static SQL Destination = new DestinationSql();


        public Form1()
        {
            InitializeComponent();
        }

        public class TableInformation
        {
            // public string TABLE_CATALOG;
            public string TableSchema;
            public string TableName;
            //public string TABLE_TYPE;

            //private string m_TABLE_TYPE;
            //public string TABLE_TYPE
            //{
            //    get { return this.m_TABLE_TYPE; }
            //    set
            //    {
            //        this.m_TABLE_TYPE = value;
            //    }
            //}

        }

        public class ViewInformation
        {
            // public string TABLE_CATALOG;
            public string TableSchema;
            public string TableName;
            //public string TABLE_TYPE;

            //private string m_TABLE_TYPE;
            //public string TABLE_TYPE
            //{
            //    get { return this.m_TABLE_TYPE; }
            //    set
            //    {
            //        this.m_TABLE_TYPE = value;
            //    }
            //}

        }
        public class StoredProcedureInformation
        {
            public string RoutineSchema;
            public string RoutineName;
            public string RoutineDefinition;
        }

        public class ScalareFunctionInformation
        {
            public string FunctionSchema;
            public string FunctionName;
            public string FunctionDefinition;
        }

        public class TableValuedFunctionInformation
        {
            public string FunctionSchema;
            public string FunctionName;
            public string FunctionDefinition;
        }


        // Sequence

        // -- 1. add linkedserver
        //    -- register linkedserver
        //    -- add linkedserver-login
        //    -- enable rpc/rpcOUT for procedures 

        // -- 2. Using the name of linkedserver:
        //    -- create table synonyms
        //    -- create view synonyms
        //    -- create procedure synonyms


        // -- 3. Using function definition:
        //    -- create scalar functions 
        //    -- create table-valued functions 

        private void btnShow_Click(object sender, EventArgs e)
        {
            string sourceDb = @"CORDB2016.COR_Basic_BKB";

            // MsgBox(Source.GetConnectionString());
            // MsgBox(Destination.GetConnectionString());
            System.Collections.Generic.List<TableInformation> lsTables = null;
            System.Collections.Generic.List<ViewInformation> lsViews = null;
            System.Collections.Generic.List<StoredProcedureInformation> lsProcedures = null;
            System.Collections.Generic.List<ScalareFunctionInformation> lsScalarFunctions = null;
            System.Collections.Generic.List<TableValuedFunctionInformation> lsTableValuedFunctions = null;

            using (System.Data.IDbCommand cmd = Source.CreateCommandFromFile("01_ListTables.sql"))
            {
                lsTables = Source.GetList<TableInformation>(cmd);
            }

            using (System.Data.IDbCommand cmd = Source.CreateCommandFromFile("02_ListViews.sql"))
            {
                lsViews = Source.GetList<ViewInformation>(cmd);
            }

            using (System.Data.IDbCommand cmd = Source.CreateCommandFromFile("03a_SSMS_ListProcedures.sql"))
            {
                lsProcedures = Source.GetList<StoredProcedureInformation>(cmd);
            }

            using (System.Data.IDbCommand cmd = Source.CreateCommandFromFile("04_ListScalarFunctions.sql"))
            {
                lsScalarFunctions = Source.GetList<ScalareFunctionInformation>(cmd);
            }

            using (System.Data.IDbCommand cmd = Source.CreateCommandFromFile("05_ListTableValuedFunctions.sql"))
            {
                lsTableValuedFunctions = Source.GetList<TableValuedFunctionInformation>(cmd);
                
            }

            // Source.SynonymExists("dbo", "T_AP_Geschoss");

            /*
            // System.Console.WriteLine(lsTables);
            foreach (TableInformation thisTable in lsTables)
            {
                Destination.DropCreateSynonym(thisTable.TableSchema, thisTable.TableName, sourceDb);
            }

            // System.Console.WriteLine(lsViews);
            foreach (ViewInformation thisView in lsViews)
            {
                Destination.DropCreateSynonym(thisView.TableSchema, thisView.TableName, sourceDb);
            }

            // System.Console.WriteLine(lsProcedures);
            foreach (StoredProcedureInformation thisProcedure in lsProcedures)
            {
                Destination.DropCreateSynonym(thisProcedure.RoutineSchema, thisProcedure.RoutineName, sourceDb);
            }
            */

            
            // System.Console.WriteLine(lsScalarFunctions);
            foreach (ScalareFunctionInformation thisFScalarFunction in lsScalarFunctions)
            {
                Destination.DropSynonymIfExists(thisFScalarFunction.FunctionSchema, thisFScalarFunction.FunctionName);
                Destination.DropFunctionIfExists(thisFScalarFunction.FunctionSchema, thisFScalarFunction.FunctionName);
                
                try
                {
                    Destination.ExecuteNonQuery(thisFScalarFunction.FunctionDefinition);
                }
                catch (System.Exception ex)
                {
                    System.Console.WriteLine(System.Environment.NewLine);
                    System.Console.WriteLine(System.Environment.NewLine);

                    System.Console.WriteLine(ex.Message);
                    // System.Console.WriteLine(ex.StackTrace);
                    
                    System.Console.WriteLine(thisFScalarFunction.FunctionSchema);
                    System.Console.WriteLine(thisFScalarFunction.FunctionName);
                    // System.Console.WriteLine(thisFScalarFunction.FunctionDefinition);
                }
                
            }
            

            /*
            // System.Console.WriteLine(lsTableValuedFunctions);
            foreach (TableValuedFunctionInformation thisTableValuedFunction in lsTableValuedFunctions)
            {
                Destination.DropSynonymIfExists(thisTableValuedFunction.FunctionSchema, thisTableValuedFunction.FunctionName);
                Destination.DropFunctionIfExists(thisTableValuedFunction.FunctionSchema, thisTableValuedFunction.FunctionName);

                try
                {
                    Destination.ExecuteNonQuery(thisTableValuedFunction.FunctionDefinition);
                }
                catch (System.Exception ex)
                {
                    System.Console.WriteLine(System.Environment.NewLine);
                    System.Console.WriteLine(System.Environment.NewLine);

                    System.Console.WriteLine(ex.Message);
                    // System.Console.WriteLine(ex.StackTrace);

                    System.Console.WriteLine(thisTableValuedFunction.FunctionSchema);
                    // System.Console.WriteLine(thisTableValuedFunction.FunctionName);
                    // System.Console.WriteLine(thisTableValuedFunction.FunctionDefinition);
                }

            }
            */


            MsgBox("fertig");
            
            



        }

        public static void MsgBox(object obj)
        {
            if (obj != null)
                System.Windows.Forms.MessageBox.Show(obj.ToString());
            else
                System.Windows.Forms.MessageBox.Show("obj is NULL");
        }


    }


}
