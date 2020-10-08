/// @desc

function pal_swap_init_system(shd) {}
#macro shd_pal_swapper 0
function pal_swap_set() { var _ = argument[0]; _=_; }
function pal_swap_reset() {}


pal_swap_init_system(shd_pal_swapper) // comment the functions above
// and import PixelatedPope's Palette swap asset if you own it