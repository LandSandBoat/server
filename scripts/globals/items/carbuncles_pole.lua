-----------------------------------------
-- ID: 18581
-- Item: Carbuncle's Pole
-- Item Effect: Restores 160-220 HP
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")

function onAdditionalEffect(player, target, damage)
    local chance = 15

    if (chance > math.random(0, 99)) then
        local dmg = math.random(50, 90)
        local params = {}
        params.bonusmab = 0
        params.includemab = false
        dmg = addBonusesAbility(player, tpz.magic.ele.LIGHT, target, dmg, params)
        dmg = dmg * applyResistanceAddEffect(player, target, tpz.magic.ele.LIGHT, 0)
        dmg = adjustForTarget(target, dmg, tpz.magic.ele.LIGHT)
        dmg = finalMagicNonSpellAdjustments(player, target, tpz.magic.ele.LIGHT, dmg)

        local message = tpz.msg.basic.ADD_EFFECT_DMG
        if (dmg < 0) then
            message = tpz.msg.basic.ADD_EFFECT_HEAL
        end

        return tpz.subEffect.LIGHT_DAMAGE, message, dmg
    else
        return 0, 0, 0
    end
end

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    local hpHeal = math.random(160, 220)
    local dif = target:getMaxHP() - target:getHP()
    if (hpHeal > dif) then
        hpHeal = dif
    end
    target:addHP(hpHeal)
    target:messageBasic(tpz.msg.basic.RECOVERS_HP, 0, hpHeal)
end
