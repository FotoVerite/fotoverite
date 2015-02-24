BRAND = "FotoVerite"
COMPANY = "FotoVerite"
WEBSITE = "FotoVerite.com"

STANDARD_EMAIL_REGEX = /\A[a-z0-9_\-\.%+]+@[a-z0-9\-\.]+\.[a-z]+\Z/i

Time::DATE_FORMATS[:standard] = "%B %e, %Y at %l:%M %p %Z"
Time::DATE_FORMATS[:date_only] = "%-1m/%-1e/%Y"
Time::DATE_FORMATS[:month_and_year] = "%m/%y"

Date::DATE_FORMATS[:standard] = "%B %e, %Y"

IMAGE_MIME_TYPES = ['image/jpeg', 'image/jpg', 'image/pjpeg', 'image/gif', 'image/png']
