-----------------------------------
-- Ability: Assault
-- Orders the avatar to attack.
-- Obtained: Summoner Level 1
-- Recast Time: 10 sec
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    player:petAttack(target)
end

return abilityObject
