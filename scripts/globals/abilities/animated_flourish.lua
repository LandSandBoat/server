-----------------------------------
-- Ability: Animated Flourish
-- Provokes the target. Requires at least one, but uses two Finishing Moves.
-- Obtained: Dancer Level 20
-- Finishing Moves Used: 1-2
-- Recast Time: 00:30
-----------------------------------
require("scripts/globals/jobpoints")
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    if
        player:hasStatusEffect(xi.effect.FINISHING_MOVE_1) or
        player:hasStatusEffect(xi.effect.FINISHING_MOVE_2) or
        player:hasStatusEffect(xi.effect.FINISHING_MOVE_3) or
        player:hasStatusEffect(xi.effect.FINISHING_MOVE_4) or
        player:hasStatusEffect(xi.effect.FINISHING_MOVE_5)
    then
        return 0, 0
    else
        return xi.msg.basic.NO_FINISHINGMOVES, 0
    end
end

ability_object.onUseAbility = function(player, target, ability)
    local jpBonusVE = player:getJobPointLevel(xi.jp.FLOURISH_I_EFFECT) * 10

    if (player:hasStatusEffect(xi.effect.FINISHING_MOVE_1)) then
        player:delStatusEffect(xi.effect.FINISHING_MOVE_1)
        target:addEnmity(player, 0, 1000 + jpBonusVE)

    --Add extra enmity if 2 finishing moves are used
    elseif (player:hasStatusEffect(xi.effect.FINISHING_MOVE_2)) then
        player:delStatusEffect(xi.effect.FINISHING_MOVE_2)
        target:addEnmity(player, 0, 1500 + jpBonusVE)
    elseif (player:hasStatusEffect(xi.effect.FINISHING_MOVE_3)) then
        player:delStatusEffectSilent(xi.effect.FINISHING_MOVE_3)
        player:addStatusEffect(xi.effect.FINISHING_MOVE_1, 1, 0, 7200)
        target:addEnmity(player, 0, 1500 + jpBonusVE)

    elseif (player:hasStatusEffect(xi.effect.FINISHING_MOVE_4)) then
        player:delStatusEffectSilent(xi.effect.FINISHING_MOVE_4)
        player:addStatusEffect(xi.effect.FINISHING_MOVE_2, 1, 0, 7200)
        target:addEnmity(player, 0, 1500 + jpBonusVE)

    elseif (player:hasStatusEffect(xi.effect.FINISHING_MOVE_5)) then
        player:delStatusEffectSilent(xi.effect.FINISHING_MOVE_5)
        player:addStatusEffect(xi.effect.FINISHING_MOVE_3, 1, 0, 7200)
        target:addEnmity(player, 0, 1500 + jpBonusVE)
    end
end

return ability_object
