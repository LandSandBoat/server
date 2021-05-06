-- Uses a mixture of mob and player WS formulas
require("scripts/globals/weaponskills")
require("scripts/globals/magicburst")
require("scripts/globals/status")
require("scripts/globals/utils")
require("scripts/globals/magic")
require("scripts/globals/msg")


-- params contains: ftp100, ftp200, ftp300, str_wsc, dex_wsc, vit_wsc, int_wsc, mnd_wsc, canCrit, crit100, crit200, crit300, acc100, acc200, acc300, ignoresDef, ignore100, ignore200, ignore300, atkmulti, kick, accBonus, weaponType, weaponDamage
function doAutoPhysicalWeaponskill(attacker, target, wsID, tp, primaryMsg, action, taChar, wsParams, skill, action)

    -- Determine cratio and ccritratio
    local ignoredDef = 0
    if (wsParams.ignoresDef == not nil and wsParams.ignoresDef == true) then
        ignoredDef = calculatedIgnoredDef(tp, target:getStat(xi.mod.DEF), wsParams.ignored100, wsParams.ignored200, wsParams.ignored300)
    end
    local cratio, ccritratio = getAutocRatio(attacker, target, wsParams, ignoredDef, true)

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
    calcParams.weaponDamage = getMeleeDmg(attacker, attack.weaponType, wsParams.kick)

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

    -- Send our wsParams off to calculate our raw WS damage, hits landed, and shadows absorbed
    calcParams = calculateRawWSDmg(attacker, target, wsID, tp, action, wsParams, calcParams)
    local finaldmg = calcParams.finalDmg

    -- Delete statuses that may have been spent by the WS
    attacker:delStatusEffectSilent(xi.effect.BUILDING_FLOURISH)

    -- Calculate reductions
    if not wsParams.formless then
        --finaldmg = target:physicalDmgTaken(finaldmg, attack.damageType)
        if (attack.weaponType == xi.skill.HAND_TO_HAND) then
            finaldmg = finaldmg * target:getMod(xi.mod.HTHRES) / 1000
        elseif (attack.weaponType == xi.skill.DAGGER or attack.weaponType == xi.skill.POLEARM) then
            finaldmg = finaldmg * target:getMod(xi.mod.PIERCERES) / 1000
        elseif (attack.weaponType == xi.skill.CLUB or attack.weaponType == xi.skill.STAFF) then
            finaldmg = finaldmg * target:getMod(xi.mod.IMPACTRES) / 1000
        else
            finaldmg = finaldmg * target:getMod(xi.mod.SLASHRES) / 1000
        end
    end

    finaldmg = finaldmg * WEAPON_SKILL_POWER -- Add server bonus
    calcParams.finalDmg = finaldmg

    if calcParams.tpHitsLanded + calcParams.extraHitsLanded > 0 then
        finaldmg = takeWeaponskillDamage(target, attacker, wsParams, primaryMsg, attack, calcParams, action)
    else
        skill:setMsg(xi.msg.basic.SKILL_MISS)
    end

    return finaldmg, calcParams.criticalHit, calcParams.tpHitsLanded, calcParams.extraHitsLanded, calcParams.shadowsAbsorbed
end

-- params contains: ftp100, ftp200, ftp300, str_wsc, dex_wsc, vit_wsc, int_wsc, mnd_wsc, canCrit, crit100, crit200, crit300, acc100, acc200, acc300, ignoresDef, ignore100, ignore200, ignore300, atkmulti, accBonus, weaponDamage
function doAutoRangedWeaponskill(attacker, target, wsID, wsParams, tp, primaryMsg, skill, action)
    -- Determine cratio and ccritratio
    local ignoredDef = 0
    if (wsParams.ignoresDef == not nil and wsParams.ignoresDef == true) then
        ignoredDef = calculatedIgnoredDef(tp, target:getStat(xi.mod.DEF), wsParams.ignored100, wsParams.ignored200, wsParams.ignored300)
    end
    local cratio, ccritratio = getAutocRatio(attacker, target, wsParams, ignoredDef, false)

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
    local calcParams =
    {
        weaponDamage = {wsParams.weaponDamage or attacker:getRangedDmg()},
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
        bonusAcc = 0 + attacker:getMod(xi.mod.WSACC)
    }
    calcParams.hitRate = getAutoHitRate(attacker, target, false, calcParams.bonusAcc, calcParams.melee)

    -- Send our params off to calculate our raw WS damage, hits landed, and shadows absorbed
    calcParams = calculateRawWSDmg(attacker, target, wsID, tp, action, wsParams, calcParams)
    local finaldmg = calcParams.finalDmg

    -- Calculate reductions
    finaldmg = target:rangedDmgTaken(finaldmg)
    finaldmg = finaldmg * target:getMod(xi.mod.PIERCERES) / 1000

    finaldmg = finaldmg * WEAPON_SKILL_POWER -- Add server bonus
    calcParams.finalDmg = finaldmg

    if calcParams.tpHitsLanded + calcParams.extraHitsLanded > 0 then
        finaldmg = takeWeaponskillDamage(target, attacker, wsParams, primaryMsg, attack, calcParams, action)
    else
        skill:setMsg(xi.msg.basic.SKILL_MISS)
    end

    return finaldmg, calcParams.criticalHit, calcParams.tpHitsLanded, calcParams.extraHitsLanded, calcParams.shadowsAbsorbed
end

function getAutoHitRate(attacker, defender, capHitRate, bonus, melee)
    local acc = (melee and attacker:getACC() or attacker:getRACC()) + (bonus or 0)
    local eva = defender:getEVA()

    local levelbonus = 0
    if (attacker:getMainLvl() > defender:getMainLvl()) then
        levelbonus = 2 * (attacker:getMainLvl() - defender:getMainLvl())
    end

    local hitrate = acc - eva + levelbonus + 75
    hitrate = hitrate/100

    -- Applying hitrate caps
    if (capHitRate) then -- this isn't capped for when acc varies with tp, as more penalties are due
        hitrate = utils.clamp(hitrate, 0.2, 0.95)
    end
    return hitrate
end

-- Given the raw ratio value (atk/def) and levels, returns the cRatio (min then max)
function getAutocRatio(attacker, defender, params, ignoredDef, melee)
    local cratio = (melee and attacker:getStat(xi.mod.ATT) or attacker:getRATT()) * params.atkmulti / (defender:getStat(xi.mod.DEF) - ignoredDef)

    local levelbonus = 0
    if attacker:getMainLvl() > defender:getMainLvl() then
        levelbonus = 0.05 * (attacker:getMainLvl() - defender:getMainLvl())
    end

    cratio = cratio + levelbonus
    cratio = utils.clamp(cratio, 0, melee and 4.0 or 3.0)

    local pdif = {}
    local pdifcrit = {}

    if melee then
        local pdifmin = 0
        local pdifmax = 1

        if cratio < 0.5 then
            pdifmax = cratio + 0.5
        elseif 0.5 <= cratio and cratio <= 0.7 then
            pdifmax = 1
        elseif 0.7 < cratio and cratio <= 1.2 then
            pdifmax = cratio + 0.3
        elseif 1.2 < cratio and cratio <= 1.5 then
            pdifmax = (cratio * 0.25) + cratio
        elseif 1.5 < cratio and cratio <= 2.625 then
            pdifmax = cratio + 0.375
        elseif 2.625 < cratio and cratio <= 3.25 then
            pdifmax = 3
        else
            pdifmax = cratio
        end

        if cratio < 0.38 then
            pdifmin =  0
        elseif 0.38 <= cratio and cratio <= 1.25 then
            pdifmin = cratio * 1176 / 1024 - 448 / 1024
        elseif 1.25 < cratio and cratio <= 1.51 then
            pdifmin = 1
        elseif 1.51 < cratio and cratio <= 2.44 then
            pdifmin = cratio * 1176 / 1024 - 775 / 1024
        else
            pdifmin = cratio - 0.375
        end

        pdif[1] = pdifmin
        pdif[2] = pdifmax

        cratio = cratio + 1
        cratio = utils.clamp(cratio, 0, 4.0)

        -- printf("ratio: %f min: %f max %f\n", cratio, pdifmin, pdifmax)

        if cratio < 0.5 then
            pdifmax = cratio + 0.5
        elseif 0.5 <= cratio and cratio <= 0.7 then
            pdifmax = 1
        elseif 0.7 < cratio and cratio <= 1.2 then
            pdifmax = cratio + 0.3
        elseif 1.2 < cratio and cratio <= 1.5 then
            pdifmax = cratio * 0.25 + cratio
        elseif 1.5 < cratio and cratio <= 2.625 then
            pdifmax = cratio + 0.375
        elseif 2.625 < cratio and cratio <= 3.25 then
            pdifmax = 3
        else
            pdifmax = cratio
        end

        if cratio < 0.38 then
            pdifmin =  0
        elseif 0.38 <= cratio and cratio <= 1.25 then
            pdifmin = cratio * 1176 / 1024 - 448 / 1024
        elseif 1.25 < cratio and cratio <= 1.51 then
            pdifmin = 1
        elseif 1.51 < cratio and cratio <= 2.44 then
            pdifmin = cratio * 1176 / 1024 - 775 / 1024
        else
            pdifmin = cratio - 0.375
        end

        local critbonus = attacker:getMod(xi.mod.CRIT_DMG_INCREASE) - defender:getMod(xi.mod.CRIT_DEF_BONUS)
        critbonus = utils.clamp(critbonus, 0, 100)
        pdifcrit[1] = pdifmin * (100 + critbonus) / 100
        pdifcrit[2] = pdifmax * (100 + critbonus) / 100
    else
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
        -- printf("ratio: %f min: %f max %f\n", cratio, pdifmin, pdifmax)

        pdifmin = pdifmin * 1.25
        pdifmax = pdifmax * 1.25

        local critbonus = attacker:getMod(xi.mod.CRIT_DMG_INCREASE) - defender:getMod(xi.mod.CRIT_DEF_BONUS)
        critbonus = utils.clamp(critbonus, 0, 100)
        pdifcrit[1] = pdifmin * (100 + critbonus) / 100
        pdifcrit[2] = pdifmax * (100 + critbonus) / 100
    end

    return pdif, pdifcrit
end
