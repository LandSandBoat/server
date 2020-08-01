-----------------------------------------
-- ID: 16501
-- Item: Acid Knife
-- Additional Effect: Weakens defense
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------

function onAdditionalEffect(player, target, damage)
    local chance = 10

    if (math.random(0, 99) >= chance or applyResistanceAddEffect(player, target, tpz.magic.ele.WIND, 0) <= 0.5) then
        return 0, 0, 0
    else
        target:delStatusEffect(tpz.effect.DEFENSE_BOOST)
        target:addStatusEffect(tpz.effect.DEFENSE_DOWN, 12, 0, 60)
        return tpz.subEffect.DEFENSE_DOWN, tpz.msg.basic.ADD_EFFECT_STATUS, tpz.effect.DEFENSE_DOWN
    end
end
