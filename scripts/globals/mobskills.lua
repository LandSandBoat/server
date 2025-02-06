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
require('scripts/globals/utils')
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
    ATK_VARIES  = 2, -- Not implemented
    DMG_VARIES  = 3, -- Damage formula incorrect
    CRIT_VARIES = 4, -- Not implemented
    RANGED      = 5, -- Needs varification
}

xi.mobskills.magicalTpBonus =
{
    NO_EFFECT   = 0,
    MACC_BONUS  = 1, -- Not implemented
    MAB_BONUS   = 2, -- Not implemented
    DMG_BONUS   = 3, -- Damage formula incorrect
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

xi.mobskills.mobRangedMove = function(mob, target, skill, numberofhits, accmod, ftp, tpeffect)
    -- TODO: Replace this with ranged attack code
    return xi.mobskills.mobPhysicalMove(mob, target, skill, numberofhits, accmod, ftp, xi.mobskills.physicalTpBonus.RANGED)
end

-- helper function to handle a single hit and check for parrying, guarding, and blocking
local function handleSinglePhysicalHit(mob, target, hitdamage, hitslanded, finaldmg, tpEffect)
    -- if a non-ranged physical mobskill then can parry or guard
    if
        tpEffect == xi.mobskills.physicalTpBonus.RANGED or
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

    return hitslanded, finaldmg
end

-----------------------------------
-- Mob Physical Abilities
-- accMod   : linear multiplier for accuracy (1 default)
-- ftp   : linear multiplier for damage (1 default)
-- tpEffect : Defined in xi.mobskills.physicalTpBonus
-----------------------------------
xi.mobskills.mobPhysicalMove = function(mob, target, skill, numHits, accMod, ftp, tpEffect, mtp000, mtp150, mtp300, isCannonball)
    local returninfo    = {}

    -- mobs use fSTR (but with special calculation in the called function)
    local fSTR = xi.combat.physical.calculateMeleeStatFactor(mob, target)
    if tpEffect == xi.mobskills.physicalTpBonus.RANGED then
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

    local applyLevelCorrection = xi.combat.levelCorrection.isLevelCorrectedZone(mob)
    local weaponType           = xi.skill.NONE -- use NONE for mobs
    local attMod               = 1             -- TODO: implement attack boosts for mobskills
    local canCrit              = false         -- TODO: implement which skills can crit
    local isCannonball         = isCannonball or false
    local pDif                 = xi.combat.physical.calculateMeleePDIF(mob, target, weaponType, attMod, canCrit, applyLevelCorrection, false, 0, false, xi.slot.MAIN, isCannonball)

    hitdamage = hitdamage * pDif

    -- start the hits
    local finaldmg   = 0
    local hitsdone   = 1
    local hitslanded = 0

    -- first hit has a higher chance to land
    local firstHitChance = hitrate * 1.5

    if tpEffect == xi.mobskills.physicalTpBonus.RANGED then
        firstHitChance = hitrate * 1.2
    end

    firstHitChance = utils.clamp(firstHitChance, 35, 95)

    if (math.random(1, 100)) <= firstHitChance then
        -- use helper function check for parry guard and blocking and handle the hit
        hitslanded, finaldmg = handleSinglePhysicalHit(mob, target, hitdamage, hitslanded, finaldmg, tpEffect)
    end

    while hitsdone < numHits do
        if (math.random(1, 100)) <= hitrate then --it hit
            hitslanded, finaldmg = handleSinglePhysicalHit(mob, target, hitdamage, hitslanded, finaldmg, tpEffect)
        end

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
    local sdt                         = xi.spells.damage.calculateSDT(target, actionElement)
    local resist                      = xi.mobskills.applyPlayerResistance(actor, nil, target, actor:getStat(xi.mod.INT) - target:getStat(xi.mod.INT), petAccBonus, actionElement)
    local dayAndWeather               = xi.spells.damage.calculateDayAndWeather(actor, 0, actionElement)
    local magicBonusDiff              = xi.spells.damage.calculateMagicBonusDiff(actor, target, 0, 0, actionElement)
    local targetMagicDamageAdjustment = xi.spells.damage.calculateTMDA(target, actionElement)

    -- Calculate final damage.
    finalDamage = math.floor(finalDamage * sdt)
    finalDamage = math.floor(finalDamage * resist)
    finalDamage = math.floor(finalDamage * dayAndWeather)
    finalDamage = math.floor(finalDamage * magicBonusDiff)
    finalDamage = math.floor(finalDamage * targetMagicDamageAdjustment)
    finalDamage = math.floor(finalDamage * damageModifier)

    -- magical mob skills are single hit so provide single Melee hit TP return if primary target
    -- TODO: This should probably be moved to AFTER all damage is calculated, since this is not the final step.
    if finalDamage > 0 and action:getPrimaryTargetID() == target:getID() then
        local tpReturn = xi.combat.tp.getSingleMeleeHitTPReturn(actor, target)
        actor:addTP(tpReturn)
    end

    return finalDamage
end

-- effect = xi.effect.WHATEVER if enfeeble
-- statmod = the stat to account for resist (INT, MND, etc) e.g. xi.mod.INT
-- This determines how much the monsters ability resists on the player.
xi.mobskills.applyPlayerResistance = function(actor, effectId, target, diff, bonusMacc, element)
    if not bonusMacc then
        bonusMacc = 0
    end

    if diff > 10 then
        bonusMacc = bonusMacc + 10 + (diff - 10) / 2
    else
        bonusMacc = bonusMacc + diff
    end

    return xi.combat.magicHitRate.calculateResistRate(actor, target, 0, xi.skill.NONE, 0, element, 0, effectId, bonusMacc)
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

-- Calculates breath damage
-- mob is a mob reference to get hp and lvl
-- percent is the percentage to take from HP
-- base is calculated from main level to create a minimum
-- Equation: (HP * percent) + (LVL / base)
-- cap is optional, defines a maximum damage
xi.mobskills.mobBreathMove = function(mob, target, skill, percent, base, element, cap)
    local damage = (mob:getHP() * percent) + (mob:getMainLvl() / base)

    if not cap then
        -- cap max damage
        cap = math.floor(mob:getHP() / 5)
    end

    -- Deal bonus damage vs mob ecosystem
    local systemBonus = utils.getEcosystemStrengthBonus(mob:getEcosystem(), target:getEcosystem())
    damage = damage + damage * (systemBonus * 0.25)

    -- elemental resistence
    if element and element > 0 then
        -- no skill available, pass nil
        local resist  = xi.mobskills.applyPlayerResistance(mob, nil, target, mob:getStat(xi.mod.INT)-target:getStat(xi.mod.INT), 0, element)
        local defense = xi.spells.damage.calculateSDT(target, element)

        damage = damage * resist * defense
    end

    damage = utils.clamp(damage, 1, cap)

    local liement = target:checkLiementAbsorb(xi.damageType.ELEMENTAL + element) -- check for Liement.
    if liement < 0 then -- skip BDT/DT etc for Liement if we absorb.
        return math.floor(damage * liement)
    end

    -- The values set for this modifiers are base 10000.
    -- -2500 in item_mods.sql means -25% damage recived.
    -- 2500 would mean 25% ADDITIONAL damage taken.
    -- The effects of the "Shell" spells are also included in this step. The effect also aplies a negative value.

    local globalDamageTaken   = target:getMod(xi.mod.DMG) / 10000          -- Mod is base 10000
    local breathDamageTaken   = target:getMod(xi.mod.DMGBREATH) / 10000    -- Mod is base 10000
    local combinedDamageTaken = 1.0 + utils.clamp(breathDamageTaken + globalDamageTaken, -0.5, 0.5) -- The combination of regular "Damage Taken" and "Breath Damage Taken" caps at 50%. There is no BDTII known as of yet.

    damage = math.floor(damage * combinedDamageTaken)

    -- Handle Phalanx
    if damage > 0 then
        damage = utils.clamp(damage - target:getMod(xi.mod.PHALANX), 0, 99999)
    end

    -- Handle Stoneskin
    if damage > 0 then
        damage = utils.clamp(utils.stoneskin(target, damage), -99999, 99999)
    end

    -- breath mob skills are single hit so provide single Melee hit TP return if primary target
    if damage > 0 and skill:getPrimaryTargetID() == target:getID() then
        local tpReturn = xi.combat.tp.getSingleMeleeHitTPReturn(mob, target)
        mob:addTP(tpReturn)
    end

    return damage
end

xi.mobskills.mobFinalAdjustments = function(dmg, mob, skill, target, attackType, damageType, shadowbehav)
    -- If target has Hysteria, no message skip rest
    if mob:hasStatusEffect(xi.effect.HYSTERIA) then
        skill:setMsg(xi.msg.basic.NONE)
        return 0
    end

    -- physical attack missed, skip rest
    if skill:hasMissMsg() then
        return 0
    end

    --handle pd
    if
        (target:hasStatusEffect(xi.effect.PERFECT_DODGE) or
        target:hasStatusEffect(xi.effect.ALL_MISS)) and
        attackType == xi.attackType.PHYSICAL
    then
        skill:setMsg(xi.msg.basic.SKILL_MISS)
        return 0
    end

    -- set message to damage
    -- this is for AoE because its only set once
    if mob:getCurrentAction() == xi.action.PET_MOBABILITY_FINISH then
        if skill:getMsg() ~= xi.msg.basic.JA_MAGIC_BURST then
            skill:setMsg(xi.msg.basic.USES_JA_TAKE_DAMAGE)
        end
    else
        skill:setMsg(xi.msg.basic.DAMAGE)
    end

    --Handle shadows depending on shadow behavior / attackType
    if
        shadowbehav ~= xi.mobskills.shadowBehavior.WIPE_SHADOWS and
        shadowbehav ~= xi.mobskills.shadowBehavior.IGNORE_SHADOWS
    then --remove 'shadowbehav' shadows.

        if skill:isAoE() or skill:isConal() then
            shadowbehav = MobTakeAoEShadow(mob, target, shadowbehav)
        end

        dmg = utils.takeShadows(target, dmg, shadowbehav)

        -- dealt zero damage, so shadows took hit
        if dmg == 0 then
            skill:setMsg(xi.msg.basic.SHADOW_ABSORB)
            return shadowbehav
        end

    elseif shadowbehav == xi.mobskills.shadowBehavior.WIPE_SHADOWS then --take em all!
        target:delStatusEffect(xi.effect.COPY_IMAGE)
        target:delStatusEffect(xi.effect.BLINK)
        target:delStatusEffect(xi.effect.THIRD_EYE)
    end

    if
        attackType == xi.attackType.PHYSICAL or
        attackType == xi.attackType.RANGED
    then
        if not skill:isSingle() then
            target:delStatusEffect(xi.effect.THIRD_EYE)
        end

        -- Handle Third Eye using shadowbehav as a guide.
        if utils.thirdeye(target) then
            skill:setMsg(xi.msg.basic.ANTICIPATE)

            return 0
        end
    end

    -- Handle Automaton Analyzer which decreases damage from successive special attacks
    if target:getMod(xi.mod.AUTO_ANALYZER) > 0 then
        local analyzerSkill = target:getLocalVar('analyzer_skill')
        local analyzerHits = target:getLocalVar('analyzer_hits')
        if
            analyzerSkill == skill:getID() and
            target:getMod(xi.mod.AUTO_ANALYZER) > analyzerHits
        then
            -- Successfully mitigating damage at a fixed 40%
            dmg = dmg * 0.6
            analyzerHits = analyzerHits + 1
        else
            target:setLocalVar('analyzer_skill', skill:getID())
            analyzerHits = 0
        end

        target:setLocalVar('analyzer_hits', analyzerHits)
    end

    if attackType == xi.attackType.PHYSICAL then
        dmg = target:physicalDmgTaken(dmg, damageType)
    elseif attackType == xi.attackType.MAGICAL then
        dmg = target:magicDmgTaken(dmg, damageType - xi.damageType.ELEMENTAL)
    elseif attackType == xi.attackType.BREATH then
        dmg = target:breathDmgTaken(dmg)
    elseif attackType == xi.attackType.RANGED then
        dmg = target:rangedDmgTaken(dmg)
    end

    if dmg < 0 then
        return dmg
    end

    -- Handle Phalanx
    if dmg > 0 then
        dmg = utils.clamp(dmg - target:getMod(xi.mod.PHALANX), 0, 99999)
    end

    if attackType == xi.attackType.MAGICAL then
        dmg = utils.oneforall(target, dmg)

        if dmg < 0 then
            return 0
        end
    end

    dmg = utils.stoneskin(target, dmg)

    if dmg > 0 then
        target:updateEnmityFromDamage(mob, dmg)
        target:handleAfflatusMiseryDamage(dmg)
    end

    return dmg
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
        local statmod = xi.mod.INT
        local element = mob:getStatusEffectElement(typeEffect)
        local resist  = xi.mobskills.applyPlayerResistance(mob, typeEffect, target, mob:getStat(statmod)-target:getStat(statmod), 0, element)

        if resist >= 0.25 then
            local totalDuration = utils.clamp(duration * resist, 1)
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

xi.mobskills.mobBuffMove = function(mob, typeEffect, power, tick, duration)
    if mob:addStatusEffect(typeEffect, power, tick, duration) then
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

    return minimum + (maximum - minimum) * ((tp - 1000) / 1000)
end
