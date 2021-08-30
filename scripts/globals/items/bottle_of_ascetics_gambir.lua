-----------------------------------------
-- ID:          5842
-- Item:        bottle_of_ascetics_gambir
-- Item Effect: MATK/MACC 50
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/item_utils")
-----------------------------------------

local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    local effect1   = xi.effect.MAGIC_ATK_BOOST
    local effect2   = xi.effect.INTENSION
    local power1    =  50 --MATT
    local power2    =  50 --MACC
    local duration  = 300

    item_utils.addTwoItemEffects(target, effect1, effect2, power1, power2, duration)
end

return item_object
