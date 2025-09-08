from django.contrib import admin
from django.urls import path, include
from django.conf import settings
from django.conf.urls.static import static
from django.http import HttpResponse, JsonResponse
from master import views
from master.views import custom_login_view


# ✅ Safe root view (handles '/')
def home_view(request):
    return HttpResponse("Student Alerts Backend is running.")

# ✅ Health check endpoint (handles '/actuator/health/')
def actuator_health(request):
    return JsonResponse({"status": "UP"})

urlpatterns = [
    path('admin', admin.site.urls),
    path('', include('master.urls')), 
    path('', include('admission.urls')), # Includes app-level URLs for the routes defined in `master.urls`
    path('', include('attendence.urls')),
    path('', include('license.urls')),
    # project/urls.py
path('', include('timetable.urls')),
path('', include('lms.urls')),



path('', include('core.urls')),



path('fees', include('fees.urls')),
path('transport/', include('transport.urls')),
 path('hr/', include('hr.urls')),
   path('healthz/', lambda r: HttpResponse("ok")),
    path('actuator/health/', actuator_health),


]+ static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
