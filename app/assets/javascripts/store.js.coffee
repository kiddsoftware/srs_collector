# http://emberjs.com/guides/models/defining-a-store/

inflector = Ember.Inflector.inflector
inflector.irregular("dictionary", "dictionaries")
inflector.plural(/dia$/, "dia") # media -> media
inflector.singular(/dia$/, "dia")

# Use ActiveModelAdapter because we want to use underscores instead of
# camel-case in our JSON.
SrsCollector.Adapter = DS.ActiveModelAdapter.extend
  namespace: 'api/v1'

SrsCollector.Store = DS.Store.extend
  adapter: SrsCollector.Adapter
