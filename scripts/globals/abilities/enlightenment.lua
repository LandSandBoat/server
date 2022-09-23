-----------------------------------
-- Ability: Enlightenment
-- Your next spell cast may be any from your list regardless of addenda.
-- Obtained: Scholar Level 75
-- Recast Time: 0:05:00
-- Duration: 0:01:00 or 1 Spell, whichever occurs first
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    if player:hasStatusEffect(xi.effect.ENLIGHTENMENT) then
        return xi.msg.basic.EFFECT_ALREADY_ACTIVE, 0
    end
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    local merit = (player:getMerit(xi.merit.ENLIGHTENMENT) - 5)
    player:addStatusEffect(xi.effect.ENLIGHTENMENT, merit, 0, 60)
    return xi.effect.ENLIGHTENMENT
end

return ability_object
