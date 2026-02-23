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

---@enum xi.mobskills.drainType
xi.mobskills.drainType =
{
    HP = 0,
    MP = 1,
    TP = 2,
}

-- Shadow Behavior (Number of shadows to remove)
---@enum xi.mobskills.shadowBehavior
xi.mobskills.shadowBehavior =
{
    IGNORE_SHADOWS = 0,
    NUMSHADOWS_1   = 1,
    NUMSHADOWS_2   = 2,
    NUMSHADOWS_3   = 3,
    NUMSHADOWS_4   = 4,
    WIPE_SHADOWS   = 999,
}

---@enum xi.mobskills.physicalTpBonus
xi.mobskills.physicalTpBonus =
{
    NO_EFFECT   = 0,
    ACC_VARIES  = 1, -- Not implemented
    ATK_VARIES  = 2,
    DMG_VARIES  = 3, -- Damage formula incorrect
    CRIT_VARIES = 4, -- Deprecated, pending removal from mob skills
}

---@enum xi.mobskills.magicalTpBonus
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

local function calculateMobMagicBurst(target, actionElement, skillchainCount)
    local burstMultiplier = 1.0

    if actionElement > xi.element.NONE then
        local resistRank = target:getMod(xi.data.element.getElementalResistanceRankModifier(actionElement))
        local rankTable  = { 1.15, 0.85, 0.6, 0.5, 0.4, 0.15, 0.05 } -- TODO: Confirm resist rank tier scaling.
        local rankBonus  = 0

        if resistRank <= -3 then
            rankBonus = 1.5
        elseif resistRank >= 5 then
            rankBonus = 0
        else
            rankBonus = rankTable[resistRank + 3]
        end

        -- https://w.atwiki.jp/bartlett3/pages/329.html
        -- This page has a bullet point on pet magic bursts where avatar magic damage is discussed.
        if skillchainCount >= 1 then
            burstMultiplier = burstMultipliersByTier[skillchainCount] + rankBonus
        end
    end

    -- TODO: Do pets gain bonus from Sengikori?
    -- Sengikori appears to add to base mb multiplier per JP wiki https://wiki.ffo.jp/html/20051.html
    -- if
    --     skillchainCount >= 1 and
    --     target:getMod(xi.mod.SENGIKORI_MB_DMG_DEBUFF) > 0
    -- then
    --     burstMultiplier = burstMultiplier + target:getMod(xi.mod.SENGIKORI_MB_DMG_DEBUFF) / 100
    --     target:setMod(xi.mod.SENGIKORI_MB_DMG_DEBUFF, 0) -- Consume the "Effect" upon magic burst.
    -- end

    return burstMultiplier
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

---@param mob CBaseEntity
---@param target CBaseEntity
---@param skill CPetSkill|CMobSkill
---@param numberofhits number
---@param accmod number?
---@param ftp number
---@param tpEffect xi.mobskills.physicalTpBonus?
---@param mtp000 number?
---@param mtp150 number?
---@param mtp300 number?
---@param params physicalMobSkillParam?
---@return physicalMobSkillRetVal
xi.mobskills.mobRangedMove = function(mob, target, skill, numberofhits, accmod, ftp, tpEffect, mtp000, mtp150, mtp300, params)
    -- TODO: Replace this with ranged attack code
    params = params or {}
    params.isRanged = true
    return xi.mobskills.mobPhysicalMove(mob, target, skill, numberofhits, accmod, ftp, tpEffect, mtp000, mtp150, mtp300, params)
end

-- helper function to handle a single hit and check for parrying, guarding, and blocking
---@param mob CBaseEntity
---@param target CBaseEntity
---@param hitdamage number
---@param hitslanded number
---@param finaldmg number
---@param params physicalMobSkillHitParams
---@return integer, integer, boolean
local function handleSinglePhysicalHit(mob, target, hitdamage, hitslanded, finaldmg, params)
    -- Determine if this hit is critical
    -- TODO: Remove CRIT_VARIES from existing mob skills and replace with params.canCrit
    local isCritical = false
    if
        params.canCrit or
        params.tpEffect == xi.mobskills.physicalTpBonus.CRIT_VARIES
    then
        local critRate = xi.combat.physical.calculateSwingCriticalRate(mob, target, mob:getTP(), xi.slot.MAIN)
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
        local blockedWithShieldMastery = false

        -- TODO: we took damage, so handle stoneskin and phalanx here
        -- TODO: apply PDT/DT/damage resistance/absorption here

        -- What is the correct order of operations for SS, Phalanx and Block reduction?
        if not params.isRanged and xi.combat.physical.isBlocked(target, mob) then
            hitdamage = hitdamage - xi.combat.physical.getDamageReductionForBlock(target, mob, hitdamage)

            if target:hasTrait(xi.trait.SHIELD_MASTERY) then
                blockedWithShieldMastery = true
            end
        end

        -- Reduce HP of target

        -- if this individual hit landed and > 0 damage was taken, try to interrupt
        if
            hitdamage > 0 and
            not blockedWithShieldMastery and
            not params.isRanged
        then
            target:tryHitInterrupt(mob)
        end

        -- update the hitslanded and finaldmg
        hitslanded = hitslanded + 1
        finaldmg = finaldmg + hitdamage
    end

    return hitslanded, finaldmg, isCritical
end

-- input to xi.mobskills.mobPhysicalMove
---@alias physicalMobSkillParam { canCrit: boolean?, isCannonball: boolean?, isRanged: boolean?}

-- return value of xi.mobskills.mobPhysicalMove
---@alias physicalMobSkillRetVal { damage: number, hitslanded: number, isCritical: boolean}

-- passed to handleSinglePhysicalHit inside xi.mobskills.mobPhysicalMove
---@alias physicalMobSkillHitParams { canCrit: boolean, tpEffect: xi.mobskills.physicalTpBonus, weaponType: xi.skill, attMod: number, applyLevelCorrection: boolean, isCannonball: boolean, isRanged: boolean}

-- TODO: accMod currently does nothing
-----------------------------------
-- Mob Physical Abilities
-- accMod     : linear multiplier for accuracy (1 default)
-- ftp        : linear multiplier for damage (1 default)
-- tpEffect   : Defined in xi.mobskills.physicalTpBonus
-- params     : optional table for additional parameters { canCrit = true, isCannonball = true, isRanged = true }
-----------------------------------
---@param mob CBaseEntity
---@param target CBaseEntity
---@param skill CPetSkill|CMobSkill
---@param numHits number
---@param accMod number?
---@param ftp number
---@param tpEffect xi.mobskills.physicalTpBonus?
---@param mtp000 number?
---@param mtp150 number?
---@param mtp300 number?
---@param params physicalMobSkillParam?
---@return physicalMobSkillRetVal
xi.mobskills.mobPhysicalMove = function(mob, target, skill, numHits, accMod, ftp, tpEffect, mtp000, mtp150, mtp300, params)
    params           = params or {}
    local returninfo =
    {
        damage = 0,
        hitslanded = 0,
        isCritical = false,
    }

    -- mobs use fSTR (but with special calculation in the called function)
    local fSTR = xi.combat.physical.calculateMeleeStatFactor(mob, target)
    if params.isRanged then
        fSTR = xi.combat.physical.calculateRangedStatFactor(mob, target)
    end

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

    local targetSpecialAttackEvasion = target:getMod(xi.mod.SPECIAL_ATTACK_EVASION)

    -- Not sure if this first hit bonus is real. Needs verification.
    local firstHitBonus = 100

    if params.isRanged then
        firstHitBonus = 40
    end

    local firstHitChance = xi.combat.physicalHitRate.getPhysicalHitRate(mob, target, targetSpecialAttackEvasion * -1 + firstHitBonus, xi.attackAnimation.RIGHT_ATTACK, false)
    local hitrate        = xi.combat.physicalHitRate.getPhysicalHitRate(mob, target, targetSpecialAttackEvasion * -1, xi.attackAnimation.RIGHT_ATTACK, false)

    -- TODO: handle Blink/Utsusemi/PD/etc
    if math.random() <= firstHitChance then
        local isCritical = false
        -- use helper function check for parry guard and blocking and handle the hit
        hitslanded, finaldmg, isCritical = handleSinglePhysicalHit(mob, target, hitdamage, hitslanded, finaldmg, hitParams)

        hitCrit = isCritical or hitCrit -- set crit flag, might be used in WS messaging
    end

    -- TODO: handle Blink/Utsusemi/PD/etc
    while hitsdone < numHits do
        local isCritical = false
        if math.random() <= hitrate then --it hit
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
        local tpReturn = xi.combat.tp.getSingleMeleeHitTPReturn(mob, false)
        tpReturn = tpReturn + 10 * (hitslanded - 1) -- extra hits give 10 TP each
        mob:addTP(tpReturn)
    end

    returninfo.damage     = finaldmg
    returninfo.hitslanded = hitslanded
    returninfo.isCritical = hitCrit

    skill:setAttackType(xi.attackType.PHYSICAL)
    skill:setCritical(returninfo.isCritical)

    return returninfo
end

-----------------------------------
-- Documentation: xi.mobskills.mobMagicalMove
-- params.baseDamage           = #: Sets the skill's baseDamage.
-- params.additiveDamage       = { #, #, # }: Bonus damage added after base damage multipliers. Linear scaling based on fTP.
-- params.fTP                  = { #, #, # }: Linear baseDamage multiplier
-- params.fTPBonus             = #: Acts the same as TP_BONUS for players. Directly adds to the TP value when the skill is used.
-- params.element              = element enum: Element of attack
-- params.attackType           = attackType enum: The attack type of the skill
-- params.damageType           = damageType enum: The damage type of the skill
-- params.shadowBehavior       = How many shadows this skill consumes per hit.
-- params.mATTBonus            = { #, #, # }: Flat MACC bonus/penalty (Integer)
-- params.mACCBonus            = { #, #, # }: Flat MATT bonus/penalty (Integer)
-- params.skipDamageAdjustment = boolean: Ignores Target Damage Adjustment calculations.
-- params.skipMagicBonusDiff   = boolean: Ignores MDB step
-- params.skipStoneSkin        = boolean: skips stoneskin calculation.
-- params.resistTierOverride   = float: Forces a specific resist tier.
-- params.str_wSC              = float: % of STR stat added to baseDamage of skill.
-- params.dex_wSC              = float: % of DEX stat added to baseDamage of skill.
-- params.vit_wSC              = float: % of VIT stat added to baseDamage of skill.
-- params.agi_wSC              = float: % of AGI stat added to baseDamage of skill.
-- params.int_wSC              = float: % of INT stat added to baseDamage of skill.
-- params.mnd_wSC              = float: % of MND stat added to baseDamage of skill.
-- params.chr_wSC              = float: % of CHR stat added to baseDamage of skill.
-- params.dStatMultiplier      = float: Multiplier used in dStat calculations.
-- params.dStatAttackerMod     = xi.mod.<STAT ATTRIBUTE>: Defines which of the attacker's stats is used when calculating dStat.
-- params.dStatDefenderMod     = xi.mod.<STAT ATTRIBUTE>: Defines which of the defender's stats is used when calculating dStat.
-- params.canMagicBurst        = boolean: Determines if the skill is allowed to magic burst.
-- params.primaryMessage       = xi.msg enum: Sets the default message of the skill.
-----------------------------------
---@alias magicalMobSkillRetVal { damage: number, hitsLanded: number, attackType: xi.attackType, damageType: xi.damageType }

---@param mob CBaseEntity
---@param target CBaseEntity
---@param skill CPetSkill|CMobSkill
---@param action CAction
---@param skillParams table
---@return magicalMobSkillRetVal
xi.mobskills.mobMagicalMove = function(mob, target, skill, action, skillParams)
    local returnInfo = {}

    -- Setup Params used in mobskill's lua. Set default values if a Param is nil.
    local damage               = utils.defaultIfNil(skillParams.baseDamage, mob:getMainLvl() + 2)
    local additiveDamage       = utils.defaultIfNil(skillParams.additiveDamage, { 0, 0, 0 })
    local fTPScale             = utils.defaultIfNil(skillParams.fTP, { 1.00, 1.00, 1.00 })
    local fTPBonus             = utils.defaultIfNil(skillParams.fTPBonus, 0)
    local actionElement        = utils.defaultIfNil(skillParams.element, 0)
    local attackType           = utils.defaultIfNil(skillParams.attackType, xi.attackType.MAGICAL)
    local damageType           = utils.defaultIfNil(skillParams.damageType, xi.damageType.ELEMENTAL)
    local shadowsToRemove      = utils.defaultIfNil(skillParams.shadowBehavior, xi.mobskills.shadowBehavior.NUMSHADOWS_1)
    local mATTBonusfTP         = utils.defaultIfNil(skillParams.mATTBonus, { 0, 0, 0 })
    local mACCBonusfTP         = utils.defaultIfNil(skillParams.mACCBonus, { 0, 0, 0 })
    local skipDamageAdjustment = utils.defaultIfNil(skillParams.skipDamageAdjustment and true, false)
    local skipMagicBonusDiff   = utils.defaultIfNil(skillParams.skipMagicBonusDiff and true, false)
    local skipStoneskin        = utils.defaultIfNil(skillParams.skipStoneSkin and true, false)
    -- TODO: handle different types of Stoneskin(Magical, Physical, Agnostic)
    local resistTierOverride   = utils.defaultIfNil(skillParams.resistTierOverride, 0)
    local dStatMultiplier      = utils.defaultIfNil(skillParams.dStatMultiplier, 0)
    local dStatAttackerMod     = utils.defaultIfNil(skillParams.dStatAttackerMod, xi.mod.INT)
    local dStatDefenderMod     = utils.defaultIfNil(skillParams.dStatDefenderMod, xi.mod.INT)
    local canMagicBurst        = utils.defaultIfNil(skillParams.canMagicBurst and true, false)
    local primaryMessage       = utils.defaultIfNil(skillParams.primaryMessage, xi.msg.basic.DAMAGE)

    -- If a stat_wSC is not specified in skill script, it will default to 0. (Sanitized in xi.combat.physical.calculateWSC)
    local strWSC = skillParams.str_wSC
    local dexWSC = skillParams.dex_wSC
    local vitWSC = skillParams.vit_wSC
    local agiWSC = skillParams.agi_wSC
    local intWSC = skillParams.int_wSC
    local mndWSC = skillParams.mnd_wSC
    local chrWSC = skillParams.chr_wSC

    -- Initialize returnInfo params
    returnInfo.damage              = 0
    returnInfo.hitsLanded          = 0
    returnInfo.attackType          = attackType
    returnInfo.damageType          = damageType

    -- Set skill's default message.
    skill:setMsg(primaryMessage)

    if mob:hasStatusEffect(xi.effect.HYSTERIA) then
        skill:setMsg(xi.msg.basic.NONE)

        return returnInfo
    end

    ----------------------------------
    -- Calculate Base Damage
    ----------------------------------
    local wscMods = xi.combat.physical.calculateWSC(mob, strWSC, dexWSC, vitWSC, agiWSC, intWSC, mndWSC, chrWSC)

    -- TODO: Do mobs benefit from Fencer job trait's TP_BONUS?
    -- Best way to test will likely be to find a mob that uses a magical skill with fTP scaling and has varying jobs to compare (WAR 45 min for Fencer, 80 BST, 85 BRD).
    local bonusTP             = mob:getMod(xi.mod.TP_BONUS) + fTPBonus
    local tpValue             = math.min(skill:getTP() + bonusTP, 3000)
    local baseDamagefTPMult   = xi.combat.physical.calculateTPfactor(tpValue, fTPScale)
    local additiveBonusDamage = math.floor(xi.combat.physical.calculateTPfactor(tpValue, additiveDamage))

    -- dStat Multiplier is usually 1, 1.5, 2 depending on skill.
    -- Negative dStat subtracts 0.5 from the multiplier.
    -- https://docs.google.com/spreadsheets/d/1YBoveP-weMdidrirY-vPDzHyxbEI2ryECINlfCnFkLI/edit?pli=1&gid=57955395#gid=57955395&range=D8
    local dStat = 0

    if skillParams.dStatMultiplier then
        dStat = mob:getStat(dStatAttackerMod) - target:getStat(dStatDefenderMod)

        if not mob:isAvatar() then
            -- TODO: Does this apply to jug pets and avatars?
            if dStat < 0 then
                dStatMultiplier = dStatMultiplier - 0.5

                if dStatMultiplier < 1 then
                    dStat = -1
                end
            end
        end

        dStat = math.floor(dStat * dStatMultiplier)
        dStat = utils.clamp(dStat, -65, 999)
    end

    damage = math.floor((damage + wscMods + mob:getMod(xi.mod.MAGIC_DAMAGE)) * baseDamagefTPMult + dStat + additiveBonusDamage)
    damage = math.max(0, damage)

    local hitsLanded = 1 -- Magic skills can't miss in the same way as physical skills so assume 1 hit landed for calculations.

    -- TODO: SAM Yaegasumi ability.

    -- Handle Shadows (Utsusemi, Blink, etc.)
    damage = xi.mobskills.handleShadows(mob, target, skill, damage, attackType, shadowsToRemove)

    if skill:getMsg() == xi.msg.basic.SHADOW_ABSORB then
        -- Note: Damage in this case equals the amount of shadows consumed for the purpose of messaging.
        --       takeDamage() is gated by returnInfo.hitsLanded being greater than 0 to prevent chip damage through shadows.
        returnInfo.damage     = damage
        returnInfo.hitsLanded = 0

        return returnInfo
    end

    -- Calculate if skill will be absorbed or nullified.
    local absorbDamage  = 1
    local nullifyDamage = 1

    if attackType == xi.attackType.BREATH then
        nullifyDamage  = xi.spells.damage.calculateNullification(target, actionElement, false, true)
    else
        nullifyDamage  = xi.spells.damage.calculateNullification(target, actionElement, true, false)
    end

    if nullifyDamage == 0 then
        -- Note: Nullification takes precedence over elemental absorption.
        -- Note: We still count nullifies as a "hit" since additional status effects tied to the skill itself will still apply.
        returnInfo.damage     = 0
        returnInfo.hitsLanded = hitsLanded

        return returnInfo
    end

    if attackType == xi.attackType.BREATH then
        absorbDamage  = xi.spells.damage.calculateAbsorption(target, actionElement, false)
    else
        absorbDamage  = xi.spells.damage.calculateAbsorption(target, actionElement, true)
    end

    ----------------------------------
    -- Calculate MACC/Resists/Damage Adjustments
    ----------------------------------
    local mAccuracyBonus = 0
    local mAttackBonus   = 0

    -- Flat MACC bonus based on fTP scale
    mAccuracyBonus = xi.combat.physical.calculateTPfactor(tpValue, mACCBonusfTP)

    -- Flat MATT bonus based on fTP scale
    mAttackBonus = xi.combat.physical.calculateTPfactor(tpValue, mATTBonusfTP)

    -- Calculate bonus magic accuracy for pets
    local petAccuracyBonus = xi.mobskills.calculatePetMagicAccuracyBonus(mob, target, actionElement)

    -- Add all magic accuracy values together.
    mAccuracyBonus = mAccuracyBonus + petAccuracyBonus

    -- Damage Multipliers.
    local sdt                   = xi.combat.damage.magicalElementSDT(target, actionElement)
    local resistTier            = 1
    local dayAndWeather         = xi.spells.damage.calculateDayAndWeather(mob, actionElement, false)
    local magicBonusDiff        = 1
    local magicDamageAdjustment = 1
    local bloodPactMultiplier   = 1
    local magicBurst            = 1
    local magicBurstBonus       = 1

    -- If skill was not absorbed, calculate resist and damage adjustments.
    -- Note: Elemental absorb mechanics such as Liement are calculated BEFORE resist/damage adjustments (such as shell/magic bursts).
    if absorbDamage > 0 then
        resistTier = xi.combat.magicHitRate.calculateResistRate(mob, target, 0, 0, 0, actionElement, dStatAttackerMod, 0, mAccuracyBonus)

        if mob:isAvatar() then
            bloodPactMultiplier = 1 + mob:getMod(xi.mod.BP_DAMAGE) / 100
        end

        if
            not skipDamageAdjustment and
            attackType == xi.attackType.BREATH
        then
            -- Damage Adjustment for breath damage
            magicDamageAdjustment = xi.combat.damage.calculateDamageAdjustment(target, false, false, false, true)
        elseif not skipDamageAdjustment then
            -- Damage Adjustment for Magical damage.
            magicDamageAdjustment = xi.combat.damage.calculateDamageAdjustment(target, false, true, false, false)
        end

        if canMagicBurst then
            local _, skillchainCount = xi.magicburst.formMagicBurst(target, actionElement)

            if skillchainCount > 0 then
                -- TODO: Glyphic Bracers magic burst modifiers. https://www.bg-wiki.com/ffxi/Glyphic_Bracers
                magicBurst      = calculateMobMagicBurst(target, actionElement, skillchainCount)
                magicBurstBonus = xi.spells.damage.calculateIfMagicBurstBonus(mob, target, 0, 0, actionElement)

                -- TODO: petskills currently seem to be searching for a mobskillID rather than the petskill ID which causes the magic burst to display the wrong message. Use JA_MAGIC_BURST for now.
                -- skill:setMsg(xi.msg.basic.PET_MAGIC_BURST)
                skill:setMsg(xi.msg.basic.JA_MAGIC_BURST)
            end
        end
    end

    if not skipMagicBonusDiff then
        magicBonusDiff = xi.spells.damage.calculateMagicBonusDiff(mob, target, 0, 0, actionElement, mAttackBonus)
    end

    -- Force a resist tier if defined.
    if skillParams.resistTierOverride then
        resistTier = resistTierOverride
    end

    damage = math.floor(damage * sdt)
    damage = math.floor(damage * resistTier)
    damage = math.floor(damage * dayAndWeather)
    damage = math.floor(damage * magicBonusDiff)
    damage = math.floor(damage * magicDamageAdjustment)
    damage = math.floor(damage * bloodPactMultiplier)
    damage = math.floor(damage * absorbDamage)
    damage = math.floor(damage * magicBurst)
    damage = math.floor(damage * magicBurstBonus)

    -- If we absorbed, then return early as the rest is not needed.
    if absorbDamage < 0  then
        -- Messaging is handled in core. Returning a negative damage value automatically sets the absorb message.
        -- Note: We still count absorbs as a "hit" since additional status effects tied to the skill itself will still apply even if absorbed.
        returnInfo.damage     = damage
        returnInfo.hitsLanded = hitsLanded

        return returnInfo
    end

    damage = math.floor(target:handleSevereDamage(damage, false))
    damage = math.floor(target:checkDamageCap(damage))
    damage = math.floor(utils.handleAutomatonAutoAnalyzer(target, skill, damage))
    damage = utils.handlePhalanx(target, damage)
    damage = utils.handleOneForAll(target, damage)

    if not skipStoneskin then
        -- TODO: Some Stoneskin effects only absorb certain damage types.
        damage = utils.handleStoneskin(target, damage)
    end

    target:updateEnmityFromDamage(mob, damage)
    target:handleAfflatusMiseryDamage(damage)

    -- Calculate TP return of the mob skill.
    xi.mobskills.calculateSkillTPReturn(damage, mob, skill, target, attackType, hitsLanded)

    returnInfo.damage     = damage
    returnInfo.hitsLanded = hitsLanded

    return returnInfo
end

-----------------------------------
-- Documentation: xi.mobskills.mobBreathMove
-- params.percentMultipier     = #                   : % Multiplier on mob's current HP. Damage = mobCurrentHP * percentMultipier
-- params.damageCap            = #                   : Maximum damage the skill can deal regardless of current HP.
-- params.bonusDamage          = #                   : Flat damage added after multipliers.
-- params.element              = element enum        : Element of breath attack. Default: 1
-- params.attackType           = attackType enum     : attackType of the skill.
-- params.damageType           = damageType enum     : damageType of the skill.
-- params.shadowBehavior       = shadowBehavior enum : How many shadows the skill will consume.
-- params.skipDamageAdjustment = bool                : Determines whether to skip damage taken % modifiers (Shell etc.)
-- params.skipStoneSkin        = bool                : Determines whether the skill should bypass stoneskin.
-- params.mAccuracyBonus       = { #, #, # }         : Flat magic accuracy bonus or penalties based on fTP scale.
-- params.resistStat           = xi.mod.<Stat>       : Determines which base stat attribute is used when calculating resist. (INT, MND, etc.)
-- params.canMagicBurst        = bool                : Determines if the skill can perform a magic burst.
-- params.primaryMessage       = msg enum            : Sets the default message of the skill.
-----------------------------------
-- return value of xi.mobskills.mobBreathMove
---@alias breathMobSkillRetVal { damage: number, hitsLanded: number, attackType: xi.attackType, damageType: xi.damageType }

---@param mob CBaseEntity
---@param target CBaseEntity
---@param skill CPetSkill|CMobSkill
---@param action CAction
---@param skillParams table
---@return breathMobSkillRetVal
xi.mobskills.mobBreathMove = function(mob, target, skill, action, skillParams)
    local returnInfo = {}

    local mobCurrentHP = skill:getMobHP()

    local percentMultipier     = skillParams.percentMultipier or 0.10
    local breathSkillDamageCap = skillParams.damageCap or math.floor(mobCurrentHP / 5)
    local bonusDamage          = skillParams.bonusDamage or 0
    local mAccuracyBonusfTP    = skillParams.mAccuracyBonus or { 0, 0, 0 }
    local actionElement        = skillParams.element or 0
    local attackType           = skillParams.attackType or xi.attackType.BREATH
    local damageType           = skillParams.damageType or xi.damageType.ELEMENTAL
    local shadowsToRemove      = skillParams.shadowBehavior or xi.mobskills.shadowBehavior.IGNORE_SHADOWS
    -- Note: Breath skills so far have not been found to use MAB/MDEF. If we find an outlier, add here.
    local skipStoneskin        = skillParams.skipStoneSkin and true or false
    -- TODO: handle different types of Stoneskin(Magical, Physical, Agnostic)
    local resistStat           = skillParams.resistStat or xi.mod.INT
    local canMagicBurst        = skillParams.canMagicBurst and true or false
    local primaryMessage       = skillParams.primaryMessage or xi.msg.basic.DAMAGE
    -- TODO: Critical Hit Param? See Magma Fan mobskill.

    -- Initialize default returnInfo returns
    returnInfo.damage     = 0
    returnInfo.hitsLanded = 0
    returnInfo.attackType = attackType
    returnInfo.damageType = damageType

    -- Set skill's default message.
    skill:setMsg(primaryMessage)

    if mob:hasStatusEffect(xi.effect.HYSTERIA) then
        skill:setMsg(xi.msg.basic.NONE)

        return returnInfo
    end

    -- Calculate base damage
    local damage     = math.floor(mobCurrentHP * percentMultipier + bonusDamage)
    local hitsLanded = 1

    -- TODO: SAM Yaegasumi ability.

    -- Handle Shadows (Utsusemi, Blink, etc.)
    damage = xi.mobskills.handleShadows(mob, target, skill, damage, attackType, shadowsToRemove)

    if skill:getMsg() == xi.msg.basic.SHADOW_ABSORB then
        -- Note: Damage in this case equals the amount of shadows consumed for the purpose of messaging.
        --       takeDamage() is gated by returnInfo.hitsLanded being greater than 0 to prevent chip damage through shadows.
        returnInfo.damage     = damage
        returnInfo.hitsLanded = 0

        return returnInfo
    end

    -- Calculate if skill will be absorbed or nullified.
    local absorbDamage  = 1
    local nullifyDamage = 1

    nullifyDamage = xi.spells.damage.calculateNullification(target, actionElement, false, true)

    if nullifyDamage == 0 then
        -- Note: Nullification takes precedence over elemental absorption.
        -- Note: We still count nullifies as a "hit" since additional status effects tied to the skill itself will still apply.
        returnInfo.damage     = 0
        returnInfo.hitsLanded = hitsLanded

        return returnInfo
    end

    absorbDamage = xi.spells.damage.calculateAbsorption(target, actionElement, false)

    -- Calulate TP and TP_BONUS if applicable.
    -- TODO: Do mobs benefit from Fencer job trait's TP_BONUS?
    -- Best way to test will likely be to find a mob that uses a magical skill with fTP scaling and has varying jobs to compare (WAR 45 min for Fencer, 80 BST, 85 BRD).
    local bonusTP = mob:getMod(xi.mod.TP_BONUS)
    local tpValue = math.min(skill:getTP() + bonusTP, 3000)

    -- Flat MACC bonus/penalty based on fTP scale if defined.
    local mAccuracyBonus = 0

    mAccuracyBonus = xi.combat.physical.calculateTPfactor(tpValue, mAccuracyBonusfTP)

    -- Damage Multipliers
    local systemBonus            = 1 -- 1 + utils.getEcosystemStrengthBonus(mob:getEcosystem(), target:getEcosystem()) / 4
    local elementalSDT           = 1
    local resistRate             = 1
    local dayAndWeather          = 1
    local breathDamageAdjustment = 1
    local magicBurst             = 1
    local magicBurstBonus        = 1

    -- If skill was not absorbed, calculate resist and damage adjustments.
    -- Note: Elemental absorb mechanics such as Liement are calculated BEFORE resist/damage adjustments (such as shell/magic bursts).
    if absorbDamage > 0 then
        if canMagicBurst then
            local _, skillchainCount = xi.magicburst.formMagicBurst(target, actionElement)

            if skillchainCount > 0 then
                if mob:isPet() and mob:getMaster() ~= nil then
                    mAccuracyBonus = mAccuracyBonus + 25 -- TODO: This is based off a previous function. Would eventually like to get a capture for this.

                    -- TODO: Do jug pet breaths gain damage or only an accuracy bonus?
                    -- magicBurst      = calculateMobMagicBurst(target, actionElement, skillchainCount)
                    -- magicBurstBonus = xi.spells.damage.calculateIfMagicBurstBonus(mob, target, 0, 0, actionElement)

                    skill:setMsg(xi.msg.basic.PET_MAGIC_BURST)
                end
            end
        end

        resistRate             = xi.combat.magicHitRate.calculateResistRate(mob, target, 0, 0, xi.skillRank.A_PLUS, actionElement, resistStat, 0, mAccuracyBonus)
        breathDamageAdjustment = xi.combat.damage.calculateDamageAdjustment(target, false, false, false, true)
    end

    -- TODO: Need more research about monster correlation.
    -- local systemBonus     = 1 + utils.getEcosystemStrengthBonus(mob:getEcosystem(), target:getEcosystem()) / 4
    elementalSDT  = xi.combat.damage.magicalElementSDT(target, actionElement)
    dayAndWeather = xi.spells.damage.calculateDayAndWeather(mob, actionElement, false)

    damage = math.floor(damage * systemBonus)
    damage = math.floor(damage * elementalSDT)
    damage = math.floor(damage * resistRate)
    damage = math.floor(damage * dayAndWeather)
    damage = math.floor(damage * breathDamageAdjustment)
    damage = utils.clamp(damage, 0, breathSkillDamageCap)
    damage = math.floor(damage * absorbDamage)
    damage = math.floor(damage * magicBurst)
    damage = math.floor(damage * magicBurstBonus)

    -- If we absorbed, then return early as the rest is not needed.
    if absorbDamage < 0  then
        -- Messaging is handled in core. Returning a negative damage value automatically sets the absorb message.

        returnInfo.damage     = damage
        returnInfo.hitsLanded = hitsLanded
        -- Note: We still count absorbs as a "hit" since additional status effects tied to the skill itself will still apply even if absorbed.

        return returnInfo
    end

    damage = math.floor(target:handleSevereDamage(damage, false))
    damage = math.floor(target:checkDamageCap(damage))
    damage = math.floor(utils.handleAutomatonAutoAnalyzer(target, skill, damage))
    damage = utils.handlePhalanx(target, damage)
    damage = utils.handleOneForAll(target, damage)

    if not skipStoneskin then
        -- TODO: Some Stoneskin effects only absorb certain damage types.
        damage = utils.handleStoneskin(target, damage)
    end

    target:updateEnmityFromDamage(mob, damage)
    target:handleAfflatusMiseryDamage(damage)

    -- Calculate TP return of the mob skill.
    xi.mobskills.calculateSkillTPReturn(damage, mob, skill, target, attackType, hitsLanded)

    returnInfo.damage     = damage
    returnInfo.hitsLanded = hitsLanded

    return returnInfo
end

---@param info magicalMobSkillRetVal|physicalMobSkillRetVal
---@param mob CBaseEntity
---@param skill CPetSkill|CMobSkill
---@param target CBaseEntity
---@param attackType xi.attackType
---@param damageType xi.damageType
---@param shadowsToRemove xi.mobskills.shadowBehavior|integer?
---@param hitsLanded number?
---@return number
xi.mobskills.mobFinalAdjustments = function(info, mob, skill, target, attackType, damageType, shadowsToRemove, hitsLanded)
    if hitsLanded == nil then
        hitsLanded = 0
    end

    local damage = info.damage

    -- If target has Hysteria, no message skip rest
    -- TODO: Need to also handle in core to interrupt the mobskill. Proper behavior is: Mob will ready a skill but it will not fire off.
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
    if mob:getCurrentAction() == xi.action.category.PET_MOBABILITY_FINISH then
        if skill:getMsg() ~= xi.msg.basic.JA_MAGIC_BURST then
            skill:setMsg(xi.msg.basic.USES_JA_TAKE_DAMAGE)
        end
    else
        skill:setMsg(xi.msg.basic.DAMAGE)
    end

    -- Handle shadows depending on shadow behavior / attackType
    if
        shadowsToRemove ~= nil and
        shadowsToRemove ~= xi.mobskills.shadowBehavior.WIPE_SHADOWS and
        shadowsToRemove ~= xi.mobskills.shadowBehavior.IGNORE_SHADOWS
    then
        -- Handle Utsusemi preservation mechanic to reduce shadow consumption.
        -- This is usually for AOE physical attacks(AOE Magic usually wipes shadows).
        if
            skill:isAoE() or
            skill:isConal()
        then
            shadowsToRemove = utils.attemptShadowMitigation(target, shadowsToRemove)
        end

        -- Remove shadows
        local shadowsUsed = 0
        damage, shadowsUsed = utils.takeShadows(target, damage, shadowsToRemove)

        -- Dealt zero damage, so shadows took all hits.
        if damage == 0 then
            skill:setMsg(xi.msg.basic.SHADOW_ABSORB)

            return shadowsUsed
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
        if xi.combat.physicalHitRate.checkAnticipated(mob, target) then
            skill:setMsg(xi.msg.basic.ANTICIPATE)

            return 0
        end
    end

    -- Handle Automaton Analyzer which decreases damage from successive special attacks
    utils.handleAutomatonAutoAnalyzer(target, skill, damage)

    if attackType == xi.attackType.PHYSICAL then
        damage = damage * xi.combat.damage.physicalElementSDT(target, damageType)
        damage = target:physicalDmgTaken(damage, damageType)
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
        damage = damage * xi.combat.damage.physicalElementSDT(target, damageType)
        damage = target:rangedDmgTaken(damage)
    end

    if damage < 0 then
        return damage
    end

    damage = utils.handlePhalanx(target, damage)

    if attackType == xi.attackType.MAGICAL then
        damage = utils.handleOneForAll(target, damage)
    end

    damage = utils.handleStoneskin(target, damage)

    if damage > 0 then
        target:updateEnmityFromDamage(mob, damage)
        target:handleAfflatusMiseryDamage(damage)
    end

    -- Calculate TP return of the mob skill.
    xi.mobskills.calculateSkillTPReturn(damage, mob, skill, target, attackType, hitsLanded)

    return damage
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
            mobTPReturn    = xi.combat.tp.getSingleMeleeHitTPReturn(mob, false)
            targetTPReturn = xi.combat.tp.calculateTPGainOnPhysicalDamage(mob, target, damage, mob:getBaseDelay())
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

---@param actor CBaseEntity
---@param target CBaseEntity
---@param skill CPetSkill|CMobSkill
---@param action CAction
---@param info table
---@return boolean
-- Used as a conditional filter for target:takeDamage so the target doesn't take chip damage through shadows.
xi.mobskills.processDamage = function(actor, target, skill, action, info)
    if info.hitsLanded > 0 then
        return true
    end

    return false
end

-- returns true if mob attack hit
-- used to stop tp move status effects
xi.mobskills.mobPhysicalHit = function(skill)
    if skill:hasMissMsg() then
        return false
    end

    return true
end

xi.mobskills.mobDrainMove = function(mob, target, drainType, drain, attackType, damageType)
    -- TODO: We clamp the drain in this function so the drain can not be more than what the target has.
    -- Is this also reflected in the damage messaging on retail?
    -- Currently we do not return the clamped drain afterwards so the damage messaging will not be updated to reflect this.

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
        mob:addStatusEffect(drainEffectCorrelation[typeEffect], { power = power, duration = duration, origin = mob, tick = tick })

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
        -- Check immunity. TODO: We dont fetch elements.
        if xi.data.statusEffect.isTargetImmune(target, typeEffect, xi.element.NONE) then
            return xi.msg.basic.SKILL_MISS -- <user> uses <skill>, but misses <target>.

        -- Check resist traits. TODO: We do not fetch action objects, so we cannot set action modifiers.
        elseif xi.data.statusEffect.isTargetResistant(mob, target, typeEffect) then
            -- action:setModifier(xi.msg.actionModifier.RESIST) -- Resist!
            return xi.msg.basic.SKILL_MISS                  -- <user> uses <skill>, but misses <target>.

        -- Check effect incompatibilities.
        elseif xi.data.statusEffect.isEffectNullified(target, typeEffect, 0) then
            return xi.msg.basic.SKILL_MISS -- <user> uses <skill>, but misses <target>.
        end

        local element    = mob:getStatusEffectElement(typeEffect) -- TODO: Do something.
        local resistRate = xi.combat.magicHitRate.calculateResistRate(mob, target, 0, 0, 0, element, xi.mod.INT, typeEffect, 0)
        if resistRate >= 0.25 then
            local totalDuration = math.floor(duration * resistRate)
            target:addStatusEffect(typeEffect, { power = power, duration = totalDuration, origin = mob, tick = tick, subType = subType, subPower = subPower, tier = tier })

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
    if mob:addStatusEffect(typeEffect, { power = power, duration = duration, origin = mob, tick = tick, subType = subType, subPower = subPower }) then
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

-- Used for mobskills that remove player equipment.
-- Removes items from randomly chosen equipment slots.
---@param target CBaseEntity
---@param numberToUnequip number
xi.mobskills.unequipRandomSlots = function(target, numberToUnequip)
    local slots = {}

    -- Collect only slots that actually have something equipped
    for i = xi.slot.MAIN, xi.slot.BACK do
        local itemID = target:getEquipID(i)
        if itemID and itemID ~= 0 then
            table.insert(slots, i)
        end
    end

    for _ = 1, math.min(numberToUnequip, #slots) do
        local index = math.random(#slots)
        target:unequipItem(table.remove(slots, index))
    end
end

---@param target CBaseEntity
---@param attacker CBaseEntity
---@param skill CMobSkill
---@param action CAction
---@return xi.action.knockback
xi.mobskills.calculateKnockback = function(target, attacker, skill, action)
    return utils.clamp(skill:getKnockback() - target:getMod(xi.mod.KNOCKBACK_REDUCTION), xi.action.knockback.NONE, xi.action.knockback.LEVEL7)
end

---@param actor CBaseEntity
---@param target CBaseEntity
---@param skill CMobSkill|CPetSkill
---@param damage integer
---@param attackType xi.attackType
---@param shadowsToRemove xi.mobskills.shadowBehavior|integer?
xi.mobskills.handleShadows = function(actor, target, skill, damage, attackType, shadowsToRemove)
    -- Handle shadows depending on shadow behavior / attackType
    if
        shadowsToRemove ~= nil and
        shadowsToRemove ~= xi.mobskills.shadowBehavior.WIPE_SHADOWS and
        shadowsToRemove ~= xi.mobskills.shadowBehavior.IGNORE_SHADOWS
    then
        -- Utsusemi preservation (mostly AoE physical)
        if skill:isAoE() or skill:isConal() then
            shadowsToRemove = utils.attemptShadowMitigation(target, shadowsToRemove)
        end

        local shadowsUsed = 0
        damage, shadowsUsed = utils.takeShadows(target, damage, shadowsToRemove)

        -- Shadows absorbed everything
        if damage == 0 then
            skill:setMsg(xi.msg.basic.SHADOW_ABSORB)

            return shadowsUsed
        end

    elseif shadowsToRemove == xi.mobskills.shadowBehavior.WIPE_SHADOWS then
        target:delStatusEffect(xi.effect.COPY_IMAGE)
        target:delStatusEffect(xi.effect.BLINK)
        target:delStatusEffect(xi.effect.THIRD_EYE)
    end

    -- Physical / Ranged handling
    if
        attackType == xi.attackType.PHYSICAL or
        attackType == xi.attackType.RANGED
    then
        -- Third Eye does not block AoE attacks
        if not skill:isSingle() then
            target:delStatusEffect(xi.effect.THIRD_EYE)
        end

        -- Anticipate check (Third Eye)
        if xi.combat.physicalHitRate.checkAnticipated(actor, target) then
            skill:setMsg(xi.msg.basic.ANTICIPATE)
            return 0
        end
    end

    return damage
end

xi.mobskills.calculatePetMagicAccuracyBonus = function(mob, target, actionElement)
    local petAccBonus = 0

    if mob:isPet() and mob:getMaster() ~= nil then
        local master = mob:getMaster()

        if mob:isAvatar() then
            local masterSkillLevel    = master:getSkillLevel(xi.skill.SUMMONING_MAGIC)
            local masterMaxSkillLevel = master:getMaxSkillLevel(mob:getMainLvl(), xi.job.SMN, xi.skill.SUMMONING_MAGIC)

            petAccBonus = utils.clamp(masterSkillLevel - masterMaxSkillLevel, 0, 200)
        end

        local skillchainTier, _ = xi.magicburst.formMagicBurst(target, actionElement)
        if
            mob:getPetID() > 0 and
            skillchainTier > 0
        then
            petAccBonus = petAccBonus + 25
        end
    end

    return petAccBonus
end
