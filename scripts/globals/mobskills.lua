-----------------------------------
-- Monster TP Moves Global
-- NOTE: A lot of this is good estimating since the FFXI playerbase has not found all of info for individual moves.
-- What is known is that they roughly follow player Weaponskill calculations (pDIF, dMOD, ratio, etc) so this is what
-- this set of functions emulates.
-----------------------------------
require('scripts/globals/magicburst')
require('scripts/globals/magic')
require('scripts/globals/utils')
-----------------------------------
xi = xi or {}
xi.mobskills = xi.mobskills or {}

-- mob types
-- used in mob:isMobType()
xi.mobskills.mobType =
{
    NORMAL      = 0x00,
    UNUSED      = 0x01,
    NOTORIOUS   = 0x02,
    FISHED      = 0x04,
    CALLED      = 0x08,
    BATTLEFIELD = 0x10,
    EVENT       = 0x20,
}

xi.mobskills.drainType =
{
    HP = 0,
    MP = 1,
    TP = 2,
}

-- shadowbehav (number of shadows to take off)
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
    ACC_VARIES  = 0,
    ATK_VARIES  = 1,
    DMG_VARIES  = 2,
    CRIT_VARIES = 3,
}

xi.mobskills.magicalTpBonus =
{
    NO_EFFECT   = 0,
    MACC_BONUS  = 1,
    MAB_BONUS   = 2,
    DMG_BONUS   = 3,
    RANGED      = 4,
}

local function MobTPMod(tp)
    -- increase damage based on tp
    if tp >= 3000 then
        return 2
    elseif tp >= 2000 then
        return 1.5
    end

    return 1
end

local function calculateMobMagicBurst(caster, ele, target)
    local burst = 1.0
    local skillchainTier, skillchainCount = xi.magicburst.formMagicBurst(ele, target)

    if skillchainTier > 0 then
        if skillchainCount == 1 then
            burst = 1.3
        elseif skillchainCount == 2 then
            burst = 1.35
        elseif skillchainCount == 3 then
            burst = 1.40
        elseif skillchainCount == 4 then
            burst = 1.45
        elseif skillchainCount == 5 then
            burst = 1.50
        else
            -- Something strange is going on if this occurs.
            burst = 1.0
        end
    end

    return burst
end

local function MobTakeAoEShadow(mob, target, max)
    -- this should be using actual nin skill
    -- TODO fix this
    if target:getMainJob() == xi.job.NIN and math.random() < 0.6 then
        max = max - 1
        if max < 1 then
            max = 1
        end
    end

    return math.random(1, max)
end

local function fTP(tp, ftp1, ftp2, ftp3)
    if tp < 1000 then
        tp = 1000
    end

    if tp >= 1000 and tp < 1500 then
        return ftp1 + (((ftp2 - ftp1) / 500) * (tp - 1000))
    elseif tp >= 1500 and tp <= 3000 then
        -- generate a straight line between ftp2 and ftp3 and find point @ tp
        return ftp2 + (((ftp3 - ftp2) / 1500) * (tp - 1500))
    end

    return 1 -- no ftp mod
end

xi.mobskills.mobRangedMove = function(mob, target, skill, numberofhits, accmod, dmgmod, tpeffect)
    -- this will eventually contian ranged attack code
    return xi.mobskills.mobPhysicalMove(mob, target, skill, numberofhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.RANGED)
end

-- PHYSICAL MOVE FUNCTION
-- Call this on every physical move!
-- accmod is a linear multiplier for accuracy (1 default)
-- dmgmod is a linear multiplier for damage (1 default)
-- tpeffect is an enum which can be one of:
-- 0 xi.mobskills.physicalTpBonus.ACC_VARIES
-- 1 xi.mobskills.physicalTpBonus.ATK_VARIES
-- 2 xi.mobskills.physicalTpBonus.DMG_VARIES
-- 3 xi.mobskills.physicalTpBonus.CRIT_VARIES
-- mtp100/200/300 are the three values for 100% TP, 200% TP, 300% TP just like weaponskills.lua
-- if xi.mobskills.physicalTpBonus.ACC_VARIES -> three values are acc %s (1.0 is 100% acc, 0.8 is 80% acc, 1.2 is 120% acc)
-- if xi.mobskills.physicalTpBonus.ATK_VARIES -> three values are attack multiplier (1.5x 0.5x etc)
-- if xi.mobskills.physicalTpBonus.DMG_VARIES -> three values are

xi.mobskills.mobPhysicalMove = function(mob, target, skill, numberofhits, accmod, dmgmod, tpeffect, mtp000, mtp150, mtp300, offcratiomod)
    local returninfo = {}

    --get dstr (bias to monsters, so no fSTR)
    local dstr = mob:getStat(xi.mod.STR) - target:getStat(xi.mod.VIT)
    if dstr < -10 then
        dstr = -10
    end

    if dstr > 10 then
        dstr = 10
    end

    local lvluser = mob:getMainLvl()
    local lvltarget = target:getMainLvl()
    local acc = mob:getACC()
    local eva = target:getEVA() + target:getMod(xi.mod.SPECIAL_ATTACK_EVASION)

    if target:hasStatusEffect(xi.effect.YONIN) and mob:isFacing(target, 23) then -- Yonin evasion boost if mob is facing target
        eva = eva + target:getStatusEffect(xi.effect.YONIN):getPower()
    end

    --apply WSC
    local base = mob:getWeaponDmg() + dstr --todo: change to include WSC
    if base < 1 then
        base = 1
    end

    --work out and cap ratio
    if offcratiomod == nil then -- default to attack. Pretty much every physical mobskill will use this, Cannonball being the exception.
        offcratiomod = mob:getStat(xi.mod.ATT)
    end

    local ratio = offcratiomod / target:getStat(xi.mod.DEF)
    local lvldiff = lvluser - lvltarget
    if lvldiff < 0 then
        lvldiff = 0
    end

    ratio = ratio + lvldiff * 0.05
    ratio = utils.clamp(ratio, 0, 4)

    --work out hit rate for mobs
    local hitrate = ((acc * accmod) - eva) / 2 + (lvldiff * 2) + 75

    hitrate = utils.clamp(hitrate, 20, 95)

    --work out the base damage for a single hit
    local hitdamage = base + lvldiff
    if hitdamage < 1 then
        hitdamage = 1
    end

    hitdamage = hitdamage * dmgmod

    if tpeffect == xi.mobskills.physicalTpBonus.DMG_VARIES then
        hitdamage = hitdamage * MobTPMod(skill:getTP() / 10)
    end

    --work out min and max cRatio
    local maxRatio = ratio
    local minRatio = ratio - 0.375

    if ratio < 0.5 then
        maxRatio = ratio + 0.5
    elseif ratio <= 0.7 then
        maxRatio = 1
    elseif ratio <= 1.2 then
        maxRatio = ratio + 0.3
    elseif ratio <= 1.5 then
        maxRatio = (ratio * 0.25) + ratio
    elseif ratio <= 2.625 then
        maxRatio = ratio + 0.375
    elseif ratio <= 3.25 then
        maxRatio = 3
    end

    if ratio < 0.38 then
        minRatio =  0
    elseif ratio <= 1.25 then
        minRatio = ratio * (1176 / 1024) - (448 / 1024)
    elseif ratio <= 1.51 then
        minRatio = 1
    elseif ratio <= 2.44 then
        minRatio = ratio * (1176 / 1024) - (775 / 1024)
    end

    --apply ftp (assumes 1~3 scalar linear mod)
    if tpeffect == xi.mobskills.magicalTpBonus.DMG_BONUS then
        hitdamage = hitdamage * fTP(skill:getTP(), mtp000, mtp150, mtp300)
    end

    -- start the hits
    local finaldmg = 0
    local hitsdone = 1
    local hitslanded = 0

    local chance = math.random()

    -- first hit has a higher chance to land
    local firstHitChance = hitrate * 1.5

    if tpeffect == xi.mobskills.magicalTpBonus.RANGED then
        firstHitChance = hitrate * 1.2
    end

    firstHitChance = utils.clamp(firstHitChance, 35, 95)

    --Applying pDIF
    local pdif
    if (chance * 100) <= firstHitChance then
        pdif = math.random((minRatio * 1000), (maxRatio * 1000)) --generate random PDIF
        pdif = pdif / 1000 --multiplier set.
        finaldmg = finaldmg + hitdamage * pdif
        hitslanded = hitslanded + 1
    end

    while hitsdone < numberofhits do
        chance = math.random()

        if (chance * 100) <= hitrate then --it hit
            pdif = math.random(minRatio * 1000, maxRatio * 1000) --generate random PDIF
            pdif = pdif / 1000 --multiplier set.
            finaldmg = finaldmg + hitdamage * pdif
            hitslanded = hitslanded + 1
        end

        hitsdone = hitsdone + 1
    end

    -- if an attack landed it must do at least 1 damage
    if hitslanded >= 1 and finaldmg < 1 then
        finaldmg = 1
    end

    -- all hits missed
    if hitslanded == 0 or finaldmg == 0 then
        finaldmg = 0
        hitslanded = 0
        skill:setMsg(xi.msg.basic.SKILL_MISS)
    end

    returninfo.dmg = finaldmg
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

xi.mobskills.mobMagicalMove = function(mob, target, skill, damage, element, dmgmod, tpeffect, tpvalue)
    local returninfo = {}

    local mdefBarBonus = 0
    if
        element >= xi.element.FIRE and
        element <= xi.element.WATER and
        target:hasStatusEffect(xi.magic.barSpell[element])
    then -- bar- spell magic defense bonus
        mdefBarBonus = target:getStatusEffect(xi.magic.barSpell[element]):getSubPower()
    end

    -- plus 100 forces it to be a number
    local mab = (100 + mob:getMod(xi.mod.MATT)) / (100 + target:getMod(xi.mod.MDEF) + mdefBarBonus)

    if mab > 1.3 then
        mab = 1.3
    end

    if mab < 0.7 then
        mab = 0.7
    end

    if tpeffect == xi.mobskills.magicalTpBonus.DMG_BONUS then
        damage = damage * (((skill:getTP() / 10) * tpvalue) / 100)
    end

    -- resistance is added last
    local finaldmg = damage * mab * dmgmod

    -- get resistance
    local avatarAccBonus = 0
    if mob:isPet() and mob:getMaster() ~= nil then
        local master = mob:getMaster()
        if mob:isAvatar() then
            avatarAccBonus = utils.clamp(master:getSkillLevel(xi.skill.SUMMONING_MAGIC) - master:getMaxSkillLevel(mob:getMainLvl(), xi.job.SMN, xi.skill.SUMMONING_MAGIC), 0, 200)
        end
    end

    local resist       = xi.mobskills.applyPlayerResistance(mob, nil, target, mob:getStat(xi.mod.INT)-target:getStat(xi.mod.INT), avatarAccBonus, element)
    local magicDefense = getElementalDamageReduction(target, element)

    finaldmg       = finaldmg * resist * magicDefense
    returninfo.dmg = finaldmg

    return returninfo
end

-- effect = xi.effect.WHATEVER if enfeeble
-- statmod = the stat to account for resist (INT, MND, etc) e.g. xi.mod.INT
-- This determines how much the monsters ability resists on the player.
xi.mobskills.applyPlayerResistance = function(mob, effect, target, diff, bonus, element)
    local percentBonus = 0
    local magicaccbonus = 0

    if diff > 10 then
        magicaccbonus = magicaccbonus + 10 + (diff - 10) / 2
    else
        magicaccbonus = magicaccbonus + diff
    end

    if bonus ~= nil then
        magicaccbonus = magicaccbonus + bonus
    end

    if effect ~= nil then
        percentBonus = percentBonus - xi.magic.getEffectResistance(target, effect)
    end

    local p = getMagicHitRate(mob, target, 0, element, percentBonus, magicaccbonus)

    return getMagicResist(p)
end

xi.mobskills.mobAddBonuses = function(caster, target, dmg, ele) -- used for SMN magical bloodpacts, despite the name.
    local magicDefense = getElementalDamageReduction(target, ele)
    dmg = math.floor(dmg * magicDefense)

    local dayWeatherBonus = 1.00

    if caster:getWeather() == xi.magic.singleWeatherStrong[ele] then
        if math.random() < 0.33 then
            dayWeatherBonus = dayWeatherBonus + 0.10
        end
    elseif caster:getWeather() == xi.magic.singleWeatherWeak[ele] then
        if math.random() < 0.33 then
            dayWeatherBonus = dayWeatherBonus - 0.10
        end
    elseif caster:getWeather() == xi.magic.doubleWeatherStrong[ele] then
        if math.random() < 0.33 then
            dayWeatherBonus = dayWeatherBonus + 0.25
        end
    elseif caster:getWeather() == xi.magic.doubleWeatherWeak[ele] then
        if math.random() < 0.33 then
            dayWeatherBonus = dayWeatherBonus - 0.25
        end
    end

    if VanadielDayElement() == xi.magic.dayStrong[ele] then
        if math.random() < 0.33 then
            dayWeatherBonus = dayWeatherBonus + 0.10
        end
    elseif VanadielDayElement() == xi.magic.dayWeak[ele] then
        if math.random() < 0.33 then
            dayWeatherBonus = dayWeatherBonus - 0.10
        end
    end

    if dayWeatherBonus > 1.35 then
        dayWeatherBonus = 1.35
    end

    dmg = math.floor(dmg * dayWeatherBonus)

    local burst = calculateMobMagicBurst(caster, ele, target)
    dmg = math.floor(dmg * burst)

    local mdefBarBonus = 0
    if
        ele >= xi.element.FIRE and
        ele <= xi.element.WATER and
        target:hasStatusEffect(xi.magic.barSpell[ele])
    then -- bar- spell magic defense bonus
        mdefBarBonus = target:getStatusEffect(xi.magic.barSpell[ele]):getSubPower()
    end

    local mab = (100 + caster:getMod(xi.mod.MATT)) / (100 + target:getMod(xi.mod.MDEF) + mdefBarBonus)

    dmg = math.floor(dmg * mab)

    local magicDmgMod = (10000 + target:getMod(xi.mod.DMGMAGIC)) / 10000

    dmg = math.floor(dmg * magicDmgMod)

    return dmg
end

-- Calculates breath damage
-- mob is a mob reference to get hp and lvl
-- percent is the percentage to take from HP
-- base is calculated from main level to create a minimum
-- Equation: (HP * percent) + (LVL / base)
-- cap is optional, defines a maximum damage
xi.mobskills.mobBreathMove = function(mob, target, percent, base, element, cap)
    local damage = (mob:getHP() * percent) + (mob:getMainLvl() / base)

    if cap == nil then
        -- cap max damage
        cap = math.floor(mob:getHP() / 5)
    end

    -- Deal bonus damage vs mob ecosystem
    local systemBonus = utils.getEcosystemStrengthBonus(mob:getEcosystem(), target:getEcosystem())
    damage = damage + damage * (systemBonus * 0.25)

    -- elemental resistence
    if element ~= nil and element > 0 then
        -- no skill available, pass nil
        local resist = xi.mobskills.applyPlayerResistance(mob, nil, target, mob:getStat(xi.mod.INT)-target:getStat(xi.mod.INT), 0, element)

        -- get elemental damage reduction
        local defense = getElementalDamageReduction(target, element)

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
    local combinedDamageTaken = 1.0 +  utils.clamp(breathDamageTaken + globalDamageTaken, -0.5, 0.5) -- The combination of regular "Damage Taken" and "Breath Damage Taken" caps at 50%. There is no BDTII known as of yet.

    damage = math.floor(damage * combinedDamageTaken)

    -- Handle Phalanx
    if damage > 0 then
        damage = utils.clamp(damage - target:getMod(xi.mod.PHALANX), 0, 99999)
    end

    -- Handle Stoneskin
    if damage > 0 then
        damage = utils.clamp(utils.stoneskin(target, damage), -99999, 99999)
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
    skill:setMsg(xi.msg.basic.DAMAGE)

    --Handle shadows depending on shadow behaviour / attackType
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

    if attackType == xi.attackType.PHYSICAL and not skill:isSingle() then
        target:delStatusEffect(xi.effect.THIRD_EYE)
    end

    --handle Third Eye using shadowbehav as a guide
    if attackType == xi.attackType.PHYSICAL and utils.thirdeye(target) then
        skill:setMsg(xi.msg.basic.ANTICIPATE)
        return 0
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

-- function MobHit()
-- end

-- function MobAoEHit()
-- end

-- function MobMagicHit()
-- end

-- function MobMagicAoEHit()
-- end

xi.mobskills.mobDrainMove = function(mob, target, drainType, drain, attackType, damageType)
    if not target:isUndead() then
        if drainType == xi.mobskills.drainType.MP then
            -- can't go over limited mp
            if target:getMP() < drain then
                drain = target:getMP()
            end

            target:delMP(drain)
            mob:addMP(drain)

            return xi.msg.basic.SKILL_DRAIN_MP
        elseif drainType == xi.mobskills.drainType.TP then
            -- can't go over limited tp
            if target:getTP() < drain then
                drain = target:getTP()
            end

            target:delTP(drain)
            mob:addTP(drain)

            return xi.msg.basic.SKILL_DRAIN_TP
        elseif drainType == xi.mobskills.drainType.HP then
            -- can't go over limited hp
            if target:getHP() < drain then
                drain = target:getHP()
            end

            target:takeDamage(drain, mob, attackType, damageType)
            mob:addHP(drain)

            return xi.msg.basic.SKILL_DRAIN_HP
        end
    else
        -- it's undead so just deal damage
        -- can't go over limited hp
        if target:getHP() < drain then
            drain = target:getHP()
        end

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

xi.mobskills.mobDrainAttribute = function(mob, target, typeEffect, power, tick, duration)
    local positive = nil

    if typeEffect == xi.effect.STR_DOWN then
        positive = xi.effect.STR_BOOST
    elseif typeEffect == xi.effect.DEX_DOWN then
        positive = xi.effect.DEX_BOOST
    elseif typeEffect == xi.effect.AGI_DOWN then
        positive = xi.effect.AGI_BOOST
    elseif typeEffect == xi.effect.VIT_DOWN then
        positive = xi.effect.VIT_BOOST
    elseif typeEffect == xi.effect.MND_DOWN then
        positive = xi.effect.MND_BOOST
    elseif typeEffect == xi.effect.INT_DOWN then
        positive = xi.effect.INT_BOOST
    elseif typeEffect == xi.effect.CHR_DOWN then
        positive = xi.effect.CHR_BOOST
    end

    if positive ~= nil then
        local results = xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, power, tick, duration)

        if results == xi.msg.basic.SKILL_ENFEEB_IS then
            mob:addStatusEffect(positive, power, tick, duration)

            return xi.msg.basic.ATTR_DRAINED
        end

        return xi.msg.basic.SKILL_MISS
    end

    return xi.msg.basic.SKILL_NO_EFFECT
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
xi.mobskills.mobStatusEffectMove = function(mob, target, typeEffect, power, tick, duration)
    if target:canGainStatusEffect(typeEffect, power) then
        local statmod = xi.mod.INT
        local element = mob:getStatusEffectElement(typeEffect)

        local resist = xi.mobskills.applyPlayerResistance(mob, typeEffect, target, mob:getStat(statmod)-target:getStat(statmod), 0, element)

        if resist >= 0.25 then
            local totalDuration = utils.clamp(duration * resist, 1)
            target:addStatusEffect(typeEffect, power, tick, totalDuration)

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
    if target:isFacing(mob) and mob:isInfront(target) then
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
    local mobHP = target:getHP()
    local mobMaxHP = target:getMaxHP()

    if (mobHP + healAmount) > mobMaxHP then
        healAmount = mobMaxHP - mobHP
    end

    target:wakeUp()
    target:addHP(healAmount)

    return healAmount
end
