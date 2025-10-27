-----------------------------------
-- Ability: Spirit Bond
-- Description: Enables the dragoon to take some damage on behalf of their wyvern. Using Healing Breath also restores the wyvern's HP.
-- Obtained: DRG Level 65
-- Recast Time: 00:03:00
-- Duration: 00:01:00
-----------------------------------
---@type TAbility
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.dragoon.abilityCheckRequiresPet(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability)
    return xi.job_utils.dragoon.useSpiritBond(player, target, ability)
end

return abilityObject
