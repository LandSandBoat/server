-----------------------------------
-- Ability: Convergence
-- Increases the power of your next magical Blue Magic spell. Limits area of effect to single target.
-- Obtained: Blue Mage(Merit)
-- Recast Time: 10:00
-- Duration: 1 Spell or 60 seconds, whichever occurs first.
-- Maximum of +25 Magic Accuracy and +25% Magic damage.
-- +35% Magic damage with the Relic Armor augment
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end


ability_object.onUseAbility = function(player, target, ability)
local power =  player:getMerit(xi.merit.CONVERGENCE)
    player:addStatusEffect(xi.effect.CONVERGENCE, power, 0, 60)
end
