# Parsing environment variables

# Checkout the last commit of the project
If [ $GIT_FETCH_STRATEGY -eq 'fetch']
then
    cd project
    git stash save
	git pull --force
else
	git clone http://git.proxym-group.net/webmob_gbm_barwa-oci_app.git project
fi

# Scan Adapters with Sonar Scanner
cd project/adapters/GroupAdapters
mvn clean verify sonar:sonar
mvn clean install
mvn sonar:sonar
cd ../..

# Install frontend modules
cd barwa && npm install
cp -Rf ./plugins/ngx-swiper-wrapper/* node_modules/ngx-swiper-wrapper/ 
cp -Rf ./plugins/swiper/* node_modules/swiper/
cp -f ./plugins/@types/lodash/index.d.ts node_modules/@types/lodash/index.d.ts 
cp -Rf ./plugins/maps-api-loader/* node_modules/@agm/core/services/maps-api-loader/

# Scan front end with Sonar Scanner
sonar-scanner -Dsonar.projectName=barwa-front -Dsonar.projectVersion=1.0 -Dsonar.sources=./src -Dsonar.host.url=http://deploy.proxym-it.tn:9000/ -Dsonar.projectKey=qwerty12345
cd ..

# Add MFP server
mfpdev server add localserver --url http://mobilefirst:9080 --setdefault --login admin --password admin --contextroot mfpadmin

# Deploy MFP adapters
cd adapters/GroupAdapters && mfpdev adapter build && mfpdev adapter deploy localserver
cd ../..

# Build Mobile App
cd barwa
npm run build:web:prod && npm run build:mob:prod
cd ..
# Deploy Mobile App
cd BarwaMobile
mkdir www 
cordova platform remove android
cordova platform add android@6.1.2
cordova clean
cd BarwaMobile 
cordova prepare
mfpdev app register localserver
cd ..

#Build Web App
cd BarwaWeb
mfpdev app register localserver com.barwa.barwaApp
cd ..