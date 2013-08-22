from django.conf import settings
from django.core.management.base import BaseCommand, CommandError
from optparse import make_option

class Command(BaseCommand):
    help = ""
    option_list = BaseCommand.option_list

    def handle(self, *labels, **options):
        pass
