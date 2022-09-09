-----------------------------------
-- Ability: Collaborator
-- Steals 25% of the target party member's enmity and redirects it to the thief.
-- Obtained: Thief Level 65
-- Recast Time: 1:00
-- Duration: Instant
-----------------------------------
require("scripts/globals/job_utils/thief")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.thief.checkCollaborator(player, target, ability)
end

ability_object.onUseAbility = function(player, target, ability)
    xi.job_utils.thief.useCollaborator(player, target, ability)
end

return ability_object
