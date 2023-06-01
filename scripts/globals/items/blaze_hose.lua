-----------------------------------
-- ID: 15652
-- Item: Blaze Hose
-- Item Effect: Blaze Spikes
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.BLAZE_SPIKES, 15, 0, 180)
end

return itemObject
