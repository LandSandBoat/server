-----------------------------------
-- ID: 15651
-- Item: Ice Trousers
-- Item Effect: Ice Spikes
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/status")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    target:addStatusEffect(xi.effect.ICE_SPIKES, 7, 0, 180)
end

return item_object
