-----------------------------------
-- Ability: Wild Flourish
-- Readies target for a skillchain. Requires at least two Finishing Moves.
-- Obtained: Dancer Level 60
-- Finishing Moves Used: 2
-- Recast Time: 0:30
-- Duration: 0:05
-----------------------------------
require("scripts/globals/weaponskills")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player, target, ability)
    if (player:getAnimation() ~= 1) then
        return tpz.msg.basic.REQUIRES_COMBAT, 0
    else
        if (player:hasStatusEffect(tpz.effect.FINISHING_MOVE_1)) then
            return tpz.msg.basic.NO_FINISHINGMOVES, 0
        elseif (player:hasStatusEffect(tpz.effect.FINISHING_MOVE_2)) then
            player:delStatusEffect(tpz.effect.FINISHING_MOVE_2)
            return 0, 0
        elseif (player:hasStatusEffect(tpz.effect.FINISHING_MOVE_3)) then
            player:delStatusEffectSilent(tpz.effect.FINISHING_MOVE_3)
            player:addStatusEffect(tpz.effect.FINISHING_MOVE_1, 1, 0, 7200)
            return 0, 0
        elseif (player:hasStatusEffect(tpz.effect.FINISHING_MOVE_4)) then
            player:delStatusEffectSilent(tpz.effect.FINISHING_MOVE_4)
            player:addStatusEffect(tpz.effect.FINISHING_MOVE_2, 1, 0, 7200)
            return 0, 0
        elseif (player:hasStatusEffect(tpz.effect.FINISHING_MOVE_5)) then
            player:delStatusEffectSilent(tpz.effect.FINISHING_MOVE_5)
            player:addStatusEffect(tpz.effect.FINISHING_MOVE_3, 1, 0, 7200)
            return 0, 0
        else
            return tpz.msg.basic.NO_FINISHINGMOVES, 0
        end
    end
end

function onUseAbility(player, target, ability, action)
    if (not target:hasStatusEffect(tpz.effect.CHAINBOUND, 0) and not target:hasStatusEffect(tpz.effect.SKILLCHAIN, 0)) then
        target:addStatusEffectEx(tpz.effect.CHAINBOUND, 0, 1, 0, 5, 0, 1)
    else
        ability:setMsg(tpz.msg.basic.JA_NO_EFFECT)
    end
    action:animation(target:getID(), getFlourishAnimation(player:getWeaponSkillType(tpz.slot.MAIN)))
    action:speceffect(target:getID(), 1)
    return 0
end
