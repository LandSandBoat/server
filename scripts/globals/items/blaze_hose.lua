-----------------------------------
-- ID: 15652
-- Item: Blaze Hose
-- Item Effect: Blaze Spikes
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local effect = target:getStatusEffect(xi.effect.BLAZE_SPIKES)
    if effect ~= nil and effect:getSubType() == 15652 then
        target:delStatusEffect(xi.effect.BLAZE_SPIKES)
    end
    return 0
end

item_object.onItemUse = function(target)
    target:addStatusEffect(xi.effect.BLAZE_SPIKES, 15, 0, 180, 15652)
end

return item_object
