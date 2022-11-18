-----------------------------------
-- Avatar Global Functions
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/weaponskills")
require("scripts/globals/damage")
-----------------------------------
xi = xi or {}
xi.summon = xi.summon or {}

local function getDexCritRate(source, target)
    -- https://www.bg-wiki.com/bg/Critical_Hit_Rate
    local dDex = source:getStat(xi.mod.DEX) - target:getStat(xi.mod.AGI)
    local dDexAbs = math.abs(dDex)

    local sign = 1
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

local function getAvatarfSTR(avatarStr, targetVit, avatar)
    -- https://www.bluegartr.com/threads/114636-Monster-Avatar-Pet-damage
    -- fSTR for avatars has no cap and a lower bound of floor(weaponDmg/9)
    local dSTR = avatarStr - targetVit
    local divisor = 4
    local fSTR = 0
    if dSTR >= 12 then
        fSTR = (dSTR + 4) / divisor
    elseif dSTR >= 6 then
        fSTR = (dSTR + 6) / divisor
    elseif dSTR >= 1 then
        fSTR = (dSTR + 7) / divisor
    elseif dSTR >= -2 then
        fSTR = (dSTR + 8) / divisor
    elseif dSTR >= -7 then
        fSTR = (dSTR + 9) / divisor
    elseif dSTR >= -15 then
        fSTR = (dSTR + 10) / divisor
    elseif dSTR >= -21 then
        fSTR = (dSTR + 12) / divisor
    else
        fSTR = (dSTR + 13) / divisor
    end

    local weapon_rank = 0
    local lower_cap = weapon_rank * -1
    if weapon_rank == 0 then
        lower_cap = -1
    end

    fSTR = utils.clamp(fSTR, lower_cap, weapon_rank + 8)
    return fSTR
end

local function fTP(tp, ftp1, ftp2, ftp3)
    if tp >= 1000 and tp < 2000 then
        return ftp1 + ( ((ftp2 - ftp1) / 1000) * (tp - 1000) )
    elseif tp >= 2000 and tp <= 3000 then
        -- generate a straight line between ftp2 and ftp3 and find point @ tp
        return ftp2 + ( ((ftp3 - ftp2) / 1000) * (tp - 2000) )
    end

    return 1 -- no ftp mod
end

local function avatarHitDmg(baseDmg, fSTR, pDif, attacker, target, ftp)
    -- https://www.bg-wiki.com/bg/Physical_Damage
    -- Physical Damage = Base Damage * pDIF
    -- where Base Damange is defined as Weapon Damage + fSTR
    if ftp == nil then
        ftp = 1
    end

    local dmg = (baseDmg + fSTR) * utils.clamp(ftp * pDif, 0, 4.0)

    dmg = xi.weaponskills.handleBlock(attacker, target, dmg)
    return dmg
end

xi.summon.getSummoningSkillOverCap = function(avatar)
    local summoner = avatar:getMaster()
    local summoningSkill = summoner:getSkillLevel(xi.skill.SUMMONING_MAGIC)
    local maxSkill = summoner:getMaxSkillLevel(avatar:getMainLvl(), xi.job.SMN, xi.skill.SUMMONING_MAGIC)

    return math.max(summoningSkill - maxSkill, 0)
end

xi.summon.avatarPhysicalMove = function(avatar, target, skill, numberofhits, accmod, dmgmod, dmgmodsubsequent, tpeffect, mtp100, mtp200, mtp300, wSC)
    local returninfo = {}

    if wSC == nil then
        wSC = 0
    end

    -- https://forum.square-enix.com/ffxi/threads/45365?p=534537#post534537
    -- https://www.bg-wiki.com/bg/Hit_Rate
    -- https://www.bluegartr.com/threads/114636-Monster-Avatar-Pet-damage
    -- As of December 10th 2015 pet hit rate caps at 99% (familiars, wyverns, avatars and automatons)
    -- increased from 95%
    local maxHitRate = 0.95
    local minHitRate = 0.2

    -- Hit Rate (%) = 75 + floor( (Accuracy - Evasion)/2 ) + 2*(dLVL)
    -- For Avatars negative penalties for level correction seem to be ignored for attack and likely for accuracy,
    -- bonuses cap at level diff of 38 based on this testing:
    -- https://www.bluegartr.com/threads/114636-Monster-Avatar-Pet-damage
    -- If there are penalties they seem to be applied differently similarly to monsters.
    local baseHitRate = xi.weaponskills.getHitRate(avatar, target, 0, xi.summon.getSummoningSkillOverCap(avatar))
    -- First hit gets a +100 ACC bonus which translates to +50 hit
    local firstHitAccBonus = 0.5

    -- Normal hits computed first
    local hitrateFirst = utils.clamp(baseHitRate + firstHitAccBonus, minHitRate, maxHitRate)
    local hitrateSubsequent = utils.clamp(baseHitRate, minHitRate, maxHitRate)

    -- Compute hits first so we can exit early
    local firstHitLanded = false
    local numHitsLanded = 0
    local numHitsProcessed = 1
    local finaldmg = 0

    local missChance = math.random()

    missChance = xi.weaponskills.handleParry(avatar, target, missChance, false)

    if missChance < hitrateFirst then
        firstHitLanded = true
        numHitsLanded = numHitsLanded + 1
    end

    while numHitsProcessed < numberofhits do
        missChance = math.random()
        missChance = xi.weaponskills.handleParry(avatar, target, missChance, false)

        if missChance < hitrateSubsequent then
            numHitsLanded = numHitsLanded + 1
        end
        numHitsProcessed = numHitsProcessed + 1
    end

    if numHitsLanded == 0 then
        -- Missed everything we can exit early
        finaldmg = 0
        skill:setMsg(xi.msg.basic.SKILL_MISS)
        returninfo.dmg = finaldmg
        returninfo.hitslanded = numHitsLanded
        return returninfo
    else
        -- https://www.bg-wiki.com/bg/Critical_Hit_Rate
        -- Crit rate has a base of 5% and no cap, 0-100% are valid
        -- Dex contribution to crit rate is capped and works in tiers
        local baseCritRate = 5
        local maxCritRate = 1 -- 100%
        local minCritRate = 0 -- 0%

        local critRate = (baseCritRate + getDexCritRate(avatar, target) + avatar:getMod(xi.mod.CRITHITRATE)) / 100
        critRate = utils.clamp(critRate, minCritRate, maxCritRate)

        local baseDmg = (avatar:getMainLvl() * 0.75) + (wSC * 0.85)

        local fSTR = getAvatarfSTR(avatar:getStat(xi.mod.STR), target:getStat(xi.mod.VIT), avatar)

        -- Calculating with the known era pdif ratio for weaponskills.
        if mtp100 == nil or mtp200 == nil or mtp300 == nil then -- Nil gate for xi.weaponskills.cMeleeRatio, will default mtp for each level to 1.
            mtp100 = 1.0
            mtp200 = 1.0
            mtp300 = 1.0
        end

        local pdifSoftCap = { nonCrit = 1.6, crit = 2.1 }
        local tp = avatar:getTP()
        local params = { atk100 = mtp100, atk200 = mtp200, atk300 = mtp300 }
        local pDifTable = xi.weaponskills.cMeleeRatio(avatar, target, params, 0, tp, xi.slot.MAIN)
        local pDif = utils.clamp(pDifTable[1], 0, pdifSoftCap.nonCrit)
        local pDifCrit = utils.clamp(pDifTable[2], 0, pdifSoftCap.crit)

        --Everything past this point is randomly computed per hit

        numHitsProcessed = 0

        if firstHitLanded then
            local ftp = fTP(tp, 1.35, 1.65, 1.875)

            if numberofhits > 1 then
                ftp = fTP(tp, 1.1, 1.3, 1.425)
            end

            local isCrit = math.random() < critRate

            if isCrit then
                pDif = pDifCrit
            end

            finaldmg = avatarHitDmg(baseDmg, fSTR, pDif, avatar, target, ftp) * dmgmod

            numHitsProcessed = 1
        end

        while numHitsProcessed < numHitsLanded do
            local ftp = 1
            local isCrit = math.random() < critRate
            pDifTable = xi.weaponskills.cMeleeRatio(avatar, target, params, 0, tp, xi.slot.MAIN)
            pDif = utils.clamp(pDifTable[1], 0, pdifSoftCap.nonCrit)
            pDifCrit = utils.clamp(pDifTable[2], 0, pdifSoftCap.crit)

            if isCrit then
                pDif = pDifCrit
            end

            finaldmg = finaldmg + (avatarHitDmg(baseDmg, fSTR, pDif, avatar, target, ftp) * dmgmodsubsequent)
            numHitsProcessed = numHitsProcessed + 1
        end
    end

    if target:getMod(xi.mod.PET_DMG_TAKEN_PHYSICAL) ~= 0 then
        finaldmg = finaldmg * (target:getMod(xi.mod.PET_DMG_TAKEN_PHYSICAL) / 100)
    end

    finaldmg = xi.damage.applyDamageTaken(target, finaldmg, xi.attackType.PHYSICAL)

    returninfo.dmg = finaldmg
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
    -- Physical Attack Missed
    if
        skilltype == xi.attackType.PHYSICAL and
        dmg == 0
    then
        return 0
    end

    -- set message to damage
    -- this is for AoE because its only set once
    skill:setMsg(xi.msg.basic.DAMAGE)

    -- Handle shadows depending on shadow behaviour / skilltype
    dmg = utils.takeShadows(target, mob, dmg, shadowbehav)

    -- handle Third Eye using shadowbehav as a guide
    local teye = target:getStatusEffect(xi.effect.THIRD_EYE)
    if teye ~= nil and skilltype == xi.attackType.PHYSICAL then -- T.Eye only procs when active with PHYSICAL stuff
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
        target:hasStatusEffect(xi.effect.PERFECT_DODGE) or
        target:hasStatusEffect(xi.effect.ALL_MISS) and
        skilltype == xi.attackType.PHYSICAL
    then
        return 0
    end

    -- handle super jump
    if target:hasStatusEffect(xi.effect.ALL_MISS) and target:getStatusEffect(xi.effect.ALL_MISS):getPower() > 1 then
        skill:setMsg(xi.msg.basic.JA_MISS_2)
        return 0
    end

    -- Calculate Blood Pact Damage before stoneskin
    dmg = dmg + dmg * mob:getMod(xi.mod.BP_DAMAGE) / 100

    -- handle One For All, Liement

    -- Handle Phalanx
    if dmg > 0 then
        dmg = utils.clamp(dmg - target:getMod(xi.mod.PHALANX), 0, 99999)
    end

    if skilltype == xi.attackType.MAGICAL then
        dmg = utils.oneforall(target, dmg)
        dmg = utils.rampart(target, dmg)
    end

    -- handling stoneskin
    dmg = utils.stoneskin(target, dmg)

    if dmg > 0 then
        target:updateEnmityFromDamage(mob, dmg)
        target:handleAfflatusMiseryDamage(dmg)
    end

    mob:setTP(0)

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
