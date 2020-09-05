-----------------------------------------
-- ID: 18008
-- Item: Hushed Dagger
-- Additional Effect: Silence
-- TODO: Enchantment: Ensilence
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
        target:addStatusEffect(tpz.effect.SILENCE, 5, 0, 30)
        return tpz.subEffect.SILENCE, tpz.msg.basic.ADD_EFFECT_STATUS, tpz.effect.SILENCE
    end
end

function onItemCheck(target)
end

function onItemUse(target)
end
