-----------------------------------------
-- ID: 5878
-- Item: Amnesia Screen
-- Effect: 2 Mins of immunity to "Amnesia" effects.
-----------------------------------------
require("scripts/globals/status")
-----------------------------------------

function onItemCheck(target)
    if (target:hasStatusEffect(tpz.effect.NEGATE_AMNESIA)) then
        return 56
    end
    return 0
end

function onItemUse(target)
    target:addStatusEffect(tpz.effect.NEGATE_AMNESIA, 1, 0, 120)
end
