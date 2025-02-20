-----------------------------------
-- Avatar Global Functions
-----------------------------------
require('scripts/globals/combat/level_correction')
require('scripts/globals/combat/physical_utilities')
-----------------------------------
xi = xi or {}
xi.summon = xi.summon or {}

local function getDexCritRate(source, target)
    -- https://www.bg-wiki.com/bg/Critical_Hit_Rate
    local dDex    = source:getStat(xi.mod.DEX) - target:getStat(xi.mod.AGI)
    local dDexAbs = math.abs(dDex)
    local sign    = 1

    if dDex < 0 then
        -- target has higher AGI so this will be a decrease to crit rate
        sign = -1
    end

    -- default to +0 crit rate for a delta of 0-6
    local critRate = 0
    if dDexAbs > 39 then
        -- 40-50: (dDEX-35)
        critRate = dDexAbs - 35
    elseif dDexAbs > 29 then
        -- 30-39: +4
        critRate = 4
    elseif dDexAbs > 19 then
        -- 20-29: +3
        critRate = 3
    elseif dDexAbs > 13 then
        -- 14-19: +2
        critRate = 2
    elseif dDexAbs > 6 then
        -- 7-13: +1
        critRate = 1
    end

    -- Crit rate from stats caps at +-15
    return math.min(critRate, 15) * sign
end

local function getRandRatio(wRatio)
    local maxRatio   = 4.25 -- 4.25 for Avatars, they count as 1H but same as mobs don't have a non-crit cap

    local upperLimit = math.min(wRatio + 0.375, maxRatio)
    if wRatio < 0.5 then
        upperLimit = math.max(wRatio + 0.5, 0.5)
    elseif wRatio < 0.7 then
        upperLimit = 1
    elseif wRatio < 1.2 then
        upperLimit = wRatio + 0.3
    elseif wRatio < 1.5 then
        upperLimit = wRatio * 1.25
    end

    local lowerLimit = math.min(wRatio - 0.375, maxRatio)
    if wRatio < 0.38 then
        lowerLimit = math.max(wRatio, 0.5)
    elseif wRatio < 1.25 then
        lowerLimit = (wRatio * (1176 / 1024)) - (448 / 1024)
    elseif wRatio < 1.51 then
        lowerLimit = 1
    elseif wRatio < 2.44 then
        lowerLimit = (wRatio * (1176 / 1024)) - (755 / 1024)
    end

    -- Randomly pick a value between lower and upper limits for qRatio
    local qRatio = lowerLimit + (math.random() * (upperLimit - lowerLimit))

    return qRatio
end

local function avatarFTP(tp, ftp1, ftp2, ftp3)
    if tp < 1000 then
        tp = 1000
    end

    if tp >= 1000 and tp < 2000 then
        return ftp1 + (ftp2 - ftp1) / 100 * (tp - 1000)
    elseif tp >= 2000 and tp <= 3000 then
        -- generate a straight line between ftp2 and ftp3 and find point @ tp
        return ftp2 + (ftp3 - ftp2) / 100 * (tp - 2000)
    end

    return 1 -- no ftp mod
end

local function avatarHitDmg(weaponDmg, fSTR, pDif)
    -- https://www.bg-wiki.com/bg/Physical_Damage
    -- Physical Damage = Base Damage * pDIF
    -- where Base Damange is defined as Weapon Damage + fSTR
    return (weaponDmg + fSTR) * pDif
end

xi.summon.getSummoningSkillOverCap = function(avatar)
    local summoner       = avatar:getMaster()
    local summoningSkill = summoner:getSkillLevel(xi.skill.SUMMONING_MAGIC)
    local maxSkill       = summoner:getMaxSkillLevel(avatar:getMainLvl(), xi.job.SMN, xi.skill.SUMMONING_MAGIC)

    return math.max(summoningSkill - maxSkill, 0)
end

xi.summon.avatarPhysicalMove = function(avatar, target, skill, numberofhits, accmod, dmgmod, dmgmodsubsequent, tpeffect, mtp100, mtp200, mtp300)
    local returninfo = {}

    -- I have never read a limit on accuracy bonus from summoning skill which can currently go far past 200 over cap
    -- current retail is over +250 skill so I am removing the cap, my SMN is at 695 total skill
    local acc = avatar:getACC() + xi.summon.getSummoningSkillOverCap(avatar)
    local eva = target:getEVA()

    -- Level correction does not happen in Adoulin zones, Legion, or zones in Escha/Reisenjima
    -- https://www.bg-wiki.com/bg/PDIF#Level_Correction_Function_.28cRatio.29
    local shouldApplyLevelCorrection = xi.combat.levelCorrection.isLevelCorrectedZone(avatar)

    -- https://forum.square-enix.com/ffxi/threads/45365?p=534537#post534537
    -- https://www.bg-wiki.com/bg/Hit_Rate
    -- https://www.bluegartr.com/threads/114636-Monster-Avatar-Pet-damage
    -- As of December 10th 2015 pet hit rate caps at 99% (familiars, wyverns, avatars and automatons)
    -- increased from 95%
    local maxHitRate = 0.99
    local minHitRate = 0.2

    -- Hit Rate (%) = 75 + floor( (Accuracy - Evasion)/2 ) + 2*(dLVL)
    -- For Avatars negative penalties for level correction seem to be ignored for attack and likely for accuracy,
    -- bonuses cap at level diff of 38 based on this testing:
    -- https://www.bluegartr.com/threads/114636-Monster-Avatar-Pet-damage
    -- If there are penalties they seem to be applied differently similarly to monsters.
    local levelDiff         = math.min(avatar:getMainLvl() - target:getMainLvl(), 38) -- Max level diff is 38
    local levelCorrection   = 0

    -- Only bonuses are applied for avatar level correction
    if shouldApplyLevelCorrection then
        if levelDiff > 0 then
            levelCorrection = math.max(levelDiff * 2, 0)
        end
    end

    -- Delta acc / 2 for hit rate
    local dAcc = math.floor((acc - eva) / 2)

    -- Normal hits computed first
    local hitrateSubsequent = 75 + dAcc + levelCorrection
    local hitrateFirst      = hitrateSubsequent + 50 -- First hit gets a +100 ACC bonus which translates to +50 hit
    hitrateSubsequent       = hitrateSubsequent / 100
    hitrateFirst            = hitrateFirst / 100
    hitrateSubsequent       = utils.clamp(hitrateSubsequent, minHitRate, maxHitRate)
    hitrateFirst            = utils.clamp(hitrateFirst, minHitRate, maxHitRate)

    -- Compute hits first so we can exit early
    local firstHitLanded   = false
    local numHitsLanded    = 0
    local numHitsProcessed = 1
    local finaldmg         = 0

    if math.random() < hitrateFirst then
        firstHitLanded = true
        numHitsLanded  = numHitsLanded + 1
    end

    while numHitsProcessed < numberofhits do
        if math.random() < hitrateSubsequent then
            numHitsLanded = numHitsLanded + 1
        end

        numHitsProcessed = numHitsProcessed + 1
    end

    if numHitsLanded == 0 then
        -- Missed everything we can exit early
        finaldmg = 0
        skill:setMsg(xi.msg.basic.SKILL_MISS)
    else
        -- https://www.bg-wiki.com/bg/Critical_Hit_Rate
        -- Crit rate has a base of 5% and no cap, 0-100% are valid
        -- Dex contribution to crit rate is capped and works in tiers
        local baseCritRate = 5
        local maxCritRate  = 1 -- 100%
        local minCritRate  = 0 -- 0%
        local critRate     = baseCritRate + getDexCritRate(avatar, target) + avatar:getMod(xi.mod.CRITHITRATE)

        critRate = critRate / 100
        critRate = utils.clamp(critRate, minCritRate, maxCritRate)

        local weaponDmg = avatar:getWeaponDmg()
        local fSTR      = xi.combat.physical.calculateMeleeStatFactor(avatar, target)

        -- https://www.bg-wiki.com/bg/PDIF
        -- https://www.bluegartr.com/threads/127523-pDIF-Changes-(Feb.-10th-2016)
        local ratio  = avatar:getStat(xi.mod.ATT) / target:getStat(xi.mod.DEF)
        local cRatio = ratio

        if shouldApplyLevelCorrection then
            -- Mobs, Avatars and pets only get bonuses, no penalties (or they are calculated differently)
            if levelDiff > 0 then
                local correction       = levelDiff * 0.05
                local cappedCorrection = math.min(correction, 1.9)
                cRatio                 = cRatio + cappedCorrection
            end
        end

        --Everything past this point is randomly computed per hit

        numHitsProcessed      = 0
        local critAttackBonus = 1 + ((avatar:getMod(xi.mod.CRIT_DMG_INCREASE) - target:getMod(xi.mod.CRIT_DEF_BONUS)) / 100)

        if firstHitLanded then
            local wRatio = cRatio
            local isCrit = math.random() < critRate
            if isCrit then
                wRatio = wRatio + 1
            end

            local qRatio = getRandRatio(wRatio)                  -- Get a random ratio from min and max
            local pDif   = qRatio * (1 + (math.random() * 0.05)) -- Final pDif is qRatio randomized with a 1-1.05 multiplier

            if isCrit then
                pDif = pDif * critAttackBonus
            end

            finaldmg         = avatarHitDmg(weaponDmg, fSTR, pDif) * dmgmod
            numHitsProcessed = 1
        end

        while numHitsProcessed < numHitsLanded do
            local wRatio = cRatio
            local isCrit = math.random() < critRate
            if isCrit then
                wRatio = wRatio + 1
            end

            local qRatio = getRandRatio(wRatio)                  -- Get a random ratio from min and max.
            local pDif   = qRatio * (1 + math.random() * 0.05) -- Final pDif is qRatio randomized with a 1-1.05 multiplier.

            if isCrit then
                pDif = pDif * critAttackBonus
            end

            finaldmg         = finaldmg + (avatarHitDmg(weaponDmg, fSTR, pDif) * dmgmodsubsequent)
            numHitsProcessed = numHitsProcessed + 1
        end

        -- apply ftp bonus
        if tpeffect == xi.mobskills.physicalTpBonus.DMG_VARIES then
            finaldmg = finaldmg * avatarFTP(avatar:getTP(), mtp100, mtp200, mtp300)
        end
    end

    returninfo.dmg        = finaldmg
    returninfo.hitslanded = numHitsLanded

    return returninfo
end

local attackTypeShields =
{
    [xi.attackType.PHYSICAL] = xi.effect.PHYSICAL_SHIELD,
    [xi.attackType.RANGED  ] = xi.effect.ARROW_SHIELD,
    [xi.attackType.MAGICAL ] = xi.effect.MAGIC_SHIELD,
}

xi.summon.avatarFinalAdjustments = function(dmg, mob, skill, target, skilltype, damagetype, shadowbehav)
    local missMessage = xi.msg.basic.SKILL_MISS
    if mob:getCurrentAction() == xi.action.PET_MOBABILITY_FINISH then
        missMessage = xi.msg.basic.JA_MISS_2
    end

    -- Physical Attack Missed
    if
        skilltype == xi.attackType.PHYSICAL and
        dmg == 0
    then
        skill:setMsg(missMessage)

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

    -- Handle shadows depending on shadow behavior / skilltype
    dmg = utils.takeShadows(target, dmg, shadowbehav)

    -- handle Third Eye using shadowbehav as a guide
    local teye = target:getStatusEffect(xi.effect.THIRD_EYE)

    -- T.Eye only procs when active with PHYSICAL stuff
    if
        teye ~= nil and
        skilltype == xi.attackType.PHYSICAL
    then
        if shadowbehav == xi.mobskills.shadowBehavior.WIPE_SHADOWS then -- e.g. aoe moves
            target:delStatusEffect(xi.effect.THIRD_EYE)
        elseif shadowbehav ~= xi.mobskills.shadowBehavior.IGNORE_SHADOWS then -- it can be absorbed by shadows
            -- third eye doesnt care how many shadows, so attempt to anticipate, but reduce
            -- chance of anticipate based on previous successful anticipates.
            local prevAnt = teye:getPower()
            if prevAnt == 0 then
                -- 100% proc
                teye:setPower(1)
                skill:setMsg(xi.msg.basic.ANTICIPATE)
                return 0
            end

            if math.random() * 10 < 8 - prevAnt then
                -- anticipated!
                teye:setPower(prevAnt + 1)
                skill:setMsg(xi.msg.basic.ANTICIPATE)
                return 0
            end

            target:delStatusEffect(xi.effect.THIRD_EYE)
        end
    end

    -- TODO: Handle anything else (e.g. if you have Magic Shield and its a Magic skill, then do 0 damage.
    for attackType, shieldEffect in pairs(attackTypeShields) do
        if skilltype == attackType and target:hasStatusEffect(shieldEffect) then
            return 0
        end
    end

    -- handle invincible
    if
        target:hasStatusEffect(xi.effect.INVINCIBLE) and
        skilltype == xi.attackType.PHYSICAL
    then
        return 0
    end

    -- handle pd
    if
        (target:hasStatusEffect(xi.effect.PERFECT_DODGE) or
        target:hasStatusEffect(xi.effect.ALL_MISS)) and
        skilltype == xi.attackType.PHYSICAL
    then
        skill:setMsg(missMessage)

        return 0
    end

    -- Calculate Blood Pact Damage before stoneskin
    dmg = math.floor(dmg + dmg * mob:getMod(xi.mod.BP_DAMAGE) / 100)

    if dmg < 0 then
        return dmg
    end

    -- handle One For All, Liement
    if skilltype == xi.attackType.MAGICAL then
        dmg = utils.oneforall(target, dmg)
    end

    -- Handle Phalanx
    if dmg > 0 then
        dmg = utils.clamp(dmg - target:getMod(xi.mod.PHALANX), 0, 99999)
    end

    -- handling stoneskin
    dmg = utils.stoneskin(target, dmg)

    -- Check if the mob has a damage cap
    dmg = target:checkDamageCap(dmg)

    return dmg
end

-- returns true if mob attack hit
-- used to stop tp move status effects
xi.summon.avatarPhysicalHit = function(skill, dmg)
    -- if message is not the default. Then there was a miss, shadow taken etc
    return skill:getMsg() == xi.msg.basic.DAMAGE
end

-- Checks if the summoner is in a Trial Size Avatar Mini Fight (used to restrict summoning while in bcnm)
xi.summon.avatarMiniFightCheck = function(caster)
    local result = 0
    local bcnmid
    if caster:hasStatusEffect(xi.effect.BATTLEFIELD) then
        bcnmid = caster:getStatusEffect(xi.effect.BATTLEFIELD):getPower()
        if
            bcnmid == 418 or
            bcnmid == 609 or
            bcnmid == 450 or
            bcnmid == 482 or
            bcnmid == 545 or
            bcnmid == 578
        then -- Mini Avatar Fights
            result = 40 -- Cannot use <spell> in this area.
        end
    end

    return result
end
