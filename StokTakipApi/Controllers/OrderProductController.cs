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
        SqlCommand cmd2;
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
        [HttpPost("addProduct")]
        public void Post([FromBody] OrderProduct orderProduct)
        {
            string sqlQueryUpdate = "";
            if (!orderProduct.Type)
            {
                sqlQueryUpdate = "update warehouseProduct set quantity = ((select quantity from warehouseProduct " +
                    "where warehouseId =" + orderProduct.WarehouseId + " and productId = " + orderProduct.ProductId + " and isDeleted = 'false') + " + orderProduct.Quantity + ")  " +
                    "where warehouseId = " + orderProduct.WarehouseId + " and productId = " + orderProduct.ProductId + " and isDeleted = 'false'";
            }
            else
            {
                sqlQueryUpdate = "update warehouseProduct set quantity = ((select quantity from warehouseProduct " +
                    "where warehouseId =" + orderProduct.WarehouseId + " and productId = " + orderProduct.ProductId + " and isDeleted = 'false') - " + orderProduct.Quantity + ")  " +
                    "where warehouseId = " + orderProduct.WarehouseId + " and productId = " + orderProduct.ProductId + " and isDeleted = 'false'";
            }
            string sqlQuery = "Insert Into orderProducts (productId,userId,type,quantity,warehouseId) values " +
                "(" + orderProduct.ProductId + "," +
                "" + orderProduct.UserId + "," +
                "'" + orderProduct.Type + "'," +
                "" + orderProduct.Quantity + "," + orderProduct.WarehouseId + 
                ")";
            using (con = new SqlConnection(connectionString))
            {
                con.Open();
                cmd = new SqlCommand(sqlQuery)
                {
                    Connection = con
                };
                cmd.ExecuteReader();
                con.Close();
                con.Open();
                cmd2 = new SqlCommand(sqlQueryUpdate)
                {
                    Connection = con
                };
                cmd2.ExecuteReader();
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
