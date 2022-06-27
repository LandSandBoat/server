-----------------------------------
-- Ability: Reverse Flourish
-- Converts remaining finishing moves into TP. Requires at least one Finishing Move.
-- Obtained: Dancer Level 40
-- Finishing Moves Used: 1-5
-- Recast Time: 00:30
-----------------------------------
require("scripts/globals/settings")
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
    local tpGain = 0
    local stm = 0.5 + (0.1 * player:getMod(xi.mod.REVERSE_FLOURISH_EFFECT))

    local numMerits = player:getMerit(xi.merit.REVERSE_FLOURISH_EFFECT)

    if (player:hasStatusEffect(xi.effect.FINISHING_MOVE_1)) then
        tpGain = 9.5 * 1 + stm * 1 ^ 2 + numMerits

    elseif (player:hasStatusEffect(xi.effect.FINISHING_MOVE_2)) then
        tpGain = 9.5 * 2 + stm * 2 ^ 2 + numMerits

    elseif (player:hasStatusEffect(xi.effect.FINISHING_MOVE_3)) then
        tpGain = 9.5 * 3 + stm * 3 ^ 2 + numMerits

    elseif (player:hasStatusEffect(xi.effect.FINISHING_MOVE_4)) then
        tpGain = 9.5 * 4 + stm * 4 ^ 2 + numMerits

    elseif (player:hasStatusEffect(xi.effect.FINISHING_MOVE_5)) then
        tpGain = 9.5 * 5 + stm * 5 ^ 2 + numMerits
    end

    tpGain = tpGain * 10

    player:addTP(tpGain)
    player:delStatusEffect(xi.effect.FINISHING_MOVE_1)
    player:delStatusEffect(xi.effect.FINISHING_MOVE_2)
    player:delStatusEffect(xi.effect.FINISHING_MOVE_3)
    player:delStatusEffect(xi.effect.FINISHING_MOVE_4)
    player:delStatusEffect(xi.effect.FINISHING_MOVE_5)

    return tpGain
end

return ability_object
