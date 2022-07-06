-----------------------------------
-- Warrior Job Utilities
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
xi = xi or {}
xi.job_utils = xi.job_utils or {}
xi.job_utils.warrior = xi.job_utils.warrior or {}

-----------------------------------
-- Ability Check Functions
-----------------------------------
xi.job_utils.warrior.checkBrazenRush = function(player, target, ability)
    ability:setRecast(ability:getRecast() - player:getMod(xi.mod.ONE_HOUR_RECAST))
    return 0, 0
end

xi.job_utils.warrior.checkMightyStrikes = function(player, target, ability)
    ability:setRecast(ability:getRecast() - player:getMod(xi.mod.ONE_HOUR_RECAST))
    return 0, 0
end

xi.job_utils.warrior.checkTomahawk = function(player, target, ability)
    --Placeholder code. Needs to check for direction and equiped ammo.
    return 0, 0
end

-----------------------------------
-- Ability Use Functions
-----------------------------------
xi.job_utils.warrior.useAggressor = function(player, target, ability)
    local merits = player:getMerit(xi.merit.AGGRESSIVE_AIM)
    player:addStatusEffect(xi.effect.AGGRESSOR, merits, 0, 180 + player:getMod(xi.mod.AGGRESSOR_DURATION))
end

xi.job_utils.warrior.useBerserk = function(player, target, ability)
    player:addStatusEffect(xi.effect.BERSERK, 25 + player:getMod(xi.mod.BERSERK_EFFECT), 0, 180 + player:getMod(xi.mod.BERSERK_DURATION))
end

xi.job_utils.warrior.useBloodRage = function(player, target, ability)
    player:addStatusEffect(xi.effect.BLOOD_RAGE, 1, 0, 30)
end

xi.job_utils.warrior.useBrazenRush = function(player, target, ability)
    player:addStatusEffect(xi.effect.BRAZEN_RUSH, 100, 3, 30)
end

xi.job_utils.warrior.useDefender = function(player, target, ability)
    player:addStatusEffect(xi.effect.DEFENDER, 1, 0, 180 + player:getMod(xi.mod.DEFENDER_DURATION))
end

xi.job_utils.warrior.useMightyStrikes = function(player, target, ability)
    player:addStatusEffect(xi.effect.MIGHTY_STRIKES, 1, 0, 45)
end

xi.job_utils.warrior.useRestraint = function(player, target, ability)
    --placeholder
end

xi.job_utils.warrior.useRetaliation = function(player, target, ability)
    player:addStatusEffect(xi.effect.RETALIATION, 1, 0, 180)
end

xi.job_utils.warrior.useTomahawk = function(player, target, ability)
    --placeholder
end

xi.job_utils.warrior.useWarcry = function(player, target, ability)
    local merit = player:getMerit(xi.merit.SAVAGERY)
    local power = 0
    local duration = 30

    if player:getMainJob() == xi.job.WAR then
        power = math.floor((player:getMainLvl()/4)+4.75)/256
    else
        power = math.floor((player:getSubLvl()/4)+4.75)/256
    end

    power = power * 100
    duration = duration + player:getMod(xi.mod.WARCRY_DURATION)
    target:addStatusEffect(xi.effect.WARCRY, power, 0, duration, 0, merit)
end

xi.job_utils.warrior.useWarriorsCharge = function(player, target, ability)
    local merits = player:getMerit(xi.merit.WARRIORS_CHARGE)
    player:addStatusEffect(xi.effect.WARRIORS_CHARGE, merits-5, 0, 60)
end
