-----------------------------------
--  ID: 15698
--  Sneaking Boots
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    target:delStatusEffect(xi.effect.SNEAK)
    target:addStatusEffect(xi.effect.SNEAK, 1, 0, math.floor(180 * xi.settings.SNEAK_INVIS_DURATION_MULTIPLIER))
end

return item_object
