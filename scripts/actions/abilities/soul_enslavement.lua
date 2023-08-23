-----------------------------------
-- Ability: Soul Enslavement
-- Description: Melee attacks absorb target's TP.
-- Obtained: Dark Knight Level 96
-- Recast Time: 01:00:00
-- Duration: 00:00:30
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.dark_knight.checkSoulEnslavement(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability)
    xi.job_utils.dark_knight.useSoulEnslavement(player, target, ability)
end

return abilityObject
