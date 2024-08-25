-----------------------------------
-- Ability: Soul Voice
-- Enhances the effects of your songs.
-- Obtained: Bard Level 1
-- Recast Time: 1:00:00
-- Duration: 0:03:00
-----------------------------------
---@type TAbility
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.bard.checkSoulVoice(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability)
    xi.job_utils.bard.useSoulVoice(player, target, ability)
end

return abilityObject
