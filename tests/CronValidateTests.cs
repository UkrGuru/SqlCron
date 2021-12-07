using System;
using System.Reflection;
using UkrGuru.SqlJson;
using Xunit;

namespace SqlCronTests
{
    public class CronTests
    {
        public CronTests()
        {
            var dbName = "SqlCronTest";

            var connectionString = $"Server=(localdb)\\mssqllocaldb;Database={dbName};Trusted_Connection=True";

            //var dbInitScript = $"IF DB_ID('{dbName}') IS NOT NULL BEGIN " +
            //        $"  ALTER DATABASE {dbName} SET SINGLE_USER WITH ROLLBACK IMMEDIATE; " +
            //        $"  DROP DATABASE {dbName}; " +
            //        $"END " +
            //        $"CREATE DATABASE {dbName};";

            //DbHelper.ConnectionString = connectionString.Replace(dbName, "master");
            //DbHelper.ExecCommand(dbInitScript);

            DbHelper.ConnectionString = connectionString;

            //var assembly = Assembly.GetExecutingAssembly();
            //var resourceName = $"{assembly.GetName().Name}.Resources.InitDb.sql";
            //assembly.ExecResource(resourceName);
        }

        [Fact]
        public void CronValidateTests()
        {
            Assert.Equal("OK", DbHelper.FromProc("CronValidateTests"));
        }

        [Fact]
        public void CronValidatePartTests()
        {
            Assert.Equal("OK", DbHelper.FromProc("CronValidatePartTests"));
        }

        [Fact]
        public void CronValidateRangeTests()
        {
            Assert.Equal("OK", DbHelper.FromProc("CronValidateRangeTests"));
        }

        [Fact]
        public void CronValidateStepTests()
        {
            Assert.Equal("OK", DbHelper.FromProc("CronValidateStepTests"));
        }
    }
}
