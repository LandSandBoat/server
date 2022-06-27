-----------------------------------
-- Ability: Chi Blast
-- Releases Chi to attack an enemy.
-- Obtained: Monk Level 41
-- Recast Time: 3:00
-- Duration: Instant
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    local boost = player:getStatusEffect(xi.effect.BOOST)
    local multiplier = 1.0
    if boost ~= nil then
        multiplier = (boost:getPower()/100) * 4 -- power is the raw % atk boost
    end

    local dmg = math.floor(player:getStat(xi.mod.MND) * (0.5 + (math.random() / 2))) * multiplier

    dmg = utils.stoneskin(target, dmg)
    target:takeDamage(dmg, player, xi.attackType.SPECIAL, xi.damageType.ELEMENTAL)
    target:updateEnmityFromDamage(player, dmg)
    target:updateClaim(player)
    player:delStatusEffect(xi.effect.BOOST)

    return dmg
end

return ability_object
