﻿using Microsoft.AspNetCore.Identity;
using Nest;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace Film.Models
{
    public class User : IdentityUser
    {
    
            public User() {
           
                UserKnowledges = new List<UserKnowledges>();
                JobsWorker = new List<Job>();
                JobPreWorker = new List<JobPreWorker>();
                JobsCreator = new List<Job>();
                Notifications = new List<Notifications>();
                UserDates = new UserDates();
            Location = new GeoLocation(Lat, Lon);
        }

        public virtual UserDates UserDates { get; set; }
        public bool Admin { get; set; }
        public bool Status { get; set; }
        [NotMapped]
        [DefaultValue(false)]
        public bool RememberMe { get; set; }
        [NotMapped]
        public string Password { get; set; }
        [NotMapped]
        public string Token { get; set; }
        [NotMapped]
        public DateTime TokenExpiration { get; set; }
        [DataType(DataType.EmailAddress, ErrorMessage = "E-mail is not valid")]
        public override string Email { get => base.Email; set => base.Email = value; }

        public List<UserKnowledges> UserKnowledges { get; set; }
        [InverseProperty("UserWorker")]
        public virtual List<Job> JobsWorker { get; set; }
        public virtual List<JobPreWorker> JobPreWorker { get; set; }
        [InverseProperty("UserCreator")]
        public virtual List<Job> JobsCreator { get; set; }
        public virtual Suscription Suscription { get; set; }
        public virtual List<Notifications> Notifications { get; set; }


        [NotMapped]
        public GeoLocation Location { get; set; }
        [NotMapped]
        public double Lat { get; set; }
        [NotMapped]
        public double Lon { get; set; }
    }
}
