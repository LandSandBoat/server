-----------------------------------
-- Ability: Call Wyvern
-- Summons a Wyvern to fight by your side.
-- Obtained: Dragoon Level 1
-- Recast Time: 20:00
-- Duration: Instant
-- Special: Only available if Dragoon is your main class.
-----------------------------------
require("scripts/globals/job_utils/dragoon")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return tpz.job_utils.dragoon.abilityCheckCallWyvern(player, target, ability)
end

ability_object.onUseAbility = function(player, target, ability)
    tpz.job_utils.dragoon.useCallWyvern(player, target, ability)
end

return ability_object
