-----------------------------------
-- Ability: Battuta
-- Increases the likelihood of parrying and deals counter damage after parrying dependent upon harbored runes.
-- Obtained: Rune Fencer Level 75 (merit)
-- Recast Time: 5:00
-- Duration: 1:30
-----------------------------------
require("scripts/globals/job_utils/rune_fencer")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.rune_fencer.checkHaveRunes(player)
end

abilityObject.onUseAbility = function(player, target, ability, action)
    return xi.job_utils.rune_fencer.useBattuta(player, target, ability, action)
end

return abilityObject
