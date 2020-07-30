-----------------------------------------
-- ID: 4172
-- Item: Wizards Drink
-- Item Effect: +100% MP
-----------------------------------------
require("scripts/globals/status")
-----------------------------------------

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    local duration = 900
    target:delStatusEffect(tpz.effect.MAX_MP_BOOST)
    target:addStatusEffect(tpz.effect.MAX_MP_BOOST, 100, 0, duration)
end
