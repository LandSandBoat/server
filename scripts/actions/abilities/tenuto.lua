-----------------------------------
-- Ability: Tenuto
-- If the next song you cast affects yourself, it will not subsequently be overwritten by other songs.
-- Obtained: Bard Level 83
-- Recast Time: 0:15
-- Duration: 1:00, or until next song is cast.
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    xi.job_utils.bard.useTenuto(player, target, ability)
end

return abilityObject
