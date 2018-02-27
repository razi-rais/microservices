using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using System.Net.Http;
using webapp2._0.Models;

namespace webapp2._0.Controllers
{
    public class HomeController : Controller
    {
 
        public IActionResult Index()
        {
            return View();
        }

        /* public HomeController()
        {
            client = new HttpClient();
        }
        */

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
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }

        public async Task<IActionResult> API()
        {
            HttpClient client = new HttpClient();
            var response = await client.GetStringAsync("http://aspwebapi:9000/api/business");
            ViewData["Message"] = response;  

            return View();
        }
    }
}
