using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using StokTakipApi.Models;
using System.Data;


// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace StokTakipApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class WarehouseController : ControllerBase
    {

        SqlConnection con;
        SqlCommand cmd;
        List<Warehouse> warehouses = new();

        string connectionString = "Server=MSI; Database=STOKTAKIPOTOMASYONU; Trusted_Connection=True; TrustServerCertificate=True;";

        // GET: api/<WarehouseController>
        [HttpGet("getAll")]
        public IEnumerable<Warehouse> GetAll()
        {
            using (con = new SqlConnection(connectionString))
            {
                con.Open();
                cmd = new SqlCommand("Select * from warehouses where isDeleted = 'false'")
                {
                    Connection = con
                };

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            warehouses.Add(new Warehouse()
                            {
                                Id = (int)reader.GetValue("id"),
                                Code = reader.GetValue("warehouseCode").ToString(),
                                Name = reader.GetValue("warehouseName").ToString(),
                                Address = reader.GetValue("warehouseAddress").ToString(),
                                Capacity = (int)reader.GetValue("warehouseCapacity"),
                                AdminId = (int)reader.GetValue("warehouseAdminId"),
                                IsActive = (bool)reader.GetValue("isActive")
                            });
                        }
                    }
                }
                con.Close();
                return warehouses;
            }
        }
        
        [HttpGet("warehouseCapacity")]
        public IEnumerable<WarehouseCapacity> warehouseCapacity()
        {
            List<WarehouseCapacity> warehouseCapacities = new();
            using (con = new SqlConnection(connectionString))
            {
                con.Open();
                cmd = new SqlCommand("select  sum(wp.quantity) as stock, warehouseId  from warehouses join warehouseProduct as wp on warehouses.id = wp.warehouseId group by wp.warehouseId")
                {
                    Connection = con
                };

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            warehouseCapacities.Add(new WarehouseCapacity()
                            {
                                WarehouseId = (int)reader.GetValue("warehouseId"),
                                Quantity = (int)reader.GetValue("stock"),
                            });
                        }
                    }
                }
                con.Close();
                return warehouseCapacities;
            }
        }
        [HttpGet("warehouseProductsDetail/{id}")]
        public IEnumerable<ProductDetailWarehouse> warehouseProductsDetail(int id)
        {
            List<ProductDetailWarehouse> productDetailWarehouses = new();
            using (con = new SqlConnection(connectionString))
            {
                con.Open();
                cmd = new SqlCommand("select wp.id as wpId, wp.quantity , wp.date , pd.id , pd.productName , pd.productCode , " +
                    "pd.productDesc , pd.productPrice   from warehouseProduct as wp join products as pd on pd.id =  " +
                    "wp.productId where wp.isDeleted = 'false' and pd.isDeleted = 'false' and wp.warehouseId =  " + id)
                {
                    Connection = con
                };

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            productDetailWarehouses.Add(new ProductDetailWarehouse()
                            {
                                OrderNumber = (int)reader.GetValue("wpId"),
                                Quantity = (int)reader.GetValue("quantity"),
                                Date = (DateTime)reader.GetValue("date"),
                                ProductId = (int)reader.GetValue("id"),
                                ProductName = reader.GetValue("productName").ToString(),
                                ProductCode = reader.GetValue("productCode").ToString(),
                                ProductDescription = reader.GetValue("productDesc").ToString(),
                                ProductUnitPrice = (int)reader.GetValue("productPrice")
                            });
                        }
                    }
                }
                con.Close();
                return productDetailWarehouses;
            }
        }
        [HttpGet("warehouseProductsQuantity")]
        public IEnumerable<WarehouseProductQuantity> warehouseProductQuantity()
        {
            List<WarehouseProductQuantity> warehouseProductQuantities = new();
            using (con = new SqlConnection(connectionString))
            {
                con.Open();
                cmd = new SqlCommand("select   sum(quantity) as stock , productId, warehouseId   from warehouses join warehouseProduct as wp on warehouses.id = wp.warehouseId group by warehouseId, productId")
                {
                    Connection = con
                };

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            warehouseProductQuantities.Add(new WarehouseProductQuantity()
                            {
                                WarehouseId = (int)reader.GetValue("warehouseId"),
                                Quantity = (int)reader.GetValue("stock"),
                                ProductId = (int)reader.GetValue("productId")
                            });
                        }
                    }
                }
                con.Close();
                return warehouseProductQuantities;
            }
        }

        // GET api/<WarehouseController>/5
        [HttpGet("getWarehouseById/{id}")]
        public IEnumerable<Warehouse> GetWarehouseById(int id)
        {
            using (con = new SqlConnection(connectionString))
            {
                con.Open();
                cmd = new SqlCommand("Select * from warehouses where isDeleted = 'false' and id = " + id)
                {
                    Connection = con
                };

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            warehouses.Add(new Warehouse()
                            {
                                Id = (int)reader.GetValue("id"),
                                Code = reader.GetValue("warehouseCode").ToString(),
                                Name = reader.GetValue("warehouseName").ToString(),
                                Address = reader.GetValue("warehouseAddress").ToString(),
                                Capacity = (int)reader.GetValue("warehouseCapacity"),
                                AdminId = (int)reader.GetValue("warehouseAdminId"),
                                IsActive = (bool)reader.GetValue("isActive")
                            }) ;
                        }
                    }
                }
                con.Close();
                return warehouses;
            }
        }

        // POST api/<WarehouseController>
        [HttpPost("addWarehouse")]
        public void addWarehouse([FromBody] Warehouse warehouse)
        {
            string sqlQuery = "Insert Into warehouses (warehouseCode,warehouseName,warehouseAddress,warehouseCapacity,warehouseAdminId) values " +
                "('" + warehouse.Code + "'," +
                "'" + warehouse.Name + "'," +
                "'" + warehouse.Address + "'," +
                warehouse.Capacity + "," +
                warehouse.AdminId + ")" ;
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

        // PUT api/<WarehouseController>/5
        [HttpPut("updateWarehouse/{id}")]
        public void Put(int id, [FromBody] Warehouse warehouse)
        {
            string sqlQuery = "Update warehouses set " +
                "warehouseName = '" + warehouse.Name + "'," +
                "warehouseCode = '" + warehouse.Code + "'," +
                "warehouseAddress = '" + warehouse.Address + "'," +
                "warehouseCapacity = '" + warehouse.Capacity + "'," +
                "warehouseAdminId = '" + warehouse.AdminId + "'" +
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

        // DELETE api/<WarehouseController>/5
        [HttpDelete("deleteWarehouse/{id}")]
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
