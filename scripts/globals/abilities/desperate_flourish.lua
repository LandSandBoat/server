-----------------------------------
-- Ability: Desperate Flourish
-- Weighs down a target with a low rate of success. Requires one Finishing Move.
-- Obtained: Dancer Level 30
-- Finishing Moves Used: 1
-- Recast Time: 00:20
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

    local isSneakValid = player:hasStatusEffect(xi.effect.SNEAK_ATTACK)
    if (isSneakValid and not player:isBehind(target)) then
        isSneakValid = false
    end

    local hitrate = getHitRate(player, target, true, player:getJobPointLevel(xi.jp.FLOURISH_I_EFFECT))

    if (math.random() <= hitrate or isSneakValid) then

        local spell = GetSpell(216)
        local params = {}
        params.diff = 0
        params.skillType = player:getWeaponSkillType(xi.slot.MAIN)
        params.bonus = 50 - target:getMod(xi.mod.STUNRES)
        local resist = applyResistance(player, target, spell, params)

        if resist > 0.25 then
            target:delStatusEffectSilent(xi.effect.WEIGHT)
            target:addStatusEffect(xi.effect.WEIGHT, 50, 0, 60 * resist)
        else
            ability:setMsg(xi.msg.basic.JA_DAMAGE)
        end
        ability:setMsg(xi.msg.basic.JA_ENFEEB_IS)
        action:setAnimation(target:getID(), getFlourishAnimation(player:getWeaponSkillType(xi.slot.MAIN)))
        action:speceffect(target:getID(), 2)
        return xi.effect.WEIGHT
    else
        ability:setMsg(xi.msg.basic.JA_MISS)
        return 0
    end
end

return ability_object
