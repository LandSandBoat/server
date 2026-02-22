-----------------------------------
-- ID: 15650
-- Item: shock subligar
-- Item Effect: Shock Spikes
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target, user)
    target:addStatusEffect(xi.effect.SHOCK_SPIKES, { power = 7, duration = 180, origin = user })
end

return itemObject
