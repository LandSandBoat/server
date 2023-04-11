-----------------------------------
-- ID: 15652
-- Item: Blaze Hose
-- Item Effect: Blaze Spikes
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    target:delStatusEffect(xi.effect.BLAZE_SPIKES)
    target:addStatusEffect(xi.effect.BLAZE_SPIKES, 15, 0, 180, 0, 0, 0, xi.items.BLAZE_HOSE)
end

return itemObject
