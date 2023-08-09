# generate newsAPI script

MODULE="Modules/MediaStackAPI/Sources/MediaStackAPI"

openapi-generator generate -i "mediastack.yml" -g swift5 -o "mediastackgen"
rm -r $MODULE""*
cp -R "mediastackgen/OpenAPIClient/Classes/OpenAPIs/". $MODULE
rm -r "mediastackgen"
