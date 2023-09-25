-----------------------------------
-- ID: 5879
-- Item: Doom Screen
-- Effect: 2 Mins of immunity to "Doom" effects.
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    if target:hasStatusEffect(xi.effect.NEGATE_DOOM) then
        return 56
    end

    return 0
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.NEGATE_DOOM, 1, 0, 120)
end

return itemObject
