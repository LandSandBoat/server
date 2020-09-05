-----------------------------------------
-- ID: 18318, 18319, 18646, 18660, 18674, 19755, 19848, 21015, 21016, 21954
-- Item: Amanomurakumo
-- Additional Effect: 10% Attack Down
-----------------------------------------
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/status")

function onAdditionalEffect(player, target, damage)
    local chance = 10

    if math.random(100) <= chance and applyResistanceAddEffect(player, target, tpz.magic.ele.WATER, 0) > 0.5 then
        target:delStatusEffect(tpz.effect.ATTACK_BOOST)
        target:addStatusEffect(tpz.effect.ATTACK_DOWN, 10, 0, 60) -- Power needs verification/correction
        return tpz.subEffect.ATTACK_DOWN, tpz.msg.basic.ADD_EFFECT_STATUS, tpz.effect.ATTACK_DOWN
    end

    return 0, 0, 0
end
