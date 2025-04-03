from django.db import models
from django.contrib.auth.models import AbstractUser

class Dailyquest(models.Model):
    id = models.IntegerField(primary_key=True)
    quest = models.ForeignKey('Quest', models.DO_NOTHING, db_column='quest', blank=True, null=True)

    class Meta:
        managed = True
        db_table = 'DailyQuest'


class Friend(models.Model):
    pk = models.CompositePrimaryKey('user_id', 'friend_id')
    user = models.ForeignKey('User', models.DO_NOTHING)
    friend = models.ForeignKey('User', models.DO_NOTHING, related_name='friend_friend_set')
    created_at = models.DateField(blank=True, null=True)

    class Meta:
        managed = True
        db_table = 'Friend'
        unique_together = (('user', 'friend'),)


class League(models.Model):
    id = models.IntegerField(primary_key=True)
    name = models.CharField(max_length=255, blank=True, null=True)
    maxscore = models.IntegerField(db_column='maxScore', blank=True, null=True)  # Field name made lowercase.
    minscore = models.IntegerField(db_column='minScore', blank=True, null=True)  # Field name made lowercase.

    class Meta:
        managed = True
        db_table = 'League'


class Quest(models.Model):
    id = models.IntegerField(primary_key=True)
    description = models.CharField(max_length=255, blank=True, null=True)
    score = models.IntegerField(blank=True, null=True)
    completed = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = True
        db_table = 'Quest'


class Station(models.Model):
    id = models.IntegerField(primary_key=True)
    station_id = models.IntegerField(blank=True, null=True)
    line_id = models.IntegerField(blank=True, null=True)
    lat = models.FloatField(blank=True, null=True)
    lon = models.FloatField(blank=True, null=True)
    name = models.CharField(max_length=255, blank=True, null=True)

    class Meta:
        managed = True
        db_table = 'Station'


class Travel(models.Model):
    id = models.IntegerField(primary_key=True)
    origin = models.ForeignKey(Station, models.DO_NOTHING, db_column='origin', blank=True, null=True)
    destination = models.ForeignKey(Station, models.DO_NOTHING, db_column='destination', related_name='travel_destination_set', blank=True, null=True)
    quest = models.ForeignKey(Quest, models.DO_NOTHING, db_column='quest', blank=True, null=True)
    completed = models.IntegerField(blank=True, null=True)
    datetime_arrive = models.DateTimeField(blank=True, null=True)
    datetime_salida = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = True
        db_table = 'Travel'




class User(AbstractUser):
    profilepic_path = models.CharField(db_column='profilePic_path', max_length=255, blank=True, null=True)
    quests = models.IntegerField(blank=True, null=True)
    travels = models.IntegerField(blank=True, null=True)
    score = models.IntegerField(blank=True, null=True)
    league = models.ForeignKey(League, models.DO_NOTHING, db_column='league', blank=True, null=True)


    groups = models.ManyToManyField(
        'auth.Group',
        related_name='custom_user_set',
        blank=True
    )
    user_permissions = models.ManyToManyField(
        'auth.Permission',
        related_name='custom_user_permissions_set',
        blank=True
    )
    class Meta:
        managed = True
        db_table = 'User'


class UserQuest(models.Model):
    id = models.IntegerField(primary_key=True)
    quest = models.ForeignKey(Quest, models.DO_NOTHING, db_column='quest', blank=True, null=True)
    user = models.ForeignKey(User, models.DO_NOTHING, db_column='user', blank=True, null=True)

    class Meta:
        managed = True
        db_table = 'User_Quest'


class UserTravel(models.Model):
    id = models.IntegerField(primary_key=True)
    travel = models.ForeignKey(Travel, models.DO_NOTHING, db_column='travel', blank=True, null=True)
    user = models.ForeignKey(User, models.DO_NOTHING, db_column='user', blank=True, null=True)

    class Meta:
        managed = True
        db_table = 'User_Travel'
