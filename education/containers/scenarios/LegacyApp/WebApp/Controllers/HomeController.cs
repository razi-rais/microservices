using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace AspNet4._5WebApp.Controllers
{
    public class HomeController : Controller
    {
       
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult FrenchRevolution()
        {
            ViewBag.Message = "French Revolution.";

            IList<BusinessLayer.HistoricEvent> listHistoricEvents =
                BusinessLayer.Data.GetHistoricEvent("FrenchRevolution");

            return View(listHistoricEvents);
        }
        public ActionResult Renaissance()
        {
            ViewBag.Message = "Renaissance.";

            IList<BusinessLayer.HistoricEvent> listHistoricEvents = 
                BusinessLayer.Data.GetHistoricEvent("Renaissance");

            return View(listHistoricEvents);
        }
        public ActionResult WW2()
        {
            ViewBag.Message = "World War II.";

            IList<BusinessLayer.HistoricEvent> listHistoricEvents =
                BusinessLayer.Data.GetHistoricEvent("ww2");

            return View(listHistoricEvents);
        }

        public ActionResult WW1()
        {
            ViewBag.Message = "World War I.";

            IList<BusinessLayer.HistoricEvent> listHistoricEvents =
                BusinessLayer.Data.GetHistoricEvent("ww1");

            return View(listHistoricEvents);
        }

    }
}