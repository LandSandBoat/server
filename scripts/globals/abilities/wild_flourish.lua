-----------------------------------
-- Ability: Wild Flourish
-- Readies target for a skillchain. Requires at least two Finishing Moves.
-- Obtained: Dancer Level 60
-- Finishing Moves Used: 2
-- Recast Time: 0:30
-- Duration: 0:05
-----------------------------------
require("scripts/globals/weaponskills")
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    if (player:getAnimation() ~= 1) then
        return xi.msg.basic.REQUIRES_COMBAT, 0
    else
        if (player:hasStatusEffect(xi.effect.FINISHING_MOVE_1)) then
            return xi.msg.basic.NO_FINISHINGMOVES, 0
        elseif (player:hasStatusEffect(xi.effect.FINISHING_MOVE_2)) then
            player:delStatusEffect(xi.effect.FINISHING_MOVE_2)
            return 0, 0
        elseif (player:hasStatusEffect(xi.effect.FINISHING_MOVE_3)) then
            player:delStatusEffectSilent(xi.effect.FINISHING_MOVE_3)
            player:addStatusEffect(xi.effect.FINISHING_MOVE_1, 1, 0, 7200)
            return 0, 0
        elseif (player:hasStatusEffect(xi.effect.FINISHING_MOVE_4)) then
            player:delStatusEffectSilent(xi.effect.FINISHING_MOVE_4)
            player:addStatusEffect(xi.effect.FINISHING_MOVE_2, 1, 0, 7200)
            return 0, 0
        elseif (player:hasStatusEffect(xi.effect.FINISHING_MOVE_5)) then
            player:delStatusEffectSilent(xi.effect.FINISHING_MOVE_5)
            player:addStatusEffect(xi.effect.FINISHING_MOVE_3, 1, 0, 7200)
            return 0, 0
        else
            return xi.msg.basic.NO_FINISHINGMOVES, 0
        end
    end
end

ability_object.onUseAbility = function(player, target, ability, action)
    if (not target:hasStatusEffect(xi.effect.CHAINBOUND, 0) and not target:hasStatusEffect(xi.effect.SKILLCHAIN, 0)) then
        target:addStatusEffectEx(xi.effect.CHAINBOUND, 0, 1, 0, 5, 0, 1)
    else
        ability:setMsg(xi.msg.basic.JA_NO_EFFECT)
    end
    action:setAnimation(target:getID(), getFlourishAnimation(player:getWeaponSkillType(xi.slot.MAIN)))
    action:speceffect(target:getID(), 1)
    return 0
end

return ability_object
