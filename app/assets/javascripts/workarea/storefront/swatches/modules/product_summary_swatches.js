/**
 * @namespace WORKAREA.productSummarySwatches
 */
WORKAREA.registerModule('productSummarySwatches', (function () {
    'use strict';

    var replaceProductSummary = function ($productSummary, newSummary) {
            var $newSummary = $(newSummary);

            WORKAREA.initModules($newSummary);

            $productSummary.empty().append($newSummary);
        },

        loadImage = function ($productSummary, newSummary) {
            var imageSrc = $('.product-summary__media-image', newSummary)[0].src,
                gettingImage = WORKAREA.image.get(imageSrc);

            WORKAREA.loading.createLoadingIndicator(gettingImage, {
                container: $productSummary,
                cssModifiers: 'loading--fill-parent',
                delay: 0
            });

            gettingImage.always(_.partial(replaceProductSummary, $productSummary, newSummary));
        },

        fallbackToUrl = function ($button) {
            window.location = $button.attr('href');
        },

        buttonIsSelected = function ($button) {
            return $button.hasClass('swatch-options__swatch-button--selected');
        },

        handleSwatchButtonClick = function (event) {
            var $button = $(event.currentTarget),
                $productSummary = $button.closest('.product-summary'),
                endpoint = $button.data('productSummarySwatch').url;

            event.preventDefault();

            if (buttonIsSelected($button)) { return; }

            $.get(endpoint)
            .done(_.partial(loadImage, $productSummary))
            .fail(_.partial(fallbackToUrl, $button));
        },

        /**
         * @method
         * @name init
         * @memberof WORKAREA.productSummarySwatches
         */
        init = function ($scope) {
            $('[data-product-summary-swatch]', $scope)
            .on('click', handleSwatchButtonClick);
        };

    return {
        init: init
    };
}()));
