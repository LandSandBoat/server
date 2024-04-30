-----------------------------------
-- Ability: Unleash
-- Description: Increases the accuracy of Charm and reduces the recast times of Sic and Ready.
-- Obtained: BST Level 96
-- Recast Time: 01:00:00
-- Duration: 0:01:00
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.beastmaster.onAbilityCheckUnleash(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability)
    return xi.job_utils.beastmaster.onUseAbilityUnleash(player, target, ability)
end

return abilityObject
