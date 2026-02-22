-----------------------------------
-- ID: 15651
-- Item: Ice Trousers
-- Item Effect: Ice Spikes
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target, user)
    target:addStatusEffect(xi.effect.ICE_SPIKES, { power = 7, duration = 180, origin = user })
end

return itemObject
