-----------------------------------
-- Ability: Deploy
-- Orders your automaton to attack.
-- Obtained: Puppetmaster Level 1
-- Recast Time: 10 seconds
-- Duration: Instant
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    player:petAttack(target)
end

return abilityObject
