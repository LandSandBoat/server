-----------------------------------
-- ID: 4172
-- Item: Reraiser
-- Item Effect: +50% HP
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target, user)
    local duration = 900
    target:delStatusEffect(xi.effect.MAX_MP_BOOST)
    target:addStatusEffect(xi.effect.MAX_MP_BOOST, { power = 50, duration = duration, origin = user })
end

return itemObject
