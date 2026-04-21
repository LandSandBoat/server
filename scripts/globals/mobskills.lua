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
    NUMSHADOWS_5   = 5,
    NUMSHADOWS_6   = 6,
    NUMSHADOWS_7   = 7,
    NUMSHADOWS_8   = 8,
    NUMSHADOWS_9   = 9,
    WIPE_SHADOWS   = 999,
}

-- TODO: Currently still used by avatar skills. Marked for deletion once they get converted.
---@enum xi.mobskills.physicalTpBonus
xi.mobskills.physicalTpBonus =
{
    NO_EFFECT   = 0,
    ACC_VARIES  = 1, -- Not implemented
    ATK_VARIES  = 2,
    DMG_VARIES  = 3, -- Damage formula incorrect
    CRIT_VARIES = 4, -- Deprecated, pending removal from mob skills
}

-- TODO: Currently still used by avatar skills. Marked for deletion once they get converted.
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

---@params target CBaseEntity
---@params actionElement xi.element
---@params skillChainCount integer
---@return number
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

-- LLS definitions for normalizePhysicalSkillParams()
--- @class physicalSkillParams
--- @field baseDamage          number|nil
--- @field numHits             integer
--- @field fTP                 number[]
--- @field fTPSubsequentHits   number[]
--- @field fTPBonus            number
--- @field attackMultiplier    number[]
--- @field accuracyModifier    number[]
--- @field guaranteedFirstHit  boolean
--- @field canCrit             boolean
--- @field criticalChance      number[]
--- @field ignoreDefense       number[]
--- @field isCannonball        boolean
--- @field attackType          xi.attackType
--- @field damageType          xi.damageType
--- @field hybridSkill         boolean
--- @field hybridSkillElement  xi.element
--- @field hybridAttackType    xi.attackType
--- @field hybridDamageType    xi.damageType
--- @field shadowBehavior      xi.mobskills.shadowBehavior
--- @field skipStoneskin       boolean
--- @field skipYaegasumi       boolean
--- @field skipFSTR            boolean
--- @field skipPDIF            boolean
--- @field skipParry           boolean
--- @field skipGuard           boolean
--- @field skipBlock           boolean
--- @field primaryMessage      xi.msg.basic

--- Table of default skill params shared by physical/ranged mobskills.
--- Sets default values if the params are not explicitly defined in the mobskill script.
--- @param skillParams physicalSkillParams
--- @return physicalSkillParams
local function normalizePhysicalSkillParams(skillParams)
    local defaults =
    {
        baseDamage            = nil, -- handled separately
        numHits               = 1,
        fTP                   = { 1.00, 1.00, 1.00 },
        fTPSubsequentHits     = { 1.00, 1.00, 1.00 },
        fTPBonus              = 0,
        attackMultiplier      = { 1.00, 1.00, 1.00 },
        accuracyModifier      = { 0, 0, 0 },
        guaranteedFirstHit    = false,
        canCrit               = false,
        criticalChance        = { 0.00, 0.00, 0.00 },
        ignoreDefense         = { 0.00, 0.00, 0.00 },
        isCannonball          = false,
        attackType            = xi.attackType.PHYSICAL,
        damageType            = xi.damageType.SLASHING,
        hybridSkill           = false,
        hybridSkillElement    = xi.element.NONE,
        hybridAttackType      = xi.attackType.MAGICAL,
        hybridDamageType      = xi.damageType.ELEMENTAL,
        shadowBehavior        = xi.mobskills.shadowBehavior.NUMSHADOWS_1,
        skipStoneskin         = false,
        skipYaegasumi         = false,
        skipFSTR              = false,
        skipPDIF              = false,
        skipParry             = false,
        skipGuard             = false,
        skipBlock             = false,
        primaryMessage        = xi.msg.basic.DAMAGE,
    }

    local result = {}

    for paramName, defaultValue in pairs(defaults) do
        result[paramName] = utils.defaultIfNil(skillParams[paramName], defaultValue)
    end

    return result
end

-- Helper function to store default physical hit information before being modified.
---@class physicalHitInfo
---@field hitNumber integer The index of the hit in a multi-hit attack.
---@field hitLanded boolean Whether the hit connected with the target.
---@field hitYaegasumi boolean Whether the hit was absorbed by Yaegasumi.
---@field hitAnticipated boolean Whether the hit was anticipated (e.g. by an ability).
---@field hitParried boolean Whether the hit was parried.
---@field hitGuarded boolean Whether the hit was guarded.
---@field hitAbsorbed boolean Whether the hit was absorbed.
---@field hitBlocked boolean Whether the hit was blocked.
---@field isCritical boolean Whether the hit was a critical strike.
---@field pDif number The pDIF multiplier used for damage calculation.
---@field missType string|nil The type of miss, or nil if the hit landed.
---@field hitDamage integer The amount of damage dealt by the hit.
---@field shadowsConsumed integer The number of Utsusemi shadows consumed.

---Creates a default HitInfo table for a physical hit before damage resolution.
---@param hitNumber integer The index of this hit in a multi-hit attack sequence.
---@return physicalHitInfo
local function defaultHitInfo(hitNumber)
    return {
        hitNumber       = hitNumber,
        hitLanded       = false,
        hitYaegasumi    = false,
        hitAnticipated  = false,
        hitParried      = false,
        hitGuarded      = false,
        hitAbsorbed     = false,
        hitBlocked      = false,
        isCritical      = false,
        pDif            = 0,
        missType        = nil,
        hitDamage       = 0,
        shadowsConsumed = 0,
    }
end

---Tallies the results of all hits from a physical mob skill into aggregate values.
---@param hitData physicalHitInfo[] List of hit result tables from `returnInfo.hitData`
---@return number totalDamage Sum of damage dealt across all landed hits
---@return number hitsLanded Count of hits that successfully dealt damage
---@return boolean hitsYaegasumi True if any hit was evaded by Yaegasumi
---@return boolean hitsAnticipated True if any hit was blocked by Third Eye anticipation
---@return number hitsAbsorbed Count of hits absorbed by shadows (Utsusemi/Blink)
---@return number shadowsAbsorbed Total number of shadow images consumed across all absorbed hits
---@return boolean anyCrit True if any landed hit was a critical strike
local function tallyHitResults(hitData)
    local totalDamage     = 0
    local hitsLanded      = 0
    local hitsYaegasumi   = false
    local hitsAnticipated = false
    local shadowsAbsorbed = 0
    local hitsAbsorbed    = 0
    local anyCrit         = false

    for _, hit in ipairs(hitData) do
        if hit.hitLanded then
            hitsLanded  = hitsLanded + 1
            totalDamage = totalDamage + hit.hitDamage
            anyCrit     = anyCrit or hit.isCritical
        end

        if hit.hitYaegasumi then
            hitsYaegasumi = true
        end

        if hit.hitAnticipated then
            hitsAnticipated = true
        end

        if hit.hitAbsorbed then
            hitsAbsorbed    = hitsAbsorbed + 1
            shadowsAbsorbed = shadowsAbsorbed + hit.shadowsConsumed
        end
    end

    return totalDamage, hitsLanded, hitsYaegasumi, hitsAnticipated, hitsAbsorbed, shadowsAbsorbed, anyCrit
end

---@param skill CPetSkill|CMobSkill
---@param hitsLanded integer
---@param hitsYaegasumi boolean
---@param hitsAnticipated boolean
---@param hitsAbsorbed integer
---@param shadowsAbsorbed integer
---@param primaryMessage xi.msg.basic
---@param totalDamage integer
---@return integer
local function resolveMissMessage(skill, hitsLanded, hitsYaegasumi, hitsAnticipated, hitsAbsorbed, shadowsAbsorbed, primaryMessage, totalDamage)
    if hitsLanded == 0 and hitsYaegasumi then
        -- Yaegasumi
        -- TODO: Get captures of Yaegasumi ability and confirm.
        skill:setMsg(xi.msg.basic.EVADES)
    elseif hitsLanded == 0 and hitsAnticipated then
        -- Third Eye
        skill:setMsg(xi.msg.basic.ANTICIPATE)
    elseif hitsLanded == 0 and hitsAbsorbed > 0 then
        -- Utsusemi and Blink
        skill:setMsg(xi.msg.basic.SHADOW_ABSORB)
        totalDamage = shadowsAbsorbed
    elseif hitsLanded == 0 then
        if primaryMessage == xi.msg.basic.RANGED_ATTACK_HIT then
            skill:setMsg(xi.msg.basic.RANGED_ATTACK_MISS)
        elseif primaryMessage == xi.msg.basic.HIT_DMG then
            skill:setMsg(xi.msg.basic.HIT_MISS)
        else
            skill:setMsg(xi.msg.basic.SKILL_MISS)
        end

        totalDamage = 0
    end

    return totalDamage
end

-- passed to handleSinglePhysicalHit() inside xi.mobskills.mobPhysicalMove() and handleSingleRangedHit() inside xi.mobskills.mobRangedMove()
---@class physicalMobSkillHitParams
---@field hitNumber number
---@field attackType xi.attackType
---@field damageType xi.damageType
---@field shadowsToRemove number
---@field skipStoneskin boolean
---@field canCrit boolean
---@field weaponType xi.skill
---@field tpValue number
---@field attackMultiplier number
---@field critModTable table
---@field applyLevelCorrection boolean
---@field isCannonball boolean
---@field ignoreDefense boolean
---@field ignoreDefenseFactor number
---@field skipPDIF boolean
---@field skipParry boolean
---@field skipGuard boolean
---@field skipBlock boolean

-- helper function to handle a single hit and check for parrying, guarding, and blocking
---@param mob CBaseEntity
---@param target CBaseEntity
---@param baseHitDamage number
---@param params physicalMobSkillHitParams
---@return physicalHitInfo
local function handleSinglePhysicalHit(mob, target, baseHitDamage, params)
    local hitNumber                = params.hitNumber
    local hitParried               = xi.combat.physical.isParried(target, mob) and not params.skipParry
    local hitGuarded               = xi.combat.physical.isGuarded(target, mob) and not params.skipGuard
    local isCritical               = false
    local hitBlocked               = false
    local blockedWithShieldMastery = false
    local hitInfo                  = defaultHitInfo(hitNumber)

    ----------------------------------
    -- Parry / Guard
    ----------------------------------
    if hitParried then
        hitInfo.hitParried = true
        hitInfo.missType   = 'Parried'

        return hitInfo
    end

    if hitGuarded then
        hitInfo.hitGuarded = true
        hitInfo.missType   = 'Guarded'

        return hitInfo
    end

    ----------------------------------
    -- Critical Check
    ----------------------------------
    if params.canCrit then
        local critRate = xi.combat.physical.calculateSwingCriticalRate(mob, target, params.tpValue, xi.slot.MAIN, params.critModTable)

        isCritical = math.random(1, 1000) <= critRate * 1000
    end

    ----------------------------------
    -- PDIF + Damage
    ----------------------------------
    local pDif      = 1
    local hitDamage = 0

    if not params.skipPDIF then
        pDif = xi.combat.physical.calculateMeleePDIF(mob, target, params.weaponType, params.attackMultiplier, isCritical, params.applyLevelCorrection, params.ignoreDefense, params.ignoreDefenseFactor, false, xi.slot.MAIN, params.isCannonball)
    end

    hitDamage = math.floor(baseHitDamage * pDif)

    if
        xi.combat.physical.isBlocked(target, mob) and
        not params.skipBlock
    then
        hitBlocked = true

        hitDamage = hitDamage - xi.combat.physical.getDamageReductionForBlock(target, mob, hitDamage)

        if target:getMod(xi.mod.SHIELD_MASTERY_TP) > 0 then
            blockedWithShieldMastery = true
        end
    end

    hitDamage = math.floor(hitDamage * xi.combat.damage.physicalElementSDT(target, params.damageType))
    hitDamage = math.floor(hitDamage * xi.combat.damage.calculateDamageAdjustment(target, true, false, false, false))

    -- TODO: Automaton Steam Jacket Reduction

    -- TODO: Automaton Equalizer Reduction

    -- TODO: Need captures for different severe damage mechanics. Do they proc per hit or per skill
    hitDamage = math.floor(target:handleSevereDamage(hitDamage, true))

    -- TODO: Convert Damage to MP + Cover Bonus

    -- TODO: Fan Dance Reduction

    hitDamage = math.floor(target:checkDamageCap(hitDamage))
    hitDamage = utils.handlePhalanx(target, hitDamage)

    if not params.skipStoneskin then
        hitDamage = utils.handleStoneskin(target, hitDamage)
    end

    if hitDamage > 0 then
        target:trySkillUp(xi.skill.EVASION, target:getMainLvl())

        if not blockedWithShieldMastery then
            target:tryHitInterrupt(mob)
        end
    end

    ----------------------------------
    -- Successful Hit
    ----------------------------------
    hitInfo.hitLanded  = true
    hitInfo.hitDamage  = hitDamage
    hitInfo.hitBlocked = hitBlocked
    hitInfo.isCritical = isCritical
    hitInfo.pDif       = pDif

    return hitInfo
end

-- helper function to handle a single ranged hit and check for parrying, guarding, and blocking
---@param mob CBaseEntity
---@param target CBaseEntity
---@param baseHitDamage number
---@param params physicalMobSkillHitParams
---@return physicalHitInfo
local function handleSingleRangedHit(mob, target, baseHitDamage, params)
    local hitNumber                = params.hitNumber
    local hitParried               = xi.combat.physical.isParried(target, mob) and not params.skipParry
    local hitGuarded               = xi.combat.physical.isGuarded(target, mob) and not params.skipGuard
    local isCritical               = false
    local hitBlocked               = false
    local blockedWithShieldMastery = false
    local hitInfo                  = defaultHitInfo(hitNumber)

    ----------------------------------
    -- Parry / Guard
    ----------------------------------
    if hitParried then
        hitInfo.hitParried = true
        hitInfo.missType   = 'Parried'

        return hitInfo
    end

    if hitGuarded then
        hitInfo.hitGuarded = true
        hitInfo.missType   = 'Guarded'

        return hitInfo
    end

    ----------------------------------
    -- Critical Check
    ----------------------------------
    if params.canCrit then
        local critRate = xi.combat.physical.calculateRangedCriticalRate(mob, target, params.tpValue, xi.slot.MAIN, params.critModTable)

        isCritical = math.random(1, 1000) <= critRate * 1000
    end

    ----------------------------------
    -- PDIF + Damage
    ----------------------------------
    local pDif      = 1
    local hitDamage = 0

    if not params.skipPDIF then
        pDif = xi.combat.physical.calculateRangedPDIF(mob, target, params.weaponType, params.attackMultiplier, isCritical, params.applyLevelCorrection, params.ignoreDefense, params.ignoreDefenseFactor, false, 0)
    end

    hitDamage = math.floor(baseHitDamage * pDif)

    if
        xi.combat.physical.isBlocked(target, mob) and
        not params.skipBlock
    then
        hitBlocked = true

        hitDamage = hitDamage - xi.combat.physical.getDamageReductionForBlock(target, mob, hitDamage)

        if target:getMod(xi.mod.SHIELD_MASTERY_TP) > 0 then
            blockedWithShieldMastery = true
        end
    end

    hitDamage = math.floor(hitDamage * xi.combat.damage.physicalElementSDT(target, params.damageType))
    hitDamage = math.floor(hitDamage * xi.combat.damage.calculateDamageAdjustment(target, true, false, true, false))

    -- TODO: Automaton Steam Jacket Reduction

    -- TODO: Automaton Equalizer Reduction

    -- TODO: Need captures for different severe damage mechanics. Do they proc per hit or per skill
    hitDamage = math.floor(target:handleSevereDamage(hitDamage, true))

    -- TODO: Convert Damage to MP + Cover Bonus

    -- TODO: Fan Dance Reduction

    hitDamage = math.floor(target:checkDamageCap(hitDamage))
    hitDamage = utils.handlePhalanx(target, hitDamage)

    if not params.skipStoneskin then
        hitDamage = utils.handleStoneskin(target, hitDamage)
    end

    if hitDamage > 0 then
        target:trySkillUp(xi.skill.EVASION, target:getMainLvl())

        if not blockedWithShieldMastery then
            target:tryHitInterrupt(mob)
        end
    end

    ----------------------------------
    -- Successful Hit
    ----------------------------------
    hitInfo.hitLanded  = true
    hitInfo.hitDamage  = hitDamage
    hitInfo.hitBlocked = hitBlocked
    hitInfo.isCritical = isCritical
    hitInfo.pDif       = pDif

    return hitInfo
end

---@alias rangedMobSkillRetVal { damage: number, hybridDamage: number, hitsLanded: number, attackType: xi.attackType, damageType: xi.damageType, hybridAttackType: xi.attackType, hybridDamageType: xi.damageType, isCritical: boolean, hitData: table }

---@param mob CBaseEntity
---@param target CBaseEntity
---@param skill CPetSkill|CMobSkill
---@param action CAction
---@param skillParams table
---@return rangedMobSkillRetVal
xi.mobskills.mobRangedMove = function(mob, target, skill, action, skillParams)
    local returnInfo = {}

    -- Sanitizes skillParams and sets defaults for any params not explicitly set in mob skill scripts.
    local params = normalizePhysicalSkillParams(skillParams)

    local damage = params.baseDamage or mob:getWeaponDmg()

    -- Initialize return structure
    returnInfo.damage           = 0
    returnInfo.hybridDamage     = 0
    returnInfo.hitsLanded       = 0
    returnInfo.attackType       = params.attackType
    returnInfo.damageType       = params.damageType
    returnInfo.hybridAttackType = params.hybridAttackType
    returnInfo.hybridDamageType = params.hybridDamageType
    returnInfo.isCritical       = false
    returnInfo.hitData          = {}

    skill:setMsg(params.primaryMessage)

    ----------------------------------
    -- Base Damage Calculation
    ----------------------------------
    local fSTR       = 0
    local wscMods    = xi.combat.physical.calculateWSC(mob, skillParams.str_wSC, skillParams.dex_wSC, skillParams.vit_wSC, skillParams.agi_wSC, skillParams.int_wSC, skillParams.mnd_wSC, skillParams.chr_wSC)
    local bonusTP    = mob:getMod(xi.mod.TP_BONUS) + params.fTPBonus
    local skillTP    = math.max(1000, skill:getTP())
    local tpValue    = math.min(skillTP + bonusTP, 3000)
    local basefTP    = xi.combat.physical.calculateTPfactor(tpValue, params.fTP)
    local baseDamage = 0

    if not params.skipFSTR then
        fSTR = xi.combat.physical.calculateRangedStatFactor(mob, target)
    end

    baseDamage = math.max(1, math.floor((damage + fSTR + wscMods) * basefTP))

    local subsequentDamage = baseDamage
    if params.fTPSubsequentHits then
        subsequentDamage = math.floor((damage + fSTR + wscMods) * xi.combat.physical.calculateTPfactor(tpValue, params.fTPSubsequentHits))
    end

    ----------------------------------
    -- Calculate Skill Params To Pass To hitParams.
    ----------------------------------
    -- targetSpecialAttackEvasion gets transformed to a negative number since its a modifier on the target affecting the attacker's accuracy.
    local targetSpecialAttackEvasion = target:getMod(xi.mod.SPECIAL_ATTACK_EVASION) * -1
    local accuracyModifier           = 0
    if params.accuracyModifier then
        accuracyModifier = xi.combat.physical.calculateTPfactor(tpValue, params.accuracyModifier)
    end

    local attackMultiplier = 1
    if params.attackMultiplier then
        attackMultiplier = xi.combat.physical.calculateTPfactor(tpValue, params.attackMultiplier)
    end

    local ignoreDefenseFactor = 0
    local hitIgnoreDefense    = false
    if params.ignoreDefense then
        ignoreDefenseFactor = xi.combat.physical.calculateTPfactor(tpValue, params.ignoreDefense)
        hitIgnoreDefense    = true
    end

    ----------------------------------
    -- Params for the individual hits
    ----------------------------------
    local hitParams =
    {
        hitNumber            = 0,
        attackType           = params.attackType,
        damageType           = params.damageType,
        skipStoneskin        = params.skipStoneskin,
        canCrit              = params.canCrit,
        weaponType           = xi.skill.NONE,
        tpValue              = tpValue,
        attackMultiplier     = attackMultiplier,
        critModTable         = params.criticalChance,
        applyLevelCorrection = xi.data.levelCorrection.isLevelCorrectedZone(mob),
        isCannonball         = params.isCannonball,
        ignoreDefense        = hitIgnoreDefense,
        ignoreDefenseFactor  = ignoreDefenseFactor, -- If the table exists, it ignores defense
        skipPDIF             = params.skipPDIF,
        skipParry            = params.skipParry,
        skipGuard            = params.skipGuard,
        skipBlock            = params.skipBlock,
    }

    ----------------------------------
    -- Calculate the hits
    ----------------------------------
    for hitNumber = 1, params.numHits do
        local hitInfo           = nil
        local hitChance         = 0
        local shadowsConsumed   = 0
        local hitAbsorbed       = false
        local attackAnticipated = false
        local attackYaegasumi   = false

        ----------------------------------
        -- Handle Utsusemi and Blink
        ----------------------------------
        hitAbsorbed, shadowsConsumed = xi.mobskills.handleShadowConsumption(target, skill, params, params.shadowBehavior)

        ----------------------------------
        -- Calculate Hit Rate
        ----------------------------------
        if params.guaranteedFirstHit and hitNumber == 1 then
            hitChance = 1
        elseif hitNumber == 1 then
            -- First hit gets bonus accuracy. TODO: Confirm this and the amount if true.
            hitChance = xi.combat.physicalHitRate.getRangedHitRate(mob, target, 100 + accuracyModifier + targetSpecialAttackEvasion, false)
        else
            hitChance = xi.combat.physicalHitRate.getRangedHitRate(mob, target, accuracyModifier + targetSpecialAttackEvasion, false)
        end

        if not hitInfo then
            -- If the skill did not penetrate and deal damage through the target's shadows, record hit as absorbed.
            if hitAbsorbed then
                hitInfo                  = defaultHitInfo(hitNumber)
                hitInfo.hitAbsorbed      = true
                hitInfo.missType         = 'Shadow'
                hitInfo.shadowsConsumed  = shadowsConsumed or 0
            elseif
                not params.skipYaegasumi and
                target:hasStatusEffect(xi.effect.YAEGASUMI)
                -- TODO: Fully implement mechanics of this ability (TP Return to the target evading, WS damage bonus)
                -- TODO: How does this interact with shadows/third eye? Do they overwrite? If they coexist, which takes priority?
            then
                attackYaegasumi      = true -- TODO: Assuming this acts like Third Eye for now in that it blocks all hits.
                hitInfo              = defaultHitInfo(hitNumber)
                hitInfo.hitYaegasumi = true
                hitInfo.missType     = 'Yaegasumi Evade'
            elseif xi.combat.physicalHitRate.checkAnticipated(mob, target) then
                attackAnticipated      = true -- We use this below to break the attack loop since Third Eye blocks the whole skill.
                hitInfo                = defaultHitInfo(hitNumber)
                hitInfo.hitAnticipated = true
                hitInfo.missType       = 'Anticipated'
            elseif math.random(1, 100) <= hitChance * 100 then
                hitParams.hitNumber = hitNumber

                local damageForThisHit = (hitNumber == 1) and baseDamage or subsequentDamage

                hitInfo = handleSingleRangedHit(mob, target, damageForThisHit, hitParams)

                hitInfo.shadowsConsumed = shadowsConsumed
            else
                hitInfo          = defaultHitInfo(hitNumber)
                hitInfo.missType = 'Evaded / Missed'
            end
        end

        -- Debugging
        if not hitInfo then
            error('hitInfo was not assigned for hit #' .. tostring(hitNumber))
        end

        -- Record the individual hit into hitData table.
        table.insert(returnInfo.hitData, hitInfo)

        -- Third Eye treats multi hit attacks as a single hit.
        -- Exit early if there are remaining hits after the anticipated hit.
        if
            hitAbsorbed or
            attackAnticipated or
            attackYaegasumi
        then
            break
        end
    end

    ----------------------------------
    -- Tally All Hit Results
    ----------------------------------
    local totalDamage, hitsLanded, hitsYaegasumi, hitsAnticipated, hitsAbsorbed, shadowsAbsorbed, anyCrit = tallyHitResults(returnInfo.hitData)

    ----------------------------------
    -- Handle Automaton Analyzer Attachment
    ----------------------------------
    totalDamage = math.floor(utils.handleAutomatonAutoAnalyzer(target, skill, totalDamage))

    ----------------------------------
    -- Handle Hybrid Skill Magic Damage
    ----------------------------------
    local magicDamage = 0

    -- TODO: Need more research on hybrid skills. Is the magical damage strictly reliant on the physical hit doing damage?
    --       How does xi.mod.MAGIC_DAMAGE and MAB interact with this?
    if params.hybridSkill then
        magicDamage = xi.mobskills.handleHybridDamage(mob, target, totalDamage, params.hybridSkillElement)
    end

    ----------------------------------
    -- Handle Miss Messaging
    ----------------------------------
    totalDamage = resolveMissMessage(skill, hitsLanded, hitsYaegasumi, hitsAnticipated, hitsAbsorbed, shadowsAbsorbed, params.primaryMessage, totalDamage)

    -- Mob only gets TP for hitting the initial target. AOE hits do not count.
    xi.mobskills.calculateSkillTPReturn(damage, mob, skill, target, params.attackType, hitsLanded)

    returnInfo.damage       = totalDamage
    returnInfo.hybridDamage = magicDamage
    returnInfo.hitsLanded   = hitsLanded
    returnInfo.isCritical   = anyCrit

    skill:setAttackType(xi.attackType.PHYSICAL)
    skill:setCritical(anyCrit)

    return returnInfo
end

---@alias physicalMobSkillRetVal { damage: number, hybridDamage: number, hitsLanded: number, attackType: xi.attackType, damageType: xi.damageType, hybridAttackType: xi.attackType, hybridDamageType: xi.damageType, isCritical: boolean, hitData: table }

---@param mob CBaseEntity
---@param target CBaseEntity
---@param skill CPetSkill|CMobSkill
---@param action CAction
---@param skillParams table
---@return physicalMobSkillRetVal
xi.mobskills.mobPhysicalMove = function(mob, target, skill, action, skillParams)
    local returnInfo = {}

    -- Sanitizes skillParams and sets defaults for any params not explicitly set in mob skill scripts.
    local params = normalizePhysicalSkillParams(skillParams)

    local damage = params.baseDamage or mob:getWeaponDmg()

    -- Initialize return structure
    returnInfo.damage           = 0
    returnInfo.hybridDamage     = 0
    returnInfo.hitsLanded       = 0
    returnInfo.attackType       = params.attackType
    returnInfo.damageType       = params.damageType
    returnInfo.hybridAttackType = params.hybridAttackType
    returnInfo.hybridDamageType = params.hybridDamageType
    returnInfo.isCritical       = false
    returnInfo.hitData          = {}

    skill:setMsg(params.primaryMessage)

    ----------------------------------
    -- Base Damage Calculation
    ----------------------------------
    local fSTR       = 0
    local wscMods    = xi.combat.physical.calculateWSC(mob, skillParams.str_wSC, skillParams.dex_wSC, skillParams.vit_wSC, skillParams.agi_wSC, skillParams.int_wSC, skillParams.mnd_wSC, skillParams.chr_wSC)
    local bonusTP    = mob:getMod(xi.mod.TP_BONUS) + params.fTPBonus
    local skillTP    = math.max(1000, skill:getTP())
    local tpValue    = math.min(skillTP + bonusTP, 3000)
    local basefTP    = xi.combat.physical.calculateTPfactor(tpValue, params.fTP)
    local baseDamage = 0

    if not params.skipFSTR then
        fSTR = xi.combat.physical.calculateMeleeStatFactor(mob, target)
    end

    baseDamage = math.max(1, math.floor((damage + fSTR + wscMods) * basefTP))

    local subsequentDamage = baseDamage

    if params.fTPSubsequentHits then
        subsequentDamage = math.floor((damage + fSTR + wscMods) * xi.combat.physical.calculateTPfactor(tpValue, params.fTPSubsequentHits))
    end

    ----------------------------------
    -- Calculate Skill Params To Pass To hitParams.
    ----------------------------------
    -- Mobs seem to not usually use TP moves during Mighty Strikes but if forced to by a script, the hits will crit.
    if mob:hasStatusEffect(xi.effect.MIGHTY_STRIKES) then
        params.canCrit = true
        params.criticalChance = { 1.00, 1.00, 1.00 }
    end

    -- targetSpecialAttackEvasion gets transformed to a negative number since its a modifier on the target affecting the attacker's accuracy.
    local targetSpecialAttackEvasion = target:getMod(xi.mod.SPECIAL_ATTACK_EVASION) * -1
    local accuracyModifier           = 0
    if params.accuracyModifier then
        accuracyModifier = xi.combat.physical.calculateTPfactor(tpValue, params.accuracyModifier)
    end

    local attackMultiplier = 1
    if params.attackMultiplier then
        attackMultiplier = xi.combat.physical.calculateTPfactor(tpValue, params.attackMultiplier)
    end

    local ignoreDefenseFactor = 0
    local hitIgnoreDefense    = false
    if params.ignoreDefense then
        ignoreDefenseFactor = xi.combat.physical.calculateTPfactor(tpValue, params.ignoreDefense)
        hitIgnoreDefense    = true
    end

    ----------------------------------
    -- Params for the individual hits
    ----------------------------------
    local hitParams =
    {
        hitNumber            = 0,
        attackType           = params.attackType,
        damageType           = params.damageType,
        skipStoneskin        = params.skipStoneskin,
        canCrit              = params.canCrit,
        weaponType           = xi.skill.NONE,
        tpValue              = tpValue,
        attackMultiplier     = attackMultiplier,
        critModTable         = params.criticalChance,
        applyLevelCorrection = xi.data.levelCorrection.isLevelCorrectedZone(mob),
        isCannonball         = params.isCannonball,
        ignoreDefense        = hitIgnoreDefense,
        ignoreDefenseFactor  = ignoreDefenseFactor, -- If the table exists, it ignores defense
        skipPDIF             = params.skipPDIF,
        skipParry            = params.skipParry,
        skipGuard            = params.skipGuard,
        skipBlock            = params.skipBlock,
    }

    ----------------------------------
    -- Calculate the hits
    ----------------------------------

    for hitNumber = 1, params.numHits do
        local hitInfo           = nil
        local hitChance         = 0
        local shadowsConsumed   = 0
        local hitAbsorbed       = false
        local attackAnticipated = false
        local attackYaegasumi   = false

        ----------------------------------
        -- Handle Utsusemi and Blink
        ----------------------------------
        hitAbsorbed, shadowsConsumed = xi.mobskills.handleShadowConsumption(target, skill, params, params.shadowBehavior)

        ----------------------------------
        -- Calculate Hit Rate
        ----------------------------------
        if
            target:hasStatusEffect(xi.effect.PERFECT_DODGE) or
            target:hasStatusEffect(xi.effect.ALL_MISS)
        then
            hitChance = 0
        elseif params.guaranteedFirstHit and hitNumber == 1 then
            hitChance = 1
        elseif hitNumber == 1 then
            -- First hit gets bonus accuracy. TODO: Confirm this and the amount if true.
            hitChance = xi.combat.physicalHitRate.getPhysicalHitRate(mob, target, 100 + accuracyModifier + targetSpecialAttackEvasion, xi.attackAnimation.RIGHT_ATTACK, false)
        else
            hitChance = xi.combat.physicalHitRate.getPhysicalHitRate(mob, target, accuracyModifier + targetSpecialAttackEvasion, xi.attackAnimation.RIGHT_ATTACK, false)
        end

        if not hitInfo then
            -- If the skill did not penetrate and deal damage through the target's shadows, record hit as absorbed.
            if hitAbsorbed then
                hitInfo                  = defaultHitInfo(hitNumber)
                hitInfo.hitAbsorbed      = true
                hitInfo.missType         = 'Shadow'
                hitInfo.shadowsConsumed  = shadowsConsumed or 0
            elseif
                not params.skipYaegasumi and
                target:hasStatusEffect(xi.effect.YAEGASUMI)
                -- TODO: Fully implement mechanics of this ability (TP Return to target evading, WS damage bonus)
                -- TODO: How does this interact with shadows/third eye? Do they overwrite? If they coexist, which takes priority?
            then
                attackYaegasumi      = true -- TODO: Assuming this acts like Third Eye for now in that it blocks all hits.
                hitInfo              = defaultHitInfo(hitNumber)
                hitInfo.hitYaegasumi = true
                hitInfo.missType     = 'Yaegasumi Evade'
            elseif xi.combat.physicalHitRate.checkAnticipated(mob, target) then
                attackAnticipated      = true -- We use this below to break the attack loop since Third Eye blocks the whole skill.
                hitInfo                = defaultHitInfo(hitNumber)
                hitInfo.hitAnticipated = true
                hitInfo.missType       = 'Anticipated'
            elseif math.random(1, 100) <= hitChance * 100 then
                hitParams.hitNumber = hitNumber

                local damageForThisHit = (hitNumber == 1) and baseDamage or subsequentDamage

                hitInfo = handleSinglePhysicalHit(mob, target, damageForThisHit, hitParams)

                hitInfo.shadowsConsumed  = shadowsConsumed
            else
                hitInfo          = defaultHitInfo(hitNumber)
                hitInfo.missType = 'Evaded / Missed'
            end
        end

        -- Debugging
        if not hitInfo then
            error('hitInfo was never assigned for hit #' .. tostring(hitNumber))
        end

        -- Record the individual hit into hitData table.
        table.insert(returnInfo.hitData, hitInfo)

        -- Third Eye treats multi hit attacks as a single hit.
        -- Exit early if there are remaining hits after the anticipated hit.
        if
            hitAbsorbed or
            attackAnticipated or
            attackYaegasumi
        then
            break
        end
    end

    ----------------------------------
    -- Tally All Hit Results
    ----------------------------------
    local totalDamage, hitsLanded, hitsYaegasumi, hitsAnticipated, hitsAbsorbed, shadowsAbsorbed, anyCrit = tallyHitResults(returnInfo.hitData)

    ----------------------------------
    -- Handle Automaton Analyzer Attachment
    ----------------------------------
    totalDamage = math.floor(utils.handleAutomatonAutoAnalyzer(target, skill, totalDamage))

    ----------------------------------
    -- Handle Hybrid Skill Magic Damage
    ----------------------------------
    local magicDamage = 0

    -- TODO: Need more research on hybrid skills. Is the magical damage strictly reliant on the physical hit doing damage?
    --       How does xi.mod.MAGIC_DAMAGE and MAB interact with this?
    if params.hybridSkill then
        magicDamage = xi.mobskills.handleHybridDamage(mob, target, totalDamage, params.hybridSkillElement)
    end

    ----------------------------------
    -- Handle Miss Messaging
    ----------------------------------
    totalDamage = resolveMissMessage(skill, hitsLanded, hitsYaegasumi, hitsAnticipated, hitsAbsorbed, shadowsAbsorbed, params.primaryMessage, totalDamage)

    ----------------------------------
    -- Handle TP Returns
    ----------------------------------
    xi.mobskills.calculateSkillTPReturn(damage, mob, skill, target, params.attackType, hitsLanded)

    returnInfo.damage       = totalDamage
    returnInfo.hybridDamage = magicDamage
    returnInfo.hitsLanded   = hitsLanded
    returnInfo.isCritical   = anyCrit

    skill:setAttackType(xi.attackType.PHYSICAL)
    skill:setCritical(anyCrit)

    return returnInfo
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

    local hitsLanded      = 1 -- Magic skills can't miss in the same way as physical skills so assume 1 hit landed for calculations.
    local hitAbsorbed     = false
    local shadowsConsumed = 0

    -- TODO: SAM Yaegasumi ability.

    hitAbsorbed, shadowsConsumed = xi.mobskills.handleShadowConsumption(target, skill, skillParams, shadowsToRemove)

    if hitAbsorbed then
        skill:setMsg(xi.msg.basic.SHADOW_ABSORB)

        returnInfo.damage     = shadowsConsumed
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
    local damage          = math.floor(mobCurrentHP * percentMultipier + bonusDamage)
    local hitsLanded      = 1
    local hitAbsorbed     = false
    local shadowsConsumed = 0

    -- TODO: SAM Yaegasumi ability.

    hitAbsorbed, shadowsConsumed = xi.mobskills.handleShadowConsumption(target, skill, skillParams, shadowsToRemove)

    if hitAbsorbed then
        skill:setMsg(xi.msg.basic.SHADOW_ABSORB)

        returnInfo.damage     = shadowsConsumed
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

xi.mobskills.calculateSkillTPReturn = function(damage, mob, skill, target, attackType, hitsLanded)
    -- Calculate TP return of the mob skill.
    if
        hitsLanded > 0 and
        damage > 0
    then
        local mobTPReturn    = 0
        local targetTPReturn = 0

        if attackType == xi.attackType.PHYSICAL then
            mobTPReturn    = xi.combat.tp.getSingleMeleeHitTPReturn(mob, false)
            targetTPReturn = xi.combat.tp.calculateTPGainOnPhysicalDamage(mob, target, damage, mob:getBaseDelay())
        elseif attackType == xi.attackType.RANGED then
            mobTPReturn    = xi.combat.tp.getSingleRangedHitTPReturn(mob)
            targetTPReturn = xi.combat.tp.calculateTPGainOnPhysicalDamage(mob, target, damage, mob:getBaseRangedDelay())
        elseif
            attackType == xi.attackType.BREATH or
            attackType == xi.attackType.MAGICAL
        then
            mobTPReturn    = xi.combat.tp.getSingleMeleeHitTPReturn(mob, false)
            targetTPReturn = xi.combat.tp.calculateTPGainOnPhysicalDamage(mob, target, damage, mob:getBaseDelay())
        end

        -- Handle additional hit TP return for mob.
        mobTPReturn = mobTPReturn + 10 * (hitsLanded - 1) -- Extra hits give 10 TP each

        -- Mob gains TP if skill hit the primary target.
        if skill:getPrimaryTargetID() == target:getID() then
            mob:addTP(mobTPReturn)
        end

        -- Targets hit gain TP
        target:addTP(targetTPReturn)

        local saveTPModifier = mob:getMod(xi.mod.SAVETP)
        if
            saveTPModifier > 0 and
            mob:getTP() < saveTPModifier
        then
            mob:setTP(saveTPModifier)
        end
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

---@param target CBaseEntity
---@param skill CMobSkill|CPetSkill
---@param params table
---@param shadowsToRemove xi.mobskills.shadowBehavior | integer
xi.mobskills.handleShadowConsumption = function(target, skill, params, shadowsToRemove)
    local shadowsConsumed  = 0
    local shadowsMitigated = 0
    local hitAbsorbed      = false

    local isAoE   = skill:isAoE()
    local isConal = skill:isConal()

    ----------------------------------
    -- Wipe all shadows
    ----------------------------------
    if shadowsToRemove == xi.mobskills.shadowBehavior.WIPE_SHADOWS then
        target:delStatusEffect(xi.effect.COPY_IMAGE)
        target:delStatusEffect(xi.effect.BLINK)

        -- Magical skills do not interact with Third Eye
        if
            params.attackType == xi.attackType.PHYSICAL or
            params.attackType == xi.attackType.RANGED
        then
            target:delStatusEffect(xi.effect.THIRD_EYE)
        end
    end

    ----------------------------------
    -- AoE physical skills remove Third Eye and Blink.
    -- Magical skills do not interact with Third Eye.
    ----------------------------------
    if
        isAoE or
        isConal
    then
        if
            params.attackType == xi.attackType.PHYSICAL or
            params.attackType == xi.attackType.RANGED
        then
            target:delStatusEffect(xi.effect.THIRD_EYE)
        end

        target:delStatusEffect(xi.effect.BLINK)
    end

    ----------------------------------
    -- Standard shadow handling
    ----------------------------------
    if
        shadowsToRemove ~= xi.mobskills.shadowBehavior.WIPE_SHADOWS and
        shadowsToRemove ~= xi.mobskills.shadowBehavior.IGNORE_SHADOWS
    then
        local attemptedShadowRemoval = shadowsToRemove

        if isAoE or isConal then
            shadowsMitigated = utils.attemptShadowMitigation(target, attemptedShadowRemoval)
        end

        local finalRemoval = attemptedShadowRemoval - shadowsMitigated

        hitAbsorbed, shadowsConsumed = utils.shadowAbsorb(target, finalRemoval)
    end

    return hitAbsorbed, shadowsConsumed
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

xi.mobskills.handleHybridDamage = function(mob, target, physicalDamage, element)
    local magicDamage = math.floor(physicalDamage)

    -- Multipliers.
    local nullifyDamage         = xi.spells.damage.calculateNullification(target, element, true, false)
    local absorbDamage          = xi.spells.damage.calculateAbsorption(target, element, true)
    local sdt                   = 1
    local resist                = 1
    local magicDamageAdjustment = 1
    local dayAndWeather         = xi.spells.damage.calculateDayAndWeather(mob, element, false)
    local magicBonusDiff        = xi.spells.damage.calculateMagicBonusDiff(mob, target, 0, 0, element, 0)
    local petAccBonus           = xi.mobskills.calculatePetMagicAccuracyBonus(mob, target, element)
    -- Note: Elemental absorb mechanics such as Liement are calculated BEFORE resist/damage adjustments (such as shell/magic bursts).

    if absorbDamage > 0 then
        sdt                   = xi.combat.damage.magicalElementSDT(target, element)
        resist                = xi.combat.magicHitRate.calculateResistRate(mob, target, 0, 0, 0, element, xi.mod.INT, 0, petAccBonus)
        magicDamageAdjustment = xi.combat.damage.calculateDamageAdjustment(target, false, true, false, false)
    end

    -- Calculate final damage.
    magicDamage = math.floor(magicDamage * sdt)
    magicDamage = math.floor(magicDamage * resist)
    magicDamage = math.floor(magicDamage * dayAndWeather)
    magicDamage = math.floor(magicDamage * magicBonusDiff)
    magicDamage = math.floor(magicDamage * magicDamageAdjustment)
    magicDamage = math.floor(magicDamage * absorbDamage)
    magicDamage = math.floor(magicDamage * nullifyDamage)
    magicDamage = math.floor(magicDamage * 0.5)

    magicDamage = utils.handleOneForAll(target, magicDamage)
    magicDamage = utils.handleStoneskin(target, magicDamage)

    return magicDamage
end
