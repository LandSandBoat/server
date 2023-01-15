-----------------------------------
-- Contains all common weaponskill calculations including but not limited to:
-- fSTR
-- Alpha
-- Ratio -> cRatio
-- min/max cRatio
-- applications of fTP
-- applications of critical hits ('Critical hit rate varies with TP.')
-- applications of accuracy mods ('Accuracy varies with TP.')
-- applications of damage mods ('Damage varies with TP.')
-- performance of the actual WS (rand numbers, etc)
-----------------------------------
require("scripts/globals/magicburst")
require("scripts/globals/magiantrials")
require("scripts/globals/ability")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/utils")
require("scripts/globals/msg")
-----------------------------------

-- Obtains alpha, used for working out WSC on legacy servers
local function getAlpha(level)
    -- Retail has no alpha anymore as of 2014. Weaponskill functions
    -- should be checking for xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES and
    -- overwriting the results of this function if the server has it set
    local alpha = 1.00

    if level <= 5 then
        alpha = 1.00
    elseif level <= 11 then
        alpha = 0.99
    elseif level <= 17 then
        alpha = 0.98
    elseif level <= 23 then
        alpha = 0.97
    elseif level <= 29 then
        alpha = 0.96
    elseif level <= 35 then
        alpha = 0.95
    elseif level <= 41 then
        alpha = 0.94
    elseif level <= 47 then
        alpha = 0.93
    elseif level <= 53 then
        alpha = 0.92
    elseif level <= 59 then
        alpha = 0.91
    elseif level <= 61 then
        alpha = 0.90
    elseif level <= 63 then
        alpha = 0.89
    elseif level <= 65 then
        alpha = 0.88
    elseif level <= 67 then
        alpha = 0.87
    elseif level <= 69 then
        alpha = 0.86
    elseif level <= 71 then
        alpha = 0.85
    elseif level <= 73 then
        alpha = 0.84
    elseif level <= 75 then
        alpha = 0.83
    elseif level < 99 then
        alpha = 0.85
    else
        alpha = 1
    end

    return alpha
end

local function souleaterBonus(attacker, wsParams)
    local bonus = 0

    if attacker:hasStatusEffect(xi.effect.SOULEATER) then
        local percent = 0.1

        if attacker:getMainJob() ~= xi.job.DRK then
            percent = percent / 2
        end

        percent = percent + math.min(0.02, 0.01 * attacker:getMod(xi.mod.SOULEATER_EFFECT))
        local health = attacker:getHP()

        if health > 10 then
            bonus = bonus + health * percent
        end

        attacker:delHP(wsParams.numHits * 0.10 * attacker:getHP())
    end

    return bonus
end

local function fencerBonus(attacker)
    local bonus = 0

    if attacker:getObjType() ~= xi.objType.PC then
        return 0
    end

    local mainEquip = attacker:getStorageItem(0, 0, xi.slot.MAIN)
    if
        mainEquip and
        not mainEquip:isTwoHanded() and
        not mainEquip:isHandToHand()
    then
        local subEquip = attacker:getStorageItem(0, 0, xi.slot.SUB)

        if
            subEquip == nil or
            subEquip:getSkillType() == xi.skill.NONE or
            subEquip:isShield()
        then
            bonus = attacker:getMod(xi.mod.FENCER_CRITHITRATE) / 100
        end
    end

    return bonus
end

local function shadowAbsorb(target)
    local targShadows = target:getMod(xi.mod.UTSUSEMI)
    local shadowType = xi.mod.UTSUSEMI

    if targShadows == 0 then
        if math.random() < 0.8 then
            targShadows = target:getMod(xi.mod.BLINK)
            shadowType = xi.mod.BLINK
        end
    end

    if targShadows > 0 then
        if shadowType == xi.mod.UTSUSEMI then
            local effect = target:getStatusEffect(xi.effect.COPY_IMAGE)
            if effect then
                if targShadows - 1 == 1 then
                    effect:setIcon(xi.effect.COPY_IMAGE)
                elseif targShadows - 1 == 2 then
                    effect:setIcon(xi.effect.COPY_IMAGE_2)
                elseif targShadows - 1 == 3 then
                    effect:setIcon(xi.effect.COPY_IMAGE_3)
                end
            end
        end

        target:setMod(shadowType, targShadows - 1)
        if targShadows - 1 == 0 then
            target:delStatusEffect(xi.effect.COPY_IMAGE)
            target:delStatusEffect(xi.effect.BLINK)
        end

        return true
    end

    return false
end

local function accVariesWithTP(hitrate, acc, tp, a1, a2, a3)
    -- sadly acc varies with tp ALL apply an acc PENALTY, the acc at various %s are given as a1 a2 a3
    local accpct = fTP(tp, a1, a2, a3)
    local acclost = acc - (acc * accpct)
    local hrate = hitrate - (0.005 * acclost)

    -- cap it
    if hrate > 0.95 then
        hrate = 0.95
    end

    if hrate < 0.2 then
        hrate = 0.2
    end

    return hrate
end

local function getMultiAttacks(attacker, target, wsParams)
    local numHits = wsParams.numHits
    local bonusHits = 0
    local multiChances = 1
    local doubleRate = (attacker:getMod(xi.mod.DOUBLE_ATTACK) + attacker:getMerit(xi.merit.DOUBLE_ATTACK_RATE)) / 100
    local tripleRate = (attacker:getMod(xi.mod.TRIPLE_ATTACK) + attacker:getMerit(xi.merit.TRIPLE_ATTACK_RATE)) / 100
    local quadRate = attacker:getMod(xi.mod.QUAD_ATTACK) / 100
    local oaThriceRate = attacker:getMod(xi.mod.MYTHIC_OCC_ATT_THRICE) / 100
    local oaTwiceRate = attacker:getMod(xi.mod.MYTHIC_OCC_ATT_TWICE) / 100

    local isJump = wsParams.isJump or false

    if isJump then
        doubleRate = doubleRate + attacker:getMod(xi.mod.JUMP_DOUBLE_ATTACK)
    end

    -- Add Ambush Augments to Triple Attack
    if attacker:hasTrait(76) and attacker:isBehind(target, 23) then -- TRAIT_AMBUSH
        tripleRate = tripleRate + attacker:getMerit(xi.merit.AMBUSH) / 3 -- Value of Ambush is 3 per mert, augment gives +1 Triple Attack per merit
    end

    -- QA/TA/DA can only proc on the first hit of each weapon or each fist
    if
        attacker:getOffhandDmg() > 0 or
        attacker:getWeaponSkillType(xi.slot.MAIN) == xi.skill.HAND_TO_HAND
    then
        multiChances = 2
    end

    for i = 1, multiChances, 1 do
        if math.random() < quadRate then
            bonusHits = bonusHits + 3
        elseif math.random() < tripleRate then
            bonusHits = bonusHits + 2
        elseif math.random() < doubleRate then
            bonusHits = bonusHits + 1
        elseif i == 1 and math.random() < oaThriceRate then -- Can only proc on first hit
            bonusHits = bonusHits + 2
        elseif i == 1 and math.random() < oaTwiceRate then -- Can only proc on first hit
            bonusHits = bonusHits + 1
        end

        if i == 1 then
            attacker:delStatusEffect(xi.effect.ASSASSINS_CHARGE)
            attacker:delStatusEffect(xi.effect.WARRIORS_CHARGE)

            -- recalculate DA/TA/QA rate
            doubleRate = (attacker:getMod(xi.mod.DOUBLE_ATTACK) + attacker:getMerit(xi.merit.DOUBLE_ATTACK_RATE)) / 100
            tripleRate = (attacker:getMod(xi.mod.TRIPLE_ATTACK) + attacker:getMerit(xi.merit.TRIPLE_ATTACK_RATE)) / 100
            quadRate = attacker:getMod(xi.mod.QUAD_ATTACK) / 100
        end
    end

    if (numHits + bonusHits) > 8 then
        return 8
    end

    return numHits + bonusHits
end

local function cRangedRatio(attacker, defender, params, ignoredDef, tp)
    local atkmulti = fTP(tp, params.atk100, params.atk200, params.atk300)
    local cratio = attacker:getRATT() / (defender:getStat(xi.mod.DEF) - ignoredDef)

    local levelCorrection = 0
    if attacker:getMainLvl() < defender:getMainLvl() then
        levelCorrection = 0.025 * (defender:getMainLvl() - attacker:getMainLvl())
    end

    cratio = cratio - levelCorrection
    cratio = cratio * atkmulti
    -- adding cap check base on weapon https://www.bg-wiki.com/ffxi/PDIF info
    local weaponType = attacker:getWeaponSkillType(xi.slot.RANGED)
    local cRatioCap = 0
    if weaponType == xi.skill.MARKSMANSHIP then
        cRatioCap = 3.5
    else
        cRatioCap = 3.25
    end

    if cratio < 0 then
        cratio = 0
    elseif cratio > cRatioCap then
        cratio = cRatioCap
    end

    -- max
    local pdifmax = 0

    if cratio < 0.9 then
        pdifmax = cratio * (10 / 9)
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
        pdifmin = (cratio * (20 / 19)) - (3 / 19)
    end

    local pdif = {}
    pdif[1] = pdifmin
    pdif[2] = pdifmax

    local pdifcrit = {}

    pdifmin = pdifmin * 1.25
    pdifmax = pdifmax * 1.25

    pdifcrit[1] = pdifmin
    pdifcrit[2] = pdifmax

    return pdif, pdifcrit
end

local function getRangedHitRate(attacker, target, capHitRate, bonus)
    local acc = attacker:getRACC()
    local eva = target:getEVA()

    if bonus == nil then
        bonus = 0
    end

    if
        target:hasStatusEffect(xi.effect.YONIN) and
        target:isFacing(attacker, 23)
    then
        -- Yonin evasion boost if defender is facing attacker
        bonus = bonus - target:getStatusEffect(xi.effect.YONIN):getPower()
    end

    if attacker:hasTrait(76) and attacker:isBehind(target, 23) then --TRAIT_AMBUSH
        bonus = bonus + attacker:getMerit(xi.merit.AMBUSH)
    end

    acc = acc + bonus

    if attacker:getMainLvl() > target:getMainLvl() then -- acc bonus!
        acc = acc + ((attacker:getMainLvl() - target:getMainLvl()) * 4)
    elseif attacker:getMainLvl() < target:getMainLvl() then -- acc penalty :(
        acc = acc - ((target:getMainLvl() - attacker:getMainLvl()) * 4)
    end

    local hitdiff = 0
    local hitrate = 75

    hitdiff = (acc - eva) / 2 -- no need to check if eva is hier or lower than acc it will be negative if eva is higher and positive if acc is higher

    hitrate = hitrate + hitdiff
    hitrate = hitrate / 100

    -- Applying hitrate caps
    if capHitRate then -- this isn't capped for when acc varies with tp, as more penalties are due
        if hitrate > 0.95 then
            hitrate = 0.95
        end

        if hitrate < 0.2 then
            hitrate = 0.2
        end
    end

    return hitrate
end

-- Function to calculate if a hit in a WS misses, criticals, and the respective damage done
local function getSingleHitDamage(attacker, target, dmg, wsParams, calcParams)
    local criticalHit = false
    local finaldmg = 0
    -- local pdif = 0 Reminder for Future Implementation!

    local missChance = math.random()

    if
        (missChance <= calcParams.hitRate or -- See if we hit the target
        calcParams.guaranteedHit or
        calcParams.melee and
        math.random() < attacker:getMod(xi.mod.ZANSHIN) / 100) and
        not calcParams.mustMiss
    then
        if not shadowAbsorb(target) then
            local critChance = math.random() -- See if we land a critical hit
            criticalHit = (wsParams.canCrit and critChance <= calcParams.critRate) or
                calcParams.forcedFirstCrit or
                calcParams.mightyStrikesApplicable

            if criticalHit then
                calcParams.criticalHit = true
                calcParams.pdif = generatePdif(calcParams.ccritratio[1], calcParams.ccritratio[2], true)
            else
                calcParams.pdif = generatePdif(calcParams.cratio[1], calcParams.cratio[2], true)
            end

            finaldmg = dmg * calcParams.pdif

            -- Duplicate the first hit with an added magical component for hybrid WSes
            if calcParams.hybridHit then
                -- Calculate magical bonuses and reductions
                local magicdmg = addBonusesAbility(attacker, wsParams.ele, target, finaldmg, wsParams)

                magicdmg = magicdmg * applyResistanceAbility(attacker, target, wsParams.ele, wsParams.skill, calcParams.bonusAcc)
                magicdmg = target:magicDmgTaken(magicdmg, wsParams.ele)

                if magicdmg > 0 then
                    magicdmg = adjustForTarget(target, magicdmg, wsParams.ele) -- this may absorb or nullify
                end

                if magicdmg > 0 then                                           -- handle nonzero damage if previous function does not absorb or nullify
                    magicdmg = magicdmg - target:getMod(xi.mod.PHALANX)
                    magicdmg = utils.clamp(magicdmg, 0, 99999)
                    magicdmg = utils.oneforall(target, magicdmg)
                    magicdmg = utils.stoneskin(target, magicdmg)
                end

                finaldmg = finaldmg + magicdmg
            end

            calcParams.hitsLanded = calcParams.hitsLanded + 1
        else
            calcParams.shadowsAbsorbed = calcParams.shadowsAbsorbed + 1
        end
    end

    return finaldmg, calcParams
end

local function modifyMeleeHitDamage(attacker, target, attackTbl, wsParams, rawDamage)
    local adjustedDamage = rawDamage

    if not wsParams.formless then
        adjustedDamage = target:physicalDmgTaken(adjustedDamage, attackTbl.damageType)

        if attackTbl.weaponType == xi.skill.HAND_TO_HAND then
            adjustedDamage = adjustedDamage * target:getMod(xi.mod.HTH_SDT) / 1000
        elseif
            attackTbl.weaponType == xi.skill.DAGGER or
            attackTbl.weaponType == xi.skill.POLEARM
        then
            adjustedDamage = adjustedDamage * target:getMod(xi.mod.PIERCE_SDT) / 1000
        elseif
            attackTbl.weaponType == xi.skill.CLUB or
            attackTbl.weaponType == xi.skill.STAFF
        then
            adjustedDamage = adjustedDamage * target:getMod(xi.mod.IMPACT_SDT) / 1000
        else
            adjustedDamage = adjustedDamage * target:getMod(xi.mod.SLASH_SDT) / 1000
        end
    end

    if adjustedDamage > 0 then
        adjustedDamage = adjustedDamage - target:getMod(xi.mod.PHALANX)
        adjustedDamage = utils.clamp(adjustedDamage, 0, 99999)
    end

    adjustedDamage = utils.stoneskin(target, adjustedDamage)

    adjustedDamage = adjustedDamage + souleaterBonus(attacker, wsParams)

    return adjustedDamage
end

local modParameters =
{
    [xi.mod.WS_STR_BONUS] = 'str_wsc',
    [xi.mod.WS_DEX_BONUS] = 'dex_wsc',
    [xi.mod.WS_VIT_BONUS] = 'vit_wsc',
    [xi.mod.WS_AGI_BONUS] = 'agi_wsc',
    [xi.mod.WS_INT_BONUS] = 'int_wsc',
    [xi.mod.WS_MND_BONUS] = 'mnd_wsc',
    [xi.mod.WS_CHR_BONUS] = 'chr_wsc',
}

local function calculateWsMods(attacker, calcParams, wsParams)
    local wsMods = calcParams.fSTR +
        (attacker:getStat(xi.mod.STR) * wsParams.str_wsc + attacker:getStat(xi.mod.DEX) * wsParams.dex_wsc +
        attacker:getStat(xi.mod.VIT) * wsParams.vit_wsc + attacker:getStat(xi.mod.AGI) * wsParams.agi_wsc +
        attacker:getStat(xi.mod.INT) * wsParams.int_wsc + attacker:getStat(xi.mod.MND) * wsParams.mnd_wsc +
        attacker:getStat(xi.mod.CHR) * wsParams.chr_wsc) * calcParams.alpha
    return wsMods
end

local function calculateDEXvsAGICritRate(attacker, target)
    -- See reference at https://www.bg-wiki.com/ffxi/Critical_Hit_Rate
    local nativecrit = 0
    local dexVsAgi = attacker:getStat(xi.mod.DEX) - target:getStat(xi.mod.AGI)
    if dexVsAgi < 7 then
        nativecrit = 0
    elseif dexVsAgi < 14 then
        nativecrit = 0.01
    elseif dexVsAgi < 20 then
        nativecrit = 0.02
    elseif dexVsAgi < 30 then
        nativecrit = 0.03
    elseif dexVsAgi < 40 then
        nativecrit = 0.04
    elseif dexVsAgi <= 50 then
        nativecrit = (dexVsAgi - 35) / 100
    else
        nativecrit = 0.15 -- caps only apply to base rate, not merits and mods
    end

    return nativecrit
end

-- Calculates the raw damage for a weaponskill, used by both doPhysicalWeaponskill and doRangedWeaponskill.
-- Behavior of damage calculations can vary based on the passed in calcParams, which are determined by the calling function
-- depending on the type of weaponskill being done, and any special cases for that weaponskill
--
-- wsParams can contain: ftp100, ftp200, ftp300, str_wsc, dex_wsc, vit_wsc, int_wsc, mnd_wsc, canCrit, crit100, crit200, crit300,
-- acc100, acc200, acc300, ignoresDef, ignore100, ignore200, ignore300, atk100, atk200, atk300, kick, hybridWS, hitsHigh, formless
--
-- See doPhysicalWeaponskill or doRangedWeaponskill for how calcParams are determined.
function calculateRawWSDmg(attacker, target, wsID, tp, action, wsParams, calcParams)
    local targetLvl = target:getMainLvl()
    local targetHp = target:getHP() + target:getMod(xi.mod.STONESKIN)

    -- Recalculate accuracy if it varies with TP, applied to all hits
    if wsParams.acc100 ~= 0 then
        calcParams.hitRate = accVariesWithTP(calcParams.hitRate, calcParams.accStat, tp, wsParams.acc100, wsParams.acc200, wsParams.acc300)
    end

    -- Calculate alpha, WSC, and our modifiers for our base per-hit damage
    if not calcParams.alpha then
        if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
            calcParams.alpha = 1
        else
            calcParams.alpha = getAlpha(attacker:getMainLvl())
        end
    end

    -- Begin Checks for bonus wsc bonuses. See the following for details:
    -- https://www.bg-wiki.com/bg/Utu_Grip
    -- https://www.bluegartr.com/threads/108199-Random-Facts-Thread-Other?p=6826618&viewfull=1#post6826618

    for modId, parameterName in pairs(modParameters) do
        if attacker:getMod(modId) > 0 then
            wsParams[parameterName] = wsParams[parameterName] + (attacker:getMod(modId) / 100)
        end
    end

    local wsMods = calculateWsMods(attacker, calcParams, wsParams)
    local mainBase = calcParams.weaponDamage[1] + wsMods + calcParams.bonusWSmods

    -- Calculate fTP multiplier
    local ftp = fTP(tp, wsParams.ftp100, wsParams.ftp200, wsParams.ftp300) + calcParams.bonusfTP

    -- Calculate critrates
    local critrate = calculateDEXvsAGICritRate(attacker, target)

    if wsParams.canCrit then -- Work out critical hit ratios
        local nativecrit = 0
        critrate = fTP(tp, wsParams.crit100, wsParams.crit200, wsParams.crit300)

        if calcParams.flourishEffect and calcParams.flourishEffect:getPower() > 1 then
            critrate = critrate + (10 + calcParams.flourishEffect:getSubPower() / 2) / 100
        end

        local fencerBonusVal = calcParams.fencerBonus or 0
        nativecrit = nativecrit + attacker:getMod(xi.mod.CRITHITRATE) / 100 + attacker:getMerit(xi.merit.CRIT_HIT_RATE) / 100
                                + fencerBonusVal - target:getMerit(xi.merit.ENEMY_CRIT_RATE) / 100

        -- Innin critical boost when attacker is behind target
        if
            attacker:hasStatusEffect(xi.effect.INNIN) and
            attacker:isBehind(target, 23)
        then
            nativecrit = nativecrit + attacker:getStatusEffect(xi.effect.INNIN):getPower()
        end

        critrate = critrate + nativecrit
    end

    calcParams.critRate = critrate

    -- Start the WS
    local hitdmg = 0
    local finaldmg = 0
    calcParams.hitsLanded = 0
    calcParams.shadowsAbsorbed = 0

    -- Calculate the damage from the first hit
    local dmg = mainBase * ftp
    hitdmg, calcParams = getSingleHitDamage(attacker, target, dmg, wsParams, calcParams)

    if calcParams.melee then
        hitdmg = modifyMeleeHitDamage(attacker, target, calcParams.attackInfo, wsParams, hitdmg)
    end

    if calcParams.skillType and hitdmg > 0 then
        attacker:trySkillUp(calcParams.skillType, targetLvl)
    end

    finaldmg = finaldmg + hitdmg

    -- Have to calculate added bonus for SA/TA here since it is done outside of the fTP multiplier
    if attacker:getMainJob() == xi.job.THF then
        -- Add DEX/AGI bonus to first hit if THF main and valid Sneak/Trick Attack
        if calcParams.sneakApplicable then
            finaldmg = finaldmg +
                        (attacker:getStat(xi.mod.DEX) * (1 + attacker:getMod(xi.mod.SNEAK_ATK_DEX) / 100) * calcParams.pdif) *
                        ((100 + (attacker:getMod(xi.mod.AUGMENTS_SA))) / 100)
        end

        if calcParams.trickApplicable then
            finaldmg = finaldmg +
                        (attacker:getStat(xi.mod.AGI) * (1 + attacker:getMod(xi.mod.TRICK_ATK_AGI) / 100) * calcParams.pdif) *
                        ((100 + (attacker:getMod(xi.mod.AUGMENTS_TA))) / 100)
        end
    end

    -- We've now accounted for any crit from SA/TA, or damage bonus for a Hybrid WS, so nullify them
    calcParams.forcedFirstCrit = false
    calcParams.hybridHit = false

    -- For items that apply bonus damage to the first hit of a weaponskill (but not later hits),
    -- store bonus damage for first hit, for use after other calculations are done
    local firstHitBonus = (finaldmg * attacker:getMod(xi.mod.ALL_WSDMG_FIRST_HIT)) / 100

    -- Reset fTP if it's not supposed to carry over across all hits for this WS
    -- We'll recalculate our mainhand damage after doing offhand
    if not wsParams.multiHitfTP then
        ftp = 1
    end

    -- Do the extra hit for our offhand if applicable
    if calcParams.extraOffhandHit and finaldmg < targetHp then
        local offhandDmg = (calcParams.weaponDamage[2] + wsMods) * ftp
        hitdmg, calcParams = getSingleHitDamage(attacker, target, offhandDmg, wsParams, calcParams)

        if calcParams.melee then
            hitdmg = modifyMeleeHitDamage(attacker, target, calcParams.attackInfo, wsParams, hitdmg)
        end

        if hitdmg > 0 then
            attacker:trySkillUp(calcParams.skillType, targetLvl)
        end

        finaldmg = finaldmg + hitdmg
    end

    calcParams.guaranteedHit = false -- Accuracy bonus from SA/TA applies only to first main and offhand hit
    calcParams.tpHitsLanded = calcParams.hitsLanded -- Store number of TP hits that have landed thus far
    calcParams.hitsLanded = 0 -- Reset counter to start tracking additional hits (from WS or Multi-Attacks)

    -- Calculate additional hits if a multiHit WS (or we're supposed to get a DA/TA/QA proc from main hit)
    dmg = mainBase * ftp
    local hitsDone = 1
    local numHits = getMultiAttacks(attacker, target, wsParams)

    while hitsDone < numHits and finaldmg < targetHp do -- numHits is hits in the base WS _and_ DA/TA/QA procs during those hits
        hitdmg, calcParams = getSingleHitDamage(attacker, target, dmg, wsParams, calcParams)

        if calcParams.melee then
            hitdmg = modifyMeleeHitDamage(attacker, target, calcParams.attackInfo, wsParams, hitdmg)
        end

        if hitdmg > 0 then
            attacker:trySkillUp(calcParams.skillType, targetLvl)
        end

        finaldmg = finaldmg + hitdmg
        hitsDone = hitsDone + 1
    end

    calcParams.extraHitsLanded = calcParams.hitsLanded

    -- Factor in "all hits" bonus damage mods
    local bonusdmg = attacker:getMod(xi.mod.ALL_WSDMG_ALL_HITS) -- For any WS

    if
        attacker:getMod(xi.mod.WEAPONSKILL_DAMAGE_BASE + wsID) > 0 and
        not attacker:isPet()
    then
        -- For specific WS
        bonusdmg = bonusdmg + attacker:getMod(xi.mod.WEAPONSKILL_DAMAGE_BASE + wsID)
    end

    finaldmg = finaldmg * ((100 + bonusdmg) / 100) -- Apply our "all hits" WS dmg bonuses
    finaldmg = finaldmg + firstHitBonus -- Finally add in our "first hit" WS dmg bonus from before

    -- Return our raw damage to then be modified by enemy reductions based off of melee/ranged
    calcParams.finalDmg = finaldmg

    return calcParams
end

-- Sets up the necessary calcParams for a melee WS before passing it to calculateRawWSDmg. When the raw
-- damage is returned, handles reductions based on target resistances and passes off to takeWeaponskillDamage.
function doPhysicalWeaponskill(attacker, target, wsID, wsParams, tp, action, primaryMsg, taChar)
    -- Determine cratio and ccritratio
    local ignoredDef = 0

    if wsParams.ignoresDef then
        ignoredDef = calculatedIgnoredDef(tp, target:getStat(xi.mod.DEF), wsParams.ignored100, wsParams.ignored200, wsParams.ignored300)
    end

    local cratio, ccritratio = cMeleeRatio(attacker, target, wsParams, ignoredDef, tp)

    -- Set up conditions and wsParams used for calculating weaponskill damage
    local gorgetBeltFTP, gorgetBeltAcc = handleWSGorgetBelt(attacker)
    local attack =
    {
        ['type'] = xi.attackType.PHYSICAL,
        ['slot'] = xi.slot.MAIN,
        ['weaponType'] = attacker:getWeaponSkillType(xi.slot.MAIN),
        ['damageType'] = attacker:getWeaponDamageType(xi.slot.MAIN)
    }

    local calcParams = {}
    calcParams.wsID = wsID
    calcParams.attackInfo = attack
    calcParams.weaponDamage = getMeleeDmg(attacker, attack.weaponType, wsParams.kick)
    calcParams.fSTR = fSTR(attacker:getStat(xi.mod.STR), target:getStat(xi.mod.VIT), attacker:getWeaponDmgRank())
    calcParams.cratio = cratio
    calcParams.ccritratio = ccritratio
    calcParams.accStat = attacker:getACC()
    calcParams.melee = true
    calcParams.mustMiss = target:hasStatusEffect(xi.effect.PERFECT_DODGE) or
        (target:hasStatusEffect(xi.effect.ALL_MISS) and not wsParams.hitsHigh)
    calcParams.sneakApplicable = attacker:hasStatusEffect(xi.effect.SNEAK_ATTACK) and
        (attacker:isBehind(target) or attacker:hasStatusEffect(xi.effect.HIDE) or
        target:hasStatusEffect(xi.effect.DOUBT))
    calcParams.taChar = taChar
    calcParams.trickApplicable = calcParams.taChar ~= nil
    calcParams.assassinApplicable = calcParams.trickApplicable and attacker:hasTrait(68)
    calcParams.guaranteedHit = calcParams.sneakApplicable or calcParams.trickApplicable
    calcParams.mightyStrikesApplicable = attacker:hasStatusEffect(xi.effect.MIGHTY_STRIKES)
    calcParams.forcedFirstCrit = calcParams.sneakApplicable or calcParams.assassinApplicable
    calcParams.extraOffhandHit = attacker:isDualWielding() or attack.weaponType == xi.skill.HAND_TO_HAND
    calcParams.hybridHit = wsParams.hybridWS
    calcParams.flourishEffect = attacker:getStatusEffect(xi.effect.BUILDING_FLOURISH)
    calcParams.fencerBonus = fencerBonus(attacker)
    calcParams.bonusTP = wsParams.bonusTP or 0

    local isJump = wsParams.isJump or false
    if isJump then
        calcParams.bonusfTP = 0
        calcParams.bonusAcc = attacker:getMod(xi.mod.JUMP_ACC_BONUS)
        calcParams.bonusWSmods = 0
    else
        calcParams.bonusfTP = gorgetBeltFTP or 0
        calcParams.bonusAcc = (gorgetBeltAcc or 0) + attacker:getMod(xi.mod.WSACC)
        calcParams.bonusWSmods = wsParams.bonusWSmods or 0
    end

    calcParams.hitRate = getHitRate(attacker, target, false, calcParams.bonusAcc)
    calcParams.skillType = attack.weaponType

    -- Send our wsParams off to calculate our raw WS damage, hits landed, and shadows absorbed
    calcParams = calculateRawWSDmg(attacker, target, wsID, tp, action, wsParams, calcParams)
    local finaldmg = calcParams.finalDmg

    -- Delete statuses that may have been spent by the WS
    attacker:delStatusEffectsByFlag(xi.effectFlag.DETECTABLE)
    attacker:delStatusEffect(xi.effect.SNEAK_ATTACK)
    attacker:delStatusEffectSilent(xi.effect.BUILDING_FLOURISH)

    finaldmg = finaldmg * xi.settings.main.WEAPON_SKILL_POWER -- Add server bonus

 --  1000 - 1050 DMG ~ 10 damage range

if finaldmg >= 1000 and finaldmg <= 1010 then
   finaldmg = math.random(1000, 1005)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1010 and finaldmg <= 1020 then
   finaldmg = math.random(1005, 1010)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1020 and finaldmg <= 1030 then
   finaldmg = math.random(1010, 1015)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1030 and finaldmg <= 1040 then
   finaldmg = math.random(1015, 1020)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1040 and finaldmg <= 1050 then
   finaldmg = math.random(1020, 1025)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1050 and finaldmg <= 1060 then
   finaldmg = math.random(1025, 1030)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1060 and finaldmg <= 1070 then
   finaldmg = math.random(1030, 1035)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1070 and finaldmg <= 1080 then
   finaldmg = math.random(1035, 1040)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1080 and finaldmg <= 1090 then
   finaldmg = math.random(1040, 1045)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1090 and finaldmg <= 1100 then
   finaldmg = math.random(1045, 1050)
   calcParams.finalDmg = finaldmg
end

 --  1050 - 1500 DMG ~ 15 damage range

if finaldmg >= 1100 and finaldmg <= 1115 then
   finaldmg = math.random(1050, 1055)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1115 and finaldmg <= 1130 then
   finaldmg = math.random(1055, 1060)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1130 and finaldmg <= 1145 then
   finaldmg = math.random(1060, 1065)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1145 and finaldmg <= 1160 then
   finaldmg = math.random(1065, 1070)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1160 and finaldmg <= 1175 then
   finaldmg = math.random(1070, 1075)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1175 and finaldmg <= 1190 then
   finaldmg = math.random(1075, 1080)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1190 and finaldmg <= 1205 then
   finaldmg = math.random(1080, 1085)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1205 and finaldmg <= 1220 then
   finaldmg = math.random(1085, 1090)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1220 and finaldmg <= 1235 then
   finaldmg = math.random(1090, 1095)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1235 and finaldmg <= 1250 then
   finaldmg = math.random(1095, 1100)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1250 and finaldmg <= 1265 then
   finaldmg = math.random(1100, 1105)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1265 and finaldmg <= 1280 then
   finaldmg = math.random(1105, 1110)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1280 and finaldmg <= 1295 then
   finaldmg = math.random(1110, 1115)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1295 and finaldmg <= 1310 then
   finaldmg = math.random(1115, 1120)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1310 and finaldmg <= 1325 then
   finaldmg = math.random(1120, 1125)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1325 and finaldmg <= 1340 then
   finaldmg = math.random(1125, 1130)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1340 and finaldmg <= 1355 then
   finaldmg = math.random(1130, 1135)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1355 and finaldmg <= 1370 then
   finaldmg = math.random(1135, 1140)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1370 and finaldmg <= 1385 then
   finaldmg = math.random(1140, 1145)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1385 and finaldmg <= 1400 then
   finaldmg = math.random(1145, 1150)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1400 and finaldmg <= 1415 then
   finaldmg = math.random(1150, 1155)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1415 and finaldmg <= 1430 then
   finaldmg = math.random(1155, 1160)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1430 and finaldmg <= 1445 then
   finaldmg = math.random(1160, 1165)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1445 and finaldmg <= 1460 then
   finaldmg = math.random(1165, 1170)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1460 and finaldmg <= 1475 then
   finaldmg = math.random(1170, 1175)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1475 and finaldmg <= 1490 then
   finaldmg = math.random(1175, 1180)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1490 and finaldmg <= 1505 then
   finaldmg = math.random(1180, 1185)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1505 and finaldmg <= 1520 then
   finaldmg = math.random(1185, 1190)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1520 and finaldmg <= 1535 then
   finaldmg = math.random(1190, 1195)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1535 and finaldmg <= 1550 then
   finaldmg = math.random(1195, 1200)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1550 and finaldmg <= 1565 then
   finaldmg = math.random(1200, 1205)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1565 and finaldmg <= 1580 then
   finaldmg = math.random(1205, 1210)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1580 and finaldmg <= 1595 then
   finaldmg = math.random(1210, 1215)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1595 and finaldmg <= 1610 then
   finaldmg = math.random(1215, 1220)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1610 and finaldmg <= 1625 then
   finaldmg = math.random(1220, 1225)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1625 and finaldmg <= 1640 then
   finaldmg = math.random(1225, 1230)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1640 and finaldmg <= 1655 then
   finaldmg = math.random(1230, 1235)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1655 and finaldmg <= 1670 then
   finaldmg = math.random(1235, 1240)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1670 and finaldmg <= 1685 then
   finaldmg = math.random(1240, 1245)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1685 and finaldmg <= 1700 then
   finaldmg = math.random(1245, 1250)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1700 and finaldmg <= 1715 then
   finaldmg = math.random(1250, 1255)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1715 and finaldmg <= 1730 then
   finaldmg = math.random(1255, 1260)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1730 and finaldmg <= 1745 then
   finaldmg = math.random(1260, 1265)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1745 and finaldmg <= 1760 then
   finaldmg = math.random(1265, 1270)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1760 and finaldmg <= 1775 then
   finaldmg = math.random(1270, 1275)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1775 and finaldmg <= 1790 then
   finaldmg = math.random(1275, 1280)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1790 and finaldmg <= 1805 then
   finaldmg = math.random(1280, 1285)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1805 and finaldmg <= 1820 then
   finaldmg = math.random(1285, 1290)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1820 and finaldmg <= 1835 then
   finaldmg = math.random(1290, 1295)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1835 and finaldmg <= 1850 then
   finaldmg = math.random(1295, 1300)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1850 and finaldmg <= 1865 then
   finaldmg = math.random(1300, 1305)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1865 and finaldmg <= 1880 then
   finaldmg = math.random(1305, 1310)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1880 and finaldmg <= 1895 then
   finaldmg = math.random(1310, 1315)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1895 and finaldmg <= 1910 then
   finaldmg = math.random(1315, 1320)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1910 and finaldmg <= 1925 then
   finaldmg = math.random(1320, 1325)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1925 and finaldmg <= 1940 then
   finaldmg = math.random(1325, 1330)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1940 and finaldmg <= 1955 then
   finaldmg = math.random(1330, 1335)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1955 and finaldmg <= 1970 then
   finaldmg = math.random(1335, 1340)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1970 and finaldmg <= 1985 then
   finaldmg = math.random(1340, 1345)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1985 and finaldmg <= 2000 then
   finaldmg = math.random(1345, 1350)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2000 and finaldmg <= 2015 then
   finaldmg = math.random(1350, 1355)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2015 and finaldmg <= 2030 then
   finaldmg = math.random(1355, 1360)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2030 and finaldmg <= 2045 then
   finaldmg = math.random(1360, 1365)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2045 and finaldmg <= 2060 then
   finaldmg = math.random(1365, 1370)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2060 and finaldmg <= 2075 then
   finaldmg = math.random(1370, 1375)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2075 and finaldmg <= 2090 then
   finaldmg = math.random(1375, 1380)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2090 and finaldmg <= 2105 then
   finaldmg = math.random(1380, 1385)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2105 and finaldmg <= 2120 then
   finaldmg = math.random(1385, 1390)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2120 and finaldmg <= 2135 then
   finaldmg = math.random(1390, 1395)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2135 and finaldmg <= 2150 then
   finaldmg = math.random(1395, 1400)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2150 and finaldmg <= 2165 then
   finaldmg = math.random(1400, 1405)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2165 and finaldmg <= 2180 then
   finaldmg = math.random(1405, 1410)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2180 and finaldmg <= 2195 then
   finaldmg = math.random(1410, 1415)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2195 and finaldmg <= 2210 then
   finaldmg = math.random(1415, 1420)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2210 and finaldmg <= 2225 then
   finaldmg = math.random(1420, 1425)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2225 and finaldmg <= 2240 then
   finaldmg = math.random(1425, 1430)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2240 and finaldmg <= 2255 then
   finaldmg = math.random(1430, 1435)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2255 and finaldmg <= 2270 then
   finaldmg = math.random(1435, 1440)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2270 and finaldmg <= 2285 then
   finaldmg = math.random(1440, 1445)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2285 and finaldmg <= 2300 then
   finaldmg = math.random(1445, 1450)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2300 and finaldmg <= 2315 then
   finaldmg = math.random(1450, 1455)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2315 and finaldmg <= 2330 then
   finaldmg = math.random(1455, 1460)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2330 and finaldmg <= 2345 then
   finaldmg = math.random(1460, 1465)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2345 and finaldmg <= 2360 then
   finaldmg = math.random(1465, 1470)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2360 and finaldmg <= 2375 then
   finaldmg = math.random(1470, 1475)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2375 and finaldmg <= 2390 then
   finaldmg = math.random(1475, 1480)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2390 and finaldmg <= 2405 then
   finaldmg = math.random(1480, 1485)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2405 and finaldmg <= 2420 then
   finaldmg = math.random(1485, 1490)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2420 and finaldmg <= 2435 then
   finaldmg = math.random(1490, 1495)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2435 and finaldmg <= 2450 then
   finaldmg = math.random(1495, 1500)
   calcParams.finalDmg = finaldmg
end

 --  1500 - 1800 DMG ~ 20 damage range

if finaldmg >= 2450 and finaldmg <= 2470 then
   finaldmg = math.random(1500, 1505)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2470 and finaldmg <= 2490 then
   finaldmg = math.random(1505, 1510)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2490 and finaldmg <= 2510 then
   finaldmg = math.random(1510, 1515)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2510 and finaldmg <= 2530 then
   finaldmg = math.random(1515, 1520)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2530 and finaldmg <= 2550 then
   finaldmg = math.random(1520, 1525)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2550 and finaldmg <= 2570 then
   finaldmg = math.random(1525, 1530)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2570 and finaldmg <= 2590 then
   finaldmg = math.random(1530, 1535)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2590 and finaldmg <= 2610 then
   finaldmg = math.random(1535, 1540)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2610 and finaldmg <= 2630 then
   finaldmg = math.random(1540, 1545)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2630 and finaldmg <= 2650 then
   finaldmg = math.random(1545, 1550)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2650 and finaldmg <= 2670 then
   finaldmg = math.random(1550, 1555)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2670 and finaldmg <= 2690 then
   finaldmg = math.random(1555, 1560)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2690 and finaldmg <= 2710 then
   finaldmg = math.random(1560, 1565)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2710 and finaldmg <= 2730 then
   finaldmg = math.random(1565, 1570)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2730 and finaldmg <= 2750 then
   finaldmg = math.random(1570, 1575)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2750 and finaldmg <= 2770 then
   finaldmg = math.random(1575, 1580)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2770 and finaldmg <= 2790 then
   finaldmg = math.random(1580, 1585)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2790 and finaldmg <= 2810 then
   finaldmg = math.random(1585, 1590)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2810 and finaldmg <= 2830 then
   finaldmg = math.random(1590, 1595)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2830 and finaldmg <= 2850 then
   finaldmg = math.random(1595, 1600)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2850 and finaldmg <= 2870 then
   finaldmg = math.random(1600, 1605)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2870 and finaldmg <= 2890 then
   finaldmg = math.random(1605, 1610)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2890 and finaldmg <= 3010 then
   finaldmg = math.random(1610, 1615)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3010 and finaldmg <= 3030 then
   finaldmg = math.random(1615, 1620)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3030 and finaldmg <= 3050 then
   finaldmg = math.random(1620, 1625)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3050 and finaldmg <= 3070 then
   finaldmg = math.random(1625, 1630)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3070 and finaldmg <= 3090 then
   finaldmg = math.random(1630, 1635)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3090 and finaldmg <= 3110 then
   finaldmg = math.random(1635, 1640)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3110 and finaldmg <= 3130 then
   finaldmg = math.random(1640, 1645)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3130 and finaldmg <= 3150 then
   finaldmg = math.random(1645, 1650)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3150 and finaldmg <= 3170 then
   finaldmg = math.random(1650, 1655)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3170 and finaldmg <= 3190 then
   finaldmg = math.random(1655, 1660)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3190 and finaldmg <= 3210 then
   finaldmg = math.random(1660, 1665)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3210 and finaldmg <= 3230 then
   finaldmg = math.random(1665, 1670)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3230 and finaldmg <= 3250 then
   finaldmg = math.random(1670, 1675)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3250 and finaldmg <= 3270 then
   finaldmg = math.random(1675, 1680)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3270 and finaldmg <= 3290 then
   finaldmg = math.random(1680, 1685)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3290 and finaldmg <= 3310 then
   finaldmg = math.random(1685, 1690)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3310 and finaldmg <= 3330 then
   finaldmg = math.random(1690, 1695)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3330 and finaldmg <= 3350 then
   finaldmg = math.random(1695, 1700)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3350 and finaldmg <= 3370 then
   finaldmg = math.random(1700, 1705)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3370 and finaldmg <= 3390 then
   finaldmg = math.random(1705, 1710)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3390 and finaldmg <= 3410 then
   finaldmg = math.random(1710, 1715)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3410 and finaldmg <= 3430 then
   finaldmg = math.random(1715, 1720)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3430 and finaldmg <= 3450 then
   finaldmg = math.random(1720, 1725)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3450 and finaldmg <= 3470 then
   finaldmg = math.random(1725, 1730)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3470 and finaldmg <= 3490 then
   finaldmg = math.random(1730, 1735)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3490 and finaldmg <= 3510 then
   finaldmg = math.random(1735, 1740)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3510 and finaldmg <= 3530 then
   finaldmg = math.random(1740, 1745)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3530 and finaldmg <= 3550 then
   finaldmg = math.random(1745, 1750)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3550 and finaldmg <= 3570 then
   finaldmg = math.random(1750, 1755)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3570 and finaldmg <= 3590 then
   finaldmg = math.random(1755, 1760)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3590 and finaldmg <= 3610 then
   finaldmg = math.random(1760, 1765)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3610 and finaldmg <= 3630 then
   finaldmg = math.random(1765, 1770)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3630 and finaldmg <= 3650 then
   finaldmg = math.random(1770, 1775)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3650 and finaldmg <= 3670 then
   finaldmg = math.random(1775, 1780)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3670 and finaldmg <= 3690 then
   finaldmg = math.random(1780, 1785)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3690 and finaldmg <= 3710 then
   finaldmg = math.random(1785, 1790)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3710 and finaldmg <= 3730 then
   finaldmg = math.random(1790, 1795)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3730 and finaldmg <= 3750 then
   finaldmg = math.random(1795, 1800)
   calcParams.finalDmg = finaldmg
end

 --  1800 - 1900 DMG ~ 50 damage range

if finaldmg >= 3750 and finaldmg <= 3800 then
   finaldmg = math.random(1800, 1805)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3800 and finaldmg <= 3850 then
   finaldmg = math.random(1805, 1810)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3850 and finaldmg <= 3900 then
   finaldmg = math.random(1810, 1815)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3900 and finaldmg <= 3950 then
   finaldmg = math.random(1815, 1820)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3950 and finaldmg <= 4000 then
   finaldmg = math.random(1820, 1825)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 4000 and finaldmg <= 4050 then
   finaldmg = math.random(1825, 1830)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 4050 and finaldmg <= 4100 then
   finaldmg = math.random(1830, 1835)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 4100 and finaldmg <= 4150 then
   finaldmg = math.random(1835, 1840)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 4150 and finaldmg <= 4200 then
   finaldmg = math.random(1840, 1845)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 4200 and finaldmg <= 4250 then
   finaldmg = math.random(1845, 1850)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 4250 and finaldmg <= 4300 then
   finaldmg = math.random(1850, 1855)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 4300 and finaldmg <= 4350 then
   finaldmg = math.random(1855, 1860)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 4350 and finaldmg <= 4400 then
   finaldmg = math.random(1860, 1865)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 4400 and finaldmg <= 4450 then
   finaldmg = math.random(1865, 1870)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 4450 and finaldmg <= 4500 then
   finaldmg = math.random(1870, 1875)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 4500 and finaldmg <= 4550 then
   finaldmg = math.random(1875, 1880)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 4550 and finaldmg <= 4600 then
   finaldmg = math.random(1880, 1885)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 4600 and finaldmg <= 4650 then
   finaldmg = math.random(1885, 1890)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 4650 and finaldmg <= 4700 then
   finaldmg = math.random(1890, 1895)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 4700 and finaldmg <= 4750 then
   finaldmg = math.random(1895, 1900)
   calcParams.finalDmg = finaldmg
end

   --  1900 - 2000 DMG ~ 100 damage range

if finaldmg >= 4750 and finaldmg <= 4850 then
   finaldmg = math.random(1900, 1905)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 4850 and finaldmg <= 4950 then
   finaldmg = math.random(1905, 1910)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 4950 and finaldmg <= 5050 then
   finaldmg = math.random(1910, 1915)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 5050 and finaldmg <= 5150 then
   finaldmg = math.random(1915, 1920)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 5150 and finaldmg <= 5250 then
   finaldmg = math.random(1920, 1925)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 5250 and finaldmg <= 5350 then
   finaldmg = math.random(1925, 1930)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 5350 and finaldmg <= 5450 then
   finaldmg = math.random(1930, 1935)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 5450 and finaldmg <= 5550 then
   finaldmg = math.random(1935, 1940)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 5550 and finaldmg <= 5650 then
   finaldmg = math.random(1940, 1945)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 5650 and finaldmg <= 5750 then
   finaldmg = math.random(1945, 1950)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 5750 and finaldmg <= 5850 then
   finaldmg = math.random(1950, 1955)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 5850 and finaldmg <= 5950 then
   finaldmg = math.random(1955, 1960)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 5950 and finaldmg <= 6050 then
   finaldmg = math.random(1960, 1965)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 6050 and finaldmg <= 6150 then
   finaldmg = math.random(1965, 1970)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 6150 and finaldmg <= 6250 then
   finaldmg = math.random(1970, 1975)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 6250 and finaldmg <= 6350 then
   finaldmg = math.random(1975, 1980)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 6350 and finaldmg <= 6450 then
   finaldmg = math.random(1980, 1985)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 6450 and finaldmg <= 6550 then
   finaldmg = math.random(1985, 1990)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 6550 and finaldmg <= 6650 then
   finaldmg = math.random(1990, 1995)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 6650 and finaldmg <= 6750 then
   finaldmg = math.random(1995, 2000)
   calcParams.finalDmg = finaldmg
end

 --  2000 - 2105 DMG ~ 200 damage range

if finaldmg >= 6750 and finaldmg <= 6950 then
   finaldmg = math.random(2000, 2005)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 6950 and finaldmg <= 7150 then
   finaldmg = math.random(2005, 2010)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 7150 and finaldmg <= 7350 then
   finaldmg = math.random(2010, 2015)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 7350 and finaldmg <= 7550 then
   finaldmg = math.random(2015, 2020)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 7550 and finaldmg <= 7750 then
   finaldmg = math.random(2020, 2025)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 7750 and finaldmg <= 7950 then
   finaldmg = math.random(2025, 2030)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 7950 and finaldmg <= 8150 then
   finaldmg = math.random(2030, 2035)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 8150 and finaldmg <= 8350 then
   finaldmg = math.random(2035, 2040)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 8350 and finaldmg <= 8550 then
   finaldmg = math.random(2040, 2045)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 8550 and finaldmg <= 8750 then
   finaldmg = math.random(2045, 2050)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 8750 and finaldmg <= 8950 then
   finaldmg = math.random(2050, 2055)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 8950 and finaldmg <= 9150 then
   finaldmg = math.random(2055, 2060)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 9150 and finaldmg <= 9350 then
   finaldmg = math.random(2060, 2065)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 9350 and finaldmg <= 9550 then
   finaldmg = math.random(2065, 2070)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 9550 and finaldmg <= 9750 then
   finaldmg = math.random(2070, 2075)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 9750 and finaldmg <= 9950 then
   finaldmg = math.random(2075, 2080)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 9950 and finaldmg <= 10150 then
   finaldmg = math.random(2080, 2085)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 10150 and finaldmg <= 10350 then
   finaldmg = math.random(2085, 2090)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 10350 and finaldmg <= 10550 then
   finaldmg = math.random(2090, 2095)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 10550 and finaldmg <= 10750 then
   finaldmg = math.random(2095, 2100)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 10750 then
    finaldmg = math.random(2100, 2105)
    calcParams.finalDmg = finaldmg
end

    finaldmg = takeWeaponskillDamage(target, attacker, wsParams, primaryMsg, attack, calcParams, action)

    return finaldmg, calcParams.criticalHit, calcParams.tpHitsLanded, calcParams.extraHitsLanded, calcParams.shadowsAbsorbed
end

-- Sets up the necessary calcParams for a ranged WS before passing it to calculateRawWSDmg. When the raw
-- damage is returned, handles reductions based on target resistances and passes off to takeWeaponskillDamage.
function doRangedWeaponskill(attacker, target, wsID, wsParams, tp, action, primaryMsg)
    -- Determine cratio and ccritratio
    local ignoredDef = 0

    if wsParams.ignoresDef then
        ignoredDef = calculatedIgnoredDef(tp, target:getStat(xi.mod.DEF), wsParams.ignored100, wsParams.ignored200, wsParams.ignored300)
    end

    local cratio, ccritratio = cRangedRatio(attacker, target, wsParams, ignoredDef, tp)

    -- Set up conditions and params used for calculating weaponskill damage
    local gorgetBeltFTP, gorgetBeltAcc = handleWSGorgetBelt(attacker)
    local attack =
    {
        ['type'] = xi.attackType.RANGED,
        ['slot'] = xi.slot.RANGED,
        ['weaponType'] = attacker:getWeaponSkillType(xi.slot.RANGED),
        ['damageType'] = attacker:getWeaponDamageType(xi.slot.RANGED)
    }

    local calcParams =
    {
        wsID = wsID,
        weaponDamage = { attacker:getRangedDmg() },
        skillType = attacker:getWeaponSkillType(xi.slot.RANGED),
        fSTR = fSTR2(attacker:getStat(xi.mod.STR), target:getStat(xi.mod.VIT), attacker:getRangedDmgRank()),
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
        fencerBonus = fencerBonus(attacker),
        bonusTP = wsParams.bonusTP or 0,
        bonusfTP = gorgetBeltFTP or 0,
        bonusAcc = (gorgetBeltAcc or 0) + attacker:getMod(xi.mod.WSACC),
        bonusWSmods = wsParams.bonusWSmods or 0
    }
    calcParams.hitRate = getRangedHitRate(attacker, target, false, calcParams.bonusAcc)

    -- Send our params off to calculate our raw WS damage, hits landed, and shadows absorbed
    calcParams = calculateRawWSDmg(attacker, target, wsID, tp, action, wsParams, calcParams)
    local finaldmg = calcParams.finalDmg

    -- Delete statuses that may have been spent by the WS
    attacker:delStatusEffectsByFlag(xi.effectFlag.DETECTABLE)

    -- Calculate reductions
    finaldmg = target:rangedDmgTaken(finaldmg)
    finaldmg = finaldmg * target:getMod(xi.mod.PIERCE_SDT) / 1000

    finaldmg = finaldmg * xi.settings.main.WEAPON_SKILL_POWER -- Add server bonus

 --  1000 - 1050 DMG ~ 10 damage range

 if finaldmg >= 1000 and finaldmg <= 1010 then
   finaldmg = math.random(1000, 1005)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1010 and finaldmg <= 1020 then
   finaldmg = math.random(1005, 1010)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1020 and finaldmg <= 1030 then
   finaldmg = math.random(1010, 1015)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1030 and finaldmg <= 1040 then
   finaldmg = math.random(1015, 1020)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1040 and finaldmg <= 1050 then
   finaldmg = math.random(1020, 1025)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1050 and finaldmg <= 1060 then
   finaldmg = math.random(1025, 1030)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1060 and finaldmg <= 1070 then
   finaldmg = math.random(1030, 1035)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1070 and finaldmg <= 1080 then
   finaldmg = math.random(1035, 1040)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1080 and finaldmg <= 1090 then
   finaldmg = math.random(1040, 1045)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1090 and finaldmg <= 1100 then
   finaldmg = math.random(1045, 1050)
   calcParams.finalDmg = finaldmg
end

 --  1050 - 1500 DMG ~ 15 damage range

if finaldmg >= 1100 and finaldmg <= 1115 then
   finaldmg = math.random(1050, 1055)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1115 and finaldmg <= 1130 then
   finaldmg = math.random(1055, 1060)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1130 and finaldmg <= 1145 then
   finaldmg = math.random(1060, 1065)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1145 and finaldmg <= 1160 then
   finaldmg = math.random(1065, 1070)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1160 and finaldmg <= 1175 then
   finaldmg = math.random(1070, 1075)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1175 and finaldmg <= 1190 then
   finaldmg = math.random(1075, 1080)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1190 and finaldmg <= 1205 then
   finaldmg = math.random(1080, 1085)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1205 and finaldmg <= 1220 then
   finaldmg = math.random(1085, 1090)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1220 and finaldmg <= 1235 then
   finaldmg = math.random(1090, 1095)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1235 and finaldmg <= 1250 then
   finaldmg = math.random(1095, 1100)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1250 and finaldmg <= 1265 then
   finaldmg = math.random(1100, 1105)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1265 and finaldmg <= 1280 then
   finaldmg = math.random(1105, 1110)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1280 and finaldmg <= 1295 then
   finaldmg = math.random(1110, 1115)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1295 and finaldmg <= 1310 then
   finaldmg = math.random(1115, 1120)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1310 and finaldmg <= 1325 then
   finaldmg = math.random(1120, 1125)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1325 and finaldmg <= 1340 then
   finaldmg = math.random(1125, 1130)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1340 and finaldmg <= 1355 then
   finaldmg = math.random(1130, 1135)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1355 and finaldmg <= 1370 then
   finaldmg = math.random(1135, 1140)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1370 and finaldmg <= 1385 then
   finaldmg = math.random(1140, 1145)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1385 and finaldmg <= 1400 then
   finaldmg = math.random(1145, 1150)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1400 and finaldmg <= 1415 then
   finaldmg = math.random(1150, 1155)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1415 and finaldmg <= 1430 then
   finaldmg = math.random(1155, 1160)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1430 and finaldmg <= 1445 then
   finaldmg = math.random(1160, 1165)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1445 and finaldmg <= 1460 then
   finaldmg = math.random(1165, 1170)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1460 and finaldmg <= 1475 then
   finaldmg = math.random(1170, 1175)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1475 and finaldmg <= 1490 then
   finaldmg = math.random(1175, 1180)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1490 and finaldmg <= 1505 then
   finaldmg = math.random(1180, 1185)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1505 and finaldmg <= 1520 then
   finaldmg = math.random(1185, 1190)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1520 and finaldmg <= 1535 then
   finaldmg = math.random(1190, 1195)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1535 and finaldmg <= 1550 then
   finaldmg = math.random(1195, 1200)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1550 and finaldmg <= 1565 then
   finaldmg = math.random(1200, 1205)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1565 and finaldmg <= 1580 then
   finaldmg = math.random(1205, 1210)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1580 and finaldmg <= 1595 then
   finaldmg = math.random(1210, 1215)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1595 and finaldmg <= 1610 then
   finaldmg = math.random(1215, 1220)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1610 and finaldmg <= 1625 then
   finaldmg = math.random(1220, 1225)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1625 and finaldmg <= 1640 then
   finaldmg = math.random(1225, 1230)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1640 and finaldmg <= 1655 then
   finaldmg = math.random(1230, 1235)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1655 and finaldmg <= 1670 then
   finaldmg = math.random(1235, 1240)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1670 and finaldmg <= 1685 then
   finaldmg = math.random(1240, 1245)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1685 and finaldmg <= 1700 then
   finaldmg = math.random(1245, 1250)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1700 and finaldmg <= 1715 then
   finaldmg = math.random(1250, 1255)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1715 and finaldmg <= 1730 then
   finaldmg = math.random(1255, 1260)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1730 and finaldmg <= 1745 then
   finaldmg = math.random(1260, 1265)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1745 and finaldmg <= 1760 then
   finaldmg = math.random(1265, 1270)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1760 and finaldmg <= 1775 then
   finaldmg = math.random(1270, 1275)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1775 and finaldmg <= 1790 then
   finaldmg = math.random(1275, 1280)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1790 and finaldmg <= 1805 then
   finaldmg = math.random(1280, 1285)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1805 and finaldmg <= 1820 then
   finaldmg = math.random(1285, 1290)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1820 and finaldmg <= 1835 then
   finaldmg = math.random(1290, 1295)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1835 and finaldmg <= 1850 then
   finaldmg = math.random(1295, 1300)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1850 and finaldmg <= 1865 then
   finaldmg = math.random(1300, 1305)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1865 and finaldmg <= 1880 then
   finaldmg = math.random(1305, 1310)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1880 and finaldmg <= 1895 then
   finaldmg = math.random(1310, 1315)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1895 and finaldmg <= 1910 then
   finaldmg = math.random(1315, 1320)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1910 and finaldmg <= 1925 then
   finaldmg = math.random(1320, 1325)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1925 and finaldmg <= 1940 then
   finaldmg = math.random(1325, 1330)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1940 and finaldmg <= 1955 then
   finaldmg = math.random(1330, 1335)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1955 and finaldmg <= 1970 then
   finaldmg = math.random(1335, 1340)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1970 and finaldmg <= 1985 then
   finaldmg = math.random(1340, 1345)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 1985 and finaldmg <= 2000 then
   finaldmg = math.random(1345, 1350)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2000 and finaldmg <= 2015 then
   finaldmg = math.random(1350, 1355)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2015 and finaldmg <= 2030 then
   finaldmg = math.random(1355, 1360)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2030 and finaldmg <= 2045 then
   finaldmg = math.random(1360, 1365)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2045 and finaldmg <= 2060 then
   finaldmg = math.random(1365, 1370)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2060 and finaldmg <= 2075 then
   finaldmg = math.random(1370, 1375)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2075 and finaldmg <= 2090 then
   finaldmg = math.random(1375, 1380)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2090 and finaldmg <= 2105 then
   finaldmg = math.random(1380, 1385)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2105 and finaldmg <= 2120 then
   finaldmg = math.random(1385, 1390)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2120 and finaldmg <= 2135 then
   finaldmg = math.random(1390, 1395)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2135 and finaldmg <= 2150 then
   finaldmg = math.random(1395, 1400)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2150 and finaldmg <= 2165 then
   finaldmg = math.random(1400, 1405)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2165 and finaldmg <= 2180 then
   finaldmg = math.random(1405, 1410)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2180 and finaldmg <= 2195 then
   finaldmg = math.random(1410, 1415)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2195 and finaldmg <= 2210 then
   finaldmg = math.random(1415, 1420)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2210 and finaldmg <= 2225 then
   finaldmg = math.random(1420, 1425)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2225 and finaldmg <= 2240 then
   finaldmg = math.random(1425, 1430)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2240 and finaldmg <= 2255 then
   finaldmg = math.random(1430, 1435)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2255 and finaldmg <= 2270 then
   finaldmg = math.random(1435, 1440)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2270 and finaldmg <= 2285 then
   finaldmg = math.random(1440, 1445)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2285 and finaldmg <= 2300 then
   finaldmg = math.random(1445, 1450)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2300 and finaldmg <= 2315 then
   finaldmg = math.random(1450, 1455)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2315 and finaldmg <= 2330 then
   finaldmg = math.random(1455, 1460)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2330 and finaldmg <= 2345 then
   finaldmg = math.random(1460, 1465)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2345 and finaldmg <= 2360 then
   finaldmg = math.random(1465, 1470)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2360 and finaldmg <= 2375 then
   finaldmg = math.random(1470, 1475)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2375 and finaldmg <= 2390 then
   finaldmg = math.random(1475, 1480)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2390 and finaldmg <= 2405 then
   finaldmg = math.random(1480, 1485)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2405 and finaldmg <= 2420 then
   finaldmg = math.random(1485, 1490)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2420 and finaldmg <= 2435 then
   finaldmg = math.random(1490, 1495)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2435 and finaldmg <= 2450 then
   finaldmg = math.random(1495, 1500)
   calcParams.finalDmg = finaldmg
end

 --  1500 - 1800 DMG ~ 20 damage range

if finaldmg >= 2450 and finaldmg <= 2470 then
   finaldmg = math.random(1500, 1505)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2470 and finaldmg <= 2490 then
   finaldmg = math.random(1505, 1510)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2490 and finaldmg <= 2510 then
   finaldmg = math.random(1510, 1515)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2510 and finaldmg <= 2530 then
   finaldmg = math.random(1515, 1520)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2530 and finaldmg <= 2550 then
   finaldmg = math.random(1520, 1525)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2550 and finaldmg <= 2570 then
   finaldmg = math.random(1525, 1530)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2570 and finaldmg <= 2590 then
   finaldmg = math.random(1530, 1535)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2590 and finaldmg <= 2610 then
   finaldmg = math.random(1535, 1540)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2610 and finaldmg <= 2630 then
   finaldmg = math.random(1540, 1545)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2630 and finaldmg <= 2650 then
   finaldmg = math.random(1545, 1550)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2650 and finaldmg <= 2670 then
   finaldmg = math.random(1550, 1555)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2670 and finaldmg <= 2690 then
   finaldmg = math.random(1555, 1560)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2690 and finaldmg <= 2710 then
   finaldmg = math.random(1560, 1565)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2710 and finaldmg <= 2730 then
   finaldmg = math.random(1565, 1570)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2730 and finaldmg <= 2750 then
   finaldmg = math.random(1570, 1575)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2750 and finaldmg <= 2770 then
   finaldmg = math.random(1575, 1580)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2770 and finaldmg <= 2790 then
   finaldmg = math.random(1580, 1585)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2790 and finaldmg <= 2810 then
   finaldmg = math.random(1585, 1590)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2810 and finaldmg <= 2830 then
   finaldmg = math.random(1590, 1595)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2830 and finaldmg <= 2850 then
   finaldmg = math.random(1595, 1600)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2850 and finaldmg <= 2870 then
   finaldmg = math.random(1600, 1605)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2870 and finaldmg <= 2890 then
   finaldmg = math.random(1605, 1610)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 2890 and finaldmg <= 3010 then
   finaldmg = math.random(1610, 1615)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3010 and finaldmg <= 3030 then
   finaldmg = math.random(1615, 1620)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3030 and finaldmg <= 3050 then
   finaldmg = math.random(1620, 1625)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3050 and finaldmg <= 3070 then
   finaldmg = math.random(1625, 1630)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3070 and finaldmg <= 3090 then
   finaldmg = math.random(1630, 1635)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3090 and finaldmg <= 3110 then
   finaldmg = math.random(1635, 1640)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3110 and finaldmg <= 3130 then
   finaldmg = math.random(1640, 1645)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3130 and finaldmg <= 3150 then
   finaldmg = math.random(1645, 1650)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3150 and finaldmg <= 3170 then
   finaldmg = math.random(1650, 1655)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3170 and finaldmg <= 3190 then
   finaldmg = math.random(1655, 1660)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3190 and finaldmg <= 3210 then
   finaldmg = math.random(1660, 1665)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3210 and finaldmg <= 3230 then
   finaldmg = math.random(1665, 1670)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3230 and finaldmg <= 3250 then
   finaldmg = math.random(1670, 1675)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3250 and finaldmg <= 3270 then
   finaldmg = math.random(1675, 1680)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3270 and finaldmg <= 3290 then
   finaldmg = math.random(1680, 1685)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3290 and finaldmg <= 3310 then
   finaldmg = math.random(1685, 1690)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3310 and finaldmg <= 3330 then
   finaldmg = math.random(1690, 1695)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3330 and finaldmg <= 3350 then
   finaldmg = math.random(1695, 1700)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3350 and finaldmg <= 3370 then
   finaldmg = math.random(1700, 1705)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3370 and finaldmg <= 3390 then
   finaldmg = math.random(1705, 1710)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3390 and finaldmg <= 3410 then
   finaldmg = math.random(1710, 1715)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3410 and finaldmg <= 3430 then
   finaldmg = math.random(1715, 1720)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3430 and finaldmg <= 3450 then
   finaldmg = math.random(1720, 1725)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3450 and finaldmg <= 3470 then
   finaldmg = math.random(1725, 1730)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3470 and finaldmg <= 3490 then
   finaldmg = math.random(1730, 1735)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3490 and finaldmg <= 3510 then
   finaldmg = math.random(1735, 1740)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3510 and finaldmg <= 3530 then
   finaldmg = math.random(1740, 1745)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3530 and finaldmg <= 3550 then
   finaldmg = math.random(1745, 1750)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3550 and finaldmg <= 3570 then
   finaldmg = math.random(1750, 1755)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3570 and finaldmg <= 3590 then
   finaldmg = math.random(1755, 1760)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3590 and finaldmg <= 3610 then
   finaldmg = math.random(1760, 1765)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3610 and finaldmg <= 3630 then
   finaldmg = math.random(1765, 1770)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3630 and finaldmg <= 3650 then
   finaldmg = math.random(1770, 1775)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3650 and finaldmg <= 3670 then
   finaldmg = math.random(1775, 1780)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3670 and finaldmg <= 3690 then
   finaldmg = math.random(1780, 1785)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3690 and finaldmg <= 3710 then
   finaldmg = math.random(1785, 1790)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3710 and finaldmg <= 3730 then
   finaldmg = math.random(1790, 1795)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3730 and finaldmg <= 3750 then
   finaldmg = math.random(1795, 1800)
   calcParams.finalDmg = finaldmg
end

 --  1800 - 1900 DMG ~ 50 damage range

if finaldmg >= 3750 and finaldmg <= 3800 then
   finaldmg = math.random(1800, 1805)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3800 and finaldmg <= 3850 then
   finaldmg = math.random(1805, 1810)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3850 and finaldmg <= 3900 then
   finaldmg = math.random(1810, 1815)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3900 and finaldmg <= 3950 then
   finaldmg = math.random(1815, 1820)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 3950 and finaldmg <= 4000 then
   finaldmg = math.random(1820, 1825)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 4000 and finaldmg <= 4050 then
   finaldmg = math.random(1825, 1830)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 4050 and finaldmg <= 4100 then
   finaldmg = math.random(1830, 1835)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 4100 and finaldmg <= 4150 then
   finaldmg = math.random(1835, 1840)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 4150 and finaldmg <= 4200 then
   finaldmg = math.random(1840, 1845)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 4200 and finaldmg <= 4250 then
   finaldmg = math.random(1845, 1850)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 4250 and finaldmg <= 4300 then
   finaldmg = math.random(1850, 1855)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 4300 and finaldmg <= 4350 then
   finaldmg = math.random(1855, 1860)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 4350 and finaldmg <= 4400 then
   finaldmg = math.random(1860, 1865)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 4400 and finaldmg <= 4450 then
   finaldmg = math.random(1865, 1870)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 4450 and finaldmg <= 4500 then
   finaldmg = math.random(1870, 1875)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 4500 and finaldmg <= 4550 then
   finaldmg = math.random(1875, 1880)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 4550 and finaldmg <= 4600 then
   finaldmg = math.random(1880, 1885)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 4600 and finaldmg <= 4650 then
   finaldmg = math.random(1885, 1890)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 4650 and finaldmg <= 4700 then
   finaldmg = math.random(1890, 1895)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 4700 and finaldmg <= 4750 then
   finaldmg = math.random(1895, 1900)
   calcParams.finalDmg = finaldmg
end

   --  1900 - 2000 DMG ~ 100 damage range

if finaldmg >= 4750 and finaldmg <= 4850 then
   finaldmg = math.random(1900, 1905)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 4850 and finaldmg <= 4950 then
   finaldmg = math.random(1905, 1910)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 4950 and finaldmg <= 5050 then
   finaldmg = math.random(1910, 1915)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 5050 and finaldmg <= 5150 then
   finaldmg = math.random(1915, 1920)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 5150 and finaldmg <= 5250 then
   finaldmg = math.random(1920, 1925)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 5250 and finaldmg <= 5350 then
   finaldmg = math.random(1925, 1930)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 5350 and finaldmg <= 5450 then
   finaldmg = math.random(1930, 1935)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 5450 and finaldmg <= 5550 then
   finaldmg = math.random(1935, 1940)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 5550 and finaldmg <= 5650 then
   finaldmg = math.random(1940, 1945)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 5650 and finaldmg <= 5750 then
   finaldmg = math.random(1945, 1950)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 5750 and finaldmg <= 5850 then
   finaldmg = math.random(1950, 1955)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 5850 and finaldmg <= 5950 then
   finaldmg = math.random(1955, 1960)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 5950 and finaldmg <= 6050 then
   finaldmg = math.random(1960, 1965)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 6050 and finaldmg <= 6150 then
   finaldmg = math.random(1965, 1970)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 6150 and finaldmg <= 6250 then
   finaldmg = math.random(1970, 1975)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 6250 and finaldmg <= 6350 then
   finaldmg = math.random(1975, 1980)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 6350 and finaldmg <= 6450 then
   finaldmg = math.random(1980, 1985)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 6450 and finaldmg <= 6550 then
   finaldmg = math.random(1985, 1990)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 6550 and finaldmg <= 6650 then
   finaldmg = math.random(1990, 1995)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 6650 and finaldmg <= 6750 then
   finaldmg = math.random(1995, 2000)
   calcParams.finalDmg = finaldmg
end

 --  2000 - 2105 DMG ~ 200 damage range

if finaldmg >= 6750 and finaldmg <= 6950 then
   finaldmg = math.random(2000, 2005)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 6950 and finaldmg <= 7150 then
   finaldmg = math.random(2005, 2010)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 7150 and finaldmg <= 7350 then
   finaldmg = math.random(2010, 2015)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 7350 and finaldmg <= 7550 then
   finaldmg = math.random(2015, 2020)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 7550 and finaldmg <= 7750 then
   finaldmg = math.random(2020, 2025)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 7750 and finaldmg <= 7950 then
   finaldmg = math.random(2025, 2030)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 7950 and finaldmg <= 8150 then
   finaldmg = math.random(2030, 2035)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 8150 and finaldmg <= 8350 then
   finaldmg = math.random(2035, 2040)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 8350 and finaldmg <= 8550 then
   finaldmg = math.random(2040, 2045)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 8550 and finaldmg <= 8750 then
   finaldmg = math.random(2045, 2050)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 8750 and finaldmg <= 8950 then
   finaldmg = math.random(2050, 2055)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 8950 and finaldmg <= 9150 then
   finaldmg = math.random(2055, 2060)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 9150 and finaldmg <= 9350 then
   finaldmg = math.random(2060, 2065)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 9350 and finaldmg <= 9550 then
   finaldmg = math.random(2065, 2070)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 9550 and finaldmg <= 9750 then
   finaldmg = math.random(2070, 2075)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 9750 and finaldmg <= 9950 then
   finaldmg = math.random(2075, 2080)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 9950 and finaldmg <= 10150 then
   finaldmg = math.random(2080, 2085)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 10150 and finaldmg <= 10350 then
   finaldmg = math.random(2085, 2090)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 10350 and finaldmg <= 10550 then
   finaldmg = math.random(2090, 2095)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 10550 and finaldmg <= 10750 then
   finaldmg = math.random(2095, 2100)
   calcParams.finalDmg = finaldmg
end

if finaldmg >= 10750 then
    finaldmg = math.random(2100, 2105)
    calcParams.finalDmg = finaldmg
end

    finaldmg = takeWeaponskillDamage(target, attacker, wsParams, primaryMsg, attack, calcParams, action)

    return finaldmg, calcParams.criticalHit, calcParams.tpHitsLanded, calcParams.extraHitsLanded, calcParams.shadowsAbsorbed
end

-- params: ftp100, ftp200, ftp300, wsc_str, wsc_dex, wsc_vit, wsc_agi, wsc_int, wsc_mnd, wsc_chr,
--         ele (xi.magic.ele.FIRE), skill (xi.skill.STAFF)

function doMagicWeaponskill(attacker, target, wsID, wsParams, tp, action, primaryMsg)
    -- Set up conditions and wsParams used for calculating weaponskill damage
    local attack =
    {
        ['type'] = xi.attackType.MAGICAL,
        ['slot'] = xi.slot.MAIN,
        ['weaponType'] = attacker:getWeaponSkillType(xi.slot.MAIN),
        ['damageType'] = xi.damageType.ELEMENTAL + wsParams.ele
    }

    local calcParams =
    {
        ['shadowsAbsorbed'] = 0,
        ['tpHitsLanded']    = 1,
        ['extraHitsLanded'] = 0,
        ['bonusTP']         = wsParams.bonusTP or 0,
        ['wsID']            = wsID
    }

    local bonusfTP, bonusacc = handleWSGorgetBelt(attacker)
    bonusacc = bonusacc + attacker:getMod(xi.mod.WSACC)

    local fint = utils.clamp(8 + (attacker:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)), -32, 32)
    local dmg = 0

    -- Magic-based WSes never miss, so we don't need to worry about calculating a miss, only if a shadow absorbed it.
    if not shadowAbsorb(target) then

        -- Begin Checks for bonus wsc bonuses. See the following for details:
        -- https://www.bg-wiki.com/bg/Utu_Grip
        -- https://www.bluegartr.com/threads/108199-Random-Facts-Thread-Other?p=6826618&viewfull=1#post6826618

        for modId, parameterName in pairs(modParameters) do
            if attacker:getMod(modId) > 0 then
                wsParams[parameterName] = wsParams[parameterName] + (attacker:getMod(modId) / 100)
            end
        end

        dmg = attacker:getMainLvl() + 2 + (attacker:getStat(xi.mod.STR) * wsParams.str_wsc + attacker:getStat(xi.mod.DEX) * wsParams.dex_wsc +
            attacker:getStat(xi.mod.VIT) * wsParams.vit_wsc + attacker:getStat(xi.mod.AGI) * wsParams.agi_wsc +
            attacker:getStat(xi.mod.INT) * wsParams.int_wsc + attacker:getStat(xi.mod.MND) * wsParams.mnd_wsc +
            attacker:getStat(xi.mod.CHR) * wsParams.chr_wsc) + fint

        -- Applying fTP multiplier
        local ftp = fTP(tp, wsParams.ftp100, wsParams.ftp200, wsParams.ftp300) + bonusfTP

        dmg = dmg * ftp

        -- Factor in "all hits" bonus damage mods
        local bonusdmg = attacker:getMod(xi.mod.ALL_WSDMG_ALL_HITS) -- For any WS
        if
            attacker:getMod(xi.mod.WEAPONSKILL_DAMAGE_BASE + wsID) > 0 and
            not attacker:isPet()
        then
            -- For specific WS
            bonusdmg = bonusdmg + attacker:getMod(xi.mod.WEAPONSKILL_DAMAGE_BASE + wsID)
        end

        -- Add in bonusdmg
        dmg = dmg * ((100 + bonusdmg) / 100) -- Apply our "all hits" WS dmg bonuses
        dmg = dmg + ((dmg * attacker:getMod(xi.mod.ALL_WSDMG_FIRST_HIT)) / 100) -- Add in our "first hit" WS dmg bonus

        -- Calculate magical bonuses and reductions
        dmg = addBonusesAbility(attacker, wsParams.ele, target, dmg, wsParams)
        dmg = dmg * applyResistanceAbility(attacker, target, wsParams.ele, wsParams.skill, bonusacc)
        dmg = target:magicDmgTaken(dmg, wsParams.ele)

        if dmg < 0 then
            calcParams.finalDmg = dmg

            dmg = takeWeaponskillDamage(target, attacker, wsParams, primaryMsg, attack, calcParams, action)
            return dmg
        end

        dmg = adjustForTarget(target, dmg, wsParams.ele)

        if dmg > 0 then
            dmg = dmg - target:getMod(xi.mod.PHALANX)
            dmg = utils.clamp(dmg, 0, 99999)
        end

        dmg = utils.oneforall(target, dmg)
        dmg = utils.stoneskin(target, dmg)

        dmg = dmg * xi.settings.main.WEAPON_SKILL_POWER -- Add server bonus
    else
        calcParams.shadowsAbsorbed = 1
    end


    calcParams.finalDmg = dmg

    if dmg > 0 then
        attacker:trySkillUp(attack.weaponType, target:getMainLvl())
    end

    dmg = takeWeaponskillDamage(target, attacker, wsParams, primaryMsg, attack, calcParams, action)

    return dmg, calcParams.criticalHit, calcParams.tpHitsLanded, calcParams.extraHitsLanded, calcParams.shadowsAbsorbed
end

-- After WS damage is calculated and damage reduction has been taken into account by the calling function,
-- handles displaying the appropriate action/message, delivering the damage to the mob, and any enmity from it
function takeWeaponskillDamage(defender, attacker, wsParams, primaryMsg, attack, wsResults, action)
    local finaldmg = wsResults.finalDmg

    if wsResults.tpHitsLanded + wsResults.extraHitsLanded > 0 then
        if finaldmg >= 0 then
            if primaryMsg then
                action:messageID(defender:getID(), xi.msg.basic.DAMAGE)
            else
                action:messageID(defender:getID(), xi.msg.basic.DAMAGE_SECONDARY)
            end

            if finaldmg > 0 then
                action:reaction(defender:getID(), xi.reaction.HIT)
                action:speceffect(defender:getID(), xi.specEffect.RECOIL)
            end
        else
            if primaryMsg then
                action:messageID(defender:getID(), xi.msg.basic.SELF_HEAL)
            else
                action:messageID(defender:getID(), xi.msg.basic.SELF_HEAL_SECONDARY)
            end
        end

        action:param(defender:getID(), math.abs(finaldmg))
    elseif wsResults.shadowsAbsorbed > 0 then
        action:messageID(defender:getID(), xi.msg.basic.SHADOW_ABSORB)
        action:param(defender:getID(), wsResults.shadowsAbsorbed)
    else
        if primaryMsg then
            action:messageID(defender:getID(), xi.msg.basic.SKILL_MISS)
        else
            action:messageID(defender:getID(), xi.msg.basic.EVADES)
        end

        action:reaction(defender:getID(), xi.reaction.EVADE)
    end

    local targetTPMult = wsParams.targetTPMult or 1
    local attackerTPMult = wsParams.attackerTPMult or 1
    local isJump = wsParams.isJump or false

    -- DA/TA/QA/OaT/Oa2-3 etc give full TP return per hit on Jumps
    if isJump then
        attackerTPMult = attackerTPMult * (wsResults.tpHitsLanded + wsResults.extraHitsLanded)
        wsResults.extraHitsLanded = 0
    end

    finaldmg = defender:takeWeaponskillDamage(attacker, finaldmg, attack.type, attack.damageType, attack.slot, primaryMsg, wsResults.tpHitsLanded * attackerTPMult, (wsResults.extraHitsLanded * 10) + wsResults.bonusTP, targetTPMult)
    if wsResults.tpHitsLanded + wsResults.extraHitsLanded > 0 then
        if finaldmg >= 0 then
            action:param(defender:getID(), math.abs(finaldmg))
        end
    end

    local enmityEntity = wsResults.taChar or attacker

    if wsParams.overrideCE and wsParams.overrideVE then
        defender:addEnmity(enmityEntity, wsParams.overrideCE, wsParams.overrideVE)
    else
        local enmityMult = wsParams.enmityMult or 1
        defender:updateEnmityFromDamage(enmityEntity, finaldmg * enmityMult)
    end

    xi.magian.checkMagianTrial(attacker, { ['mob'] = defender, ['triggerWs'] = true,  ['wSkillId'] = wsResults.wsID })

    if finaldmg > 0 then
        defender:setLocalVar("weaponskillHit", 1)
    end

    return finaldmg
end

-- Helper function to get Main damage depending on weapon type
function getMeleeDmg(attacker, weaponType, kick)
    local mainhandDamage = attacker:getWeaponDmg()
    local offhandDamage = attacker:getOffhandDmg()

    if weaponType == xi.skill.HAND_TO_HAND or weaponType == xi.skill.NONE then
        local h2hSkill = attacker:getSkillLevel(xi.skill.HAND_TO_HAND) * 0.11 + 3

        if kick and attacker:hasStatusEffect(xi.effect.FOOTWORK) then
            mainhandDamage = attacker:getMod(xi.mod.KICK_DMG) -- Use Kick damage if footwork is on
        end

        mainhandDamage = mainhandDamage + h2hSkill
        offhandDamage = mainhandDamage
    end

    return { mainhandDamage, offhandDamage }
end

function getHitRate(attacker, target, capHitRate, bonus)
    local flourisheffect = attacker:getStatusEffect(xi.effect.BUILDING_FLOURISH)

    if flourisheffect ~= nil and flourisheffect:getPower() > 1 then
        attacker:addMod(xi.mod.ACC, 20 + flourisheffect:getSubPower())
    end

    local acc = attacker:getACC()
    local eva = target:getEVA()

    if flourisheffect ~= nil and flourisheffect:getPower() > 1 then
        attacker:delMod(xi.mod.ACC, 20 + flourisheffect:getSubPower())
    end

    if bonus == nil then
        bonus = 0
    end

    if
        attacker:hasStatusEffect(xi.effect.INNIN) and
        attacker:isBehind(target, 23)
    then
        -- Innin acc boost if attacker is behind target
        bonus = bonus + attacker:getStatusEffect(xi.effect.INNIN):getPower()
    end

    if
        target:hasStatusEffect(xi.effect.YONIN) and
        attacker:isFacing(target, 23)
    then
        -- Yonin evasion boost if attacker is facing target
        bonus = bonus - target:getStatusEffect(xi.effect.YONIN):getPower()
    end

    if attacker:hasTrait(76) and attacker:isBehind(target, 23) then --TRAIT_AMBUSH
        bonus = bonus + attacker:getMerit(xi.merit.AMBUSH)
    end

    acc = acc + bonus

    if attacker:getMainLvl() > target:getMainLvl() then              -- Accuracy Bonus
        acc = acc + ((attacker:getMainLvl()-target:getMainLvl()) * 4)
    elseif attacker:getMainLvl() < target:getMainLvl() then        -- Accuracy Penalty
        acc = acc - ((target:getMainLvl()-attacker:getMainLvl()) * 4)
    end

    local hitdiff = 0
    local hitrate = 75

    if acc > eva then
        hitdiff = (acc - eva) / 2
    end

    if eva > acc then
        hitdiff = ((-1) * (eva-acc)) / 2
    end

    hitrate = hitrate + hitdiff
    hitrate = hitrate / 100

    -- Applying hitrate caps
    if capHitRate then -- this isn't capped for when acc varies with tp, as more penalties are due
        if hitrate > 0.95 then
            hitrate = 0.95
        end

        if hitrate < 0.2 then
            hitrate = 0.2
        end
    end

    return hitrate
end

function fTP(tp, ftp1, ftp2, ftp3)
    if tp >= 1000 and tp < 2000 then
        return ftp1 + (((ftp2 - ftp1) / 1000) * (tp - 1000))
    elseif tp >= 2000 and tp <= 3000 then
        -- generate a straight line between ftp2 and ftp3 and find point @ tp
        return ftp2 + (((ftp3 - ftp2) / 1000) * (tp - 2000))
    else
        print("fTP error: TP value is not between 1000-3000!")
    end

    return 1 -- no ftp mod
end

function calculatedIgnoredDef(tp, def, ignore1, ignore2, ignore3)
    if tp >= 1000 and tp < 2000 then
        return (ignore1 + (((ignore2 - ignore1) / 1000) * (tp - 1000))) * def
    elseif tp >= 2000 and tp <= 3000 then
        return (ignore2 + (((ignore3 - ignore2) / 1000) * (tp - 2000))) * def
    end

    return 1 -- no def ignore mod
end

-- Given the raw ratio value (atk/def) and levels, returns the cRatio (min then max)
function cMeleeRatio(attacker, defender, params, ignoredDef, tp)
    local flourisheffect = attacker:getStatusEffect(xi.effect.BUILDING_FLOURISH)

    if flourisheffect ~= nil and flourisheffect:getPower() > 1 then
        attacker:addMod(xi.mod.ATTP, 25 + flourisheffect:getSubPower() / 2)
    end

    local atkmulti = fTP(tp, params.atk100, params.atk200, params.atk300)
    local cratio = (attacker:getStat(xi.mod.ATT) * atkmulti) / (defender:getStat(xi.mod.DEF) - ignoredDef)

    cratio = utils.clamp(cratio, 0, 2.25)

    if flourisheffect ~= nil and flourisheffect:getPower() > 1 then
        attacker:delMod(xi.mod.ATTP, 25 + flourisheffect:getSubPower() / 2)
    end

    local levelCorrection = 0

    if attacker:getMainLvl() < defender:getMainLvl() then
        levelCorrection = 0.05 * (defender:getMainLvl() - attacker:getMainLvl())
    end

    cratio = cratio - levelCorrection

    if cratio < 0 then
        cratio = 0
    end

    local pdifmin = 0
    local pdifmax = 0

    -- max
    if cratio < 0.5 then
        pdifmax = cratio + 0.5
    elseif cratio < 0.7 then
        pdifmax = 1
    elseif cratio < 1.2 then
        pdifmax = cratio + 0.3
    elseif cratio < 1.5 then
        pdifmax = cratio * 0.25 + cratio
    elseif cratio < 2.625 then
        pdifmax = cratio + 0.375
    else
        pdifmax = 3
    end

    -- min
    if cratio < 0.38 then
        pdifmin = 0
    elseif cratio < 1.25 then
        pdifmin = cratio * 1176 / 1024 - 448 / 1024
    elseif cratio < 1.51 then
        pdifmin = 1
    elseif cratio < 2.44 then
        pdifmin = cratio * 1176 / 1024 - 775 / 1024
    else
        pdifmin = cratio - 0.375
    end

    local pdif = {}
    pdif[1] = pdifmin
    pdif[2] = pdifmax

    local pdifcrit = {}
    cratio = cratio + 1
    cratio = utils.clamp(cratio, 0, 3)

    if cratio < 0.5 then
        pdifmax = cratio + 0.5
    elseif cratio < 0.7 then
        pdifmax = 1
    elseif cratio < 1.2 then
        pdifmax = cratio + 0.3
    elseif cratio < 1.5 then
        pdifmax = cratio * 0.25 + cratio
    elseif cratio < 2.625 then
        pdifmax = cratio + 0.375
    else
        pdifmax = 3
    end

    -- min
    if cratio < 0.38 then
        pdifmin = 0
    elseif cratio < 1.25 then
        pdifmin = cratio * 1176 / 1024 - 448 / 1024
    elseif cratio < 1.51 then
        pdifmin = 1
    elseif cratio < 2.44 then
        pdifmin = cratio * 1176 / 1024 - 775 / 1024
    else
        pdifmin = cratio - 0.375
    end

    local critbonus = attacker:getMod(xi.mod.CRIT_DMG_INCREASE) - defender:getMod(xi.mod.CRIT_DEF_BONUS)
    critbonus = utils.clamp(critbonus, 0, 100)
    pdifcrit[1] = pdifmin * (100 + critbonus) / 100
    pdifcrit[2] = pdifmax * (100 + critbonus) / 100

    return pdif, pdifcrit
end

-- Returns fSTR based on range and divisor
local function calculateRawFstr(dSTR, divisor)
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

    return fSTR
end

-- Given the attacker's str and the mob's vit, fSTR is calculated (for melee WS)
function fSTR(atkStr, defVit, weaponRank)
    local dSTR = atkStr - defVit
    local fSTR = calculateRawFstr(dSTR, 4)

    -- Apply fSTR caps.
    local lowerCap = weaponRank * -1
    if weaponRank == 0 then
        lowerCap = -1
    end

    fSTR = utils.clamp(fSTR, lowerCap, weaponRank + 8)

    return fSTR
end

-- Given the attacker's str and the mob's vit, fSTR2 is calculated (for ranged WS)
function fSTR2(atkStr, defVit, weaponRank)
    local dSTR = atkStr - defVit
    local fSTR2 = calculateRawFstr(dSTR, 2)

    -- Apply fSTR2 caps.
    local lowerCap = weaponRank * -2
    if weaponRank == 0 then
        lowerCap = -2
    elseif weaponRank == 1 then
        lowerCap = -3
    end

    fSTR2 = utils.clamp(fSTR2, lowerCap, (weaponRank + 8) * 2)

    return fSTR2
end

function generatePdif (cratiomin, cratiomax, melee)
    local pdif = math.random(cratiomin * 1000, cratiomax * 1000) / 1000

    if melee then
        pdif = pdif * (math.random(100, 105) / 100)
    end

    return pdif
end

function getStepAnimation(skill)
    if skill <= 1 then
        return 15
    elseif skill <= 3 then
        return 14
    elseif skill == 4 then
        return 19
    elseif skill == 5 then
        return 16
    elseif skill <= 7 then
        return 18
    elseif skill == 8 then
        return 20
    elseif skill == 9 then
        return 21
    elseif skill == 10 then
        return 22
    elseif skill == 11 then
        return 17
    elseif skill == 12 then
        return 23
    else
        return 0
    end
end

function getFlourishAnimation(skill)
    if skill <= 1 then
        return 25
    elseif skill <= 3 then
        return 24
    elseif skill == 4 then
        return 29
    elseif skill == 5 then
        return 26
    elseif skill <= 7 then
        return 28
    elseif skill == 8 then
        return 30
    elseif skill == 9 then
        return 31
    elseif skill == 10 then
        return 32
    elseif skill == 11 then
        return 27
    elseif skill == 12 then
        return 33
    else
        return 0
    end
end

function handleWSGorgetBelt(attacker)
    local ftpBonus = 0
    local accBonus = 0

    if attacker:getObjType() == xi.objType.PC then
        -- TODO: Get these out of itemid checks when possible.
        local elementalGorget = { 15495, 15498, 15500, 15497, 15496, 15499, 15501, 15502 }
        local elementalBelt =   { 11755, 11758, 11760, 11757, 11756, 11759, 11761, 11762 }
        local neck = attacker:getEquipID(xi.slot.NECK)
        local belt = attacker:getEquipID(xi.slot.WAIST)
        local scProp1, scProp2, scProp3 = attacker:getWSSkillchainProp()

        for i, v in ipairs(elementalGorget) do
            if neck == v then
                if
                    doesElementMatchWeaponskill(i, scProp1) or
                    doesElementMatchWeaponskill(i, scProp2) or
                    doesElementMatchWeaponskill(i, scProp3)
                then
                    accBonus = accBonus + 10
                    ftpBonus = ftpBonus + 0.1
                end

                break
            end
        end

        if neck == 27510 then -- Fotia Gorget
            accBonus = accBonus + 10
            ftpBonus = ftpBonus + 0.1
        end

        for i, v in ipairs(elementalBelt) do
            if belt == v then
                if
                    doesElementMatchWeaponskill(i, scProp1) or
                    doesElementMatchWeaponskill(i, scProp2) or
                    doesElementMatchWeaponskill(i, scProp3)
                then
                    accBonus = accBonus + 10
                    ftpBonus = ftpBonus + 0.1
                end

                break
            end
        end

        if belt == 28420 then -- Fotia Belt
            accBonus = accBonus + 10
            ftpBonus = ftpBonus + 0.1
        end
    end

    return ftpBonus, accBonus
end
