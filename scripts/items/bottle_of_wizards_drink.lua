-----------------------------------
-- ID: 4172
-- Item: Wizards Drink
-- Item Effect: +100% MP
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target, user)
    local duration = 900
    target:delStatusEffect(xi.effect.MAX_MP_BOOST)
    target:addStatusEffect(xi.effect.MAX_MP_BOOST, { power = 100, duration = duration, origin = user })
end

return itemObject
