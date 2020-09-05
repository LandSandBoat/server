
require("scripts/globals/common")
require("scripts/globals/status")
require("scripts/globals/msg")

function getSummoningSkillOverCap(avatar)
    local summoner = avatar:getMaster()
    local summoningSkill = summoner:getSkillLevel(tpz.skill.SUMMONING_MAGIC)
    local maxSkill = summoner:getMaxSkillLevel(avatar:getMainLvl(), tpz.job.SMN, tpz.skill.SUMMONING_MAGIC)
    return math.max(summoningSkill - maxSkill, 0)
end

function AvatarPhysicalMove(avatar, target, skill, numberofhits, accmod, dmgmod, dmgmodsubsequent, tpeffect, mtp100, mtp200, mtp300)
    local returninfo = {}

    local acc = avatar:getACC() + utils.clamp(getSummoningSkillOverCap(avatar), 0, 200)
    local eva = target:getEVA()
    local dmg = avatar:getWeaponDmg()
    local minFstr, maxFstr = avatarFSTR(avatar:getStat(tpz.mod.STR), target:getStat(tpz.mod.VIT))
    local ratio = avatar:getStat(tpz.mod.ATT) / target:getStat(tpz.mod.DEF)

    -- Note: Avatars do not have any level correction. This is why they are so good on Wyrms! // https://kegsay.livejournal.com/tag/smn!
    local hitrate = utils.clamp(acc - eva, 20, 95)

    -- add on native crit hit rate (guesstimated, it actually follows an exponential curve)
    local critrate = (avatar:getStat(tpz.mod.DEX) - target:getStat(tpz.mod.AGI)) * 0.005 -- assumes +0.5% crit rate per 1 dDEX
    critrate = critrate + avatar:getMod(tpz.mod.CRITHITRATE) / 100
    critrate = utils.clamp(critrate, 0.05, 0.2)

    -- Applying pDIF
    if ratio <= 1 then
        maxRatio = 1
        minRatio = 1/3
    elseif ratio < 1.6 then
        maxRatio = (2 * ratio + 1) / 3
        minRatio = (7 * ratio - 4) / 9
    elseif ratio <= 1.8 then
        maxRatio = 1.8
        minRatio = 1
    elseif ratio < 3.6 then
        maxRatio = 2.4 * ratio - 2.52
        minRatio = 5 * ratio / 3 - 2
    else
        maxRatio = 4.2
        minRatio = 4
    end

    -- start the hits
    local hitsdone = 1
    local hitslanded = 0
    local hitdmg = 0
    local finaldmg = 0

    if math.random() < hitrate then
        hitdmg = avatarHitDmg(dmg, minRatio, maxRatio, minFstr, maxFstr, critrate)
        finaldmg = finaldmg + hitdmg * dmgmod
        hitslanded = hitslanded + 1
    end

    while hitsdone < numberofhits do
        if math.random() < hitrate then
            hitdmg = avatarHitDmg(dmg, minRatio, maxRatio, minFstr, maxFstr, critrate)
            finaldmg = finaldmg + hitdmg * dmgmodsubsequent
            hitslanded = hitslanded + 1
        end
        hitsdone = hitsdone + 1
    end

    -- all hits missed
    if hitslanded == 0 or finaldmg == 0 then
        finaldmg = 0
        hitslanded = 0
        skill:setMsg(tpz.msg.basic.SKILL_MISS)

    -- some hits hit
    else
        target:wakeUp()
    end

    -- apply ftp bonus
    if tpeffect == TP_DMG_BONUS then
        finaldmg = finaldmg * avatarFTP(skill:getTP(), mtp100, mtp200, mtp300)
    end

    returninfo.dmg = finaldmg
    returninfo.hitslanded = hitslanded

    return returninfo
end

-- minFstr = dSTR/4 + 0.5
-- maxFstr = dSTR/4 + 0.25
function avatarFSTR(att_str, def_vit)
    local dSTR = att_str - def_vit
    return math.floor(dSTR / 4 + 0.5), math.floor(dSTR / 4 + 0.25)
end

function avatarHitDmg(dmg, pdifMin, pdifMax, fstrMin, fstrMax, critrate)
    local fstr = math.random(fstrMin, fstrMax)
    local pdif = math.random(pdifMin * 1000, pdifMax * 1000) / 1000
    if math.random() < critrate then
        pdif = math.min(pdif + 1, 4.2)
    end
    return (dmg + fstr) * pdif
end

function AvatarFinalAdjustments(dmg, mob, skill, target, skilltype, skillparam, shadowbehav)

    -- physical attack missed, skip rest
    if skilltype == tpz.attackType.PHYSICAL and dmg == 0 then
        return 0
    end

    -- set message to damage
    -- this is for AoE because its only set once
    skill:setMsg(tpz.msg.basic.DAMAGE)

    -- Handle shadows depending on shadow behaviour / skilltype
    if shadowbehav < 5 and shadowbehav ~= MOBPARAM_IGNORE_SHADOWS then -- remove 'shadowbehav' shadows.
        local targShadows = target:getMod(tpz.mod.UTSUSEMI)
        local shadowType = tpz.mod.UTSUSEMI
        if targShadows == 0 then -- try blink, as utsusemi always overwrites blink this is okay
            targShadows = target:getMod(tpz.mod.BLINK)
            shadowType = tpz.mod.BLINK
        end

        if targShadows > 0 then
        -- Blink has a VERY high chance of blocking tp moves, so im assuming its 100% because its easier!
            if targShadows >= shadowbehav then -- no damage, just suck the shadows
                skill:setMsg(tpz.msg.basic.SHADOW_ABSORB)
                target:setMod(shadowType, targShadows - shadowbehav)
                if shadowType == tpz.mod.UTSUSEMI then -- update icon
                    effect = target:getStatusEffect(tpz.effect.COPY_IMAGE)
                    if effect ~= nil then
                        if targShadows - shadowbehav == 0 then
                            target:delStatusEffect(tpz.effect.COPY_IMAGE)
                            target:delStatusEffect(tpz.effect.BLINK)
                        elseif targShadows - shadowbehav == 1 then
                            effect:setIcon(tpz.effect.COPY_IMAGE)
                        elseif targShadows - shadowbehav == 2 then
                            effect:setIcon(tpz.effect.COPY_IMAGE_2)
                        elseif targShadows - shadowbehav == 3 then
                            effect:setIcon(tpz.effect.COPY_IMAGE_3)
                        end
                    end
                end
                return shadowbehav
            else -- less shadows than this move will take, remove all and factor damage down
                dmg = dmg * (shadowbehav - targShadows) / shadowbehav
                target:setMod(tpz.mod.UTSUSEMI, 0)
                target:setMod(tpz.mod.BLINK, 0)
                target:delStatusEffect(tpz.effect.COPY_IMAGE)
                target:delStatusEffect(tpz.effect.BLINK)
            end
        end
    elseif shadowbehav == MOBPARAM_WIPE_SHADOWS then -- take em all!
        target:setMod(tpz.mod.UTSUSEMI, 0)
        target:setMod(tpz.mod.BLINK, 0)
        target:delStatusEffect(tpz.effect.COPY_IMAGE)
        target:delStatusEffect(tpz.effect.BLINK)
    end

    -- handle Third Eye using shadowbehav as a guide
    local teye = target:getStatusEffect(tpz.effect.THIRD_EYE)
    if teye ~= nil and skilltype == tpz.attackType.PHYSICAL then -- T.Eye only procs when active with PHYSICAL stuff
        if shadowbehav == MOBPARAM_WIPE_SHADOWS then -- e.g. aoe moves
            target:delStatusEffect(tpz.effect.THIRD_EYE)
        elseif shadowbehav ~= MOBPARAM_IGNORE_SHADOWS then -- it can be absorbed by shadows
            -- third eye doesnt care how many shadows, so attempt to anticipate, but reduce
            -- chance of anticipate based on previous successful anticipates.
            prevAnt = teye:getPower()
            if prevAnt == 0 then
                -- 100% proc
                teye:setPower(1)
                skill:setMsg(tpz.msg.basic.ANTICIPATE)
                return 0
            end
            if math.random() * 10 < 8 - prevAnt then
                -- anticipated!
                teye:setPower(prevAnt+1)
                skill:setMsg(tpz.msg.basic.ANTICIPATE)
                return 0
            end
            target:delStatusEffect(tpz.effect.THIRD_EYE)
        end
    end

    -- TODO: Handle anything else (e.g. if you have Magic Shield and its a Magic skill, then do 0 damage.
    if skilltype == tpz.attackType.PHYSICAL and target:hasStatusEffect(tpz.effect.PHYSICAL_SHIELD) then
        return 0
    end

    if skilltype == tpz.attackType.RANGED and target:hasStatusEffect(tpz.effect.ARROW_SHIELD) then
        return 0
    end

    -- handle elemental resistence
    if skilltype == tpz.attackType.MAGICAL and target:hasStatusEffect(tpz.effect.MAGIC_SHIELD) then
        return 0
    end

    -- handling phalanx
    dmg = dmg - target:getMod(tpz.mod.PHALANX)
    if dmg < 0 then
        return 0
    end

    -- handle invincible
    if target:hasStatusEffect(tpz.effect.INVINCIBLE) and skilltype == tpz.attackType.PHYSICAL then
        return 0
    end
    -- handle pd
    if target:hasStatusEffect(tpz.effect.PERFECT_DODGE) or target:hasStatusEffect(tpz.effect.TOO_HIGH) and skilltype == tpz.attackType.PHYSICAL then
        return 0
    end

    -- Calculate Blood Pact Damage before stoneskin
    dmg = dmg + dmg * mob:getMod(tpz.mod.BP_DAMAGE) / 100

    -- handling stoneskin
    dmg = utils.stoneskin(target, dmg)

    return dmg
end

-- returns true if mob attack hit
-- used to stop tp move status effects
function AvatarPhysicalHit(skill, dmg)
    -- if message is not the default. Then there was a miss, shadow taken etc
    return skill:getMsg() == tpz.msg.basic.DAMAGE
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
    if caster:hasStatusEffect(tpz.effect.BATTLEFIELD) then
        bcnmid = caster:getStatusEffect(tpz.effect.BATTLEFIELD):getPower()
        if bcnmid == 418 or bcnmid == 609 or bcnmid == 450 or bcnmid == 482 or bcnmid == 545 or bcnmid == 578 then -- Mini Avatar Fights
            result = 40 -- Cannot use <spell> in this area.
        end
    end
    return result
end
