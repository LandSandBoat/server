-----------------------------------
-- Ability: Retrieve
-- Orders your automaton to return to your side.
-- Obtained: Puppetmaster Level 10
-- Recast Time: 10 seconds
-- Duration: Instant
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/status")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    player:petRetreat()
end

return ability_object
