-----------------------------------
-- Dark Knight Job Utilities
-----------------------------------
require('scripts/globals/items')
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
xi = xi or {}
xi.job_utils = xi.job_utils or {}
xi.job_utils.dark_knight = xi.job_utils.dark_knight or {}

-----------------------------------
-- Ability Check Functions
-----------------------------------
xi.job_utils.dark_knight.checkArcaneCrest = function(player, target, ability)
    local ecosystem = target:getSystem()

    if ecosystem == xi.ecosystem.ARCANA then
        return 0, 0
    else
        return xi.msg.basic.CANNOT_ON_THAT_TARG, 0
    end
end

xi.job_utils.dark_knight.checkBloodWeapon = function(player, target, ability)
    ability:setRecast(ability:getRecast() - player:getMod(xi.mod.ONE_HOUR_RECAST))

    return 0, 0
end

xi.job_utils.dark_knight.checkSoulEnslavement = function(player, target, ability)
    ability:setRecast(ability:getRecast() - player:getMod(xi.mod.ONE_HOUR_RECAST))

    return 0, 0
end

xi.job_utils.dark_knight.checkWeaponBash = function(player, target, ability)
    if not player:isWeaponTwoHanded() then
        return xi.msg.basic.NEEDS_2H_WEAPON, 0
    else
        return 0, 0
    end
end

-----------------------------------
-- Ability Use Functions
-----------------------------------
xi.job_utils.dark_knight.useArcaneCircle = function(player, target, ability)
    local duration = 180 + player:getMod(xi.mod.ARCANE_CIRCLE_DURATION)
    local power = 5

    if player:getMainJob() == xi.job.DRK then
        power = 15
    end

    target:addStatusEffect(xi.effect.ARCANE_CIRCLE, power, 0, duration)
end

xi.job_utils.dark_knight.useArcaneCrest = function(player, target, ability)
    target:addStatusEffect(xi.effect.ARCANE_CREST, 8, 1, 30)
end

xi.job_utils.dark_knight.useBloodWeapon = function(player, target, ability)
    target:addStatusEffect(xi.effect.BLOOD_WEAPON, 1, 0, 30)
end

xi.job_utils.dark_knight.useConsumeMana = function(player, target, ability)
   player:addStatusEffect(xi.effect.CONSUME_MANA, 1, 0, 60)
end

xi.job_utils.dark_knight.useDarkSeal = function(player, target, ability)
    local merits = player:getMerit(xi.merit.DARK_SEAL)
    player:addStatusEffect(xi.effect.DARK_SEAL, merits, 0, 60)
end

xi.job_utils.dark_knight.useDiabolicEye = function(player, target, ability)
    player:addStatusEffect(xi.effect.DIABOLIC_EYE, player:getMerit(xi.merit.DIABOLIC_EYE), 0, 180)
end

xi.job_utils.dark_knight.useLastResort = function(player, target, ability)
    player:addStatusEffect(xi.effect.LAST_RESORT, 0, 0, 180)
end

xi.job_utils.dark_knight.useNetherVoid = function(player, target, ability)
    player:addStatusEffect(xi.effect.NETHER_VOID, 8, 1, 30)
end

xi.job_utils.dark_knight.useScarletDelirium = function(player, target, ability)
    player:addStatusEffect(xi.effect.SCARLET_DELIRIUM, 8, 1, 90)
end

xi.job_utils.dark_knight.useSoulEnslavement = function(player, target, ability)
    player:addStatusEffect(xi.effect.SOUL_ENSLAVEMENT, 8, 1, 30)
end

xi.job_utils.dark_knight.useSouleater = function(player, target, ability)
    local jpValue = target:getJobPointLevel(xi.jp.SOULEATER_DURATION)

    player:addStatusEffect(xi.effect.SOULEATER, 1, 0, 60 + jpValue)
end

xi.job_utils.dark_knight.useWeaponBash = function(player, target, ability)
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
