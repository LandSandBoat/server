-----------------------------------
-- Ability: Retrieve
-- Orders your automaton to return to your side.
-- Obtained: Puppetmaster Level 10
-- Recast Time: 10 seconds
-- Duration: Instant
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    player:petRetreat()
end

return abilityObject
