-----------------------------------
-- Ability: Blade Bash
-- Deliver an attack that can stun the target and occasionally cause Plague.
-- Obtained: Samurai Level 75
-- Recast Time: 3:00
-- Duration: Instant
-----------------------------------
require("scripts/globals/msg")
require("scripts/globals/status")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    if not player:isWeaponTwoHanded() then
        return xi.msg.basic.NEEDS_2H_WEAPON, 0
    end

    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    -- Stun rate
    if math.random(1, 100) < 99 then
        target:addStatusEffect(xi.effect.STUN, 1, 0, 6)
    end

    -- Yes, even Blade Bash deals damage dependant of Dark Knight level
    local damage = 0

    if player:getMainJob() == xi.job.DRK then
        damage = math.floor(((player:getMainLvl() + 11) / 4) + player:getMod(xi.mod.WEAPON_BASH))
    elseif player:getSubJob() == xi.job.DRK then
        damage = math.floor(((player:getSubLvl() + 11) / 4) + player:getMod(xi.mod.WEAPON_BASH))
    end

    -- Calculating and applying Blade Bash damage
    damage = utils.stoneskin(target, damage)
    target:takeDamage(damage, player, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    target:updateEnmityFromDamage(player, damage)

    -- Applying Plague based on merit level.
    if math.random(1, 100) < 65 then
        target:addStatusEffect(xi.effect.PLAGUE, 5, 0, 15 + player:getMerit(xi.merit.BLADE_BASH))
    end

    ability:setMsg(xi.msg.basic.JA_DAMAGE)

    return damage
end

return abilityObject
