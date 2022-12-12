-----------------------------------
-- ID: 5877
-- Item: Terror Screen
-- Effect: 2 Mins of immunity to "Terror" effects.
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    if target:hasStatusEffect(xi.effect.NEGATE_TERROR) then
        return 56
    end

    return 0
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.NEGATE_TERROR, 1, 0, 120)
end

return itemObject
