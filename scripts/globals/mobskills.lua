-----------------------------------
-- Monster TP Moves Global
-- NOTE: A lot of this is good estimating since the FFXI playerbase has not found all of info for individual moves.
-- What is known is that they roughly follow player Weaponskill calculations (pDIF, dMOD, ratio, etc) so this is what
-- this set of functions emulates.
-----------------------------------
require('scripts/globals/combat/magic_hit_rate')
require('scripts/globals/magicburst')
require('scripts/globals/magic')
require('scripts/globals/spells/damage_spell')
-----------------------------------
xi = xi or {}
xi.mobskills = xi.mobskills or {}

xi.mobskills.drainType =
{
    HP = 0,
    MP = 1,
    TP = 2,
}

-- Shadow Behavior (Number of shadows to remove)
xi.mobskills.shadowBehavior =
{
    IGNORE_SHADOWS = 0,
    NUMSHADOWS_1   = 1,
    NUMSHADOWS_2   = 2,
    NUMSHADOWS_3   = 3,
    NUMSHADOWS_4   = 4,
    WIPE_SHADOWS   = 999,
}

xi.mobskills.physicalTpBonus =
{
    NO_EFFECT   = 0,
    ACC_VARIES  = 1, -- Not implemented
    ATK_VARIES  = 2,
    DMG_VARIES  = 3, -- Damage formula incorrect
    CRIT_VARIES = 4, -- Deprecated, pending removal from mob skills
}

xi.mobskills.magicalTpBonus =
{
    NO_EFFECT  = 0,
    MACC_BONUS = 1, -- Not implemented
    MAB_BONUS  = 2, -- Not implemented
    DMG_BONUS  = 3, -- Damage formula incorrect
}

local burstMultipliersByTier =
{
    [0] = 1.0,
    [1] = 1.3,
    [2] = 1.35,
    [3] = 1.40,
    [4] = 1.45,
    [5] = 1.5,
}

local function calculateMobMagicBurst(caster, ele, target)
    local burstMultiplier = 1.0
    local skillchainTier, skillchainCount = xi.magicburst.formMagicBurst(ele, target)

    if skillchainTier > 0 then
        burstMultiplier = burstMultipliersByTier[skillchainCount]
    end

    return burstMultiplier
end

local function MobTakeAoEShadow(mob, target, max)
    -- TODO: Use actual NIN skill, not this function
    if target:getMainJob() == xi.job.NIN and math.random(1, 100) <= 60 then
        max = max - 1
        if max < 1 then
            max = 1
        end
    end

    return math.random(1, max)
end

local function fTP(tp, ftp1, ftp2, ftp3)
    tp = math.max(tp, 1000)

    if tp >= 1000 and tp < 1500 then
        return ftp1 + (((ftp2 - ftp1) / 500) * (tp - 1000))
    elseif tp >= 1500 and tp <= 3000 then
        -- generate a straight line between ftp2 and ftp3 and find point @ tp
        return ftp2 + (((ftp3 - ftp2) / 1500) * (tp - 1500))
    end

    return 1 -- no ftp mod
end

xi.mobskills.mobRangedMove = function(mob, target, skill, numberofhits, accmod, ftp, tpEffect, mtp000, mtp150, mtp300, params)
    -- TODO: Replace this with ranged attack code
    params = params or {}
    params.isRanged = true
    return xi.mobskills.mobPhysicalMove(mob, target, skill, numberofhits, accmod, ftp, tpEffect, mtp000, mtp150, mtp300, params)
end

-- helper function to handle a single hit and check for parrying, guarding, and blocking
local function handleSinglePhysicalHit(mob, target, hitdamage, hitslanded, finaldmg, params)
    -- Determine if this hit is critical
    -- TODO: Remove CRIT_VARIES from existing mob skills and replace with params.canCrit
    local isCritical = false
    if
        params.canCrit or
        params.tpEffect == xi.mobskills.physicalTpBonus.CRIT_VARIES
    then
        local critRate = xi.combat.physical.calculateSwingCriticalRate(mob, target, mob:getTP(), nil)
        isCritical = math.random(1, 1000) <= critRate * 1000
    end

    -- Calculate PDIF with critical flag for this specific hit
    local pDif = 0
    if params.isRanged then
        pDif = xi.combat.physical.calculateRangedPDIF(mob, target, params.weaponType, params.attMod, isCritical, params.applyLevelCorrection, false, 0, false, 0)
    else
        pDif = xi.combat.physical.calculateMeleePDIF(mob, target, params.weaponType, params.attMod, isCritical, params.applyLevelCorrection, false, 0, false, xi.slot.MAIN, params.isCannonball)
    end

    hitdamage = hitdamage * pDif

    -- if a ranged physical mobskill then cannot be parried or guarded
    if
        params.isRanged or
        (not xi.combat.physical.isParried(target, mob) and
        not xi.combat.physical.isGuarded(target, mob))
    then
        -- also handle blocking
        local isBlockedWithShieldMastery = false
        if xi.combat.physical.isBlocked(target, mob) then
            hitdamage = hitdamage - xi.combat.physical.getDamageReductionForBlock(target, mob, hitdamage)

            if target:hasTrait(xi.trait.SHIELD_MASTERY) then
                isBlockedWithShieldMastery = true
            end
        end

        if hitdamage > 0 and not isBlockedWithShieldMastery then
            target:tryHitInterrupt(mob)
        end

        -- update the hitslanded and finaldmg
        hitslanded = hitslanded + 1
        finaldmg = finaldmg + hitdamage
    end

    return hitslanded, finaldmg, isCritical
end

-----------------------------------
-- Mob Physical Abilities
-- accMod     : linear multiplier for accuracy (1 default)
-- ftp        : linear multiplier for damage (1 default)
-- tpEffect   : Defined in xi.mobskills.physicalTpBonus
-- params     : optional table for additional parameters { canCrit = true, isCannonball = true, isRanged = true }
-----------------------------------
xi.mobskills.mobPhysicalMove = function(mob, target, skill, numHits, accMod, ftp, tpEffect, mtp000, mtp150, mtp300, params)
    local returninfo = {}
    params           = params or {}

    -- mobs use fSTR (but with special calculation in the called function)
    local fSTR = xi.combat.physical.calculateMeleeStatFactor(mob, target)
    if params.isRanged then
        fSTR = xi.combat.physical.calculateRangedStatFactor(mob, target)
    end

    local targetEvasion = target:getEVA() + target:getMod(xi.mod.SPECIAL_ATTACK_EVASION)

    if
        target:hasStatusEffect(xi.effect.YONIN) and
        mob:isFacing(target, 23)
    then
        -- Yonin evasion boost if mob is facing target
        targetEvasion = targetEvasion + target:getStatusEffect(xi.effect.YONIN):getPower()
    end

    local lvldiff = math.max(0, mob:getMainLvl() - target:getMainLvl())

    --work out hit rate for mobs
    local hitrate = ((mob:getACC() * accMod) - targetEvasion) / 2 + (lvldiff * 2) + 75

    hitrate = utils.clamp(hitrate, 20, 95)

    --work out the base damage for a single hit
    local hitdamage = math.max(1, mob:getWeaponDmg() + fSTR) * ftp

    -- TODO: Remove this and use a scalable function for a single FTP value
    if tpEffect == xi.mobskills.physicalTpBonus.DMG_VARIES then
        hitdamage = hitdamage * fTP(skill:getTP(), mtp000, mtp150, mtp300)
    end

    local attMod = 1

    if tpEffect == xi.mobskills.physicalTpBonus.ATK_VARIES then
        attMod = fTP(skill:getTP(), mtp000, mtp150, mtp300)
    end

    -- Get base hit damage calculation setup
    local applyLevelCorrection = xi.data.levelCorrection.isLevelCorrectedZone(mob)
    local canCrit              = params.canCrit or false
    local isCannonball         = params.isCannonball or false
    local isRanged             = params.isRanged or false
    local hitParams            =
    {
        canCrit = canCrit,
        tpEffect = tpEffect,
        weaponType = xi.skill.NONE, -- use NONE for mobs
        attMod = attMod,
        applyLevelCorrection = applyLevelCorrection,
        isCannonball = isCannonball,
        isRanged = isRanged,
    }

    -- start the hits
    local finaldmg   = 0
    local hitsdone   = 1
    local hitslanded = 0
    local hitCrit    = false

    -- first hit has a higher chance to land
    local firstHitChance = hitrate * 1.5

    if params.isRanged then
        firstHitChance = hitrate * 1.2
    end

    firstHitChance = utils.clamp(firstHitChance, 35, 95)

    if (math.random(1, 100)) <= firstHitChance then
        local isCritical = false
        -- use helper function check for parry guard and blocking and handle the hit
        hitslanded, finaldmg, isCritical = handleSinglePhysicalHit(mob, target, hitdamage, hitslanded, finaldmg, hitParams)

        hitCrit = isCritical or hitCrit -- set crit flag, might be used in WS messaging
    end

    while hitsdone < numHits do
        local isCritical = false
        if (math.random(1, 100)) <= hitrate then --it hit
            hitslanded, finaldmg, isCritical = handleSinglePhysicalHit(mob, target, hitdamage, hitslanded, finaldmg, hitParams)
        end

        hitCrit = isCritical or hitCrit -- set crit flag, might be used in WS messaging
        hitsdone = hitsdone + 1
    end

    -- if an attack landed it must do at least 1 damage
    if hitslanded >= 1 and finaldmg < 1 then
        finaldmg = 1
    end

    -- all hits missed
    if hitslanded == 0 or finaldmg == 0 then
        finaldmg   = 0
        hitslanded = 0
        skill:setMsg(xi.msg.basic.SKILL_MISS)
    -- calculate tp return of mob skill and add if hit primary target
    elseif skill:getPrimaryTargetID() == target:getID() then
        local tpReturn = xi.combat.tp.getSingleMeleeHitTPReturn(mob, target)
        tpReturn = tpReturn + 10 * (hitslanded - 1) -- extra hits give 10 TP each
        mob:addTP(tpReturn)
    end

    returninfo.dmg        = finaldmg
    returninfo.hitslanded = hitslanded
    returninfo.isCritical = hitCrit

    return returninfo
end

-- MAGICAL MOVE
-- Call this on every magical move!
-- mob/target/skill should be passed from onMobWeaponSkill.
-- dmg is the base damage (V value), accmod is a multiplier for accuracy (1 default, more than 1 = higher macc for mob),
-- ditto for dmg mod but more damage >1 (equivalent of M value)
-- tpeffect is an enum from one of:
-- 0 = xi.mobskills.magicalTpBonus.NO_EFFECT
-- 1 = xi.mobskills.magicalTpBonus.MACC_BONUS
-- 2 = xi.mobskills.magicalTpBonus.MAB_BONUS
-- 3 = xi.mobskills.magicalTpBonus.DMG_BONUS
-- tpvalue affects the strength of having more TP along the following lines:
-- xi.mobskills.magicalTpBonus.NO_EFFECT -> tpvalue has no xi.effect.
-- xi.mobskills.magicalTpBonus.MACC_BONUS -> direct multiplier to macc (1 for default)
-- xi.mobskills.magicalTpBonus.MAB_BONUS -> direct multiplier to mab (1 for default)
-- xi.mobskills.magicalTpBonus.DMG_BONUS -> direct multiplier to damage (V+dINT) (1 for default)
--Examples:
-- xi.mobskills.magicalTpBonus.DMG_BONUS and TP = 100, tpvalue = 1, assume V=150  --> damage is now 150*(TP*1) / 100 = 150
-- xi.mobskills.magicalTpBonus.DMG_BONUS and TP = 200, tpvalue = 1, assume V=150  --> damage is now 150*(TP*1) / 100 = 300
-- xi.mobskills.magicalTpBonus.DMG_BONUS and TP = 100, tpvalue = 2, assume V=150  --> damage is now 150*(TP*2) / 100 = 300
-- xi.mobskills.magicalTpBonus.DMG_BONUS and TP = 200, tpvalue = 2, assume V=150  --> damage is now 150*(TP*2) / 100 = 600

xi.mobskills.mobMagicalMove = function(actor, target, action, baseDamage, actionElement, damageModifier, tpEffect, tpMultiplier)
    local finalDamage = baseDamage

    -- Base damage
    if tpEffect == xi.mobskills.magicalTpBonus.DMG_BONUS then
        finalDamage = math.floor(finalDamage * action:getTP() * tpMultiplier / 1000)
    end

    -- Get bonus macc.
    local petAccBonus = 0
    if actor:isPet() and actor:getMaster() ~= nil then
        local master = actor:getMaster()
        if actor:isAvatar() then
            petAccBonus = utils.clamp(master:getSkillLevel(xi.skill.SUMMONING_MAGIC) - master:getMaxSkillLevel(actor:getMainLvl(), xi.job.SMN, xi.skill.SUMMONING_MAGIC), 0, 200)
        end

        local skillchainTier, _ = xi.magicburst.formMagicBurst(actionElement, target)
        if
            actor:getPetID() > 0 and
            skillchainTier > 0
        then
            petAccBonus = petAccBonus + 25
        end
    end

    -- Multipliers.
    local sdt            = xi.spells.damage.calculateSDT(target, actionElement)
    local resistRate     = xi.combat.magicHitRate.calculateResistRate(actor, target, 0, 0, 0, actionElement, xi.mod.INT, 0, petAccBonus)
    local dayAndWeather  = xi.spells.damage.calculateDayAndWeather(actor, actionElement, false)
    local magicBonusDiff = xi.spells.damage.calculateMagicBonusDiff(actor, target, 0, 0, actionElement)

    -- Calculate final damage.
    finalDamage = math.floor(finalDamage * sdt)
    finalDamage = math.floor(finalDamage * resistRate)
    finalDamage = math.floor(finalDamage * dayAndWeather)
    finalDamage = math.floor(finalDamage * magicBonusDiff)
    finalDamage = math.floor(finalDamage * damageModifier)

    -- magical mob skills are single hit so provide single Melee hit TP return if primary target
    -- TODO: This should probably be moved to AFTER all damage is calculated, since this is not the final step.
    if finalDamage > 0 and action:getPrimaryTargetID() == target:getID() then
        local tpReturn = xi.combat.tp.getSingleMeleeHitTPReturn(actor, target)
        actor:addTP(tpReturn)
    end

    return finalDamage
end

xi.mobskills.mobAddBonuses = function(actor, target, damage, element, skill) -- used for SMN magical bloodpacts, despite the name.
    local burst = calculateMobMagicBurst(actor, element, target)

    if
        skill and
        burst > 1 and
        actor:getPetID() > 0 -- all pets except charmed pets can get magic burst message, but only with petskill action
    then
        skill:setMsg(xi.msg.basic.JA_MAGIC_BURST)
    end

    damage = math.floor(damage * burst)

    return damage
end

-----------------------------------
-- Documentation: xi.mobskills.mobBreathMove
-- skillParams.percentMultipier  = #             : % Multiplier on mob's current HP. Damage = mobCurrentHP * percentMultipier
-- skillParams.element           = element enum  : Element of breath attack. Default: 1
-- skillParams.damageCap         = #             : Maximum damage this attack can do. Default: mob:getHP() / 5
-- skillParams.bonusDamage       = #             : Flat damage added after multipliers.
-- skillParams.mAccuracyBonus    = { #, #, # }   : Accuracy bonus or penalties based on fTP.
-- skillParams.resistStat        = xi.mod.<Stat> : Determines which base stat attribute is used when calculating resist. (INT, MND, etc.)
-----------------------------------
xi.mobskills.mobBreathMove = function(mob, target, skill, skillParams)
    local mobCurrentHP = skill:getMobHP()

    local percentMultipier     = skillParams.percentMultipier or 0.10
    local actionElement        = skillParams.element or 0
    local breathSkillDamageCap = skillParams.damageCap or math.floor(mobCurrentHP / 5)
    local bonusDamage          = skillParams.bonusDamage or 0
    local mAccuracyBonusfTP    = skillParams.mAccuracyBonus or { 0, 0, 0 }
    local resistStat           = skillParams.resistStat or xi.mod.INT
    -- TODO: Critical Hit Param? See Magma Fan mobskill.

    local damage = mobCurrentHP * percentMultipier + bonusDamage

    -- Clamp minimum damage based on current hp.
    if damage < 1 then
        damage = 1
    end

    -- Flat MACC bonus/penalty based on fTP scale
    local mAccuracyBonus = 0
    mAccuracyBonus = xi.combat.physical.calculateTPfactor(skill:getTP(), mAccuracyBonusfTP)

    local systemBonus     = 1 + utils.getEcosystemStrengthBonus(mob:getEcosystem(), target:getEcosystem()) / 4
    local elementalSDT    = xi.spells.damage.calculateSDT(target, actionElement)
    local resistRate      = xi.combat.magicHitRate.calculateResistRate(mob, target, 0, 0, xi.skillRank.A_PLUS, actionElement, resistStat, 0, mAccuracyBonus)
    local dayAndWeather   = xi.spells.damage.calculateDayAndWeather(mob, actionElement, false)
    local absorbOrNullify = xi.spells.damage.calculateNukeAbsorbOrNullify(target, actionElement)

    damage = math.floor(damage * systemBonus)
    damage = math.floor(damage * elementalSDT)
    damage = math.floor(damage * resistRate)
    damage = math.floor(damage * dayAndWeather)
    damage = utils.clamp(damage, 0, breathSkillDamageCap)
    damage = math.floor(damage * absorbOrNullify)

    if absorbOrNullify < 0 then -- Return early since the rest of the calculations are not needed if we absorbed/nullified.
        return damage
    end

    -- The values set for this modifiers are base 10000.
    -- -2500 in item_mods.sql means -25% damage recived.
    -- 2500 would mean 25% ADDITIONAL damage taken.
    -- The effects of the "Shell" spells are also included in this step. The effect also aplies a negative value.
    local globalDamageTaken   = target:getMod(xi.mod.DMG) / 10000                               -- Mod is base 10000
    local breathDamageTaken   = target:getMod(xi.mod.DMGBREATH) / 10000                         -- Mod is base 10000
    local uBreathDamageTaken  = target:getMod(xi.mod.UDMGBREATH) / 10000                        -- Mod is base 10000
    local combinedDamageTaken = utils.clamp(breathDamageTaken + globalDamageTaken, -0.5, 0.5)   -- The combination of regular "Damage Taken" and "Breath Damage Taken" caps at 50%. There is no BDTII known as of yet.
    combinedDamageTaken       = utils.clamp(1 + combinedDamageTaken + uBreathDamageTaken, 0, 2) -- Uncapped breath damage modifier. Cap is 100% both ways.

    -- Apply "Damage taken" mods to damage.
    damage = math.floor(damage * combinedDamageTaken)

    return damage
end

xi.mobskills.mobFinalAdjustments = function(damage, mob, skill, target, attackType, damageType, shadowsToRemove, hitsLanded)
    if hitsLanded == nil then
        hitsLanded = 0
    end

    -- If target has Hysteria, no message skip rest
    -- TODO: Need to also handle in core to interrupt the mobskill. Proper behavior is: Mob will attempt to use a skill but it will not fire off.
    if mob:hasStatusEffect(xi.effect.HYSTERIA) then
        skill:setMsg(xi.msg.basic.NONE)
        return 0
    end

    -- Physical attack missed, skip rest.
    if skill:hasMissMsg() then
        return 0
    end

    -- Handle Perfect Dodge
    if
        (target:hasStatusEffect(xi.effect.PERFECT_DODGE) or
        target:hasStatusEffect(xi.effect.ALL_MISS)) and
        attackType == xi.attackType.PHYSICAL
    then
        skill:setMsg(xi.msg.basic.SKILL_MISS)
        return 0
    end

    -- TODO: SAM Yaegasumi ability.

    -- TODO: Messaging for missed skill attacks (Mobskills that replace a mob's auto attacks).

    -- Set message to damage
    -- This is for AoE because its only set once
    if mob:getCurrentAction() == xi.action.PET_MOBABILITY_FINISH then
        if skill:getMsg() ~= xi.msg.basic.JA_MAGIC_BURST then
            skill:setMsg(xi.msg.basic.USES_JA_TAKE_DAMAGE)
        end
    -- TODO: Move messaging from mobskill script to here.
    else
        skill:setMsg(xi.msg.basic.DAMAGE)
    end

    -- Handle shadows depending on shadow behavior / attackType
    if
        shadowsToRemove ~= xi.mobskills.shadowBehavior.WIPE_SHADOWS and
        shadowsToRemove ~= xi.mobskills.shadowBehavior.IGNORE_SHADOWS
    then
        -- Handle Utsusemi preservation mechanic to reduce shadow consumption.
        -- This is usually for AOE physical attacks(AOE Magic usually wipes shadows).
        if
            skill:isAoE() or
            skill:isConal()
        then
            shadowsToRemove = MobTakeAoEShadow(mob, target, shadowsToRemove)
        end

        -- Remove shadows
        damage = utils.takeShadows(target, damage, shadowsToRemove)

        -- Dealt zero damage, so shadows took all hits.
        if damage == 0 then
            skill:setMsg(xi.msg.basic.SHADOW_ABSORB)

            return shadowsToRemove
        end

    elseif shadowsToRemove == xi.mobskills.shadowBehavior.WIPE_SHADOWS then -- Remove all shadows
        target:delStatusEffect(xi.effect.COPY_IMAGE)
        target:delStatusEffect(xi.effect.BLINK)
        target:delStatusEffect(xi.effect.THIRD_EYE)
    end

    if
        attackType == xi.attackType.PHYSICAL or
        attackType == xi.attackType.RANGED
    then
        if not skill:isSingle() then -- Remove Third Eye. Third eye does not block AOE attacks.
            target:delStatusEffect(xi.effect.THIRD_EYE)
        end

        -- Handle Third Eye using shadowbehav as a guide.
        if utils.thirdeye(target) then
            skill:setMsg(xi.msg.basic.ANTICIPATE)

            return 0
        end
    end

    -- Handle Automaton Analyzer which decreases damage from successive special attacks
    xi.mobskills.handleAutomatonAutoAnalyzer(damage, skill, target)

    if attackType == xi.attackType.PHYSICAL then
        damage = target:physicalDmgTaken(damage, damageType)
    elseif attackType == xi.attackType.MAGICAL then
        local element = utils.clamp(damageType - 5, xi.element.NONE, xi.element.DARK) -- Transform damage type to element
        damage = math.floor(damage * xi.spells.damage.calculateTMDA(target, element))
        damage = math.floor(damage * xi.spells.damage.calculateNukeAbsorbOrNullify(target, element))
        damage = math.floor(target:handleSevereDamage(damage, false))
    elseif attackType == xi.attackType.BREATH then
        -- Handle absorb messaging
        if damage < 0 then
            -- TODO: Handle Curse II HP/MP Nullification.
            damage = target:addHP(-damage)
            skill:setMsg(xi.msg.basic.SKILL_RECOVERS_HP)

            return damage
        end

        damage = math.floor(target:handleSevereDamage(damage, false))
        damage = math.floor(target:checkDamageCap(damage))
    elseif attackType == xi.attackType.RANGED then
        damage = target:rangedDmgTaken(damage)
    end

    if damage < 0 then
        return damage
    end

    -- Handle Phalanx
    if damage > 0 then
        damage = utils.clamp(damage - target:getMod(xi.mod.PHALANX), 0, 99999)
    end

    if attackType == xi.attackType.MAGICAL then
        damage = utils.oneforall(target, damage)

        if damage < 0 then
            return 0
        end
    end

    damage = utils.stoneskin(target, damage)

    if damage > 0 then
        target:updateEnmityFromDamage(mob, damage)
        target:handleAfflatusMiseryDamage(damage)
    end

    -- Calculate TP return of the mob skill.
    xi.mobskills.calculateSkillTPReturn(damage, mob, skill, target, attackType, hitsLanded)

    return damage
end

xi.mobskills.handleAutomatonAutoAnalyzer = function(damage, skill, target)
    -- TODO: Should this reside in a more universal place for use in other places?
    -- Handle Automaton Analyzer which decreases damage from successive special attacks
    if target:getMod(xi.mod.AUTO_ANALYZER) > 0 then
        local analyzerSkill = target:getLocalVar('analyzer_skill')
        local analyzerHits = target:getLocalVar('analyzer_hits')
        if
            analyzerSkill == skill:getID() and
            target:getMod(xi.mod.AUTO_ANALYZER) > analyzerHits
        then
            -- Successfully mitigating damage at a fixed 40%
            damage = damage * 0.6
            analyzerHits = analyzerHits + 1
        else
            target:setLocalVar('analyzer_skill', skill:getID())
            analyzerHits = 0
        end

        target:setLocalVar('analyzer_hits', analyzerHits)
    end
end

xi.mobskills.calculateSkillTPReturn = function(damage, mob, skill, target, attackType, hitsLanded)
        -- Calculate TP return of the mob skill.
    if
        hitsLanded > 0 and
        damage > 0
    then
        local mobTPReturn    = 0
        local targetTPReturn = 0

        if attackType == xi.attackType.BREATH then
            mobTPReturn    = xi.combat.tp.getSingleMeleeHitTPReturn(mob, target)
            targetTPReturn = xi.combat.tp.calculateTPGainOnPhysicalDamage(damage, mob:getBaseDelay(), mob, target)
            -- TODO: Add TP return for MAGICAL, PHYSICAL, RANGED once added in future PRs.
        end

        -- Handle additional hit TP return for mob.
        mobTPReturn = mobTPReturn + 10 * (hitsLanded - 1) -- Extra hits give 10 TP each

        -- Mob gains TP if skill hit the primary target.
        if skill:getPrimaryTargetID() == target:getID() then
            mob:addTP(mobTPReturn)
        end

        -- Targets hit gain TP
        target:addTP(targetTPReturn)

        -- TODO: SAVETP Mod
    end
end

xi.mobskills.hasMissMessage = function(mob, target, skill, damage)
    local missMessages =
    {
        xi.msg.basic.EVADES,
        xi.msg.basic.HIT_MISS,
        xi.msg.basic.JA_MISS,
        xi.msg.basic.JA_MISS_2,
        xi.msg.basic.SKILL_MISS,
        xi.msg.basic.RANGED_ATTACK_MISS,
        xi.msg.basic.SHADOW_ABSORB,
        xi.msg.basic.ANTICIPATE,
        xi.msg.basic.SKILL_RECOVERS_HP
    }

    local skillMsg = skill:getMsg()

    -- The attack was a miss, shadow absorbed, or anticipated.
    for _, msg in ipairs(missMessages) do
        if skillMsg == msg then

            return true
        end
    end

    return false
end

-- returns true if mob attack hit
-- used to stop tp move status effects
xi.mobskills.mobPhysicalHit = function(skill)
    -- if message is not the default. Then there was a miss, shadow taken etc
    return skill:hasMissMsg() == false
end

xi.mobskills.mobDrainMove = function(mob, target, drainType, drain, attackType, damageType)
    if not target:isUndead() then
        if drainType == xi.mobskills.drainType.MP then
            drain = math.min(drain, target:getMP())

            target:delMP(drain)
            mob:addMP(drain)

            return xi.msg.basic.SKILL_DRAIN_MP
        elseif drainType == xi.mobskills.drainType.TP then
            drain = math.min(drain, target:getTP())

            target:delTP(drain)
            mob:addTP(drain)

            return xi.msg.basic.SKILL_DRAIN_TP
        elseif drainType == xi.mobskills.drainType.HP then
            drain = math.min(drain, target:getHP())

            target:takeDamage(drain, mob, attackType, damageType)
            mob:addHP(drain)

            return xi.msg.basic.SKILL_DRAIN_HP
        end
    else
        drain = math.min(drain, target:getHP())

        target:takeDamage(drain, mob, attackType, damageType)
        return xi.msg.basic.DAMAGE
    end

    return xi.msg.basic.SKILL_NO_EFFECT
end

xi.mobskills.mobPhysicalDrainMove = function(mob, target, skill, drainType, drain)
    -- If target has Hysteria, no message skip rest
    if mob:hasStatusEffect(xi.effect.HYSTERIA) then
        return xi.msg.basic.NONE
    end

    if xi.mobskills.mobPhysicalHit(skill) then
        return xi.mobskills.mobDrainMove(mob, target, drainType, drain)
    end

    return xi.msg.basic.SKILL_MISS
end

local drainEffectCorrelation =
{
    [xi.effect.STR_DOWN] = xi.effect.STR_BOOST,
    [xi.effect.DEX_DOWN] = xi.effect.DEX_BOOST,
    [xi.effect.AGI_DOWN] = xi.effect.AGI_BOOST,
    [xi.effect.VIT_DOWN] = xi.effect.VIT_BOOST,
    [xi.effect.MND_DOWN] = xi.effect.MND_BOOST,
    [xi.effect.INT_DOWN] = xi.effect.INT_BOOST,
    [xi.effect.CHR_DOWN] = xi.effect.CHR_BOOST,
}

xi.mobskills.mobDrainAttribute = function(mob, target, typeEffect, power, tick, duration)
    if not drainEffectCorrelation[typeEffect] then
        return xi.msg.basic.SKILL_NO_EFFECT
    end

    local results = xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, power, tick, duration)

    if results == xi.msg.basic.SKILL_ENFEEB_IS then
        mob:addStatusEffect(drainEffectCorrelation[typeEffect], power, tick, duration)

        return xi.msg.basic.ATTR_DRAINED
    end

    return xi.msg.basic.SKILL_MISS
end

xi.mobskills.mobDrainStatusEffectMove = function(mob, target)
    -- If target has Hysteria, no message skip rest
    if mob:hasStatusEffect(xi.effect.HYSTERIA) then
        return xi.msg.basic.NONE
    end

    -- try to drain buff
    local effect = mob:stealStatusEffect(target)

    if effect ~= 0 then
        return xi.msg.basic.EFFECT_DRAINED
    end

    return xi.msg.basic.SKILL_NO_EFFECT
end

-- Adds a status effect to a target
xi.mobskills.mobStatusEffectMove = function(mob, target, typeEffect, power, tick, duration, subType, subPower, tier)
    if target:canGainStatusEffect(typeEffect, power) then
        local fullResist = xi.data.statusEffect.isTargetResistant(mob, target, typeEffect)
        if fullResist then
            return xi.msg.basic.SKILL_MISS -- resist !
        end

        local element    = mob:getStatusEffectElement(typeEffect) -- TODO: Do something.
        local resistRate = xi.combat.magicHitRate.calculateResistRate(mob, target, 0, 0, 0, element, xi.mod.INT, typeEffect, 0)
        if resistRate >= 0.25 then
            local totalDuration = math.floor(duration * resistRate)
            target:addStatusEffect(typeEffect, power, tick, totalDuration, subType, subPower, tier)

            return xi.msg.basic.SKILL_ENFEEB_IS
        end

        return xi.msg.basic.SKILL_MISS -- resist !
    end

    return xi.msg.basic.SKILL_NO_EFFECT -- no effect
end

-- similar to status effect move except, this will not land if the attack missed
xi.mobskills.mobPhysicalStatusEffectMove = function(mob, target, skill, typeEffect, power, tick, duration)
    if xi.mobskills.mobPhysicalHit(skill) then
        return xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, power, tick, duration)
    end

    return xi.msg.basic.SKILL_MISS
end

-- similar to statuseffect move except it will only take effect if facing
xi.mobskills.mobGazeMove = function(mob, target, typeEffect, power, tick, duration)
    if
        target:isFacing(mob) and
        mob:isInfront(target)
    then
        return xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, power, tick, duration)
    end

    return xi.msg.basic.SKILL_NO_EFFECT
end

xi.mobskills.mobBuffMove = function(mob, typeEffect, power, tick, duration, subType, subPower)
    if mob:addStatusEffect(typeEffect, power, tick, duration, subType, subPower) then
        return xi.msg.basic.SKILL_GAIN_EFFECT
    end

    return xi.msg.basic.SKILL_NO_EFFECT
end

xi.mobskills.mobHealMove = function(target, healAmount)
    healAmount = math.min(healAmount, target:getMaxHP() - target:getHP())

    target:wakeUp()
    target:addHP(healAmount)

    return healAmount
end

xi.mobskills.calculateDuration = function(tp, minimum, maximum)
    if tp <= 1000 then
        return minimum
    end

    return minimum + (maximum - minimum) * (tp - 1000) / 1000
end
