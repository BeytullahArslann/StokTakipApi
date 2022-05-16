using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using StokTakipApi.Models;
using System.Data;


// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace StokTakipApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class OrderController : ControllerBase
    {
        SqlConnection con;
        SqlCommand cmd;
        List<Order> orders = new();
        List<OrderTable> orderTables = new();

        string connectionString = "Server=MSI; Database=STOKTAKIPOTOMASYONU; Trusted_Connection=True; TrustServerCertificate=True;";

        // GET: api/<OrderController>
        [HttpGet("getAll")]
        public IEnumerable<Order> GetAll()
        {
            using (con = new SqlConnection(connectionString))
            {
                con.Open();
                cmd = new SqlCommand("Select * from orders where isDeleted = 'false'")
                {
                    Connection = con
                };

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            orders.Add(new Order()
                            {
                                Id = (int)reader.GetValue("id"),
                                UserId = (int)reader.GetValue("userId"),
                                Price = (int)reader.GetValue("orderPrice"),
                                Date = (DateTime)reader.GetValue("orderDate"),
                                isCompleted = (bool)reader.GetValue("isCompleted")
                            });
                        }
                    }
                }
                con.Close();
                return orders;
            }
        }
        // active order control api/<OrderController>/5
        [HttpGet("activeOrderControl/{id}")]
        public IEnumerable<Order> activeOrderControl(int id)
        {
            using (con = new SqlConnection(connectionString))
            {
                con.Open();
                cmd = new SqlCommand("Select *  from orders where isDeleted = 'false' and isCompleted = 'false' and userId = " + id)
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
                            orders.Add(new Order()
                            {
                                Id = (int)reader.GetValue("id"),
                                UserId = (int)reader.GetValue("userId"),
                                Price = (int)reader.GetValue("orderPrice"),
                                Date = (DateTime)reader.GetValue("orderDate"),
                                isCompleted = (bool)reader.GetValue("isCompleted")
                            });
                        }
                    }
                }
                con.Close();
                return orders;
                
            }
        }
        // GET api/<OrderController>/5
        [HttpGet("getOrderById/{id}")]
        public IEnumerable<Order> GetOrderById(int id)
        {
            using (con = new SqlConnection(connectionString))
            {
                con.Open();
                cmd = new SqlCommand("Select * from orders where isDeleted = 'false' and id = " + id)
                {
                    Connection = con
                };

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            orders.Add(new Order()
                            {
                                Id = (int)reader.GetValue("id"),
                                UserId = (int)reader.GetValue("userId"),
                                Price = (int)reader.GetValue("orderPrice"),
                                Date = (DateTime)reader.GetValue("orderDate"),
                                isCompleted = (bool)reader.GetValue("isCompleted")
                            });
                        }
                    }
                }
                con.Close();
                return orders;
            }
        }
        // GET api/<OrderController>/5
        [HttpGet("getOrderTable")]
        public IEnumerable<OrderTable> GetOrderTable()
        {
            string sqlQuery = "select wp.id as orderId , (users.userName + ' ' + users.userSurname) as userName , " +
                    "(wp.quantity * (select productPrice from products where id = wp.productId)) as price , " +
                    "wp.type , wp.createdAt as date from orderProducts as wp " +
                    "join products on wp.productId = products.id join users on wp.userId = users.id where wp.isDeleted = 'false'";
            using (con = new SqlConnection(connectionString))
            {
                con.Open();
                cmd = new SqlCommand(sqlQuery)
                {
                    Connection = con
                };

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            orderTables.Add(new OrderTable()
                            {
                                OrderId = (int)reader.GetValue("orderId"),
                                UserName = reader.GetValue("userName").ToString(),
                                Price = (int)reader.GetValue("price"),
                                Date = (DateTime)reader.GetValue("date"),
                                Type = (bool)reader.GetValue("type")
                            });
                        }
                    }
                }
                con.Close();
                return orderTables;
            }
        }
        // GET api/<OrderController>/5
        [HttpGet("getOrderTableByUserId/{id}")]
        public IEnumerable<OrderTable> GetOrderTableByUserId(int id)
        {
            using (con = new SqlConnection(connectionString))
            {
                con.Open();
                cmd = new SqlCommand("select wp.id as orderId , (users.userName + ' ' + users.userSurname) as userName , " +
                    "(wp.quantity * (select productPrice from products where id = wp.productId)) as price , " +
                    "wp.type , wp.createdAt as date from orderProducts as wp " +
                    "join products on wp.productId = products.id join users on wp.userId = users.id where wp.isDeleted = 'false' and wp.userId =" + id)
                {
                    Connection = con
                };

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            orderTables.Add(new OrderTable()
                            {
                                OrderId = (int)reader.GetValue("orderId"),
                                UserName = reader.GetValue("userName").ToString(),
                                Price = (int)reader.GetValue("price"),
                                Date = (DateTime)reader.GetValue("date"),
                                Type = (bool)reader.GetValue("type")
                            });
                        }
                    }
                }
                con.Close();
                return orderTables;
            }
        }

        // POST api/<OrderController>
        [HttpPost("addOrder")]
        public void addOrder([FromBody] Order order)
        {
            string sqlQuery = "Insert Into orders (userId,orderPrice,orderDate,isCompleted) values " +
                "(" + order.UserId + "," +
                "" + order.Price + "," +
                "'" + order.Date.Month.ToString() + "-" + order.Date.Day.ToString() + "-" + order.Date.Year.ToString() + "'," +
                "'" + order.isCompleted + "')";
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

        // Update order price api/<OrderController>/5
        [HttpPut("updateOrders/{id},{price}")]
        public void Put(int id, [FromBody] int price)
        {
            string sqlQuery = "Update orders set " +
                "orderPrice = " + price + "," +
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

        // PUT api/<OrderController>/5
        [HttpPut("updateOrders/{id},{order}")]
        public void Put(int id, [FromBody] Order order)
        {
            string sqlQuery = "Update orders set " +
                "userId = " + order.UserId + "," +
                "orderPrice = " + order.Price + "," +
                "orderDate = '" + order.Date.Month.ToString() + "-" + order.Date.Day.ToString() + "-" + order.Date.Year.ToString() + "'," +
                "isCompleted = '" + order.isCompleted + "'" +
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

        // Complete Order api/<OrderController>/5
        [HttpPut("completeOrder/{id}")]
        public void CompleteOrder(int id)
        {
            string sqlQuery = "Update orders set " +
                "isCompleted = 'true'" +
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

        // DELETE api/<OrderController>/5
        [HttpDelete("deleteOrder/{id}")]
        public void DeleteOrder(int id)
        {
            string sqlQuery = "Update orders set " +
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
