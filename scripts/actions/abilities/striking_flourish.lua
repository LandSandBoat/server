-----------------------------------
-- Ability: Striking Flourish
-- Description: Allows you to deliver a twofold attack. Requires at least two finishing moves.
-- Obtained: DNC Level 89
-- Recast Time: 00:00:30 (Flourishes III)
-- Duration: 00:01:00
-- Cost: 2 Finishing Move charges
-----------------------------------
---@type TAbility
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    if
        player:hasStatusEffect(xi.effect.FINISHING_MOVE_2) or
        player:hasStatusEffect(xi.effect.FINISHING_MOVE_3) or
        player:hasStatusEffect(xi.effect.FINISHING_MOVE_4) or
        player:hasStatusEffect(xi.effect.FINISHING_MOVE_5)
    then
        return 0, 0
    end

    return xi.msg.basic.NO_FINISHINGMOVES, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    if player:hasStatusEffect(xi.effect.FINISHING_MOVE_2) then
        player:delStatusEffect(xi.effect.FINISHING_MOVE_2)
        player:addStatusEffect(xi.effect.STRIKING_FLOURISH, { power = 2, duration = 60, origin = player })
    elseif player:hasStatusEffect(xi.effect.FINISHING_MOVE_3) then
        player:delStatusEffect(xi.effect.FINISHING_MOVE_3)
        player:addStatusEffect(xi.effect.FINISHING_MOVE_1, { power = 1, duration = 7200, origin = player })
        player:addStatusEffect(xi.effect.STRIKING_FLOURISH, { power = 3, duration = 60, origin = player })
    elseif player:hasStatusEffect(xi.effect.FINISHING_MOVE_4) then
        player:delStatusEffect(xi.effect.FINISHING_MOVE_4)
        player:addStatusEffect(xi.effect.FINISHING_MOVE_2, { power = 1, duration = 7200, origin = player })
        player:addStatusEffect(xi.effect.STRIKING_FLOURISH, { power = 3, duration = 60, origin = player })
    elseif player:hasStatusEffect(xi.effect.FINISHING_MOVE_5) then
        player:delStatusEffect(xi.effect.FINISHING_MOVE_5)
        player:addStatusEffect(xi.effect.FINISHING_MOVE_3, { power = 1, duration = 7200, origin = player })
        player:addStatusEffect(xi.effect.STRIKING_FLOURISH, { power = 3, duration = 60, origin = player })
    end
end

return abilityObject
