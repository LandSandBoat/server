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
require("scripts/globals/spell_data")
require("scripts/globals/magic")
require("scripts/globals/utils")
require("scripts/globals/msg")
require("scripts/globals/damage")
-----------------------------------

xi = xi or { }
xi.weaponskills = xi.weaponskills or { }

-- Obtains alpha, used for working out WSC on legacy servers
xi.weaponskills.getAlpha = function(level)
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

-- http://wiki.ffo.jp/html/1705.html
-- https://www.ffxiah.com/forum/topic/21497/stalwart-soul/ some anecdotal data that aligns with JP
-- https://www.bg-wiki.com/ffxi/Agwu%27s_Scythe Souleater Effect that goes beyond established cap, Stalwart Soul bonus being additive to trait
local function souleaterBonus(attacker, wsParams)
    if attacker:hasStatusEffect(xi.effect.SOULEATER) then
        local souleaterEffect    = math.min(0.02, attacker:getMod(xi.mod.SOULEATER_EFFECT) * 0.01)
        local souleaterEffectII  = attacker:getMod(xi.mod.SOULEATER_EFFECT_II) * 0.01 -- No known cap to this bonus. Used on Agwu's scythe
        local stalwartSoulBonus = 1 - attacker:getMod(xi.mod.STALWART_SOUL) / 100
        local bonusDamage       = attacker:getHP() * (0.1 + souleaterEffect + souleaterEffectII)

        if bonusDamage >= 1 then
            attacker:delHP(utils.stoneskin(attacker, bonusDamage * stalwartSoulBonus))

            if attacker:getMainJob() ~= xi.job.DRK then
                return bonusDamage / 2
            end

            return bonusDamage
        end
    end

    return 0
end

local scarletDeliriumBonus = function(attacker)
    local bonus = 1

    if attacker:hasStatusEffect(xi.effect.SCARLET_DELIRIUM_1) then
        local power = attacker:getStatusEffect(xi.effect.SCARLET_DELIRIUM_1):getPower()

        bonus = 1 + power / 100
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

local function getMultiAttacks(attacker, target, numHits, wsParams)
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

xi.weaponskills.cRangedRatio = function(attacker, defender, params, ignoredDef, tp)
    local atkmulti = xi.weaponskills.fTP(tp, params.atk100, params.atk200, params.atk300)

    if ignoredDef == nil then
        ignoredDef = 0
    end

    local pdif = attacker:getRangedPDIF(defender, false, atkmulti, ignoredDef)
    local pdifcrit = attacker:getRangedPDIF(defender, true, atkmulti, ignoredDef)

    return { pdif, pdifcrit }
end

xi.weaponskills.getRangedHitRate = function(attacker, target, capHitRate, bonus, wsParams, calcParams)
    local accVarryTP = 0

    if bonus == nil then
        bonus = 0
    end

    local acc100 = (wsParams and wsParams.acc100) or 0
    local acc200 = (wsParams and wsParams.acc200) or 0
    local acc300 = (wsParams and wsParams.acc300) or 0

    if acc100 ~= 0 and acc200 ~= 0 and acc300 ~= 0 then
        if calcParams.tp >= 3000 then
            accVarryTP = (wsParams.acc300 - 1) * 100
        elseif calcParams.tp >= 2000 then
            accVarryTP = (wsParams.acc200 - 1) * 100
        else
            accVarryTP = (wsParams.acc100 - 1) * 100
        end

        bonus = bonus + accVarryTP
    end

    return utils.clamp(attacker:getCRangedHitRate(target, bonus) / 100, 0.2, 0.95)
end

-- Function to calculate if a hit in a WS misses, criticals, and the respective damage done
local function getSingleHitDamage(attacker, target, dmg, wsParams, calcParams, firstHitAccBonus, isRanged, isSubAttack)
    local criticalHit = false
    local finaldmg = 0
    local pdif = 0
    local pdifCrit = 0
    local ratio = { }

    if isSubAttack == nil then
        isSubAttack = false
    end

    if isRanged then
        ratio = xi.weaponskills.cRangedRatio(attacker, target, wsParams, calcParams.ignoredDef, calcParams.tp)
        pdif = ratio[1]
        pdifCrit =  ratio[2]
        calcParams.hitRate = xi.weaponskills.getRangedHitRate(attacker, target, false, 0, wsParams, calcParams)
    else
        if
            isSubAttack and
            calcParams.extraOffhandHit and
            calcParams.attackInfo.weaponType ~= xi.skill.HAND_TO_HAND
        then
            ratio = xi.weaponskills.cMeleeRatio(attacker, target, wsParams, calcParams.ignoredDef, calcParams.tp, xi.slot.SUB)
            pdif = ratio[1]
            pdifCrit =  ratio[2]
            calcParams.hitRate = xi.weaponskills.getHitRate(attacker, target, false, 0, true, wsParams, calcParams)
        else
            ratio = xi.weaponskills.cMeleeRatio(attacker, target, wsParams, calcParams.ignoredDef, calcParams.tp, xi.slot.MAIN)
            pdif = ratio[1]
            pdifCrit =  ratio[2]
            calcParams.hitRate = xi.weaponskills.getHitRate(attacker, target, false, 0, false, wsParams, calcParams)
        end
    end

    calcParams.hitRate = utils.clamp(calcParams.hitRate + calcParams.bonusAcc, 0.2, 0.95)

    if firstHitAccBonus ~= nil and firstHitAccBonus then
        calcParams.hitRate = calcParams.hitRate + 0.5 -- First hit gets a +100 ACC bonus which translates to +50 hit
        calcParams.hitRate = utils.clamp(calcParams.hitRate, 0.2, 0.95)
    end

    local missChance = math.random()

    missChance = xi.weaponskills.handleParry(attacker, target, missChance, calcParams.guaranteedHit)

    if
        (missChance <= calcParams.hitRate or
        calcParams.guaranteedHit or
        (calcParams.melee and (math.random() < attacker:getMod(xi.mod.ZANSHIN) / 100))) and
        not calcParams.mustMiss
    then
        if not shadowAbsorb(target) then
            local critChance = math.random() -- See if we land a critical hit
            criticalHit = (wsParams.canCrit and critChance <= calcParams.critRate) or
                calcParams.forcedFirstCrit or
                calcParams.mightyStrikesApplicable

            if criticalHit then
                criticalHit = true
                calcParams.pdif = pdifCrit
            else
                calcParams.pdif = pdif
            end

            finaldmg = dmg * calcParams.pdif

            finaldmg = xi.weaponskills.handleBlock(attacker, target, finaldmg)

            -- Duplicate the first hit with an added magical component for hybrid WSes
            if calcParams.hybridHit then
                -- Calculate magical bonuses and reductions
                local ftpHybrid = xi.weaponskills.fTP(calcParams.tp, wsParams.ftp100, wsParams.ftp200, wsParams.ftp300) + calcParams.bonusfTP
                local magicdmg = finaldmg * ftpHybrid

                wsParams.damageSpell = true
                wsParams.bonus = calcParams.bonusAcc
                magicdmg = magicdmg * xi.magic.applyAbilityResistance(attacker, target, wsParams)
                magicdmg = target:magicDmgTaken(magicdmg, wsParams.ele)

                if magicdmg > 0 then
                    magicdmg = xi.magic.adjustForTarget(target, magicdmg, wsParams.ele) -- this may absorb or nullify
                end

                if magicdmg > 0 then                                           -- handle nonzero damage if previous function does not absorb or nullify
                    magicdmg = magicdmg - target:getMod(xi.mod.PHALANX)
                    magicdmg = utils.clamp(magicdmg, 0, 99999)
                    magicdmg = utils.oneforall(target, magicdmg)
                    magicdmg = utils.rampart(target, magicdmg)
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

    -- Scarlet Delirium
    adjustedDamage = adjustedDamage * scarletDeliriumBonus(attacker)

    -- Souleater
    adjustedDamage = adjustedDamage + souleaterBonus(attacker, wsParams)

    if adjustedDamage > 0 then
        adjustedDamage = adjustedDamage - target:getMod(xi.mod.PHALANX)
        adjustedDamage = utils.clamp(adjustedDamage, 0, 99999)
    end

    adjustedDamage = utils.rampart(target, adjustedDamage)
    adjustedDamage = utils.stoneskin(target, adjustedDamage)

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

-- Calculates the raw damage for a weaponskill, used by both xi.weaponskills.doPhysicalWeaponskill and xi.weaponskills.doRangedWeaponskill.
-- Behavior of damage calculations can vary based on the passed in calcParams, which are determined by the calling function
-- depending on the type of weaponskill being done, and any special cases for that weaponskill
--
-- wsParams can contain: ftp100, ftp200, ftp300, str_wsc, dex_wsc, vit_wsc, int_wsc, mnd_wsc, canCrit, crit100, crit200, crit300,
-- acc100, acc200, acc300, ignoresDef, ignore100, ignore200, ignore300, atk100, atk200, atk300, kick, hybridWS, hitsHigh, formless
--
-- See xi.weaponskills.doPhysicalWeaponskill or xi.weaponskills.doRangedWeaponskill for how calcParams are determined.
-- TODO: Reduce complexity
-- Disable cyclomatic complexity check for this function:
-- luacheck: ignore 561
xi.weaponskills.calculateRawWSDmg = function(attacker, target, wsID, tp, action, wsParams, calcParams, isRanged)
    local targetLvl = target:getMainLvl()
    local targetHp = target:getHP() + target:getMod(xi.mod.STONESKIN)

    -- Calculate alpha, WSC, and our modifiers for our base per-hit damage
    if not calcParams.alpha then
        if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
            calcParams.alpha = 1
        else
            calcParams.alpha = xi.weaponskills.getAlpha(attacker:getMainLvl())
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

    local str = math.floor(attacker:getStat(xi.mod.STR) * wsParams.str_wsc)
    local dex = math.floor(attacker:getStat(xi.mod.DEX) * wsParams.dex_wsc)
    local vit = math.floor(attacker:getStat(xi.mod.VIT) * wsParams.vit_wsc)
    local agi = math.floor(attacker:getStat(xi.mod.AGI) * wsParams.agi_wsc)
    local int = math.floor(attacker:getStat(xi.mod.INT) * wsParams.int_wsc)
    local mnd = math.floor(attacker:getStat(xi.mod.MND) * wsParams.mnd_wsc)
    local chr = math.floor(attacker:getStat(xi.mod.CHR) * wsParams.chr_wsc)

    local wsMods = calcParams.fSTR + math.floor(math.floor(str + dex + vit + agi + int + mnd + chr) * calcParams.alpha)
    local ftp = xi.weaponskills.fTP(tp, wsParams.ftp100, wsParams.ftp200, wsParams.ftp300) + calcParams.bonusfTP

    if wsParams.hybridWS then
        ftp = 1
    end

    local base = (calcParams.weaponDamage[1] + wsMods) * ftp

    local dmg = base

    if attacker:getMainJob() == xi.job.THF and not isRanged then
        -- Add DEX/AGI bonus to first hit if THF main and valid Sneak/Trick Attack
        if calcParams.sneakApplicable then
            dmg = dmg + attacker:getStat(xi.mod.DEX)
        end

        if calcParams.trickApplicable then
            dmg = dmg + attacker:getStat(xi.mod.AGI)
        end
    end

    -- Calculate critrates
    local critrate = 0.05 + calculateDEXvsAGICritRate(attacker, target) -- 5% constant crit floor + dDEX
    -- mainhand and offhand weapon crit mods aren't included with the regular CRITHITRATE mod
    local mainSlotCritBonus = 0
    local subSlotCritBonus = 0
    if attacker:getEquippedItem(xi.slot.MAIN) ~= nil then
        mainSlotCritBonus = (attacker:getEquippedItem(xi.slot.MAIN):getMod(xi.mod.CRITHITRATE_SLOT) / 100)
    end

    if attacker:getEquippedItem(xi.slot.SUB) ~= nil then
        subSlotCritBonus = attacker:getEquippedItem(xi.slot.SUB):getMod(xi.mod.CRITHITRATE_SLOT) / 100
    end

    if wsParams.canCrit then -- Work out critical hit ratios
        local bonuscrit = 0

        critrate = critrate + xi.weaponskills.fTP(tp, wsParams.crit100, wsParams.crit200, wsParams.crit300)

        if calcParams.flourishEffect and calcParams.flourishEffect:getPower() > 1 then
            critrate = critrate + (10 + calcParams.flourishEffect:getSubPower() / 2) / 100
        end

        local fencerBonusVal = calcParams.fencerBonus or 0
        bonuscrit = bonuscrit + attacker:getMod(xi.mod.CRITHITRATE) / 100 + attacker:getMerit(xi.merit.CRIT_HIT_RATE) / 100
                                + fencerBonusVal - target:getMerit(xi.merit.ENEMY_CRIT_RATE) / 100

        -- weapon slots use CRIHITRATE_SLOT mod
        if isRanged then
            bonuscrit = bonuscrit + attacker:getEquippedItem(xi.slot.RANGED):getMod(xi.mod.CRITHITRATE_SLOT) / 100
                                    + attacker:getEquippedItem(xi.slot.AMMO):getMod(xi.mod.CRITHITRATE_SLOT) / 100
        else -- count mainhand only, offhand weapons crit is added only for offhand swings
            bonuscrit = bonuscrit + mainSlotCritBonus
        end

        -- Innin critical boost when attacker is behind target
        if
            attacker:hasStatusEffect(xi.effect.INNIN) and
            attacker:isBehind(target, 23)
        then
            bonuscrit = bonuscrit + attacker:getStatusEffect(xi.effect.INNIN):getPower()
        end

        critrate = critrate + bonuscrit
    end

    calcParams.critRate = critrate

    -- Start the WS
    local hitdmg = 0
    local finaldmg = 0
    calcParams.hitsLanded = 0
    calcParams.shadowsAbsorbed = 0

    -- Calculate the damage from the first hit
    if isRanged then
        hitdmg, calcParams = getSingleHitDamage(attacker, target, dmg, wsParams, calcParams, false, isRanged, false)
    else
        hitdmg, calcParams = getSingleHitDamage(attacker, target, dmg, wsParams, calcParams, true, isRanged, false)
    end

    if calcParams.melee then
        hitdmg = modifyMeleeHitDamage(attacker, target, calcParams.attackInfo, wsParams, hitdmg)
    end

    if calcParams.skillType and hitdmg > 0 then
        attacker:trySkillUp(calcParams.skillType, targetLvl)
    end

    finaldmg = finaldmg + hitdmg

    -- Have to calculate added bonus for SA/TA here since it is done outside of the fTP multiplier

    -- We've now accounted for any crit from SA/TA, or damage bonus for a Hybrid WS, so nullify them
    calcParams.forcedFirstCrit = false
    calcParams.sneakApplicable = false
    calcParams.trickApplicable = false

    -- For items that apply bonus damage to the first hit of a weaponskill (but not later hits),
    -- store bonus damage for first hit, for use after other calculations are done
    local firstHitBonus = (finaldmg * attacker:getMod(xi.mod.ALL_WSDMG_FIRST_HIT)) / 100

    local hitsDone = 1

    ftp = 1 + calcParams.bonusfTP

    base = (calcParams.weaponDamage[1] + wsMods) * ftp

    calcParams.guaranteedHit = false -- Accuracy bonus from SA/TA applies only to first main and offhand hit

    if calcParams.extraOffhandHit then
        -- we want the offhand crit rate which can be different than mainhand depending on equipped weapons
        calcParams.critRate = calcParams.critRate - mainSlotCritBonus + subSlotCritBonus

        -- Do the extra hit for our offhand if applicable
        if finaldmg < targetHp and calcParams.skillType ~= xi.skill.HAND_TO_HAND then
            local offhandDmg = (calcParams.weaponDamage[2] + wsMods) * ftp

            hitdmg, calcParams = getSingleHitDamage(attacker, target, offhandDmg, wsParams, calcParams, false, isRanged, true)
            if calcParams.melee then
                hitdmg = modifyMeleeHitDamage(attacker, target, calcParams.subAttackInfo, wsParams, hitdmg)
            end

            if hitdmg > 0 then
                attacker:trySkillUp(calcParams.subSkillType, targetLvl)
            end

            finaldmg = finaldmg + hitdmg
            hitsDone = hitsDone + 1
        elseif finaldmg < targetHp then -- h2h case
            hitdmg, calcParams = getSingleHitDamage(attacker, target, base, wsParams, calcParams, false, isRanged, false)
            if calcParams.melee then
                hitdmg = modifyMeleeHitDamage(attacker, target, calcParams.attackInfo, wsParams, hitdmg)
            end

            if hitdmg > 0 then
                attacker:trySkillUp(calcParams.skillType, targetLvl)
            end

            finaldmg = finaldmg + hitdmg
            hitsDone = hitsDone + 1
        end

        -- going back to the mainhand crit total for the rest of the hits
        calcParams.critRate = calcParams.critRate + mainSlotCritBonus - subSlotCritBonus
    end

    -- Reset fTP if it's not supposed to carry over across all hits for this WS
    calcParams.tpHitsLanded = calcParams.hitsLanded -- Store number of TP hits that have landed thus far
    calcParams.hitsLanded = 0 -- Reset counter to start tracking additional hits (from WS or Multi-Attacks)

    -- Calculate additional hits if a multiHit WS (or we're supposed to get a DA/TA/QA proc from main hit)
    local numHits = utils.clamp(getMultiAttacks(attacker, target, wsParams.numHits, wsParams), 0, 8)

    -- adding one to make sure the extra hit from dw or h2h doesnt eat 1 base hit of the ws
    if calcParams.extraOffhandHit then
        numHits = utils.clamp(numHits + 1, 0, 8)
        calcParams.extraOffhandHit = false
    end

    -- adding one to make sure the extra hit from dw or h2h doesnt eat 1 base hit of the ws
    if calcParams.extraOffhandHit then
        numHits = utils.clamp(numHits + 1, 0, 8)
        calcParams.extraOffhandHit = false
    end

    if isRanged then
        numHits = wsParams.numHits
    end

    while hitsDone < numHits and finaldmg < targetHp do -- numHits is hits in the base WS _and_ DA/TA/QA procs during those hits
        hitdmg, calcParams = getSingleHitDamage(attacker, target, base, wsParams, calcParams, false, isRanged, false)

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

-- Sets up the necessary calcParams for a melee WS before passing it to xi.weaponskills.calculateRawWSDmg. When the raw
-- damage is returned, handles reductions based on target resistances and passes off to xi.weaponskills.takeWeaponskillDamage.
xi.weaponskills.doPhysicalWeaponskill = function(attacker, target, wsID, wsParams, tp, action, primaryMsg, taChar)
    -- Determine cratio and ccritratio
    local ignoredDef = 0

    if wsParams.ignoresDef ~= nil and wsParams.ignoresDef then
        ignoredDef = xi.weaponskills.calculatedIgnoredDef(tp, target:getStat(xi.mod.DEF), wsParams.ignored100, wsParams.ignored200, wsParams.ignored300)
    end

    -- Set up conditions and wsParams used for calculating weaponskill damage
    local gorgetBeltFTP, gorgetBeltAcc = xi.weaponskills.handleWSGorgetBelt(attacker)
    local attack =
    {
        ['type'] = xi.attackType.PHYSICAL,
        ['slot'] = xi.slot.MAIN,
        ['weaponType'] = attacker:getWeaponSkillType(xi.slot.MAIN),
        ['damageType'] = attacker:getWeaponDamageType(xi.slot.MAIN)
    }
    local subAttack =
    {
        ['type'] = xi.attackType.PHYSICAL,
        ['slot'] = xi.slot.SUB,
        ['weaponType'] = attacker:getWeaponSkillType(xi.slot.MAIN),
        ['damageType'] = attacker:getWeaponDamageType(xi.slot.MAIN)
    }

    if wsParams.specialDamageType then
        attack['damageType'] = wsParams.specialDamageType
    end

    local calcParams = {}
    calcParams.wsID = wsID
    calcParams.attackInfo = attack
    calcParams.weaponDamage = xi.weaponskills.getMeleeDmg(attacker, attack.weaponType, wsParams.kick)
    calcParams.fSTR = xi.weaponskills.fSTR(attacker:getStat(xi.mod.STR), target:getStat(xi.mod.VIT), attacker:getWeaponDmgRank())
    calcParams.accStat = attacker:getACC()
    calcParams.melee = true
    calcParams.mustMiss = target:hasStatusEffect(xi.effect.PERFECT_DODGE) or
        (target:hasStatusEffect(xi.effect.ALL_MISS) and not wsParams.hitsHigh)
    calcParams.sneakApplicable = attacker:hasStatusEffect(xi.effect.SNEAK_ATTACK) and
        (attacker:isBehind(target) or attacker:hasStatusEffect(xi.effect.HIDE) or
        target:hasStatusEffect(xi.effect.DOUBT))
    calcParams.taChar = taChar
    calcParams.ignoredDef = ignoredDef
    calcParams.tp = tp
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
    calcParams.bonusfTP = gorgetBeltFTP or 0
    calcParams.bonusAcc = (gorgetBeltAcc or 0) + attacker:getMod(xi.mod.WSACC)
    calcParams.bonusWSmods = wsParams.bonusWSmods or 0
    calcParams.hitRate = xi.weaponskills.getHitRate(attacker, target, false, calcParams.bonusAcc, false, wsParams, calcParams)
    calcParams.skillType = attack.weaponType

    if
        calcParams.extraOffhandHit and
        attack.weaponType ~= xi.skill.HAND_TO_HAND
    then
        subAttack.weaponType = attacker:getWeaponSkillType(xi.slot.SUB)
        subAttack.damageType = attacker:getWeaponDamageType(xi.slot.SUB)
        calcParams.subAttackInfo = subAttack
        calcParams.subSkillType = subAttack.weaponType
    elseif calcParams.extraOffhandHit then
        calcParams.subAttackInfo = attack
        calcParams.subSkillType = attack.weaponType
    end

    -- Send our wsParams off to calculate our raw WS damage, hits landed, and shadows absorbed
    calcParams = xi.weaponskills.calculateRawWSDmg(attacker, target, wsID, tp, action, wsParams, calcParams, false)
    local finaldmg = calcParams.finalDmg

    -- Delete statuses that may have been spent by the WS
    attacker:delStatusEffectsByFlag(xi.effectFlag.DETECTABLE)
    attacker:delStatusEffect(xi.effect.SNEAK_ATTACK)
    attacker:delStatusEffectSilent(xi.effect.BUILDING_FLOURISH)

    if attacker:checkThirdEye(target) then
        finaldmg = 0
        primaryMsg = xi.msg.basic.ANTICIPATE
    end

    finaldmg = finaldmg * xi.settings.main.WEAPON_SKILL_POWER -- Add server bonus
    calcParams.finalDmg = finaldmg
    finaldmg = xi.weaponskills.takeWeaponskillDamage(target, attacker, wsParams, primaryMsg, attack, calcParams, action)

    return finaldmg, calcParams.criticalHit, calcParams.tpHitsLanded, calcParams.extraHitsLanded, calcParams.shadowsAbsorbed
end

-- Sets up the necessary calcParams for a ranged WS before passing it to xi.weaponskills.calculateRawWSDmg. When the raw
-- damage is returned, handles reductions based on target resistances and passes off to xi.weaponskills.takeWeaponskillDamage.
xi.weaponskills.doRangedWeaponskill = function(attacker, target, wsID, wsParams, tp, action, primaryMsg)
    -- Determine cratio and ccritratio
    local ignoredDef = 0

    if wsParams.ignoresDef ~= nil and wsParams.ignoresDef then
        ignoredDef = xi.weaponskills.calculatedIgnoredDef(tp, target:getStat(xi.mod.DEF), wsParams.ignored100, wsParams.ignored200, wsParams.ignored300)
    end

    local ratio = xi.weaponskills.cRangedRatio(attacker, target, wsParams, ignoredDef, tp)
    local pdif = ratio[1]
    local pdifCrit = ratio[2]

    -- Set up conditions and params used for calculating weaponskill damage
    local gorgetBeltFTP, gorgetBeltAcc = xi.weaponskills.handleWSGorgetBelt(attacker)
    local attack =
    {
        ['type'] = xi.attackType.RANGED,
        ['slot'] = xi.slot.RANGED,
        ['weaponType'] = attacker:getWeaponSkillType(xi.slot.RANGED),
        ['damageType'] = attacker:getWeaponDamageType(xi.slot.RANGED),
        ['attackType'] = xi.attackType.RANGED,
    }

    if wsParams.specialDamageType then
        attack['damageType'] = wsParams.specialDamageType
    end

    local calcParams =
    {
        wsID = wsID,
        weaponDamage = { attacker:getRangedDmg() },
        skillType = attacker:getWeaponSkillType(xi.slot.RANGED),
        fSTR = xi.weaponskills.fSTR2(attacker:getStat(xi.mod.STR), target:getStat(xi.mod.VIT), attacker:getRangedDmgRank()),
        pdif = pdif,
        pdifCrit = pdifCrit,
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
        bonusWSmods = wsParams.bonusWSmods or 0,
        tp = tp,
    }
    calcParams.hitRate = 0

    -- Send our params off to calculate our raw WS damage, hits landed, and shadows absorbed
    calcParams = xi.weaponskills.calculateRawWSDmg(attacker, target, wsID, tp, action, wsParams, calcParams, true)
    local finaldmg = calcParams.finalDmg

    -- Delete statuses that may have been spent by the WS
    attacker:delStatusEffectsByFlag(xi.effectFlag.DETECTABLE)

    -- Calculate reductions
    finaldmg = target:rangedDmgTaken(finaldmg)
    finaldmg = finaldmg * target:getMod(xi.mod.PIERCE_SDT) / 1000

    finaldmg = finaldmg * xi.settings.main.WEAPON_SKILL_POWER -- Add server bonus
    calcParams.finalDmg = finaldmg

    finaldmg = xi.weaponskills.takeWeaponskillDamage(target, attacker, wsParams, primaryMsg, attack, calcParams, action)

    return finaldmg, calcParams.criticalHit, calcParams.tpHitsLanded, calcParams.extraHitsLanded, calcParams.shadowsAbsorbed
end

-- params: ftp100, ftp200, ftp300, wsc_str, wsc_dex, wsc_vit, wsc_agi, wsc_int, wsc_mnd, wsc_chr,
--         ele (xi.magic.ele.FIRE), skill (xi.skill.STAFF)

xi.weaponskills.doMagicWeaponskill = function(attacker, target, wsID, wsParams, tp, action, primaryMsg)
    -- Magical WSs do not resist to 0
    wsParams.damageSpell = true
    -- Set up conditions and wsParams used for calculating weaponskill damage
    local attack =
    {
        ['type'] = xi.attackType.MAGICAL,
        ['slot'] = xi.slot.MAIN,
        ['weaponType'] = attacker:getWeaponSkillType(xi.slot.MAIN),
        ['damageType'] = xi.damageType.ELEMENTAL + wsParams.element,
        ['attackType'] = xi.attackType.MAGICAL,
    }

    local calcParams =
    {
        ['shadowsAbsorbed'] = 0,
        ['tpHitsLanded']    = 1,
        ['extraHitsLanded'] = 0,
        ['bonusTP']         = wsParams.bonusTP or 0,
        ['wsID']            = wsID
    }

    local bonusfTP, bonusacc = xi.weaponskills.handleWSGorgetBelt(attacker)
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
        local ftp = xi.weaponskills.fTP(tp, wsParams.ftp100, wsParams.ftp200, wsParams.ftp300) + bonusfTP

        dmg = dmg * ftp

        -- Apply Consume Mana and Scarlet Delirium
        -- TODO: dmg = (dmg + consumeManaBonus(attacker)) * scarletDeliriumBonus(attacker)
        dmg = dmg * scarletDeliriumBonus(attacker)

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
        dmg = xi.magic.addBonusesAbility(attacker, wsParams.element, target, dmg, wsParams)
        dmg = dmg * xi.magic.applyAbilityResistance(attacker, target, wsParams)

        dmg = target:magicDmgTaken(dmg, wsParams.element)

        if dmg < 0 then
            calcParams.finalDmg = dmg

            dmg = xi.weaponskills.takeWeaponskillDamage(target, attacker, wsParams, primaryMsg, attack, calcParams, action)
            return dmg
        end

        dmg = xi.magic.adjustForTarget(target, dmg, wsParams.element)

        if dmg > 0 then
            dmg = dmg - target:getMod(xi.mod.PHALANX)
            dmg = utils.clamp(dmg, 0, 99999)
        end

        dmg = utils.oneforall(target, dmg)
        dmg = utils.rampart(target, dmg)
        dmg = utils.stoneskin(target, dmg)

        dmg = dmg * xi.settings.main.WEAPON_SKILL_POWER -- Add server bonus
    else
        calcParams.shadowsAbsorbed = 1
    end

    calcParams.finalDmg = dmg
    attack.damageType = xi.attackType.MAGICAL

    if dmg > 0 then
        attacker:trySkillUp(attack.weaponType, target:getMainLvl())
    end

    dmg = xi.weaponskills.takeWeaponskillDamage(target, attacker, wsParams, primaryMsg, attack, calcParams, action)

    return dmg, calcParams.criticalHit, calcParams.tpHitsLanded, calcParams.extraHitsLanded, calcParams.shadowsAbsorbed
end

-- After WS damage is calculated and damage reduction has been taken into account by the calling function,
-- handles displaying the appropriate action/message, delivering the damage to the mob, and any enmity from it
xi.weaponskills.takeWeaponskillDamage = function(defender, attacker, wsParams, primaryMsg, attack, wsResults, action)
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

    finaldmg = defender:takeWeaponskillDamage(attacker, finaldmg, attack.type, attack.damageType, attack.slot, primaryMsg, wsResults.tpHitsLanded * attackerTPMult, (wsResults.extraHitsLanded * 10) + wsResults.bonusTP, targetTPMult, attack.damageType == xi.attackType.MAGICAL)
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
xi.weaponskills.getMeleeDmg = function(attacker, weaponType, kick)
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

xi.weaponskills.getHitRate = function(attacker, target, capHitRate, bonus, isSubAttack, wsParams, calcParams)
    if isSubAttack == nil then
        isSubAttack = false
    end

    if bonus == nil then
        bonus = 0
    end

    local hitrate = 0
    local flourisheffect = attacker:getStatusEffect(xi.effect.BUILDING_FLOURISH)
    local accVarryTP = 0

    local acc100 = (wsParams and wsParams.acc100) or 0
    local acc200 = (wsParams and wsParams.acc200) or 0
    local acc300 = (wsParams and wsParams.acc300) or 0

    if acc100 ~= 0 and acc200 ~= 0 and acc300 ~= 0 then
        if calcParams.tp >= 3000 then
            accVarryTP = wsParams.acc300 - 1
        elseif calcParams.tp >= 2000 then
            accVarryTP = wsParams.acc200 - 1
        else
            accVarryTP = wsParams.acc100 - 1
        end

        bonus = bonus + (accVarryTP * 100)
    end

    if flourisheffect ~= nil and flourisheffect:getPower() > 1 then
        bonus = bonus + (20 + flourisheffect:getPower())
    end

    if isSubAttack then
        hitrate = attacker:getCHitRate(target, 1, bonus)
    else
        hitrate = attacker:getCHitRate(target, 0, bonus)
    end

    return utils.clamp((hitrate / 100), 0.2, 0.95)
end

xi.weaponskills.fTP = function(tp, ftp1, ftp2, ftp3)
    if tp < 1000 then
        tp = 1000
    end

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

-- local function fTPMob(tp, ftp1, ftp2, ftp3)
--     if (tp < 1000) then
--         tp = 1000
--     end

--     if (tp >= 1000 and tp < 1500) then
--         return ftp1 + ( ((ftp2 - ftp1 ) / 500) * (tp - 1000) )
--     elseif (tp >= 1500 and tp <= 3000) then
--         -- generate a straight line between ftp2 and ftp3 and find point @ tp
--         return ftp2 + ( ((ftp3 - ftp2) / 1500) * (tp - 1500) )
--     end
--     return 1 -- no ftp mod
-- end

xi.weaponskills.calculatedIgnoredDef = function(tp, def, ignore1, ignore2, ignore3)
    if tp >= 1000 and tp < 2000 then
        return (ignore1 + (((ignore2 - ignore1) / 1000) * (tp - 1000))) * def
    elseif tp >= 2000 and tp <= 3000 then
        return (ignore2 + (((ignore3 - ignore2) / 1000) * (tp - 2000))) * def
    end

    return 1 -- no def ignore mod
end

-- Given the raw ratio value (atk/def) and levels, returns the cRatio (min then max)
xi.weaponskills.cMeleeRatio = function(attacker, defender, params, ignoredDef, tp, slot)
    local flourisheffect = attacker:getStatusEffect(xi.effect.BUILDING_FLOURISH)
    local isGuarded = false

    if flourisheffect ~= nil and flourisheffect:getPower() > 1 then
        attacker:addMod(xi.mod.ATTP, 25 + flourisheffect:getSubPower() / 2)
    end

    local atkmulti = 0

    if params.atk150 ~= nil then -- Use mob fTP
        atkmulti = xi.weaponskills.fTP(tp, params.atk000, params.atk150, params.atk300) -- Calculates attack modifier for mobs
    else -- Use player fTP to scale the attack modifier
        atkmulti = xi.weaponskills.fTP(tp, params.atk100, params.atk200, params.atk300)
    end

    if ignoredDef == nil then
        ignoredDef = 0
    end

    if slot == nil then
        slot = xi.slot.MAIN
    end

    if defender:getMainJob() == xi.job.MNK then
        if
            defender:getGuardRate(attacker) > math.random(100) and
            defender:isFacing(attacker)
        then
            isGuarded = true
        end
    end

    local pdif = attacker:getPDIF(defender, false, atkmulti, slot, ignoredDef, isGuarded)
    local pdifcrit = attacker:getPDIF(defender, true, atkmulti, slot, ignoredDef, isGuarded)

    if flourisheffect ~= nil and flourisheffect:getPower() > 1 then
        attacker:delMod(xi.mod.ATTP, 25 + flourisheffect:getSubPower() / 2)
    end

    return { pdif, pdifcrit }
end

xi.weaponskills.handleBlock = function(attacker, target, finaldmg)
    if
        target:getBlockRate(attacker) > math.random(100) and
        target:isFacing(attacker) and
        target:getSystem() == xi.eco.BEASTMEN and
        target:getMainJob() == xi.job.PLD
    then
        finaldmg = math.floor(finaldmg * 0.5)
    elseif
        target:getBlockRate(attacker) > math.random(100) and
        target:isFacing(attacker) and
        target:isPC() and
        target:getEquippedItem(xi.slot.SUB):getSkillType() == xi.skill.SHIELD
    then
        local absorb = 100
        absorb = utils.clamp(absorb - target:getShieldAbsorptionRate(), 0, 100)
        absorb = absorb + target:getMod(xi.mod.SHIELD_DEF_BONUS)
        finaldmg = math.floor(finaldmg * (absorb / 100))
    end

    return finaldmg
end

xi.weaponskills.handleParry = function(attacker, target, missChance, guaranteedHit)
    local gHit = guaranteedHit or false
    if
        target:isFacing(attacker) and
        target:getParryRate(attacker) >= math.random(100) and
        target:getMainJob() ~= xi.job.MNK and not gHit
    then -- Try parry, if so miss.
        if target:getSystem() == xi.eco.BEASTMEN or target:isPC() then
            missChance = 1
        end
    end

    return missChance
end

-- Returns fSTR based on range and divisor
local function calculateRawfSTR(dSTR, divisor)
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
xi.weaponskills.fSTR = function(atk_str, def_vit, weaponRank)
    local dSTR = atk_str - def_vit
    local fSTR = calculateRawfSTR(dSTR, 4)

    -- Apply fSTR caps.
    local lowerCap = weaponRank * -1
    if weaponRank == 0 then
        lowerCap = -1
    end

    fSTR = utils.clamp(fSTR, lowerCap, weaponRank + 8)

    return fSTR
end

-- Given the attacker's str and the mob's vit, fSTR2 is calculated (for ranged WS)
xi.weaponskills.fSTR2 = function(atk_str, def_vit, weaponRank)
    local dSTR = atk_str - def_vit
    local fSTR2 = calculateRawfSTR(dSTR, 2)

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

xi.weaponskills.generatePdif = function(cratiomin, cratiomax, melee)
    local pdif = math.random(cratiomin * 1000, cratiomax * 1000) / 1000

    if melee then
        pdif = pdif * (math.random(100, 105) / 100)
    end

    return pdif
end

xi.weaponskills.getStepAnimation = function(skill)
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

xi.weaponskills.getFlourishAnimation = function(skill)
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

xi.weaponskills.handleWSGorgetBelt = function(attacker)
    local ftpBonus = 0
    local accBonus = 0

    if attacker:getObjType() == xi.objType.PC then
        -- TODO: Get these out of itemid checks when possible.
        local elementalGorget = { 15495, 15496, 15497, 15498, 15499, 15500, 15501, 15502 }
        local elementalBelt =   { 11755, 11758, 11760, 11757, 11756, 11759, 11761, 11762 }
        local neck = attacker:getEquipID(xi.slot.NECK)
        local belt = attacker:getEquipID(xi.slot.WAIST)
        local scProp1, scProp2, scProp3 = attacker:getWSSkillchainProp()

        for i, v in ipairs(elementalGorget) do
            if neck == v then
                if
                    xi.magic.doesElementMatchWeaponskill(i, scProp1) or
                    xi.magic.doesElementMatchWeaponskill(i, scProp2) or
                    xi.magic.doesElementMatchWeaponskill(i, scProp3)
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
                    xi.magic.doesElementMatchWeaponskill(i, scProp1) or
                    xi.magic.doesElementMatchWeaponskill(i, scProp2) or
                    xi.magic.doesElementMatchWeaponskill(i, scProp3)
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
