-----------------------------------------
-- ID: 16936
-- Item: Demonic Sword
-- Additional Effect: Darkness Damage
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
        local dmg = math.random(5, 21)
        local params = {}
        params.bonusmab = 0
        params.includemab = false
        dmg = addBonusesAbility(player, tpz.magic.ele.DARK, target, dmg, params)
        dmg = dmg * applyResistanceAddEffect(player, target, tpz.magic.ele.DARK, 0)
        dmg = adjustForTarget(target, dmg, tpz.magic.ele.DARK)
        dmg = finalMagicNonSpellAdjustments(player, target, tpz.magic.ele.DARK, dmg)

        local message = tpz.msg.basic.ADD_EFFECT_DMG
        if (dmg < 0) then
            message = tpz.msg.basic.ADD_EFFECT_HEAL
        end

        return tpz.subEffect.DARKNESS_DAMAGE, message, dmg
    end
end
