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
        public void CronValidatePartTests()
        {
            Assert.Null(DbHelper.Exec<string>("CronValidatePartTests"));
        }

        [Fact]
        public void CronValidateRangeTests()
        {
            Assert.Null(DbHelper.Exec<string>("CronValidateRangeTests"));
        }

        [Fact]
        public void CronValidateStepTests()
        {
            Assert.Null(DbHelper.Exec<string>("CronValidateStepTests"));
        }

        [Fact]
        public void CronValidateTests()
        {
            Assert.Null(DbHelper.Exec<string>("CronValidateTests"));
        }

        [Fact]
        public void CronWordTests()
        {
            Assert.Null(DbHelper.Exec<string>("CronWordTests"));
        }
    }
}
