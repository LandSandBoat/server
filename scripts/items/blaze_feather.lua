-----------------------------------
-- ID: 5257
-- Item: Blaze Feather
-- Status Effect: Blaze Spikes
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target, user)
    target:addStatusEffect(xi.effect.BLAZE_SPIKES, { power = 10, duration = 90, origin = user })
end

return itemObject
