-----------------------------------
-- Ability: Striking Flourish
-- Description: Allows you to deliver a twofold attack. Requires at least two finishing moves.
-- Obtained: DNC Level 89
-- Recast Time: 00:00:30 (Flourishes III)
-- Duration: 00:01:00
-- Cost: 2 Finishing Move charges
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    if (player:hasStatusEffect(xi.effect.FINISHING_MOVE_1)) then
        return xi.msg.basic.NO_FINISHINGMOVES, 0
    elseif (player:hasStatusEffect(xi.effect.FINISHING_MOVE_2)) then
        return 0, 0
    elseif (player:hasStatusEffect(xi.effect.FINISHING_MOVE_3)) then
        return 0, 0
    elseif (player:hasStatusEffect(xi.effect.FINISHING_MOVE_4)) then
        return 0, 0
    elseif (player:hasStatusEffect(xi.effect.FINISHING_MOVE_5)) then
        return 0, 0
    else
        return xi.msg.basic.NO_FINISHINGMOVES, 0
    end
end

ability_object.onUseAbility = function(player, target, ability)
    if (player:hasStatusEffect(xi.effect.FINISHING_MOVE_2)) then
        player:delStatusEffect(xi.effect.FINISHING_MOVE_2)
        player:addStatusEffect(xi.effect.STRIKING_FLOURISH, 2, 0, 60, 0, player:getMerit(xi.merit.STRIKING_FLOURISH_EFFECT))
    elseif (player:hasStatusEffect(xi.effect.FINISHING_MOVE_3)) then
        player:delStatusEffect(xi.effect.FINISHING_MOVE_3)
        player:addStatusEffect(xi.effect.FINISHING_MOVE_1, 1, 0, 7200)
        player:addStatusEffect(xi.effect.STRIKING_FLOURISH, 3, 0, 60, 0, player:getMerit(xi.merit.STRIKING_FLOURISH_EFFECT))
    elseif (player:hasStatusEffect(xi.effect.FINISHING_MOVE_4)) then
        player:delStatusEffect(xi.effect.FINISHING_MOVE_4)
        player:addStatusEffect(xi.effect.FINISHING_MOVE_2, 1, 0, 7200)
        player:addStatusEffect(xi.effect.STRIKING_FLOURISH, 3, 0, 60, 0, player:getMerit(xi.merit.STRIKING_FLOURISH_EFFECT))
    elseif (player:hasStatusEffect(xi.effect.FINISHING_MOVE_5)) then
        player:delStatusEffect(xi.effect.FINISHING_MOVE_5)
        player:addStatusEffect(xi.effect.FINISHING_MOVE_3, 1, 0, 7200)
        player:addStatusEffect(xi.effect.STRIKING_FLOURISH, 3, 0, 60, 0, player:getMerit(xi.merit.STRIKING_FLOURISH_EFFECT))
    end
end

return ability_object
