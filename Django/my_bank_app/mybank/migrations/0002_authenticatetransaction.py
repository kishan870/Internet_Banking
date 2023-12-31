# Generated by Django 4.2.4 on 2023-08-05 06:09

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ("mybank", "0001_initial"),
    ]

    operations = [
        migrations.CreateModel(
            name="AuthenticateTransaction",
            fields=[
                (
                    "id",
                    models.BigAutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name="ID",
                    ),
                ),
                ("trans_password", models.CharField(max_length=128)),
                (
                    "userID",
                    models.ForeignKey(
                        on_delete=django.db.models.deletion.CASCADE, to="mybank.uid"
                    ),
                ),
            ],
        ),
    ]
