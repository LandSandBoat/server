-----------------------------------
-- ID: 4172
-- Item: Wizards Drink
-- Item Effect: +100% MP
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    local duration = 900
    target:delStatusEffect(xi.effect.MAX_MP_BOOST)
    target:addStatusEffect(xi.effect.MAX_MP_BOOST, 100, 0, duration)
end

return item_object
