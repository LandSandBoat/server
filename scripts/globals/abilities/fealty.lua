-----------------------------------
-- Ability: Fealty
-- Grants a powerful resistance to enfeebling magic.
-- Obtained: Paladin Level 75
-- Recast Time: 0:10:00
-- Duration: 0:01:00
-----------------------------------
require("scripts/globals/job_utils/paladin")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    xi.job_utils.paladin.useFealty(player, target, ability)
end

return ability_object
