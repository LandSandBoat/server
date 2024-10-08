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

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.BLAZE_SPIKES, 10, 0, 90)
end

return itemObject
