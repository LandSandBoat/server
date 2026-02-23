-----------------------------------
-- Ninja Job Utilities
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
    local dmg        = math.floor(player:getHP() * 0.8)
    local resist     = xi.combat.magicHitRate.calculateResistRate(player, target, 0, 0, 0, xi.element.NONE, xi.mod.INT, 0, 0)
    local tmdaFactor = xi.combat.damage.calculateDamageAdjustment(target, false, true, false, false)
    local jpFactor   = 1 + player:getJobPointLevel(xi.jp.MIJIN_GAKURE_EFFECT) * 0.03

    dmg = math.floor(dmg * resist)
    dmg = math.floor(dmg * tmdaFactor)
    dmg = math.floor(dmg * jpFactor)
    dmg = utils.handleStoneskin(target, dmg)

    target:takeDamage(dmg, player, xi.attackType.SPECIAL, xi.damageType.ELEMENTAL)
    player:setLocalVar('MijinGakure', 1)
    player:setHP(0)

    return dmg
end

xi.job_utils.ninja.useYonin = function(player, target, ability, action)
    target:delStatusEffect(xi.effect.INNIN)
    target:delStatusEffect(xi.effect.YONIN)
    target:addStatusEffect(xi.effect.YONIN, { power = 30, duration = 300, origin = player, tick = 15 })

    return xi.effect.YONIN
end

xi.job_utils.ninja.useInnin = function(player, target, ability, action)
    target:delStatusEffect(xi.effect.INNIN)
    target:delStatusEffect(xi.effect.YONIN)
    target:addStatusEffect(xi.effect.INNIN, { power = 30, duration = 300, origin = player, tick = 15, subPower = 20 })

    return xi.effect.INNIN
end

xi.job_utils.ninja.useSange = function(player, target, ability, action)
    local potency = player:getMerit(xi.merit.SANGE)-1
    player:addStatusEffect(xi.effect.SANGE, { power = potency * 25, duration = 60, origin = player })

    return xi.effect.SANGE
end

xi.job_utils.ninja.useFutae = function(player, target, ability, action)
    target:addStatusEffect(xi.effect.FUTAE, { duration = 60, origin = player })

    return xi.effect.FUTAE
end

xi.job_utils.ninja.useIssekigan = function(player, target, ability, action)
    target:addStatusEffect(xi.effect.ISSEKIGAN, { power = 25, duration = 60, origin = player })

    return xi.effect.ISSEKIGAN
end

xi.job_utils.ninja.useMikage = function(player, target, ability, action)
    target:addStatusEffect(xi.effect.MIKAGE, { duration = 45, origin = player })

    return xi.effect.MIKAGE
end
