-----------------------------------
-- Ability: Building Flourish
-- Enhances potency of your next weapon skill. Requires at least one Finishing Move.
-- Obtained: Dancer Level 50
-- Finishing Moves Used: 1-3
-- Recast Time: 00:10
-- Duration: 01:00
--
-- Using one Finishing Move boosts the Accuracy of your next weapon skill.
-- Using two Finishing Moves boosts both the Accuracy and Attack of your next weapon skill.
-- Using three Finishing Moves boosts the Accuracy, Attack and Critical Hit Rate of your next weapon skill.
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

    if (player:hasStatusEffect(xi.effect.FINISHING_MOVE_1)) then
        player:delStatusEffect(xi.effect.FINISHING_MOVE_1)
        player:addStatusEffect(xi.effect.BUILDING_FLOURISH, 1, 0, 60, 0, player:getMerit(xi.merit.BUILDING_FLOURISH_EFFECT))
    elseif (player:hasStatusEffect(xi.effect.FINISHING_MOVE_2)) then
        player:delStatusEffect(xi.effect.FINISHING_MOVE_2)
        player:addStatusEffect(xi.effect.BUILDING_FLOURISH, 2, 0, 60, 0, player:getMerit(xi.merit.BUILDING_FLOURISH_EFFECT))
    elseif (player:hasStatusEffect(xi.effect.FINISHING_MOVE_3)) then
        player:delStatusEffect(xi.effect.FINISHING_MOVE_3)
        player:addStatusEffect(xi.effect.BUILDING_FLOURISH, 3, 0, 60, 0, player:getMerit(xi.merit.BUILDING_FLOURISH_EFFECT))
    elseif (player:hasStatusEffect(xi.effect.FINISHING_MOVE_4)) then
        player:delStatusEffect(xi.effect.FINISHING_MOVE_4)
        player:addStatusEffect(xi.effect.FINISHING_MOVE_1, 1, 0, 7200)
        player:addStatusEffect(xi.effect.BUILDING_FLOURISH, 3, 0, 60, 0, player:getMerit(xi.merit.BUILDING_FLOURISH_EFFECT))
    elseif (player:hasStatusEffect(xi.effect.FINISHING_MOVE_5)) then
        player:delStatusEffect(xi.effect.FINISHING_MOVE_5)
        player:addStatusEffect(xi.effect.FINISHING_MOVE_2, 1, 0, 7200)
        player:addStatusEffect(xi.effect.BUILDING_FLOURISH, 3, 0, 60, 0, player:getMerit(xi.merit.BUILDING_FLOURISH_EFFECT))
    end

end

return ability_object
