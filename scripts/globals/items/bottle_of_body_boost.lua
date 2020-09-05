-----------------------------------------
-- ID: 4172
-- Item: Reraiser
-- Item Effect: +50% HP
-----------------------------------------
require("scripts/globals/status")
-----------------------------------------

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    local duration = 900
    target:delStatusEffect(tpz.effect.MAX_HP_BOOST)
    target:addStatusEffect(tpz.effect.MAX_HP_BOOST, 50, 0, duration)
end
