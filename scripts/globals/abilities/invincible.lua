-----------------------------------
-- Ability: Invincible
-- Grants immunity to all physical attacks.
-- Obtained: Paladin Level 1
-- Recast Time: 1:00:00
-- Duration: 0:00:30
-----------------------------------
require("scripts/globals/job_utils/paladin")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.paladin.checkInvincible(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability)
    xi.job_utils.paladin.useInvincible(player, target, ability)
end

return abilityObject
