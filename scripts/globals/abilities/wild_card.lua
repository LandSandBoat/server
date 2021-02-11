-----------------------------------
-- Ability: Wild Card
-- Has a random effect on all party members within area of effect.
-- Obtained: Corsair Level 1
-- Recast Time: 1:00:00
-- Duration: Instant
-----------------------------------
require("scripts/globals/job_utils/corsair")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(caster, target, ability, action)
    return tpz.job_utils.corsair.useWildCard(caster, target, ability, action)
end

return ability_object
