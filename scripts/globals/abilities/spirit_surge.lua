-----------------------------------
-- Ability: Spirit Surge
-- Adds your wyvern's strength to your own.
-- Obtained: Dragoon Level 1
-- Recast Time: 1:00:00
-- Duration: 1:00
-----------------------------------
require("scripts/globals/job_utils/dragoon")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    -- The wyvern must be present in order to use Spirit Surge
    return tpz.job_utils.dragoon.abilityCheckRequiresPet(player, target, ability)
end

ability_object.onUseAbility = function(player, target, ability)
    tpz.job_utils.dragoon.useSpiritSurge(player, target, ability)
end

return ability_object
