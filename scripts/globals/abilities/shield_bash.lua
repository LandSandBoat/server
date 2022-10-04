-----------------------------------
-- Ability: Shield Bash
-- Delivers an attack that can stun the target. Shield required.
-- Obtained: Paladin Level 15, Valoredge automaton frame Level 1
-- Recast Time: 1:00 minute (3:00 for Valoredge version)
-- Duration: Instant
-----------------------------------
require("scripts/globals/job_utils/paladin")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.paladin.checkShieldBash(player, target, ability)
end

ability_object.onUseAbility = function(player, target, ability)
    return xi.job_utils.paladin.useShieldBash(player, target, ability)
end

return ability_object
