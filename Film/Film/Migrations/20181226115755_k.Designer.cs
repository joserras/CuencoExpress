﻿// <auto-generated />
using System;
using Film.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;

namespace Film.Migrations
{
    [DbContext(typeof(ApplicatonDbContext))]
    [Migration("20181226115755_k")]
    partial class k
    {
        protected override void BuildTargetModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("ProductVersion", "2.1.4-rtm-31024")
                .HasAnnotation("Relational:MaxIdentifierLength", 128)
                .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

            modelBuilder.Entity("Film.Models.Cliente", b =>
                {
                    b.Property<string>("Id");

                    b.Property<string>("UserId");

                    b.HasKey("Id");

                    b.HasIndex("UserId");

                    b.ToTable("Cliente");
                });

            modelBuilder.Entity("Film.Models.Trabajador", b =>
                {
                    b.Property<string>("Id")
                        .ValueGeneratedOnAdd();

                    b.Property<string>("TrabajoId");

                    b.Property<string>("UserId");

                    b.HasKey("Id");

                    b.HasIndex("TrabajoId");

                    b.HasIndex("UserId");

                    b.ToTable("Trabajador");
                });

            modelBuilder.Entity("Film.Models.Trabajo", b =>
                {
                    b.Property<string>("Id")
                        .ValueGeneratedOnAdd();

                    b.Property<int>("Estado");

                    b.Property<double>("Puntuacion");

                    b.Property<string>("TrabajadorId");

                    b.HasKey("Id");

                    b.HasIndex("TrabajadorId");

                    b.ToTable("Trabajo");
                });

            modelBuilder.Entity("Film.Models.User", b =>
                {
                    b.Property<string>("Id")
                        .ValueGeneratedOnAdd();

                    b.Property<int>("AccessFailedCount");

                    b.Property<bool>("Admin");

                    b.Property<string>("Apellidos");

                    b.Property<string>("ConcurrencyStamp");

                    b.Property<string>("Email");

                    b.Property<bool>("EmailConfirmed");

                    b.Property<bool>("Estado");

                    b.Property<bool>("LockoutEnabled");

                    b.Property<DateTimeOffset?>("LockoutEnd");

                    b.Property<string>("Nombre");

                    b.Property<string>("NormalizedEmail");

                    b.Property<string>("NormalizedUserName");

                    b.Property<string>("PasswordHash");

                    b.Property<string>("PhoneNumber");

                    b.Property<bool>("PhoneNumberConfirmed");

                    b.Property<string>("SecurityStamp");

                    b.Property<bool>("TwoFactorEnabled");

                    b.Property<string>("UserName");

                    b.HasKey("Id");

                    b.ToTable("Users");
                });

            modelBuilder.Entity("Film.Models.UserDates", b =>
                {
                    b.Property<string>("Id");

                    b.Property<string>("Direccion");

                    b.Property<double>("Puntuacion");

                    b.Property<string>("Telefono");

                    b.HasKey("Id");

                    b.ToTable("UserDates");
                });

            modelBuilder.Entity("Film.Models.Cliente", b =>
                {
                    b.HasOne("Film.Models.Trabajo", "Trabajo")
                        .WithOne("Cliente")
                        .HasForeignKey("Film.Models.Cliente", "Id")
                        .OnDelete(DeleteBehavior.Restrict);

                    b.HasOne("Film.Models.User", "User")
                        .WithMany()
                        .HasForeignKey("UserId");
                });

            modelBuilder.Entity("Film.Models.Trabajador", b =>
                {
                    b.HasOne("Film.Models.Trabajo", "Trabajo")
                        .WithMany()
                        .HasForeignKey("TrabajoId");

                    b.HasOne("Film.Models.User", "User")
                        .WithMany()
                        .HasForeignKey("UserId");
                });

            modelBuilder.Entity("Film.Models.Trabajo", b =>
                {
                    b.HasOne("Film.Models.Cliente", "Trabajador")
                        .WithMany()
                        .HasForeignKey("TrabajadorId");
                });

            modelBuilder.Entity("Film.Models.UserDates", b =>
                {
                    b.HasOne("Film.Models.User", "User")
                        .WithOne("UserDates")
                        .HasForeignKey("Film.Models.UserDates", "Id")
                        .OnDelete(DeleteBehavior.Restrict);
                });
#pragma warning restore 612, 618
        }
    }
}
