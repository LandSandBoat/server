-----------------------------------
-- ID: 5877
-- Item: Terror Screen
-- Effect: 2 Mins of immunity to "Terror" effects.
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    if target:hasStatusEffect(xi.effect.NEGATE_TERROR) then
        return 56
    end

    return 0
end

itemObject.onItemUse = function(target, user)
    target:addStatusEffect(xi.effect.NEGATE_TERROR, { power = 1, duration = 120, origin = user })
end

return itemObject
