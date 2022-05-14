using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using StokTakipApi.Models;
using System.Data;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace StokTakipApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProductController : ControllerBase
    {
        SqlConnection con;
        SqlCommand cmd;
        List<Product> products = new();

        string connectionString = "Server=MSI; Database=STOKTAKIPOTOMASYONU; Trusted_Connection=True; TrustServerCertificate=True;";
        // GET: api/<ProductController>
        [HttpGet]
        public IEnumerable<Product> GetAllProducts()
        {
            using (con = new SqlConnection(connectionString))
            {
                con.Open();
                cmd = new SqlCommand("Select * from products where isDeleted = 'false'")
                {
                    Connection = con
                };

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            products.Add(new Product()
                            {
                                Id = (int)reader.GetValue("id"),
                                Name = reader.GetValue("productName").ToString(),
                                Description = reader.GetValue("productDesc").ToString(),
                                Code = reader.GetValue("productCode").ToString(),
                                Price = (int)reader.GetValue("productPrice"),
                            });
                        }
                    }
                }
                con.Close();
                return products;
            }
        }

        // GET api/<ProductController>/5
        [HttpGet("{id}")]
        public IEnumerable<Product> Get(int id)
        {
            using (con = new SqlConnection(connectionString))
            {
                con.Open();
                cmd = new SqlCommand("Select * from products where isDeleted = 'false' and where = " + id)
                {
                    Connection = con
                };

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            products.Add(new Product()
                            {
                                Id = (int)reader.GetValue("id"),
                                Name = reader.GetValue("productName").ToString(),
                                Description = reader.GetValue("productDesc").ToString(),
                                Code = reader.GetValue("productCode").ToString(),
                                Price = (int)reader.GetValue("productPrice"),
                            });
                        }
                    }
                }
                con.Close();
                return products;
            }
        }

        // POST api/<ProductController>
        [HttpPost("addProduct/{product}")]
        public void addProduct([FromBody] Product product)
        {
            string sqlQuery = "Insert Into products (productCode,productName,productDesc,productPrice) values " +
                "('" + product.Code + "'," +
                "'" + product.Name + "'," +
                "'" + product.Description + "'," +
                product.Price + ")";
                ;
            using (con = new SqlConnection(connectionString))
            {
                con.Open();
                cmd = new SqlCommand(sqlQuery)
                {
                    Connection = con
                };
                cmd.ExecuteReader();
                con.Close();
            }
        }

        // PUT api/<ProductController>/5
        [HttpPut("updateProduct/{id},{product}")]
        public void updateProduct(int id, [FromBody] Product product)
        {
            string sqlQuery = "Update products set " +
                "productName = '" + product.Name + "'," +
                "productCode = '" + product.Code + "'," +
                "productDesc = '" + product.Description + "'," +
                "productPrice = '" + product.Price + "'," +
                "where id = " + id;
            using (con = new SqlConnection(connectionString))
            {
                con.Open();
                cmd = new SqlCommand(sqlQuery)
                {
                    Connection = con
                };
                cmd.ExecuteReader();
                con.Close();
            }
        }

        // DELETE api/<ProductController>/5
        [HttpDelete("{id}")]
        public void Delete(int id)
        {
            string sqlQuery = "Update products set " +
                "isDeleted = 'true" +
                "where id = " + id;
            using (con = new SqlConnection(connectionString))
            {
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
