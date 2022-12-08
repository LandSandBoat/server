-----------------------------------
-- Ability: Swordplay
-- Increases accuracy and evasion until you take severe damage.
-- Obtained: Rune Fencer level 20
-- Recast Time: 5:00
-- Duration: 2:00
-----------------------------------
require("scripts/globals/job_utils/rune_fencer")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    xi.job_utils.rune_fencer.useSwordplay(player, target, ability)
end

return abilityObject
