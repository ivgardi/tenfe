from django.contrib import admin
from django.urls import path, include
from rest_framework import routers
from api.core.views import UserViewSet



router = routers.DefaultRouter()

router.register(r'users', UserViewSet)


urlpatterns = [
    path('', include(router.urls)),
    path('api-auth/', include('rest_framework.urls', namespace='rest_framework')),
    path('admin/', admin.site.urls)
]
x
