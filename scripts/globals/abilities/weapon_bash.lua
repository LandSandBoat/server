-----------------------------------
-- Ability: Weapon Bash
-- Delivers an attack that can stun the target. Requires Two-handed weapon.
-- Obtained: Dark Knight Level 20
-- Cast Time: Instant
-- Recast Time: 3:00 minutes
-----------------------------------
require("scripts/globals/jobpoints")
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    if not player:isWeaponTwoHanded() then
        return xi.msg.basic.NEEDS_2H_WEAPON, 0
    else
        return 0, 0
    end
end

ability_object.onUseAbility = function(player, target, ability)
    -- Applying Weapon Bash stun. Rate is said to be near 100%, so let's say 99%.
    if (math.random()*100 < 99) then
        target:addStatusEffect(xi.effect.STUN, 1, 0, 6)
    end

    -- Weapon Bash deals damage dependant of Dark Knight level
    local darkKnightLvl = 0
    if player:getMainJob() == xi.job.DRK then
        darkKnightLvl = player:getMainLvl()    -- Use Mainjob Lvl
    elseif player:getSubJob() == xi.job.DRK then
        darkKnightLvl = player:getSubLvl()    -- Use Subjob Lvl
    end

    -- Calculating and applying Weapon Bash damage
    local jpValue = target:getJobPointLevel(xi.jp.WEAPON_BASH_EFFECT)
    local damage = math.floor(((darkKnightLvl + 11) / 4) + player:getMod(xi.mod.WEAPON_BASH) + jpValue * 10)
    target:takeDamage(damage, player, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    target:updateEnmityFromDamage(player, damage)

    return damage
end

return ability_object
