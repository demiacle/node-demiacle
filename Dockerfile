FROM cypress/base:16.18.1


RUN apt-get update \
  && apt-get -y install wget \
  && apt-get -y install git \
  # Install xpdf v4 directly since some distro repos use different
  && wget -qO xpdf-tools-linux-4.04.tar.gz https://dl.xpdfreader.com/xpdf-tools-linux-4.04.tar.gz \
  && tar xzf xpdf-tools-linux-4.04.tar.gz \
  && mv xpdf-tools-linux-4.04/bin64/pdftopng /usr/bin/ \
  && mv xpdf-tools-linux-4.04/bin64/pdfdetach /usr/bin/ \
  # Install npm global to ensure we have correct version (sometimes images will use different ones)
  && npm i npm@8.19.2 -g \
  # Install mongo v5 bin so we can use cli commands
  && apt-get update \
  && apt-get -y install gnupg \
  && wget -qO - https://www.mongodb.org/static/pgp/server-5.0.asc | apt-key add - \
  && echo "deb http://repo.mongodb.org/apt/debian buster/mongodb-org/5.0 main" | tee /etc/apt/sources.list.d/mongodb-org-5.0.list \
  && apt-get update \
  && apt-get install -y mongodb-org \
  && mongo --version \
  && mongorestore --version \
  # Install tooling dependencies
  && apt-get update \
  && apt list -a pdftk \
  && apt-get -y install pdftk \
  && pdftk --version \
  && apt list -a imagemagick \
  && apt-get -y install imagemagick \
  && convert --version \
  # Allow pdf permissions
  && sed -i 's/<policy domain="coder" rights="none" pattern="PDF" \/>//g' /etc/ImageMagick-6/policy.xml \
  && which convert \
  && apt list -a ghostscript \
  && apt-get -y install ghostscript \
  && gs -v
