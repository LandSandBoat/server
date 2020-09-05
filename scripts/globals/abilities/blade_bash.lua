-----------------------------------
-- Ability: Blade Bash
-- Deliver an attack that can stun the target and occasionally cause Plague.
-- Obtained: Samurai Level 75
-- Recast Time: 3:00
-- Duration: Instant
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player, target, ability)
    if (not player:isWeaponTwoHanded()) then
        return tpz.msg.basic.NEEDS_2H_WEAPON, 0
    else
        return 0, 0
    end
end

function onUseAbility(player, target, ability)
    -- Stun rate
    if (math.random(1, 100) < 99) then
        target:addStatusEffect(tpz.effect.STUN, 1, 0, 6)
    end

    -- Yes, even Blade Bash deals damage dependant of Dark Knight level
    local darkKnightLvl = 0
    local damage = 0
    if (player:getMainJob() == tpz.job.DRK) then
        damage = math.floor(((player:getMainLvl() + 11) / 4) + player:getMod(tpz.mod.WEAPON_BASH))
    elseif (player:getSubJob() == tpz.job.DRK) then
        damage = math.floor(((player:getSubLvl() + 11) / 4) + player:getMod(tpz.mod.WEAPON_BASH))
    end

    -- Calculating and applying Blade Bash damage
    damage = utils.stoneskin(target, damage)
    target:takeDamage(damage, player, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT)
    target:updateEnmityFromDamage(player, damage)

    -- Applying Plague based on merit level.
    if (math.random(1, 100) < 65) then
        target:addStatusEffect(tpz.effect.PLAGUE, 5, 0, 15 + player:getMerit(tpz.merit.BLADE_BASH))
    end

    ability:setMsg(tpz.msg.basic.JA_DAMAGE)

    return damage
end
