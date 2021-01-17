-----------------------------------------
-- ID: 5770
-- Item: Super Reraiser
-- Item Effect: This potion functions the same way as the spell Reraise.
-----------------------------------------
require("scripts/globals/status")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    local duration = 3600
    target:delStatusEffect(tpz.effect.RERAISE)
    target:addStatusEffect(tpz.effect.RERAISE, 3, 0, duration)
end

return item_object
