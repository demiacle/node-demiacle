FROM cypress/base:16.18.1

# Install xpdf v4 directly since some distro repos use different
RUN apt-get update
RUN apt-get -y install wget
RUN apt-get -y install git
RUN wget -qO xpdf-tools-linux-4.04.tar.gz https://dl.xpdfreader.com/xpdf-tools-linux-4.04.tar.gz
RUN tar xzf xpdf-tools-linux-4.04.tar.gz
RUN mv xpdf-tools-linux-4.04/bin64/pdftopng /usr/bin/
RUN mv xpdf-tools-linux-4.04/bin64/pdfdetach /usr/bin/

# Install npm global to ensure we have correct version (sometimes images will use different ones)
RUN npm i npm@8.19.2 -g

# Install mongo v5 bin so we can use cli commands
RUN apt-get update
RUN apt-get -y install gnupg
RUN wget -qO - https://www.mongodb.org/static/pgp/server-5.0.asc | apt-key add -
RUN echo "deb http://repo.mongodb.org/apt/debian buster/mongodb-org/5.0 main" | tee /etc/apt/sources.list.d/mongodb-org-5.0.list
RUN apt-get update
RUN apt-get install -y mongodb-org
RUN mongo --version
RUN mongorestore --version

# Install tooling dependencies
RUN apt-get update
RUN apt list -a pdftk
RUN apt-get -y install pdftk
RUN pdftk --version
RUN apt list -a imagemagick
RUN apt-get -y install imagemagick
RUN convert --version
RUN sed -i 's/<policy domain="coder" rights="none" pattern="PDF" \/>//g' /etc/ImageMagick-6/policy.xml # allow pdf permissions
RUN which convert
RUN apt list -a ghostscript
RUN apt-get -y install ghostscript
RUN gs -v
