-----------------------------------
-- Warrior Job Utilities
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
    local ammoID = player:getEquipID(xi.slot.AMMO)

    if ammoID == xi.item.THROWING_TOMAHAWK then
        return 0, 0
    else
        return xi.msg.basic.CANNOT_PERFORM, 0
    end
end

-----------------------------------
-- Ability Use Functions
-----------------------------------
xi.job_utils.warrior.useAggressor = function(player, target, ability)
    local merits = player:getMerit(xi.merit.AGGRESSIVE_AIM)

    player:addStatusEffect(xi.effect.AGGRESSOR, merits, 0, 180 + player:getMod(xi.mod.AGGRESSOR_DURATION))
end

xi.job_utils.warrior.useBerserk = function(player, target, ability)
    player:addStatusEffect(xi.effect.BERSERK, 25 + player:getMod(xi.mod.BERSERK_POTENCY), 0, 180 + player:getMod(xi.mod.BERSERK_DURATION))
end

xi.job_utils.warrior.useBloodRage = function(player, target, ability)
    local power    = 20 + player:getJobPointLevel(xi.jp.BLOOD_RAGE_EFFECT)
    local duration = 30 + player:getMod(xi.mod.ENHANCES_BLOOD_RAGE)

    target:addStatusEffect(xi.effect.BLOOD_RAGE, power, 0, duration)

    if player:getID() ~= target:getID() then
        ability:setMsg(xi.msg.basic.JA_GAIN_EFFECT)
    end

    return xi.effect.BLOOD_RAGE
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
    player:addStatusEffect(xi.effect.RESTRAINT, 0, 0, 300)
end

xi.job_utils.warrior.useRetaliation = function(player, target, ability)
    player:addStatusEffect(xi.effect.RETALIATION, 1, 0, 180)
end

xi.job_utils.warrior.useTomahawk = function(player, target, ability)
    local merits   = player:getMerit(xi.merit.TOMAHAWK) - 15
    local duration = 30 + merits

    target:addStatusEffectEx(xi.effect.TOMAHAWK, 0, 25, 3, duration, 0, 0, 0)
    player:removeAmmo()
end

xi.job_utils.warrior.useWarcry = function(player, target, ability)
    local merit    = player:getMerit(xi.merit.SAVAGERY)
    local warLevel = utils.getActiveJobLevel(player, xi.job.WAR)
    local power    = (math.floor((warLevel / 4) + 4.75) / 256) * 100
    local duration = 30

    duration = duration + player:getMod(xi.mod.WARCRY_DURATION)

    target:addStatusEffect(xi.effect.WARCRY, power, 0, duration, 0, merit)

    if player:getID() ~= target:getID() then
        ability:setMsg(xi.msg.basic.JA_ATK_ENHANCED)
    end

    return xi.effect.WARCRY
end

xi.job_utils.warrior.useWarriorsCharge = function(player, target, ability)
    local merits = player:getMerit(xi.merit.WARRIORS_CHARGE)

    player:addStatusEffect(xi.effect.WARRIORS_CHARGE, merits - 5, 0, 60)
end
