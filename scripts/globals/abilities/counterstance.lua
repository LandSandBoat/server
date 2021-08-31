-----------------------------------
-- Ability: Counterstance
-- Increases chance to counter but lowers defense.
-- Obtained: Monk Level 45
-- Recast Time: 5:00
-- Duration: 5:00
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/status")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    local power = 45 + player:getMod(xi.mod.COUNTERSTANCE_EFFECT)

    target:delStatusEffect(xi.effect.COUNTERSTANCE) --if not found this will do nothing
    target:addStatusEffect(xi.effect.COUNTERSTANCE, power, 0, 300)
end

return ability_object
