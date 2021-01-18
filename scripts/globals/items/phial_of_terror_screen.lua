-----------------------------------
-- ID: 5877
-- Item: Terror Screen
-- Effect: 2 Mins of immunity to "Terror" effects.
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    if (target:hasStatusEffect(tpz.effect.NEGATE_TERROR)) then
        return 56
    end
    return 0
end

item_object.onItemUse = function(target)
    target:addStatusEffect(tpz.effect.NEGATE_TERROR, 1, 0, 120)
end

return item_object
