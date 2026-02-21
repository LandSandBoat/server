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

itemObject.onItemUse = function(target, user)
    target:delStatusEffect(xi.effect.BLAZE_SPIKES)
    target:addStatusEffect(xi.effect.BLAZE_SPIKES, { power = 15, duration = 180, origin = user })
end

return itemObject
