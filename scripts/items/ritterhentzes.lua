-----------------------------------
-- ID: 15652
-- Item: ritter
-- Item Effect: Blaze Spikes
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target, user)
    target:addStatusEffect(xi.effect.BLAZE_SPIKES, { power = 20, duration = 210, origin = user })
end

return itemObject
