-----------------------------------
-- Ability: Climactic Flourish
-- Description: Allows you to deal critical hits. Requires at least one finishing move.
-- Obtained: DNC Level 80
-- Recast Time: 00:01:30 (Flourishes III)
-- Duration: 00:01:00
-- Cost: 1-5 Finishing Move charges
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    if player:hasStatusEffect(xi.effect.FINISHING_MOVE_1) then
        return 0, 0
    elseif player:hasStatusEffect(xi.effect.FINISHING_MOVE_2) then
        return 0, 0
    elseif player:hasStatusEffect(xi.effect.FINISHING_MOVE_3) then
        return 0, 0
    elseif player:hasStatusEffect(xi.effect.FINISHING_MOVE_4) then
        return 0, 0
    elseif player:hasStatusEffect(xi.effect.FINISHING_MOVE_5) then
        return 0, 0
    else
        return xi.msg.basic.NO_FINISHINGMOVES, 0
    end
end

ability_object.onUseAbility = function(player, target, ability)
    for move = xi.effect.FINISHING_MOVE_1, xi.effect.FINISHING_MOVE_5 do
        player:delStatusEffect(move)
        player:addStatusEffect(xi.effect.CLIMACTIC_FLOURISH, 3, 0, 60, 0, player:getMerit(xi.merit.CLIMACTIC_FLOURISH_EFFECT))
    end
end

return ability_object
