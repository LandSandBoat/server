-----------------------------------
-- Ability: Violent Flourish
-- Stuns target with a low rate of success. Requires one Finishing Move.
-- Obtained: Dancer Level 45
-- Finishing Moves Used: 1
-- Recast Time: 0:20
-- Duration: ??
-----------------------------------
require("scripts/globals/jobpoints")
require("scripts/globals/weaponskills")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    if (player:getAnimation() ~= 1) then
        return xi.msg.basic.REQUIRES_COMBAT, 0
    else
        if (player:hasStatusEffect(xi.effect.FINISHING_MOVE_1)) then
            player:delStatusEffect(xi.effect.FINISHING_MOVE_1)
            return 0, 0
        elseif (player:hasStatusEffect(xi.effect.FINISHING_MOVE_2)) then
            player:delStatusEffectSilent(xi.effect.FINISHING_MOVE_2)
            player:addStatusEffect(xi.effect.FINISHING_MOVE_1, 1, 0, 7200)
            return 0, 0
        elseif (player:hasStatusEffect(xi.effect.FINISHING_MOVE_3)) then
            player:delStatusEffectSilent(xi.effect.FINISHING_MOVE_3)
            player:addStatusEffect(xi.effect.FINISHING_MOVE_2, 1, 0, 7200)
            return 0, 0
        elseif (player:hasStatusEffect(xi.effect.FINISHING_MOVE_4)) then
            player:delStatusEffectSilent(xi.effect.FINISHING_MOVE_4)
            player:addStatusEffect(xi.effect.FINISHING_MOVE_3, 1, 0, 7200)
            return 0, 0
        elseif (player:hasStatusEffect(xi.effect.FINISHING_MOVE_5)) then
            player:delStatusEffectSilent(xi.effect.FINISHING_MOVE_5)
            player:addStatusEffect(xi.effect.FINISHING_MOVE_4, 1, 0, 7200)
            return 0, 0
        else
            return xi.msg.basic.NO_FINISHINGMOVES, 0
        end
    end
end

ability_object.onUseAbility = function(player, target, ability, action)
    --get fstr
    local fstr = fSTR(player:getStat(xi.mod.STR), target:getStat(xi.mod.VIT), player:getWeaponDmgRank())

    local params = {}
    params.atk100 = 1 params.atk200 = 1 params.atk300 = 1

    --apply WSC
    local weaponDamage = player:getWeaponDmg()

    if (player:getWeaponSkillType(xi.slot.MAIN) == 1) then
        local h2hSkill = ((player:getSkillLevel(1) * 0.11) + 3)
        weaponDamage = player:getWeaponDmg()-3

        weaponDamage = weaponDamage + h2hSkill
    end

    local base = weaponDamage + fstr
    local cratio, _ = cMeleeRatio(player, target, params, 0, 0)
    local isSneakValid = player:hasStatusEffect(xi.effect.SNEAK_ATTACK)
    if (isSneakValid and not player:isBehind(target)) then
        isSneakValid = false
    end
    local pdif = generatePdif (cratio[1], cratio[2], true)
    local hitrate = getHitRate(player, target, true)

    if (math.random() <= hitrate or isSneakValid) then
        local hit = 3
        local dmg = base * pdif

        local spell = GetSpell(252)
        params.diff = 0
        params.skillType = player:getWeaponSkillType(xi.slot.MAIN)
        params.bonus = 50 - target:getMod(xi.mod.STUNRES) + player:getMod(xi.mod.VFLOURISH_MACC) + player:getJobPointLevel(xi.jp.FLOURISH_I_EFFECT)
        local resist = applyResistance(player, target, spell, params)

        if resist > 0.25 then
            target:addStatusEffect(xi.effect.STUN, 1, 0, 2)
        else
            ability:setMsg(xi.msg.basic.JA_DAMAGE)
        end

        dmg = utils.stoneskin(target, dmg)
        target:takeDamage(dmg, player, xi.attackType.PHYSICAL, player:getWeaponDamageType(xi.slot.MAIN))
        target:updateEnmityFromDamage(player, dmg)

        action:setAnimation(target:getID(), getFlourishAnimation(player:getWeaponSkillType(xi.slot.MAIN)))
        action:speceffect(target:getID(), hit)
        return dmg
    else
        ability:setMsg(xi.msg.basic.JA_MISS)
        return 0
    end
end

return ability_object
