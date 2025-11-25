-- Uses a mixture of mob and player WS formulas
require('scripts/globals/weaponskills')
require('scripts/globals/magicburst')
require('scripts/globals/magic')

-- TODO: Consolidate this with weaponskills
xi = xi or {}
xi.autows = xi.autows or {}

-- params contains: ftpMod, str_wsc, dex_wsc, vit_wsc, int_wsc, mnd_wsc, critVaries, accVaries, ignoredDefense, atkmulti, kick, accBonus, weaponType, weaponDamage
xi.autows.doAutoPhysicalWeaponskill = function(attacker, target, wsID, tp, primaryMsg, action, taChar, wsParams, skill)
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
    calcParams.firstHitRate = xi.combat.physicalHitRate.getPhysicalHitRate(attacker, target, calcParams.bonusAcc + 100, xi.attackAnimation.RIGHT_ATTACK, true) -- TODO: do automatons get first hit acc bonus?
    calcParams.hitRate      = xi.combat.physicalHitRate.getPhysicalHitRate(attacker, target, calcParams.bonusAcc, xi.attackAnimation.RIGHT_ATTACK, true)
    calcParams.skillType = attack.weaponType
    calcParams.tpUsed = tp

    -- Send our wsParams off to calculate our raw WS damage, hits landed, and shadows absorbed
    calcParams = xi.weaponskills.calculateRawWSDmg(attacker, target, wsID, tp, action, wsParams, calcParams)
    local finaldmg = calcParams.finalDmg

    -- Calculate reductions
    if not wsParams.formless then
        --finaldmg = target:physicalDmgTaken(finaldmg, attack.damageType)
        if attack.weaponType == xi.skill.HAND_TO_HAND then
            finaldmg = finaldmg * (1 + target:getMod(xi.mod.HTH_SDT) / 10000)
        elseif
            attack.weaponType == xi.skill.DAGGER or
            attack.weaponType == xi.skill.POLEARM
        then
            finaldmg = finaldmg * (1 + target:getMod(xi.mod.PIERCE_SDT) / 10000)
        elseif
            attack.weaponType == xi.skill.CLUB or
            attack.weaponType == xi.skill.STAFF
        then
            finaldmg = finaldmg * (1 + target:getMod(xi.mod.IMPACT_SDT) / 10000)
        else
            finaldmg = finaldmg * (1 + target:getMod(xi.mod.SLASH_SDT) / 10000)
        end
    end

    finaldmg = finaldmg * xi.settings.main.WEAPON_SKILL_POWER -- Add server bonus
    calcParams.finalDmg = finaldmg

    if calcParams.tpHitsLanded + calcParams.extraHitsLanded > 0 then
        finaldmg = xi.weaponskills.takeWeaponskillDamage(target, attacker, wsParams, primaryMsg, attack, calcParams, action)
    else
        skill:setMsg(xi.msg.basic.SKILL_MISS)
    end

    skill:setAttackType(xi.attackType.PHYSICAL)
    skill:setCritical(calcParams.criticalHit)

    return finaldmg, calcParams.criticalHit, calcParams.tpHitsLanded, calcParams.extraHitsLanded, calcParams.shadowsAbsorbed
end

-- params contains: ftpMod, str_wsc, dex_wsc, vit_wsc, int_wsc, mnd_wsc, critVaries, accVaries, ignoredDefense, atkmulti, accBonus, weaponDamage
xi.autows.doAutoRangedWeaponskill = function(attacker, target, wsID, wsParams, tp, primaryMsg, skill, action)
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
    calcParams.hitRate = xi.weaponskills.getRangedHitRate(attacker, target, calcParams.bonusAcc)
    calcParams.skillType = attack.weaponType

    -- Send our params off to calculate our raw WS damage, hits landed, and shadows absorbed
    calcParams = xi.weaponskills.calculateRawWSDmg(attacker, target, wsID, tp, action, wsParams, calcParams)
    local finaldmg = calcParams.finalDmg

    -- Calculate reductions
    finaldmg = target:rangedDmgTaken(finaldmg)
    finaldmg = finaldmg * (1 + target:getMod(xi.mod.PIERCE_SDT) / 10000)

    finaldmg = finaldmg * xi.settings.main.WEAPON_SKILL_POWER -- Add server bonus
    calcParams.finalDmg = finaldmg

    if calcParams.tpHitsLanded + calcParams.extraHitsLanded > 0 then
        finaldmg = xi.weaponskills.takeWeaponskillDamage(target, attacker, wsParams, primaryMsg, attack, calcParams, action)
    else
        skill:setMsg(xi.msg.basic.SKILL_MISS)
    end

    skill:setAttackType(xi.attackType.RANGED)
    skill:setCritical(calcParams.criticalHit)

    return finaldmg, calcParams.criticalHit, calcParams.tpHitsLanded, calcParams.extraHitsLanded, calcParams.shadowsAbsorbed
end
