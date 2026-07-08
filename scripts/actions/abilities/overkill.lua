-----------------------------------
-- Ability: Overkill
-- Description: Increases ranged attack speed and the chance of activating Double/Triple Shot.
-- Obtained: RNG Level 96
-- Recast Time: 01:00:00
-- Duration: 00:01:00
-----------------------------------
---@type TAbility
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.ranger.checkOverkill(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability, action)
    return xi.job_utils.ranger.useOverkill(player, target, ability, action)
end

return abilityObject
