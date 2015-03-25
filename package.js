Package.describe({
  name: 'konutils',
  summary: '',
  version: '1.0.17',
  git: ''
});

Package.onUse(function(api) {
  api.versionsFrom('1.0');
  api.use('coffeescript');
  api.use('nooitaf:colors@0.0.2');
  api.use('thepumpinglemma:object-path@1.0.0');

  api.addFiles('server/utils.coffee', ['server']);
  api.addFiles('server/sortUtils.coffee', ['server']);
  api.addFiles('server/sessionUtils.coffee', ['server']);
  api.addFiles('server/accessUtils.coffee', ['server']);
  api.addFiles('server/filterUtils.coffee', ['server']);
  api.addFiles('server/lookupUtils.coffee', ['server']);
  api.addFiles('server/metaUtils.coffee', ['server']);

  api.export(['utils'], ['server']);
  api.export(['sortUtils'], ['server']);
  api.export(['sessionUtils'], ['server']);
  api.export(['accessUtils'], ['server']);
  api.export(['filterUtils'], ['server']);
  api.export(['lookupUtils'], ['server']);
  api.export(['metaUtils'], ['server']);
});