-----------------------------------------
-- ID: 15170
-- Item: Spartan Hoplon
-- Item Effect: Phalanx
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    if (target:addStatusEffect(tpz.effect.PHALANX, 10, 0, 180)) then -- Retail potency unknown, 10 is a guess. (someone 1000 needles test this thing!)
        target:messageBasic(tpz.msg.basic.GAINS_EFFECT_OF_STATUS, tpz.effect.PHALANX)
    else
        target:messageBasic(tpz.msg.basic.NO_EFFECT)
    end
end
