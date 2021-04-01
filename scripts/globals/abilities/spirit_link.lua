-----------------------------------
-- Ability: Spirit Link
-- Sacrifices own HP to heal Wyvern's HP.
-- Obtained: Dragoon Level 25
-- Recast Time: 1:30
-- Duration: Instant
-----------------------------------
require("scripts/globals/job_utils/dragoon")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.dragoon.abilityCheckSpiritLink(player, target, ability)
end

ability_object.onUseAbility = function(player, target, ability)
    xi.job_utils.dragoon.useSpiritLink(player, target, ability)
end

return ability_object
