-----------------------------------
-- Ability: Issekigan
-- Increases Chance of parrying and gives an enmity bonus upon a successful parry attempt.
-- Obtained: Ninja Level 95
-- Recast Time: 5:00
-- Duration: 1:00
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    target:addStatusEffect(xi.effect.ISSEKIGAN, 25, 0, 60)
end

return ability_object
