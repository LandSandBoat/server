-----------------------------------
-- ID: 5876
-- Item: Petrify Screen
-- Effect: 2 Mins of immunity to "Petrify" effects.
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    if (target:hasStatusEffect(tpz.effect.NEGATE_PETRIFY)) then
        return 56
    end
    return 0
end

item_object.onItemUse = function(target)
    target:addStatusEffect(tpz.effect.NEGATE_PETRIFY, 1, 0, 120)
end

return item_object
