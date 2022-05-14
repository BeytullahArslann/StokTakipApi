using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using StokTakipApi.Models;
using System.Data;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace StokTakipApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class OrderProductController : ControllerBase
    {
        SqlConnection con;
        SqlCommand cmd;
        List<Product> products = new();
        string connectionString = "Server=MSI; Database=STOKTAKIPOTOMASYONU; Trusted_Connection=True; TrustServerCertificate=True;";

        [HttpGet("getProductsByOrder{id}")]
        public IEnumerable<Product> GetProductByOrderId(int id)
        {
            using (con = new SqlConnection(connectionString))
            {
                con.Open();
                cmd = new SqlCommand("select * from orderProducts join products  on orderProducts.productId = products.id where isDeleted = 'false' and orderId = " + id)
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
                                Code = reader.GetValue("productCode").ToString(),
                                Name = reader.GetValue("productName").ToString(),
                                Description = reader.GetValue("productDesc").ToString(),
                                Price = (int)reader.GetValue("productPrice")
                            });
                        }
                    }
                }
                con.Close();
                return products;
            }
        }

        // POST api/<OrderProductController>
        [HttpPost("addProduct/{orderProduct}")]
        public void Post([FromBody] OrderProduct orderProduct , int warehouseId , int quantity)
        {
            string sqlQuery = "Insert Into orderProducts (productId,orderId,type,quantity) values " +
                "(" + orderProduct.ProductId + "," +
                "" + orderProduct.OrderId + "," +
                "'" + orderProduct.Type + "'," +
                "" + quantity + ")";
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


        // DELETE api/<OrderProductController>/5
        [HttpDelete("deleteProduct/{id}")]
        public void Delete(int id)
        {
            string sqlQuery = "update orderProducts " +
                "set isDeleted = 'true' where id = " + id;
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
