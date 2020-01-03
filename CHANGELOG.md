Workarea Swatches 1.0.5 (2019-08-21)
--------------------------------------------------------------------------------

*   Open Source!
*   Fix integration test against Workarea v3.4



Workarea Swatches 1.0.4 (2018-11-28)
--------------------------------------------------------------------------------

*   Add pricing details append point to swatches product template

    Adds pricing append point for PDP specfic content to appear under pricing

    SWATCHES-18
    Jeff Yucis



Workarea Swatches 1.0.3 (2018-10-30)
--------------------------------------------------------------------------------

*   Correct BrowseSwatchesSystemTest class name to not conflic with other tests

    SWATCHES-17
    Matt Duffy



Workarea Swatches 1.0.2 (2018-07-24)
--------------------------------------------------------------------------------

*   Add class to swatch link

    Helps with theming

    SWATCHES-9
    Ben Crouse



Workarea Swatches 1.0.1 (2018-06-12)
--------------------------------------------------------------------------------

*   Fix API support for swatches when browsing

    API grumbles about a missing partial otherwise.
    Ben Crouse

*   Fix images with blank options

    This caused a bug with the demo data plugin.
    Ben Crouse

*   Remove ID attribute on swatch selectors

    This caused a duplicate ID error when a packaged product includes a
    swatches product in the package. Explicitly setting the ID to `nil` for
    this element gets rid of the error.

    SWATCHES-13
    Tom Scott



Workarea Swatches 1.0.0 (2018-05-24)
--------------------------------------------------------------------------------

*   Add guard clause to prevent errors when no swatches are present

    SWATCHES-10
    Jake Beresford

*   Add classes to result filters

    ECOMMERCE-5830
    Curt Howard

*   Show swatches on category browse pages

    SWATCHES-2
    Matt Duffy

*   Leverage Workarea Changelog task

    ECOMMERCE-5355
    Curt Howard

*   Simplify swatch facet component

    SWATCHES-1
    Curt Howard

*   Include empty swatch state

    SWATCHES-1
    Curt Howard

*   Add per-product swatch overriding

    Ben Crouse

*   Add filters

    Ben Crouse

*   Add filters

    Ben Crouse

*   Add seeds

    Ben Crouse

*   Add swatches product template

    Ben Crouse



