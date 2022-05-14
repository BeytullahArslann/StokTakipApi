using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using StokTakipApi.Models;

namespace StokTakipApi.Data
{
    public class StokTakipApiContext : DbContext
    {
        public StokTakipApiContext (DbContextOptions<StokTakipApiContext> options)
            : base(options)
        {
        }

        public DbSet<StokTakipApi.Models.User>? User { get; set; }
    }
}
