-----------------------------------
-- Ability: Swordplay
-- Increases accuracy and evasion until you take severe damage.
-- Obtained: Rune Fencer level 20
-- Recast Time: 5:00
-- Duration: 2:00
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/job_utils/rune_fencer")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    xi.job_utils.rune_fencer.useSwordplay(player, target, ability)
end

return ability_object
