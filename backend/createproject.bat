php doctrinecli.php orm:schema-tool:drop --force
rm -rf entities
php doctrinecliyaml.php orm:generate-entities . --generate-annotations="TRUE"
cd entities
sed -i 's/@ORM\\/@/g' *.php
sed -i 's/NONE/AUTO/g' *.php
cd ..
php doctrinecli.php orm:generate-entities . --generate-annotations="TRUE"
php doctrinecli.php orm:schema-tool:create
mv Entities tmpEntities
mv tmpEntities entities
