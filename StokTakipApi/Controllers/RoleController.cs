using Microsoft.AspNetCore.Mvc;
using StokTakipApi.Models;
using System.Data.SqlClient;
using System.Data;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace StokTakipApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class RoleController : ControllerBase
    {
        SqlConnection con;
        SqlCommand cmd;
        List<Role> roles = new();

        string connectionString = "Server=MSI; Database=STOKTAKIPOTOMASYONU; Trusted_Connection=True; TrustServerCertificate=True;";

        // GET: api/<RoleController>
        [HttpGet("getAllRoles")]
        public IEnumerable<Role> getRoles()
        {
            using (con = new SqlConnection(connectionString))
            {
                con.Open();
                cmd = new SqlCommand("Select * from roles where isDeleted = 'false'")
                {
                    Connection = con
                };

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            roles.Add(new Role()
                            {
                                Id = (int)reader.GetValue("id"),
                                roleName = reader.GetValue("roleName").ToString(),
                                roleDesc = reader.GetValue("roleDesc").ToString(),
                            });
                        }
                    }
                }
                con.Close();
                return roles;
            }
        }

        // GET api/<RoleController>/5
        [HttpGet("getRoleById/{id}")]
        public IEnumerable<Role> Get(int id)
        {
            using (con = new SqlConnection(connectionString))
            {
                con.Open();
                cmd = new SqlCommand("Select * from roles where isDeleted = 'false' and id = " + id)
                {
                    Connection = con
                };

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            roles.Add(new Role()
                            {
                                Id = (int)reader.GetValue("id"),
                                roleName = reader.GetValue("roleName").ToString(),
                                roleDesc = reader.GetValue("roleDesc").ToString(),
                            });
                        }
                    }
                }
                con.Close();
                return roles;
            }
        }

        //// POST api/<RoleController>
        //[HttpPost]
        //public void Post([FromBody] Role role)
        //{
        //}

        // PUT api/<RoleController>/5
        [HttpPut("updateRole/{id}")]
        public void UpdateRole(int id, [FromBody] Role role)
        {
            using (con = new SqlConnection(connectionString))
            {
                String sqlQuery = "update roles set " +
                    "roleName = '" + role.roleName + "'," +
                    "roleDesc = '" + role.roleDesc + "' " +
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

        // DELETE api/<RoleController>/5
        [HttpDelete("deleteRole/{id}")]
        public void DeleteRole(int id)
        {
            using (con = new SqlConnection(connectionString))
            {
                String sqlQuery = "update roles set " +
                    "isDeleted = 'true'" +
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
