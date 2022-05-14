using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using StokTakipApi.Models;
using System.Data;



// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace StokTakipApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class WarehouseProductController : ControllerBase
    {

        SqlConnection con;
        SqlCommand cmd;
        List<WarehouseProduct> warehouseProducts = new();

        string connectionString = "Server=MSI; Database=STOKTAKIPOTOMASYONU; Trusted_Connection=True; TrustServerCertificate=True;";

        // GET: api/<WarehouseProduct>
        [HttpGet]
        public IEnumerable<WarehouseProduct> Get()
        {
            using (con = new SqlConnection(connectionString))
            {
                con.Open();
                cmd = new SqlCommand("Select * from warehouseProduct where isDeleted = 'false'")
                {
                    Connection = con
                };

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            warehouseProducts.Add(new WarehouseProduct()
                            {
                                Id = (int)reader.GetValue("id"),
                                ProductId = (int)reader.GetValue("warehouseCode"),
                                WarehouseId = (int)reader.GetValue("warehouseName"),
                                Quantity = (int)reader.GetValue("warehouseAddress"),
                                Date = (DateTime)reader.GetValue("warehouseCapacity")
                            });
                        }
                    }
                }
                con.Close();
                return warehouseProducts;
            }
        }

        // GET api/<WarehouseProduct>/5
        [HttpGet("{id}")]
        public IEnumerable<WarehouseProduct> Get(int id)
        {
            using (con = new SqlConnection(connectionString))
            {
                con.Open();
                cmd = new SqlCommand("Select * from warehouseProduct where isDeleted = 'false' and id = " + id)
                {
                    Connection = con
                };

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            warehouseProducts.Add(new WarehouseProduct()
                            {
                                Id = (int)reader.GetValue("id"),
                                ProductId = (int)reader.GetValue("warehouseCode"),
                                WarehouseId = (int)reader.GetValue("warehouseName"),
                                Quantity = (int)reader.GetValue("warehouseAddress"),
                                Date = (DateTime)reader.GetValue("warehouseCapacity")
                            });
                        }
                    }
                }
                con.Close();
                return warehouseProducts;
            }
        }

        // POST api/<WarehouseProduct>
        [HttpPost]
        public void Post([FromBody] WarehouseProduct  warehouseProduct)
        {
            string sqlQuery = "Insert Into warehouseProduct (productId,warehouseId,quantity,date) values " +
                "(" + warehouseProduct.ProductId + "," +
                "" + warehouseProduct.WarehouseId + "," +
                "" + warehouseProduct.Quantity + ",'" +
                warehouseProduct.Date + "')";
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


        // PUT api/<WarehouseProduct>/5
        [HttpPut("{id}")]
        public void Put(int id, [FromBody] WarehouseProduct warehouseProduct)
        {
            string sqlQuery = "Update warehouses set " +
                "productId = '" + warehouseProduct.ProductId + "'," +
                "warehouseId = '" + warehouseProduct.WarehouseId + "'," +
                "quantity = '" + warehouseProduct.Quantity + "'," +
                "date = '" + warehouseProduct.Date + "'," +
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


        // updateQuantity api/<WarehouseProduct>/5
        [HttpPut("updateQuantity/{id}")]
        public void updateQuantity(int id, [FromBody] int quantity)
        {
            string sqlQuery = "Update warehouses set " +
                "quantity = '" + quantity + "'," +
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

        // DELETE api/<WarehouseProduct>/5
        [HttpDelete("{id}")]
        public void Delete(int id)
        {
            string sqlQuery = "Update warehouses set " +
                "isDeleted = 'true'" +
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
