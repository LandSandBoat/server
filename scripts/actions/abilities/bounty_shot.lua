-----------------------------------
-- Ability: Bounty Shot
-- Description: Increases the rate at which the target yields treasure.
-- Obtained: RNG Level 87
-- Recast Time: 00:01:00
-----------------------------------
---@type TAbility
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.ranger.checkBountyShot(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability, action)
    -- target:addStatusEffect(xi.effect.BOUNTY_SHOT, 11, 1, 30) -- TODO: implement xi.effect.BOUNTY_SHOT
end

return abilityObject
