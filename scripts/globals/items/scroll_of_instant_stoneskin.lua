-----------------------------------------
-- ID: 5990
-- Scroll of Instant Stoneskin
-- Grants the user a 200 HP Stoneskin effect
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    if target:addStatusEffect(tpz.effect.STONESKIN, 200, 0, 300, 0, 0, 4) then
        target:messageBasic(tpz.msg.basic.GAINS_EFFECT_OF_STATUS, tpz.effect.STONESKIN)
    else
        target:messageBasic(tpz.msg.basic.NO_EFFECT)
    end
end
