-----------------------------------
-- Ability: Ternary Flourish
-- Description: Allows you to deliver a threefold attack. Requires at least three finishing moves.
-- Obtained: DNC Level 93
-- Recast Time: 00:00:45 (Flourishes III)
-- Duration: 00:01:00
-- Cost: 3 Finishing Move charges
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    if player:hasStatusEffect(tpz.effect.FINISHING_MOVE_1) then
        return tpz.msg.basic.NO_FINISHINGMOVES, 0
    elseif player:hasStatusEffect(tpz.effect.FINISHING_MOVE_2) then
        return tpz.msg.basic.NO_FINISHINGMOVES, 0
    elseif player:hasStatusEffect(tpz.effect.FINISHING_MOVE_3) then
        return 0, 0
    elseif player:hasStatusEffect(tpz.effect.FINISHING_MOVE_4) then
        return 0, 0
    elseif player:hasStatusEffect(tpz.effect.FINISHING_MOVE_5) then
        return 0, 0
    else
        return tpz.msg.basic.NO_FINISHINGMOVES, 0
    end
end

ability_object.onUseAbility = function(player, target, ability)

    if player:hasStatusEffect(tpz.effect.FINISHING_MOVE_3) then
        player:delStatusEffect(tpz.effect.FINISHING_MOVE_3)
        player:addStatusEffect(tpz.effect.TERNARY_FLOURISH, 3, 0, 60, 0, player:getMerit(tpz.merit.TERNARY_FLOURISH_EFFECT))
    elseif player:hasStatusEffect(tpz.effect.FINISHING_MOVE_4) then
        player:delStatusEffect(tpz.effect.FINISHING_MOVE_4)
        player:addStatusEffect(tpz.effect.FINISHING_MOVE_1, 1, 0, 7200)
        player:addStatusEffect(tpz.effect.TERNARY_FLOURISH, 3, 0, 60, 0, player:getMerit(tpz.merit.TERNARY_FLOURISH_EFFECT))
    elseif player:hasStatusEffect(tpz.effect.FINISHING_MOVE_5) then
        player:delStatusEffect(tpz.effect.FINISHING_MOVE_5)
        player:addStatusEffect(tpz.effect.FINISHING_MOVE_2, 1, 0, 7200)
        player:addStatusEffect(tpz.effect.TERNARY_FLOURISH, 3, 0, 60, 0, player:getMerit(tpz.merit.TERNARY_FLOURISH_EFFECT))
    end
end

return ability_object
