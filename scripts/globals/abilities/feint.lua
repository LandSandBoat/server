-----------------------------------
-- Ability: Feint
-- Reduces targets evasion by -150 (Assassin's Culottes +2 Aug: -10 more eva per merit)
-- Obtained: Thief Level 75
-- Recast Time: 2:00 minutes
-- Duration: 1:00 minutes
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/status")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    local augment = player:getMod(xi.mod.AUGMENTS_FEINT) * player:getMerit(xi.merit.FEINT) / 25 -- Divide by the merit value (feint is 25) to get the number of merit points
    player:addStatusEffect(xi.effect.FEINT, 150 + augment, 0, 60) -- -150 Evasion base
end

return ability_object
