from django.shortcuts import render

# Create your views here.
from rest_framework import generics
from .models import Image
from .serializers import ImageSerializer

class ImageListCreateView(generics.ListCreateAPIView):
    queryset = Image.objects.all()
    serializer_class = ImageSerializer
