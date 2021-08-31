-----------------------------------
-- Ability: Futae
-- Grants a bonus to your next elemental ninjutsu by expending two ninja tools.
-- Obtained: Ninja Level 77
-- Recast Time: 3:00
-- Duration: 1:00
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    target:addStatusEffect(xi.effect.FUTAE, 0, 0, 60)
end

return ability_object
