-----------------------------------------
-- ID: 16777
-- Item: Death Scythe
-- Additional Effect: Drains HP
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------

function onAdditionalEffect(player, target, damage)
    local chance = 10

    if (math.random(0, 99) >= chance) then
        return 0, 0, 0
    else
        local power = 10
        local params = {}
        params.bonusmab = 0
        params.includemab = false
        power = addBonusesAbility(player, tpz.magic.ele.DARK, target, power, params)
        power = power * applyResistanceAddEffect(player, target, tpz.magic.ele.DARK, 0)
        power = adjustForTarget(target, power, tpz.magic.ele.DARK)
        power = finalMagicNonSpellAdjustments(player, target, tpz.magic.ele.DARK, power )

        if (power < 0) then
            power = 0
        else
            player:addHP(power)
        end

        return tpz.subEffect.HP_DRAIN, tpz.msg.basic.ADD_EFFECT_HP_DRAIN, power
    end
end
