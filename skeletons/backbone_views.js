var captricity = captricity || {};

captricity.<+?BACKBONE VIEW CLASSNAME?+> = Backbone.View.extend({
    initialize: function() {
        _.bindAll(this);
    },

    render: function() {
        var $el = this.$el;
        $el.empty();

        return this;
    }
});
