-- Uses a mixture of mob and player WS formulas
require('scripts/globals/weaponskills')
require('scripts/globals/magicburst')
require('scripts/globals/utils')
require('scripts/globals/magic')

-- TODO: Consolidate this with weaponskills
xi = xi or {}
xi.autows = xi.autows or {}

local function getAutoHitRate(attacker, defender, capHitRate, bonus, melee)
    local acc = (melee and attacker:getACC() or attacker:getRACC()) + (bonus or 0)
    local eva = defender:getEVA()

    local levelbonus = 0
    if attacker:getMainLvl() > defender:getMainLvl() then
        levelbonus = 2 * (attacker:getMainLvl() - defender:getMainLvl())
    end

    local hitrate = acc - eva + levelbonus + 75
    hitrate = hitrate / 100

    -- Applying hitrate caps
    if capHitRate then -- this isn't capped for when acc varies with tp, as more penalties are due
        hitrate = utils.clamp(hitrate, 0.2, 0.95)
    end

    return hitrate
end

-- Given the raw ratio value (atk/def) and levels, returns the cRatio (min then max)
local function getRangedCRatio(attacker, defender, params, ignoredDef)
    local cratio = attacker:getRATT() * params.atkmulti / (defender:getStat(xi.mod.DEF) - ignoredDef)

    local levelbonus = 0
    if attacker:getMainLvl() > defender:getMainLvl() then
        levelbonus = 0.05 * (attacker:getMainLvl() - defender:getMainLvl())
    end

    cratio = cratio + levelbonus
    cratio = utils.clamp(cratio, 0, 3.0)

    local pdif = {}
    local pdifcrit = {}

    -- max
    local pdifmax = 0
    if cratio < 0.9 then
        pdifmax = cratio * 10 / 9
    elseif cratio < 1.1 then
        pdifmax = 1
    else
        pdifmax = cratio
    end

    -- min
    local pdifmin = 0
    if cratio < 0.9 then
        pdifmin = cratio
    elseif cratio < 1.1 then
        pdifmin = 1
    else
        pdifmin = cratio * 20 / 19 - 3 / 19
    end

    pdif[1] = pdifmin
    pdif[2] = pdifmax

    pdifmin = pdifmin * 1.25
    pdifmax = pdifmax * 1.25

    local critbonus = attacker:getMod(xi.mod.CRIT_DMG_INCREASE) - defender:getMod(xi.mod.CRIT_DEF_BONUS)
    critbonus = utils.clamp(critbonus, 0, 100)
    pdifcrit[1] = pdifmin * (100 + critbonus) / 100
    pdifcrit[2] = pdifmax * (100 + critbonus) / 100

    return pdif, pdifcrit
end

-- Given the raw ratio value (atk/def) and levels, returns the cRatio (min then max)
local function getMeleeCRatio(attacker, defender, params, ignoredDef)
    local cratio = attacker:getStat(xi.mod.ATT) * params.atkmulti / (defender:getStat(xi.mod.DEF) - ignoredDef)

    local levelbonus = 0
    if attacker:getMainLvl() > defender:getMainLvl() then
        levelbonus = 0.05 * (attacker:getMainLvl() - defender:getMainLvl())
    end

    cratio = cratio + levelbonus
    cratio = utils.clamp(cratio, 0, 4.0)

    local pdif = {}
    local pdifcrit = {}

    local pdifmin = 0
    local pdifmax = 1

    if cratio < 0.5 then
        pdifmax = cratio + 0.5
    elseif cratio <= 0.7 then
        pdifmax = 1
    elseif cratio <= 1.2 then
        pdifmax = cratio + 0.3
    elseif cratio <= 1.5 then
        pdifmax = (cratio * 0.25) + cratio
    elseif cratio <= 2.625 then
        pdifmax = cratio + 0.375
    elseif cratio <= 3.25 then
        pdifmax = 3
    else
        pdifmax = cratio
    end

    if cratio < 0.38 then
        pdifmin =  0
    elseif cratio <= 1.25 then
        pdifmin = cratio * 1176 / 1024 - 448 / 1024
    elseif cratio <= 1.51 then
        pdifmin = 1
    elseif cratio <= 2.44 then
        pdifmin = cratio * 1176 / 1024 - 775 / 1024
    else
        pdifmin = cratio - 0.375
    end

    pdif[1] = pdifmin
    pdif[2] = pdifmax

    cratio = cratio + 1
    cratio = utils.clamp(cratio, 0, 4.0)

    if cratio < 0.5 then
        pdifmax = cratio + 0.5
    elseif cratio <= 0.7 then
        pdifmax = 1
    elseif cratio <= 1.2 then
        pdifmax = cratio + 0.3
    elseif cratio <= 1.5 then
        pdifmax = cratio * 0.25 + cratio
    elseif cratio <= 2.625 then
        pdifmax = cratio + 0.375
    elseif cratio <= 3.25 then
        pdifmax = 3
    else
        pdifmax = cratio
    end

    if cratio < 0.38 then
        pdifmin =  0
    elseif cratio <= 1.25 then
        pdifmin = cratio * 1176 / 1024 - 448 / 1024
    elseif cratio <= 1.51 then
        pdifmin = 1
    elseif cratio <= 2.44 then
        pdifmin = cratio * 1176 / 1024 - 775 / 1024
    else
        pdifmin = cratio - 0.375
    end

    local critbonus = attacker:getMod(xi.mod.CRIT_DMG_INCREASE) - defender:getMod(xi.mod.CRIT_DEF_BONUS)
    critbonus = utils.clamp(critbonus, 0, 100)
    pdifcrit[1] = pdifmin * (100 + critbonus) / 100
    pdifcrit[2] = pdifmax * (100 + critbonus) / 100

    return pdif, pdifcrit
end

-- params contains: ftpMod, str_wsc, dex_wsc, vit_wsc, int_wsc, mnd_wsc, critVaries, accVaries, ignoredDefense, atkmulti, kick, accBonus, weaponType, weaponDamage
xi.autows.doAutoPhysicalWeaponskill = function(attacker, target, wsID, tp, primaryMsg, action, taChar, wsParams, skill)
    -- Determine cratio and ccritratio
    local ignoredDef         = xi.weaponskills.calculatedIgnoredDef(tp, target:getStat(xi.mod.DEF), wsParams.ignoredDefense)
    local cratio, ccritratio = getMeleeCRatio(attacker, target, wsParams, ignoredDef)

    -- Set up conditions and wsParams used for calculating weaponskill damage

    -- Handle Flame Holder attachment.
    -- Mod usage, and values returned by Flame Holder script, might not be correct.
    local flameHolderFTP = attacker:getMod(xi.mod.WEAPONSKILL_DAMAGE_BASE) / 100

    local attack =
    {
        ['type'] = xi.attackType.PHYSICAL,
        ['slot'] = xi.slot.MAIN,
        ['weaponType'] = attacker:getWeaponSkillType(xi.slot.MAIN),
        ['damageType'] = attacker:getWeaponDamageType(xi.slot.MAIN)
    }

    local calcParams = {}
    calcParams.wsID = wsID
    calcParams.weaponDamage = xi.weaponskills.getMeleeDmg(attacker, attack.weaponType, wsParams.kick)
    calcParams.attackInfo = attack
    calcParams.fSTR = utils.clamp(attacker:getStat(xi.mod.STR) - target:getStat(xi.mod.VIT), -10, 10)
    calcParams.cratio = cratio
    calcParams.ccritratio = ccritratio
    calcParams.accStat = attacker:getACC()
    calcParams.melee = true
    calcParams.mustMiss = target:hasStatusEffect(xi.effect.PERFECT_DODGE) or
        (target:hasStatusEffect(xi.effect.ALL_MISS) and not wsParams.hitsHigh)

    calcParams.sneakApplicable = false
    calcParams.taChar = taChar
    calcParams.trickApplicable = false
    calcParams.assassinApplicable = false
    calcParams.guaranteedHit = false
    calcParams.mightyStrikesApplicable = attacker:hasStatusEffect(xi.effect.MIGHTY_STRIKES)
    calcParams.forcedFirstCrit = false
    calcParams.extraOffhandHit = false
    calcParams.hybridHit = false
    calcParams.flourishEffect = false
    calcParams.alpha = 1
    calcParams.bonusWSmods = math.max(attacker:getMainLvl() - target:getMainLvl(), 0)
    calcParams.bonusTP = wsParams.bonusTP or 0
    calcParams.bonusfTP = flameHolderFTP or 0
    calcParams.bonusAcc = 0 + attacker:getMod(xi.mod.WSACC)
    calcParams.hitRate = getAutoHitRate(attacker, target, false, calcParams.bonusAcc, calcParams.melee)
    calcParams.skillType = attack.weaponType
    calcParams.tpUsed = tp

    -- Send our wsParams off to calculate our raw WS damage, hits landed, and shadows absorbed
    calcParams = xi.weaponskills.calculateRawWSDmg(attacker, target, wsID, tp, action, wsParams, calcParams)
    local finaldmg = calcParams.finalDmg

    -- Calculate reductions
    if not wsParams.formless then
        --finaldmg = target:physicalDmgTaken(finaldmg, attack.damageType)
        if attack.weaponType == xi.skill.HAND_TO_HAND then
            finaldmg = finaldmg * target:getMod(xi.mod.HTH_SDT) / 1000
        elseif
            attack.weaponType == xi.skill.DAGGER or
            attack.weaponType == xi.skill.POLEARM
        then
            finaldmg = finaldmg * target:getMod(xi.mod.PIERCE_SDT) / 1000
        elseif
            attack.weaponType == xi.skill.CLUB or
            attack.weaponType == xi.skill.STAFF
        then
            finaldmg = finaldmg * target:getMod(xi.mod.IMPACT_SDT) / 1000
        else
            finaldmg = finaldmg * target:getMod(xi.mod.SLASH_SDT) / 1000
        end
    end

    finaldmg = finaldmg * xi.settings.main.WEAPON_SKILL_POWER -- Add server bonus
    calcParams.finalDmg = finaldmg

    if calcParams.tpHitsLanded + calcParams.extraHitsLanded > 0 then
        finaldmg = xi.weaponskills.takeWeaponskillDamage(target, attacker, wsParams, primaryMsg, attack, calcParams, action)
    else
        skill:setMsg(xi.msg.basic.SKILL_MISS)
    end

    return finaldmg, calcParams.criticalHit, calcParams.tpHitsLanded, calcParams.extraHitsLanded, calcParams.shadowsAbsorbed
end

-- params contains: ftpMod, str_wsc, dex_wsc, vit_wsc, int_wsc, mnd_wsc, critVaries, accVaries, ignoredDefense, atkmulti, accBonus, weaponDamage
xi.autows.doAutoRangedWeaponskill = function(attacker, target, wsID, wsParams, tp, primaryMsg, skill, action)
    -- Determine cratio and ccritratio
    local ignoredDef         = xi.weaponskills.calculatedIgnoredDef(tp, target:getStat(xi.mod.DEF), wsParams.ignoredDefense)
    local cratio, ccritratio = getRangedCRatio(attacker, target, wsParams, ignoredDef)

    -- Set up conditions and wsParams used for calculating weaponskill damage

    -- Handle Flame Holder attachment.
    -- Mod usage, and values returned by Flame Holder script, might not be correct.
    local flameHolderFTP = attacker:getMod(xi.mod.WEAPONSKILL_DAMAGE_BASE) / 100

    local attack =
    {
        ['type'] = xi.attackType.RANGED,
        ['slot'] = xi.slot.RANGED,
        ['weaponType'] = attacker:getWeaponSkillType(xi.slot.RANGED),
        ['damageType'] = attacker:getWeaponDamageType(xi.slot.RANGED)
    }

    local rangedDamage = attacker:getRangedDmg() * (1 + attacker:getMod(xi.mod.AUTO_RANGED_DAMAGEP) / 100)

    local calcParams =
    {
        wsID = wsID,
        weaponDamage = { wsParams.weaponDamage or rangedDamage },
        attackInfo = attack,
        fSTR = utils.clamp(attacker:getStat(xi.mod.STR) - target:getStat(xi.mod.VIT), -10, 10),
        cratio = cratio,
        ccritratio = ccritratio,
        accStat = attacker:getRACC(),
        melee = false,
        mustMiss = false,
        sneakApplicable = false,
        trickApplicable = false,
        assassinApplicable = false,
        mightyStrikesApplicable = false,
        forcedFirstCrit = false,
        extraOffhandHit = false,
        flourishEffect = false,
        alpha = 1,
        bonusWSmods = math.max(attacker:getMainLvl() - target:getMainLvl(), 0),
        bonusTP = wsParams.bonusTP or 0,
        bonusfTP = flameHolderFTP or 0,
        bonusAcc = 0 + attacker:getMod(xi.mod.WSACC),
        tpUsed = tp,
    }
    calcParams.hitRate = getAutoHitRate(attacker, target, false, calcParams.bonusAcc, calcParams.melee)
    calcParams.skillType = attack.weaponType

    -- Send our params off to calculate our raw WS damage, hits landed, and shadows absorbed
    calcParams = xi.weaponskills.calculateRawWSDmg(attacker, target, wsID, tp, action, wsParams, calcParams)
    local finaldmg = calcParams.finalDmg

    -- Calculate reductions
    finaldmg = target:rangedDmgTaken(finaldmg)
    finaldmg = finaldmg * target:getMod(xi.mod.PIERCE_SDT) / 1000

    finaldmg = finaldmg * xi.settings.main.WEAPON_SKILL_POWER -- Add server bonus
    calcParams.finalDmg = finaldmg

    if calcParams.tpHitsLanded + calcParams.extraHitsLanded > 0 then
        finaldmg = xi.weaponskills.takeWeaponskillDamage(target, attacker, wsParams, primaryMsg, attack, calcParams, action)
    else
        skill:setMsg(xi.msg.basic.SKILL_MISS)
    end

    return finaldmg, calcParams.criticalHit, calcParams.tpHitsLanded, calcParams.extraHitsLanded, calcParams.shadowsAbsorbed
end
