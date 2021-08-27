-----------------------------------
-- ID: 4173
-- Item: Hi-Reraiser
-- Item Effect: This potion functions inthe same way as the spell Reraise II.
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    local duration = 5400
    target:delStatusEffect(xi.effect.RERAISE)
    target:addStatusEffect(xi.effect.RERAISE, 2, 0, duration)
end

return item_object
