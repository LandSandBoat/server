-----------------------------------
-- ID: 15912
-- Item: Lieutenant's Sash
-- On Use: Removes food effect.
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    target:delStatusEffect(tpz.effect.FOOD)
    target:delStatusEffect(tpz.effect.FIELD_SUPPORT_FOOD)
end

return item_object
