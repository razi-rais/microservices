using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;

namespace webapi2._0.Controllers
{
    [Route("api/[controller]")]
    public class BusinessController : Controller
    {
        // GET api/values
        [HttpGet]
        public IEnumerable<string> Get()
        {
            return new string[] { "Data set 1 from API", 
                                  "Data set 2 from API" ,
                                  "Data set 3 from API"};
        }

        
    }
}
