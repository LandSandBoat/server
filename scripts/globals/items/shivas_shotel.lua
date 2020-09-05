-----------------------------------------
-- ID: 17711
-- Item: Shiva's Shotel
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------

function onAdditionalEffect(player, target, damage)
    local chance = 10

    if (chance > math.random(0, 99)) then
        local dmg = math.random(38, 70)
        local params = {}
        params.bonusmab = 0
        params.includemab = false
        dmg = addBonusesAbility(player, tpz.magic.ele.ICE, target, dmg, params)
        dmg = dmg * applyResistanceAddEffect(player, target, tpz.magic.ele.ICE, 0)
        dmg = adjustForTarget(target, dmg)
        dmg = finalMagicNonSpellAdjustments(player, target, tpz.magic.ele.ICE, dmg)

        local message = tpz.msg.basic.ADD_EFFECT_DMG
        if (dmg < 0) then
            message = tpz.msg.basic.ADD_EFFECT_HEAL
        end

        return tpz.subEffect.ICE_DAMAGE, message, dmg
    else
        return 0, 0, 0
    end
end

function onItemCheck(target)
    return 0
end
