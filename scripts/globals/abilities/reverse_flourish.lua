-----------------------------------
-- Ability: Reverse Flourish
-- Converts remaining finishing moves into TP. Requires at least one Finishing Move.
-- Obtained: Dancer Level 40
-- Finishing Moves Used: 1-5
-- Recast Time: 00:30
-----------------------------------
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

    local TPGain = 0
    local STM = 0.5 + (0.1 * player:getMod(xi.mod.REVERSE_FLOURISH_EFFECT))

    local Merits = player:getMerit(xi.merit.REVERSE_FLOURISH_EFFECT)

    if (player:hasStatusEffect(xi.effect.FINISHING_MOVE_1)) then
        TPGain = 9.5 * 1 + STM * 1 ^ 2 + Merits

    elseif (player:hasStatusEffect(xi.effect.FINISHING_MOVE_2)) then
        TPGain = 9.5 * 2 + STM * 2 ^ 2 + Merits

    elseif (player:hasStatusEffect(xi.effect.FINISHING_MOVE_3)) then
        TPGain = 9.5 * 3 + STM * 3 ^ 2 + Merits

    elseif (player:hasStatusEffect(xi.effect.FINISHING_MOVE_4)) then
        TPGain = 9.5 * 4 + STM * 4 ^ 2 + Merits

    elseif (player:hasStatusEffect(xi.effect.FINISHING_MOVE_5)) then
        TPGain = 9.5 * 5 + STM * 5 ^ 2 + Merits
    end

    TPGain = TPGain * 10

    player:addTP(TPGain)
    player:delStatusEffect(xi.effect.FINISHING_MOVE_1)
    player:delStatusEffect(xi.effect.FINISHING_MOVE_2)
    player:delStatusEffect(xi.effect.FINISHING_MOVE_3)
    player:delStatusEffect(xi.effect.FINISHING_MOVE_4)
    player:delStatusEffect(xi.effect.FINISHING_MOVE_5)

    return TPGain
end

return ability_object
