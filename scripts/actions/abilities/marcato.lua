-----------------------------------
-- Ability: Marcato
-- Enhances the effect of your next song.
-- Obtained: Bard Level 95
-- Recast Time: 10:00
-- Duration: 1:00, or until next song is cast.
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    xi.job_utils.bard.useMarcato(player, target, ability)
end

return abilityObject
