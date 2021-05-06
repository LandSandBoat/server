require("scripts/globals/common")
require("scripts/globals/status")
require("scripts/globals/msg")

function getSummoningSkillOverCap(avatar)
    local summoner = avatar:getMaster()
    local summoningSkill = summoner:getSkillLevel(xi.skill.SUMMONING_MAGIC)
    local maxSkill = summoner:getMaxSkillLevel(avatar:getMainLvl(), xi.job.SMN, xi.skill.SUMMONING_MAGIC)

    return math.max(summoningSkill - maxSkill, 0)
end

function getDexCritRate(source, target)
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

function getRandRatio(wRatio)
    local qRatio = wRatio
    local upperLimit = 0
    local lowerLimit = 0
    -- 4.25 for Avatars, they count as 1H but same as mobs don't have a non-crit cap
    local maxRatio = 4.25

    if wRatio < 0.5 then
        upperLimit = math.max(wRatio + 0.5, 0.5)
    elseif wRatio < 0.7 then
        upperLimit = 1
    elseif wRatio < 1.2 then
        upperLimit = wRatio + 0.3
    elseif wRatio < 1.5 then
        upperLimit = wRatio * 1.25
    else
        upperLimit = math.min(wRatio + 0.375, maxRatio)
    end

    if wRatio < 0.38 then
        lowerLimit = math.max(wRatio, 0.5)
    elseif wRatio < 1.25 then
        lowerLimit = (wRatio * (1176/1024)) - (448/1024)
    elseif wRatio < 1.51 then
        lowerLimit = 1
    elseif wRatio < 2.44 then
        lowerLimit = (wRatio * (1176/1024)) - (755/1024)
    else
        lowerLimit = math.min(wRatio - 0.375, maxRatio)
    end
    -- Randomly pick a value between lower and upper limits for qRatio
    qRatio = lowerLimit + (math.random() * (upperLimit - lowerLimit))

    return qRatio
end

function getAvatarFSTR(weaponDmg, avatarStr, targetVit)
    -- https://www.bluegartr.com/threads/114636-Monster-Avatar-Pet-damage
    -- fSTR for avatars has no cap and a lower bound of floor(weaponDmg/9)
    local dSTR = avatarStr - targetVit
    local fSTR = dSTR
    if dSTR >= 12 then
        fSTR = (dSTR + 4) / 4
    elseif dSTR >= 6 then
        fSTR = (dSTR + 6) / 4
    elseif dSTR >= 1 then
        fSTR = (dSTR + 7) / 4
    elseif dSTR >= -2 then
        fSTR = (dSTR + 8) / 4
    elseif dSTR >= -7 then
        fSTR = (dSTR + 9) / 4
    elseif dSTR >= -15 then
        fSTR = (dSTR + 10) / 4
    elseif dSTR >= -21 then
        fSTR = (dSTR + 12) / 4
    else
        fSTR = (dSTR + 13) / 4
    end

    local min = math.floor(weaponDmg/9)
    return math.max(-min, fSTR)
end

function avatarHitDmg(weaponDmg, fSTR, pDif)
    -- https://www.bg-wiki.com/bg/Physical_Damage
    -- Physical Damage = Base Damage * pDIF
    -- where Base Damange is defined as Weapon Damage + fSTR
    return (weaponDmg + fSTR) * pDif
end

function AvatarPhysicalMove(avatar, target, skill, numberofhits, accmod, dmgmod, dmgmodsubsequent, tpeffect, mtp100,
    mtp200, mtp300)
    local returninfo = {}

    -- I have never read a limit on accuracy bonus from summoning skill which can currently go far past 200 over cap
    -- current retail is over +250 skill so I am removing the cap, my SMN is at 695 total skill
    local acc = avatar:getACC() + getSummoningSkillOverCap(avatar)
    local eva = target:getEVA()

    -- Level correction does not happen in Adoulin zones, Legion, or zones in Escha/Reisenjima
    -- https://www.bg-wiki.com/bg/PDIF#Level_Correction_Function_.28cRatio.29
    local zoneId = avatar:getZone():getID()

    local shouldApplyLevelCorrection = (zoneId < 256) and not (zoneId == 183)

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
    local baseHitRate = 75
    -- First hit gets a +100 ACC bonus which translates to +50 hit
    local firstHitAccBonus = 50
    local hitrateFirst = 0
    local hitrateSubsequent = 0
    -- Max level diff is 38
    local levelDiff = math.min(avatar:getMainLvl() - target:getMainLvl(), 38)
    -- Only bonuses are applied for avatar level correction
    local levelCorrection = 0
    if shouldApplyLevelCorrection then
        if levelDiff > 0 then
            levelCorrection = math.max((levelDiff*2), 0)
        end
    end
    -- Delta acc / 2 for hit rate
    local dAcc = math.floor((acc - eva)/2)

    -- Normal hits computed first
    hitrateSubsequent = baseHitRate + dAcc + levelCorrection
    -- First hit gets bonus hit rate
    hitrateFirst = hitrateSubsequent + firstHitAccBonus

    hitrateSubsequent = hitrateSubsequent / 100
    hitrateFirst = hitrateFirst / 100

    hitrateSubsequent = utils.clamp(hitrateSubsequent, minHitRate, maxHitRate)
    hitrateFirst = utils.clamp(hitrateFirst, minHitRate, maxHitRate)

    -- Compute hits first so we can exit early
    local firstHitLanded = false
    local numHitsLanded = 0
    local numHitsProcessed = 1
    local finaldmg = 0

    if math.random() < hitrateFirst then
        firstHitLanded = true
        numHitsLanded = numHitsLanded + 1
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
        local maxCritRate = 1 -- 100%
        local minCritRate = 0 -- 0%

        local critRate = baseCritRate + getDexCritRate(avatar, target) + avatar:getMod(xi.mod.CRITHITRATE)
        critRate = critRate / 100
        critRate = utils.clamp(critRate, minCritRate, maxCritRate)

        local weaponDmg = avatar:getWeaponDmg()

        local fSTR = getAvatarFSTR(weaponDmg, avatar:getStat(xi.mod.STR), target:getStat(xi.mod.VIT))

        -- https://www.bg-wiki.com/bg/PDIF
        -- https://www.bluegartr.com/threads/127523-pDIF-Changes-(Feb.-10th-2016)
        local ratio = avatar:getStat(xi.mod.ATT) / target:getStat(xi.mod.DEF)
        local cRatio = ratio

        if shouldApplyLevelCorrection then
            -- Mobs, Avatars and pets only get bonuses, no penalties (or they are calculated differently)
            if levelDiff > 0 then
                local correction = levelDiff * 0.05;
                local cappedCorrection = math.min(correction, 1.9)
                cRatio = cRatio + cappedCorrection
            end
        end

        --Everything past this point is randomly computed per hit

        numHitsProcessed = 0

        local critAttackBonus = 1 + ((avatar:getMod(xi.mod.CRIT_DMG_INCREASE) - target:getMod(xi.mod.CRIT_DEF_BONUS)) / 100)

        if firstHitLanded then
            local wRatio = cRatio
            local isCrit = math.random() < critRate
            if isCrit then
                wRatio = wRatio + 1
            end
            -- get a random ratio from min and max
            local qRatio = getRandRatio(wRatio)

            --Final pDif is qRatio randomized with a 1-1.05 multiplier
            local pDif = qRatio * (1 + (math.random() * 0.05))

            if isCrit then
                pDif = pDif * critAttackBonus
            end

            finaldmg = avatarHitDmg(weaponDmg, fSTR, pDif) * dmgmod
            numHitsProcessed = 1
        end

        while numHitsProcessed < numHitsLanded do
            local wRatio = cRatio
            local isCrit = math.random() < critRate
            if isCrit then
                wRatio = wRatio + 1
            end
            -- get a random ratio from min and max
            local qRatio = getRandRatio(wRatio)

            --Final pDif is qRatio randomized with a 1-1.05 multiplier
            local pDif = qRatio * (1 + (math.random() * 0.05))

            if isCrit then
                pDif = pDif * critAttackBonus
            end

            finaldmg = finaldmg + (avatarHitDmg(weaponDmg, fSTR, pDif) * dmgmodsubsequent)
            numHitsProcessed = numHitsProcessed + 1
        end

        -- apply ftp bonus
        if tpeffect == TP_DMG_BONUS then
            finaldmg = finaldmg * avatarFTP(skill:getTP(), mtp100, mtp200, mtp300)
        end
    end

    returninfo.dmg = finaldmg
    returninfo.hitslanded = numHitsLanded

    return returninfo
end

function AvatarFinalAdjustments(dmg, mob, skill, target, skilltype, skillparam, shadowbehav)

    -- physical attack missed, skip rest
    if skilltype == xi.attackType.PHYSICAL and dmg == 0 then
        return 0
    end

    -- set message to damage
    -- this is for AoE because its only set once
    skill:setMsg(xi.msg.basic.DAMAGE)

    -- Handle shadows depending on shadow behaviour / skilltype
    if shadowbehav < 5 and shadowbehav ~= MOBPARAM_IGNORE_SHADOWS then -- remove 'shadowbehav' shadows.
        local targShadows = target:getMod(xi.mod.UTSUSEMI)
        local shadowType = xi.mod.UTSUSEMI
        if targShadows == 0 then -- try blink, as utsusemi always overwrites blink this is okay
            targShadows = target:getMod(xi.mod.BLINK)
            shadowType = xi.mod.BLINK
        end

        if targShadows > 0 then
            -- Blink has a VERY high chance of blocking tp moves, so im assuming its 100% because its easier!
            if targShadows >= shadowbehav then -- no damage, just suck the shadows
                skill:setMsg(xi.msg.basic.SHADOW_ABSORB)
                target:setMod(shadowType, targShadows - shadowbehav)
                if shadowType == xi.mod.UTSUSEMI then -- update icon
                    effect = target:getStatusEffect(xi.effect.COPY_IMAGE)
                    if effect ~= nil then
                        if targShadows - shadowbehav == 0 then
                            target:delStatusEffect(xi.effect.COPY_IMAGE)
                            target:delStatusEffect(xi.effect.BLINK)
                        elseif targShadows - shadowbehav == 1 then
                            effect:setIcon(xi.effect.COPY_IMAGE)
                        elseif targShadows - shadowbehav == 2 then
                            effect:setIcon(xi.effect.COPY_IMAGE_2)
                        elseif targShadows - shadowbehav == 3 then
                            effect:setIcon(xi.effect.COPY_IMAGE_3)
                        end
                    end
                end
                return shadowbehav
            else -- less shadows than this move will take, remove all and factor damage down
                dmg = dmg * (shadowbehav - targShadows) / shadowbehav
                target:setMod(xi.mod.UTSUSEMI, 0)
                target:setMod(xi.mod.BLINK, 0)
                target:delStatusEffect(xi.effect.COPY_IMAGE)
                target:delStatusEffect(xi.effect.BLINK)
            end
        end
    elseif shadowbehav == MOBPARAM_WIPE_SHADOWS then -- take em all!
        target:setMod(xi.mod.UTSUSEMI, 0)
        target:setMod(xi.mod.BLINK, 0)
        target:delStatusEffect(xi.effect.COPY_IMAGE)
        target:delStatusEffect(xi.effect.BLINK)
    end

    -- handle Third Eye using shadowbehav as a guide
    local teye = target:getStatusEffect(xi.effect.THIRD_EYE)
    if teye ~= nil and skilltype == xi.attackType.PHYSICAL then -- T.Eye only procs when active with PHYSICAL stuff
        if shadowbehav == MOBPARAM_WIPE_SHADOWS then -- e.g. aoe moves
            target:delStatusEffect(xi.effect.THIRD_EYE)
        elseif shadowbehav ~= MOBPARAM_IGNORE_SHADOWS then -- it can be absorbed by shadows
            -- third eye doesnt care how many shadows, so attempt to anticipate, but reduce
            -- chance of anticipate based on previous successful anticipates.
            prevAnt = teye:getPower()
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
    if skilltype == xi.attackType.PHYSICAL and target:hasStatusEffect(xi.effect.PHYSICAL_SHIELD) then
        return 0
    end

    if skilltype == xi.attackType.RANGED and target:hasStatusEffect(xi.effect.ARROW_SHIELD) then
        return 0
    end

    -- handle elemental resistence
    if skilltype == xi.attackType.MAGICAL and target:hasStatusEffect(xi.effect.MAGIC_SHIELD) then
        return 0
    end

    -- handling phalanx
    dmg = dmg - target:getMod(xi.mod.PHALANX)
    if dmg < 0 then
        return 0
    end

    -- handle invincible
    if target:hasStatusEffect(xi.effect.INVINCIBLE) and skilltype == xi.attackType.PHYSICAL then
        return 0
    end
    -- handle pd
    if target:hasStatusEffect(xi.effect.PERFECT_DODGE) or target:hasStatusEffect(xi.effect.ALL_MISS) and skilltype ==
        xi.attackType.PHYSICAL then
        return 0
    end

    -- Calculate Blood Pact Damage before stoneskin
    dmg = dmg + dmg * mob:getMod(xi.mod.BP_DAMAGE) / 100

    -- handling stoneskin
    dmg = utils.stoneskin(target, dmg)

    return dmg
end

-- returns true if mob attack hit
-- used to stop tp move status effects
function AvatarPhysicalHit(skill, dmg)
    -- if message is not the default. Then there was a miss, shadow taken etc
    return skill:getMsg() == xi.msg.basic.DAMAGE
end

function avatarFTP(tp, ftp1, ftp2, ftp3)
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

-- Checks if the summoner is in a Trial Size Avatar Mini Fight (used to restrict summoning while in bcnm)
function avatarMiniFightCheck(caster)
    local result = 0
    local bcnmid
    if caster:hasStatusEffect(xi.effect.BATTLEFIELD) then
        bcnmid = caster:getStatusEffect(xi.effect.BATTLEFIELD):getPower()
        if bcnmid == 418 or bcnmid == 609 or bcnmid == 450 or bcnmid == 482 or bcnmid == 545 or bcnmid == 578 then -- Mini Avatar Fights
            result = 40 -- Cannot use <spell> in this area.
        end
    end
    return result
end
