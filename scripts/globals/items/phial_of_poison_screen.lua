-----------------------------------
-- ID: 5880
-- Item: Poison Screen
-- Effect: 2 Mins of immunity to "Poison" effects.
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    if target:hasStatusEffect(xi.effect.NEGATE_POISON) then
        return 56
    end

    return 0
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.NEGATE_POISON, 1, 0, 120)
end

return itemObject
