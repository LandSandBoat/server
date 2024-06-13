-----------------------------------
-- Ability: Diffusion
-- Grants the effect of your next support Blue Magic spell to party members within range.
-- Obtained: Blue Mage Level 75
-- Recast Time: 10:00
-- Duration: 1:00, or until the next blue magic spell is cast.
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    xi.job_utils.blue_mage.checkDiffusion(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability, action)
    xi.job_utils.blue_mage.useDiffusion(player, target, ability, action)
end

return abilityObject
