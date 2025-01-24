

module_name=$1

mkdir -p $module_name

cd $module_name

mkdir -p data/data_sources/local/
mkdir -p data/repositories/

mkdir -p domain/entity/
mkdir -p domain/repositories/
mkdir -p domain/usecases/

mkdir -p presentation/notifiers
mkdir -p presentation/views
mkdir -p presentation/widgets

touch data/data_sources/local/local_${module_name}_datasource.dart
touch data/repositories/${module_name}_repository_impl.dart

touch domain/entity/${module_name}_entity.dart
touch domain/repositories/${module_name}_repository.dart
touch domain/usecases/${module_name}_usecase.dart

touch presentation/notifiers/${module_name}_notifier.dart
touch presentation/views/${module_name}_view.dart
