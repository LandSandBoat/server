-----------------------------------
-- ID: 5878
-- Item: Amnesia Screen
-- Effect: 2 Mins of immunity to "Amnesia" effects.
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    if target:hasStatusEffect(xi.effect.NEGATE_AMNESIA) then
        return 56
    end

    return 0
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.NEGATE_AMNESIA, 1, 0, 120)
end

return itemObject
