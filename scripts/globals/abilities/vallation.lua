-----------------------------------
-- Ability: Vallation
-- Reduces elemental damage. The types of elemental damage reduced depend on the runes you harbor.
-- Obtained: Rune Fencer Level 10
-- Recast Time: 3:00
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
    return xi.job_utils.rune_fencer.applyVallation(player)
end

return ability_object
