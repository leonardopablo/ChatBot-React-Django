from django.db import models


class Recipe(models.Model):
    """Represents a recipe in the system."""
    name = models.CharField(max_length=255)
    steps = models.TextField()

    def __str__(self):
        return self.name

class AiChatSession(models.Model):
    # "sesiones de seguimiento e inteligencia artificial"
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    
class AiRequest(models.Model):
    # representa solicitudes de ai
    PENDING = 'pending'
    RUNNING = 'running'
    COMPLETED = 'complete'
    FAILED = 'failed'
    STATUS_OPTIONS = (
        (PENDING, 'Pending'),
        (RUNNING, 'Running'),
        (COMPLETED, 'Completed'),
        (FAILED, 'Failed'),
    )
    status = models.CharField(choices = STATUS_OPTIONS, default = PENDING)
    response = models.JSONField(null = True, blank = True)
    created_at = models.DateTimeField(auto_now_add = True)
    updated_at = models.DateTimeField(auto_now = True)