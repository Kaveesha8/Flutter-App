using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace WebApplication1
{
    public class AppDbContext: DbContext
    {
        public DbSet<User> users { get; set; }

        public AppDbContext(DbContextOptions options)
            : base(options)
        {

        }

    }
}
