-----------------------------------
-- ID: 5876
-- Item: Petrify Screen
-- Effect: 2 Mins of immunity to "Petrify" effects.
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    if target:hasStatusEffect(xi.effect.NEGATE_PETRIFY) then
        return 56
    end

    return 0
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.NEGATE_PETRIFY, 1, 0, 120)
end

return itemObject
