-----------------------------------
-- Ability: Fight
-- Commands your pet to attack the target.
-- Obtained: Beastmaster Level 1
-- Recast Time: 10 seconds
-- Duration: N/A
-----------------------------------
---@type TAbility
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.beastmaster.checkFight(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability)
    return xi.job_utils.beastmaster.useFight(player, target, ability)
end

return abilityObject
