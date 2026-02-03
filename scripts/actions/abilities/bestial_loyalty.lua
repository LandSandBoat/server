-----------------------------------
-- Ability: Bestial Loyalty
-- Calls a beast to fight by your side without consuming bait
-- Obtained: Beastmaster Level 23
-- Recast Time: 20:00
-- Duration: Dependent on jug pet used.
-----------------------------------
---@type TAbility
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.beastmaster.checkBestialLoyalty(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability)
    return xi.job_utils.beastmaster.useBestialLoyalty(player, target, ability)
end

return abilityObject
