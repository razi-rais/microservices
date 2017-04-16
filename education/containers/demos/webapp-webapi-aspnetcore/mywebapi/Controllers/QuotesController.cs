using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;

namespace mywebapi.Controllers
{
    [Route("api/[controller]")]
    public class QuotesController : Controller
    {
        // GET api/values
        [HttpGet]
        public IEnumerable<string> Get()
        {
            return new string[] { "The two most important days in your life are the day you are born and the day you find out why. ~ Mark Twain", 
                                  "Eighty percent of success is showing up. ~ Woody Allen" ,
                                  "Believe you can and you’re halfway there. ~ Theodore Roosevelt"};
        }

        
    }
}
