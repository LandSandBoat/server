-----------------------------------
-- ID: 15652
-- Item: Blaze Hose
-- Item Effect: Blaze Spikes
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target)
    target:delStatusEffect(xi.effect.BLAZE_SPIKES)
    target:addStatusEffect(xi.effect.BLAZE_SPIKES, 15, 0, 180)
end

return itemObject
