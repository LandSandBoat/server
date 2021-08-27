-----------------------------------
-- Ability: No Foot Rise
-- Instantly grants additional Finishing Moves.
-- Obtained: Dancer Level 75 Merit Group 2
-- Recast Time: 3 minutes
-- Duration: Instant
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/status")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    if (player:hasStatusEffect(xi.effect.FINISHING_MOVE_5)) then
        return 561, 0
    else
        return 0, 0
    end
end

ability_object.onUseAbility = function(player, target, ability)

    local moves = player:getMerit(xi.merit.NO_FOOT_RISE)
    if (player:hasStatusEffect(xi.effect.FINISHING_MOVE_1)) then
        if (moves > 4) then
            moves = 4
        end
        player:delStatusEffectSilent(xi.effect.FINISHING_MOVE_1)
        player:addStatusEffect(xi.effect.FINISHING_MOVE_1 + moves, 1, 0, 7200)
        return moves+1
    elseif (player:hasStatusEffect(xi.effect.FINISHING_MOVE_2)) then
        if (moves > 3) then
            moves = 3
        end
        player:delStatusEffectSilent(xi.effect.FINISHING_MOVE_2)
        player:addStatusEffect(xi.effect.FINISHING_MOVE_2 + moves, 1, 0, 7200)
        return moves + 2
    elseif (player:hasStatusEffect(xi.effect.FINISHING_MOVE_3)) then
        if (moves > 2) then
            moves = 2
        end
        player:delStatusEffectSilent(xi.effect.FINISHING_MOVE_3)
        player:addStatusEffect(xi.effect.FINISHING_MOVE_3 + moves, 1, 0, 7200)
        return moves + 3
    elseif (player:hasStatusEffect(xi.effect.FINISHING_MOVE_4)) then
        if (moves > 1) then
            moves = 1
        end
        player:delStatusEffectSilent(xi.effect.FINISHING_MOVE_4)
        player:addStatusEffect(xi.effect.FINISHING_MOVE_4 + moves, 1, 0, 7200)
        return moves + 4
    else
        player:addStatusEffect(xi.effect.FINISHING_MOVE_1 + moves - 1, 1, 0, 7200)
        return moves
    end
end

return ability_object
