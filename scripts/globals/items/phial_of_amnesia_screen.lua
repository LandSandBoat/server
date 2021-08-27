-----------------------------------
-- ID: 5878
-- Item: Amnesia Screen
-- Effect: 2 Mins of immunity to "Amnesia" effects.
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    if (target:hasStatusEffect(xi.effect.NEGATE_AMNESIA)) then
        return 56
    end
    return 0
end

item_object.onItemUse = function(target)
    target:addStatusEffect(xi.effect.NEGATE_AMNESIA, 1, 0, 120)
end

return item_object
