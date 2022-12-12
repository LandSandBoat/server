-----------------------------------
-- Ability: Ternary Flourish
-- Description: Allows you to deliver a threefold attack. Requires at least three finishing moves.
-- Obtained: DNC Level 93
-- Recast Time: 00:00:45 (Flourishes III)
-- Duration: 00:01:00
-- Cost: 3 Finishing Move charges
-----------------------------------
require("scripts/globals/msg")
require("scripts/globals/status")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    if
        player:hasStatusEffect(xi.effect.FINISHING_MOVE_3) or
        player:hasStatusEffect(xi.effect.FINISHING_MOVE_4) or
        player:hasStatusEffect(xi.effect.FINISHING_MOVE_5)
    then
        return 0, 0
    end

    return xi.msg.basic.NO_FINISHINGMOVES, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    if player:hasStatusEffect(xi.effect.FINISHING_MOVE_3) then
        player:delStatusEffect(xi.effect.FINISHING_MOVE_3)
        player:addStatusEffect(xi.effect.TERNARY_FLOURISH, 3, 0, 60, 0, player:getMerit(xi.merit.TERNARY_FLOURISH_EFFECT))
    elseif player:hasStatusEffect(xi.effect.FINISHING_MOVE_4) then
        player:delStatusEffect(xi.effect.FINISHING_MOVE_4)
        player:addStatusEffect(xi.effect.FINISHING_MOVE_1, 1, 0, 7200)
        player:addStatusEffect(xi.effect.TERNARY_FLOURISH, 3, 0, 60, 0, player:getMerit(xi.merit.TERNARY_FLOURISH_EFFECT))
    elseif player:hasStatusEffect(xi.effect.FINISHING_MOVE_5) then
        player:delStatusEffect(xi.effect.FINISHING_MOVE_5)
        player:addStatusEffect(xi.effect.FINISHING_MOVE_2, 1, 0, 7200)
        player:addStatusEffect(xi.effect.TERNARY_FLOURISH, 3, 0, 60, 0, player:getMerit(xi.merit.TERNARY_FLOURISH_EFFECT))
    end
end

return abilityObject
