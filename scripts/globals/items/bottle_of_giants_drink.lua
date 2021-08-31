-----------------------------------
-- ID: 4172
-- Item: Reraiser
-- Item Effect: +100% HP
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    local duration = 900
    target:delStatusEffect(xi.effect.MAX_HP_BOOST)
    target:addStatusEffect(xi.effect.MAX_HP_BOOST, 100, 0, duration)
end

return item_object
