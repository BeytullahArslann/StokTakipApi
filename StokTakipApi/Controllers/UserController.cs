using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using StokTakipApi.Data;
using StokTakipApi.Models;
using System.Data;


// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace StokTakipApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {
        SqlConnection con;
        SqlCommand cmd;
        List<User> users = new();

        string connectionString = "Server=MSI; Database=STOKTAKIPOTOMASYONU; Trusted_Connection=True; TrustServerCertificate=True;";
        // GET: api/<UserController>
        [HttpGet("getAllUser")]
        public IEnumerable<User> GetAll()
        {
            using (con = new SqlConnection(connectionString))
            {
                con.Open();
                cmd = new SqlCommand("Select * from users where isDeleted = 'false'")
                {
                    Connection = con
                };

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            users.Add(new User()
                            {
                                userId = (int)reader.GetValue("id"),
                                userName = reader.GetValue("userName").ToString(),
                                userSurname = reader.GetValue("userSurname").ToString(),
                                Email = reader.GetValue("userEmail").ToString(),
                                roleId = (int)reader.GetValue("userRole"),
                                birthDate = (DateTime)reader.GetValue("userBirthDay"),
                                isActive = (Boolean)reader.GetValue("isActive")
                            });
                        }
                    }
                }
                con.Close();
                return users;
            } 
        }

        // GET api/<UserController>/5
        [HttpGet("getUser/{id}")]
        public IEnumerable<User> GetUserById(int id)
        {
            using (con = new SqlConnection(connectionString))
            {
                con.Open();
                cmd = new SqlCommand("Select * from users where isDeleted = 'false' and id = "+id)
                {
                    Connection = con
                };

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            users.Add(new User()
                            {
                                userId = (int)reader.GetValue("id"),
                                userName = reader.GetValue("userName").ToString(),
                                userSurname = reader.GetValue("userSurname").ToString(),
                                Email = reader.GetValue("userEmail").ToString(),
                                roleId = (int)reader.GetValue("userRole"),
                                birthDate = (DateTime)reader.GetValue("userBirthDay"),
                                isActive = (Boolean)reader.GetValue("isActive")
                            });
                        }
                    }
                }
                con.Close();
                return users;
            }
        }

        // Login
        [HttpGet("login")]
        public IEnumerable<User> Login(String Email , String password)
        {
            using (con = new SqlConnection(connectionString))
            {
                con.Open();
                cmd = new SqlCommand("Select *  from users where isActive = 'true' and isDeleted = 'false' and userEmail = '" + Email + "' and userPassword = '" + password + "'")
                {
                    Connection = con
                };
                int count = 0;


                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            users.Add(new User()
                            {
                                userId = (int)reader.GetValue("id"),
                                userName = reader.GetValue("userName").ToString(),
                                userSurname = reader.GetValue("userSurname").ToString(),
                                Email = reader.GetValue("userEmail").ToString(),
                                roleId = (int)reader.GetValue("userRole"),
                                birthDate = (DateTime)reader.GetValue("userBirthDay"),
                                isActive = (Boolean)reader.GetValue("isActive")
                            });
                        }
                    }
                }
                con.Close();
                return users;
            }
        }

        // POST api/<UserController>
        [HttpPost("addUser/{user}")]
        public void addUser([FromBody] User user)
        {
            using (con = new SqlConnection(connectionString))
            {
                con.Open();
                cmd = new SqlCommand("Insert into users (userName,userSurname,userEmail,userPassword,userBirthDay,userRole) values ('" 
                    + user.userName + "','" + user.userSurname + "','" + user.Email + "','" + user.password + "'," 
                    + user.birthDate.Day.ToString() + "-" + user.birthDate.Month.ToString() + "-" + user.birthDate.Year.ToString() + "," + user.roleId + ")")
                {
                    Connection = con
                };
                cmd.ExecuteReader();
                con.Close();
            }
        }

        // PUT api/<UserController>/5
        [HttpPut("updateUser/{id}/{user}")]
        public void updateUser(int id, [FromBody] User user)
        {
            using (con = new SqlConnection(connectionString))
            {
                String sqlQuery = "update users " +
                    "set userName = '" + user.userName + "'," +
                    "userSurname = '" + user.userSurname + "'," +
                    "userEmail = '" + user.Email + "'," +
                    "userPassword = '" + user.password + "'," +
                    "userBirthDay = " +  user.birthDate.Day.ToString() + " - " + user.birthDate.Month.ToString() + " - " + user.birthDate.Year.ToString() + "," +
                    "userRole = " + user.roleId + "," +
                    "isActive = '" + user.isActive + "' " +
                    "where id = " + id;
                con.Open();
                cmd = new SqlCommand(sqlQuery)
                {
                    Connection = con
                };
                cmd.ExecuteReader();
                con.Close();
            }
        }
        // Change Role api/<UserController>/5
        [HttpPut("changeRole/{id},{newRole}")]
        public void changeRole(int id , int newRole)
        {
            using (con = new SqlConnection(connectionString))
            {
                String sqlQuery = "update users " +
                    "userRole = " + newRole + 
                    "where id = " + id;
                con.Open();
                cmd = new SqlCommand(sqlQuery)
                {
                    Connection = con
                };
                cmd.ExecuteReader();
                con.Close();
            }
        }

        // DELETE api/<UserController>/5
        [HttpDelete("deleteUser/{id}")]
        public void deleteUser(int id)
        {
            using (con = new SqlConnection(connectionString))
            {
                String sqlQuery = "update users " +
                    "isDeleted = 'true' " +
                    "where id = " + id;
                con.Open();
                cmd = new SqlCommand(sqlQuery)
                {
                    Connection = con
                };
                cmd.ExecuteReader();
                con.Close();
            }
        }
    }
}
