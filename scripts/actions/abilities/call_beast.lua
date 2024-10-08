-----------------------------------
-- Ability: Call Beast
-- Calls a beast to fight by your side.
-- Obtained: Beastmaster Level 23
-- Recast Time: 5:00
-- Duration: Dependent on jug pet used.
-----------------------------------
---@type TAbility
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.beastmaster.onAbilityCheckJug(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability)
    return xi.job_utils.beastmaster.onUseAbilityJug(player, target, ability)
end

return abilityObject
