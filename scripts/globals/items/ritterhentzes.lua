-----------------------------------------
-- ID: 15652
-- Item: ritter
-- Item Effect: Blaze Spikes
-----------------------------------------
local item_object = {}

require("scripts/globals/settings")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    target:addStatusEffect(tpz.effect.BLAZE_SPIKES, 20, 0, 210)
end

return item_object
