using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using System.Net.Http;

namespace mywebapp.Controllers
{
    public class HomeController : Controller
    {
        HttpClient client;

        public HomeController()
        {
            client = new HttpClient();
        }

        public IActionResult Index()
        {
            return View();
        }

        public IActionResult About()
        {
            ViewData["Message"] = "Your application description page.";

            return View();
        }

        public IActionResult Contact()
        {
            ViewData["Message"] = "Your contact page.";

            return View();
        }

        public IActionResult Error()
        {
            return View();
        }

        public async Task<IActionResult> Quotes()
        {
           
            var response = await client.GetStringAsync("http://demowebapi:9000/api/quotes");
            //var sessions = JsonConvert.DeserializeObject&amp;lt;List&amp;lt;Session&amp;gt;&amp;gt;(response);
            ViewData["Message"] = response; //"Sessions";
            
            return View();
         }
    }
}
