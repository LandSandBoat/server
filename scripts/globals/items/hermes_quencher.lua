-----------------------------------------
-- ID: 5255
-- Item: Hermes Quencher
-- Item Effect: Flee for 30 seconds
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")

function onItemCheck(target)
    if (target:hasStatusEffect(tpz.effect.MEDICINE)) then
        return tpz.msg.basic.ITEM_NO_USE_MEDICATED
    end
    return 0
end

function onItemUse(target)
    target:delStatusEffect(tpz.effect.FLEE)
    target:addStatusEffect(tpz.effect.FLEE, 100, 0, 30)
    target:messageBasic(tpz.msg.basic.GAINS_EFFECT_OF_STATUS, tpz.effect.FLEE)
    target:addStatusEffect(tpz.effect.MEDICINE, 0, 0, 900)
end
