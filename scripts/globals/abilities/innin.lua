-----------------------------------
-- Ability: Innin
-- Reduces enmity and impairs evasion. Grants a bonus to accuracy, critical hit rate, and ninjutsu damage when striking target from behind.
-- Obtained: Ninja Level 40
-- Recast Time: 3:00
-- Duration: 5:00
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    target:delStatusEffect(xi.effect.INNIN)
    target:delStatusEffect(xi.effect.YONIN)
    target:addStatusEffect(xi.effect.INNIN, 30, 15, 300, 0, 20)
end

return abilityObject
