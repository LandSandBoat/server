-----------------------------------
-- Dark Knight Job Utilities
-----------------------------------
require('scripts/globals/items')
require("scripts/globals/msg")
require("scripts/globals/utils")
-----------------------------------
xi = xi or {}
xi.job_utils = xi.job_utils or {}
xi.job_utils.dark_knight = xi.job_utils.dark_knight or {}

-----------------------------------
-- Ability Check Functions
-----------------------------------
xi.job_utils.dark_knight.checkArcaneCrest = function(player, target, ability)
    local ecosystem = target:getEcosystem()

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
    -- TODO:
    -- Create Bonus vs Ecosystem handling
    -- https://www.bg-wiki.com/ffxi/Arcane_Circle
    -- Main (DRK) job gives a unique 15% damage bonus against arcana, 15% damage resistance from arcana, and likely +15% Arcana Killer.
    -- When subbed, gives 5% of these bonuses.

    -- Job Points bonus will need to be handled in the Bonus vs Ecosystem handling system
    -- https://www.bg-wiki.com/ffxi/Job_Points#Dark_Knight
    -- Arcane Circle Effect: Reduces the amount of damage taken from arcana while under the effects of Arcane Circle.
    local duration = 180 * (1 + (player:getMod(xi.mod.ARCANE_CIRCLE_DURATION) / 100))
    local power    = 15 + player:getMod(xi.mod.ARCANE_CIRCLE_POTENCY)

    if player:getMainJob() ~= xi.job.DRK then
        power = 5
    end

    target:addStatusEffect(xi.effect.ARCANE_CIRCLE, power, 0, duration)
end

xi.job_utils.dark_knight.useArcaneCrest = function(player, target, ability)
    local power    = 20
    local jpValue  = player:getJobPointLevel(xi.jp.ARCANE_CREST_DURATION)
    local duration = 180 + jpValue

    target:addStatusEffect(xi.effect.ARCANE_CREST, power, 0, duration)
end

xi.job_utils.dark_knight.useBloodWeapon = function(player, target, ability)
    local duration = 30 + player:getMod(xi.mod.ENHANCES_BLOOD_WEAPON)

    target:addStatusEffect(xi.effect.BLOOD_WEAPON, 1, 0, duration)
end

xi.job_utils.dark_knight.useConsumeMana = function(player, target, ability)
    player:addStatusEffect(xi.effect.CONSUME_MANA, 1, 0, 60)
end

xi.job_utils.dark_knight.useDarkSeal = function(player, target, ability)
    -- Power: Each merit level after the first reduces Dark Magic casting time by -10% (total of -40% bonus).
    -- Sub Power: Enhances Dark Seal effect by increasing duration of Dark Magic by 10% per merit level (total of 50% bonus).
    local power    = player:getMerit(xi.merit.DARK_SEAL) - 10
    local subPower = (player:getMerit(xi.merit.DARK_SEAL) / 10) * player:getMod(xi.mod.ENHANCES_DARK_SEAL)

    player:addStatusEffect(xi.effect.DARK_SEAL, power, 0, 60, 0, subPower)
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
    if math.random(1, 100) <= 99 then
        target:addStatusEffect(xi.effect.STUN, 1, 0, 6)
    end

    -- Weapon Bash deals damage dependant of Dark Knight level
    local darkKnightLvl = utils.getActiveJobLevel(player, xi.job.DRK)

    -- Calculating and applying Weapon Bash damage
    local jpValue = target:getJobPointLevel(xi.jp.WEAPON_BASH_EFFECT)
    local damage  = math.floor((darkKnightLvl + 11) / 4 + player:getMod(xi.mod.WEAPON_BASH) + jpValue * 10)

    target:takeDamage(damage, player, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    target:updateEnmityFromDamage(player, damage)

    return damage
end
