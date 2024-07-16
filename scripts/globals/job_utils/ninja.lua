-----------------------------------
-- Ninja Job Utilities
-----------------------------------
require('scripts/globals/utils')
-----------------------------------
xi = xi or {}
xi.job_utils = xi.job_utils or {}
xi.job_utils.ninja = xi.job_utils.ninja or {}

-----------------------------------
-- Ability Check Functions
-----------------------------------

xi.job_utils.ninja.checkMijinGakure = function(player, target, ability)
    ability:setRecast(math.max(0, ability:getRecast() - player:getMod(xi.mod.ONE_HOUR_RECAST) * 60))
    return 0, 0
end

xi.job_utils.ninja.checkYonin = function(player, target, ability)
    return 0, 0
end

xi.job_utils.ninja.checkInnin = function(player, target, ability)
    return 0, 0
end

xi.job_utils.ninja.checkSange = function(player, target, ability)
    return 0, 0
end

xi.job_utils.ninja.checkFutae = function(player, target, ability)
    return 0, 0
end

xi.job_utils.ninja.checkIssekigan = function(player, target, ability)
    return 0, 0
end

xi.job_utils.ninja.checkMikage = function(player, target, ability)
    ability:setRecast(math.max(0, ability:getRecast() - player:getMod(xi.mod.ONE_HOUR_RECAST) * 60))
    return 0, 0
end

-----------------------------------
-- Ability Use Functions
-----------------------------------

xi.job_utils.ninja.useMijinGakure = function(player, target, ability, action)
    local dmg    = player:getHP() * 0.8 + player:getMainLvl() / 0.5
    local resist = xi.mobskills.applyPlayerResistance(player, nil, target, player:getStat(xi.mod.INT)-target:getStat(xi.mod.INT), 0, xi.element.NONE)

    -- Job Point Bonus (3% per Level)
    dmg = dmg * (1 + (player:getJobPointLevel(xi.jp.MIJIN_GAKURE_EFFECT) * 0.03))
    dmg = dmg * resist
    dmg = utils.stoneskin(target, dmg)

    target:takeDamage(dmg, player, xi.attackType.SPECIAL, xi.damageType.ELEMENTAL)
    player:setLocalVar('MijinGakure', 1)
    player:setHP(0)

    return dmg
end

xi.job_utils.ninja.useYonin = function(player, target, ability, action)
    target:delStatusEffect(xi.effect.INNIN)
    target:delStatusEffect(xi.effect.YONIN)
    target:addStatusEffect(xi.effect.YONIN, 30, 15, 300, 0, 20)
end

xi.job_utils.ninja.useInnin = function(player, target, ability, action)
    target:delStatusEffect(xi.effect.INNIN)
    target:delStatusEffect(xi.effect.YONIN)
    target:addStatusEffect(xi.effect.INNIN, 30, 15, 300, 0, 20)
end

xi.job_utils.ninja.useSange = function(player, target, ability, action)
    local potency = player:getMerit(xi.merit.SANGE)-1
    player:addStatusEffect(xi.effect.SANGE, potency * 25, 0, 60)
end

xi.job_utils.ninja.useFutae = function(player, target, ability, action)
    target:addStatusEffect(xi.effect.FUTAE, 0, 0, 60)
end

xi.job_utils.ninja.useIssekigan = function(player, target, ability, action)
    target:addStatusEffect(xi.effect.ISSEKIGAN, 25, 0, 60)
end

xi.job_utils.ninja.useMikage = function(player, target, ability, action)
    target:addStatusEffect(xi.effect.MIKAGE, 0, 0, 45)
end
