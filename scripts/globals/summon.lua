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

-- SDT Table for mob SDT
xi.summon.sdtModTable = { xi.mod.FIRE_SDT, xi.mod.ICE_SDT, xi.mod.WIND_SDT, xi.mod.EARTH_SDT, xi.mod.THUNDER_SDT, xi.mod.WATER_SDT, xi.mod.LIGHT_SDT, xi.mod.DARK_SDT }

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

    if critRate == 0 then
        return 0
    end

    -- Crit rate from stats caps at +-15
    return math.min(critRate, 15) * sign
end

xi.summon.getAvatarfSTR = function(avatarStr, targetVit, avatar)
    -- https://www.bluegartr.com/threads/114636-Monster-Avatar-Pet-damage
    -- fSTR for avatars has no cap and a lower bound of floor(weaponDmg/9)
    local dSTR = avatarStr - targetVit
    local fSTR = math.floor(dSTR + 4) / 4

    return utils.clamp(fSTR, -20, 24)
end

xi.summon.dStat = function(avatar, target, mod)
    local avatarStat = avatar:getStat(mod)
    local targetStat = target:getStat(mod)

    if not avatarStat then
        avatarStat = 0
    end

    if not targetStat then
        targetStat = 0
    end

    local dStat = math.floor(avatarStat - targetStat)

    -- When dStat is positive it is multiplied by 1.5, when it is negative is is just the raw value
    if dStat >= 0 then
        dStat = math.floor(dStat * 1.5)
    end

    -- There is no upper limit of dstat, but there is a lower limit of -65
    return utils.clamp(dStat, -65, 999)
end

xi.summon.fTP = function(tp, ftp1, ftp2, ftp3, damagetype)
    -- Physical BPs do not scale
    if damagetype == xi.attackType.PHYSICAL then
        return ftp1
    end

    -- Default to Magical BPs - these scale between anchors
    if tp >= 0 and tp < 1500 then
        return ftp1 + (ftp2 - ftp1) * (tp / 1500)
    else
        return ftp2 + (ftp3 - ftp2) * ((tp - 1500) / 1500)
    end
end

xi.summon.avatarHitDmg = function(baseDmg, fSTR, pDif, attacker, target, ftp, wsMods)
    -- Physical Damage = (Weapon Damage + fSTR + WSC) x fTP x pdif x pdt
    -- where Base Damange is defined as Weapon Damage + fSTR
    if ftp == nil then
        ftp = 1
    end

    local dmg = (baseDmg + fSTR + wsMods) * ftp * pDif

    dmg = xi.weaponskills.handleBlock(attacker, target, dmg)
    return dmg
end

xi.summon.getSummoningSkillOverCap = function(avatar)
    local summoner = avatar:getMaster()
    local summoningSkill = summoner:getSkillLevel(xi.skill.SUMMONING_MAGIC)
    local maxSkill = summoner:getMaxSkillLevel(avatar:getMainLvl(), xi.job.SMN, xi.skill.SUMMONING_MAGIC)

    return math.max(summoningSkill - maxSkill, 0)
end

xi.summon.avatarPhysicalMove = function(avatar, target, skill, wsParams, tp)
    local returninfo = {}

    local calcParams = {}
    calcParams.skill = skill
    calcParams.fSTR = xi.summon.getAvatarfSTR(avatar:getStat(xi.mod.STR), target:getStat(xi.mod.VIT), avatar)
    calcParams.melee = true
    calcParams.tp = avatar:getTP()
    calcParams.alpha = xi.weaponskills.getAlpha(avatar:getMainLvl())

    -- https://forum.square-enix.com/ffxi/threads/45365?p=534537#post534537
    -- https://www.bg-wiki.com/bg/Hit_Rate
    -- https://www.bluegartr.com/threads/114636-Monster-Avatar-Pet-damage
    -- As of December 10th 2015 pet hit rate caps at 99% (familiars, wyverns, avatars and automatons) increased from 95%
    -- Cap at 95% for ASB
    local maxHitRate = 0.95
    local minHitRate = 0.2

    -- Hit Rate (%) = 75 + floor( (Accuracy - Evasion)/2 ) + 2*(dLVL)
    -- For Avatars negative penalties for level correction seem to be ignored for attack and likely for accuracy,
    -- bonuses cap at level diff of 38 based on this testing:
    -- https://www.bluegartr.com/threads/114636-Monster-Avatar-Pet-damage
    -- If there are penalties they seem to be applied differently similarly to monsters.
    -- This is all being handled inside xi.weaponskills.getHitRate
    local baseHitRate = xi.weaponskills.getHitRate(avatar, target, 0, xi.summon.getSummoningSkillOverCap(avatar), false, wsParams, calcParams)
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

    if missChance < hitrateFirst then
        firstHitLanded = true
        numHitsLanded = numHitsLanded + 1
    end

    while numHitsProcessed < wsParams.numHits do
        missChance = math.random()
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
        -- Pets do not crit unless specifically told to
        local critRate = 0
        if wsParams.critHit ~= nil then
            -- https://www.bg-wiki.com/bg/Critical_Hit_Rate
            local baseCritRate = 5
            local maxCritRate = 1 -- 100%
            local minCritRate = 0.05 -- 5% (This is useed after /100)
            critRate = (baseCritRate + getDexCritRate(avatar, target) + avatar:getMod(xi.mod.CRITHITRATE)) / 100
            critRate = utils.clamp(critRate, minCritRate, maxCritRate)
        end

        -- Calculate wSC
        local str = math.floor(avatar:getStat(xi.mod.STR) * wsParams.str_wsc)
        local dex = math.floor(avatar:getStat(xi.mod.DEX) * wsParams.dex_wsc)
        local vit = math.floor(avatar:getStat(xi.mod.VIT) * wsParams.vit_wsc)
        local agi = math.floor(avatar:getStat(xi.mod.AGI) * wsParams.agi_wsc)
        local int = math.floor(avatar:getStat(xi.mod.INT) * wsParams.int_wsc)
        local mnd = math.floor(avatar:getStat(xi.mod.MND) * wsParams.mnd_wsc)
        local chr = math.floor(avatar:getStat(xi.mod.CHR) * wsParams.chr_wsc)

        local wsMods = math.floor(math.floor(str + dex + vit + agi + int + mnd + chr) * calcParams.alpha) -- This calculates WSC, must floor twice in and then out
        local baseDmg = math.floor(10 + 0.5 * avatar:getMainLvl()) -- This calculates base damage of avatars

        -- If Carbuncle
        if avatar:getModelId() == 16 then
            baseDmg = math.floor(3 + 0.5 * avatar:getMainLvl())
        end

        local pDifTable = {}
        -- Calculate pDIF
        if wsParams.melee then
            pDifTable = xi.weaponskills.cMeleeRatio(avatar, target, wsParams, 0, calcParams.tp, xi.slot.MAIN)
        else
            pDifTable = xi.weaponskills.cRangedRatio(avatar, target, wsParams, 0, calcParams.tp)
        end

        local pDif = pDifTable[1]
        local pDifCrit = pDifTable[2]

        --Everything past this point is randomly computed per hit
        numHitsProcessed = 0

        if firstHitLanded then
            -- Avatars do not have scaling ftps until 2016. In case someone wants this as a qol change add it in
            local ftp = xi.summon.fTP(calcParams.tp, wsParams.ftp000,  wsParams.ftp150,  wsParams.ftp300, xi.attackType.PHYSICAL)
            local isCrit = math.random() < critRate

            if isCrit then
                pDif = pDifCrit
            end

            finaldmg = xi.summon.avatarHitDmg(baseDmg, calcParams.fSTR, pDif, avatar, target, ftp, wsMods)

            numHitsProcessed = 1
        end

        while numHitsProcessed < numHitsLanded do
            local ftp = 1
            local isCrit = math.random() < critRate
            pDifTable = xi.weaponskills.cMeleeRatio(avatar, target, wsParams, 0, calcParams.tp, xi.slot.MAIN)
            pDif = pDifTable[1]
            pDifCrit = pDifTable[2]

            if isCrit then
                pDif = pDifCrit
            end

            finaldmg = finaldmg + xi.summon.avatarHitDmg(baseDmg, calcParams.fSTR, pDif, avatar, target, ftp, wsMods)
            numHitsProcessed = numHitsProcessed + 1
        end
    end

    if target:getMod(xi.mod.PET_DMG_TAKEN_PHYSICAL) ~= 0 then
        finaldmg = finaldmg * (target:getMod(xi.mod.PET_DMG_TAKEN_PHYSICAL) / 100)
    end

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

xi.summon.physicalSDT = function(attacker, target, damagetype, finalDmg)
    local adjustedDamage = finalDmg
    adjustedDamage = target:physicalDmgTaken(adjustedDamage, damagetype)

    if damagetype == xi.damageType.BLUNT then
        adjustedDamage = adjustedDamage * target:getMod(xi.mod.IMPACT_SDT) / 1000
    elseif damagetype == xi.damageType.PIERCING then
        adjustedDamage = adjustedDamage * target:getMod(xi.mod.PIERCE_SDT) / 1000
    elseif damagetype == xi.damageType.SLASHING then
        adjustedDamage = adjustedDamage * target:getMod(xi.mod.SLASH_SDT) / 1000
    end

    return adjustedDamage
end

xi.summon.avatarFinalAdjustments = function(dmg, mob, skill, target, skilltype, damagetype, shadowbehav, shareEnmity)
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

    if skilltype == xi.attackType.PHYSICAL then
        -- Adds SDT resist to phys blood pacts
        dmg = xi.summon.physicalSDT(mob, target, damagetype, dmg)
    end

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
        (target:hasStatusEffect(xi.effect.PERFECT_DODGE) or
        target:hasStatusEffect(xi.effect.ALL_MISS)) and
        skilltype == xi.attackType.PHYSICAL
    then
        return 0
    end

    -- handle super jump
    if
        target:hasStatusEffect(xi.effect.ALL_MISS) and
        target:getStatusEffect(xi.effect.ALL_MISS):getPower() > 1
    then
        skill:setMsg(xi.msg.basic.JA_MISS_2)
        return 0
    end

    -- Calculate Blood Pact Damage before stoneskin
    dmg = dmg + dmg * mob:getMod(xi.mod.BP_DAMAGE) / 100

    -- if magic then apply magic mods here
    -- (physical mods are applied in physicalSDT)
    if skilltype == xi.attackType.MAGICAL then
        dmg = xi.damage.applyDamageTaken(target, dmg, skilltype, damagetype)
    end

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

-- Prepares the calc params for Magical BPs
xi.summon.calculateMagicBloodPactParams = function(avatar, target, skill, wsParams)
    -- set default value for tpBonus if it doesn't exist
    if not wsParams.tpBonus then
        wsParams.tpBonus = 0
    end

    local params = {}
    params.melee = false
    params.skill = skill
    params.dStat = utils.ternary(wsParams.breath, 0, xi.summon.dStat(avatar, target, xi.mod.INT))
    params.tp = avatar:getTP() + wsParams.tpBonus
    params.alpha = xi.weaponskills.getAlpha(avatar:getMainLvl())
    return params
end

-- Prepares the WSC values for magical BPs
xi.summon.calculateMagicWsc = function(avatar, wsParams, alpha)
    -- Get base stats
    local str = math.floor(avatar:getStat(xi.mod.STR) * wsParams.str_wsc)
    local dex = math.floor(avatar:getStat(xi.mod.DEX) * wsParams.dex_wsc)
    local vit = math.floor(avatar:getStat(xi.mod.VIT) * wsParams.vit_wsc)
    local agi = math.floor(avatar:getStat(xi.mod.AGI) * wsParams.agi_wsc)
    local int = math.floor(avatar:getStat(xi.mod.INT) * wsParams.int_wsc)
    local mnd = math.floor(avatar:getStat(xi.mod.MND) * wsParams.mnd_wsc)
    local chr = math.floor(avatar:getStat(xi.mod.CHR) * wsParams.chr_wsc)

    -- This calculates WSC, must floor twice in and then out
    return math.floor(math.floor(str + dex + vit + agi + int + mnd + chr) * alpha)
end

-- Prepares the magical resist values for avatar magical BPs
xi.summon.calculateResist = function(avatar, target, skill, skillType, spellElement, skillchainCount, params)
    local resist        = 1 -- The variable we want to calculate
    local hitRate       = 0.95 -- Default hit rate of capped hit
    local effectRes     = 0 -- Default value for effect resistance

    -- Get the effect resistance from the effectEva table
    if params.effect then
        effectRes = utils.ternary(xi.magic.effectEva[params.effect], xi.magic.effectEva[params.effect], 0)
    end

    -- if we're skillchaining, boost macc by 25
    if skillchainCount > 0 then
        if not params.maccBonus then
            params.maccBonus = 0
        end

        params.maccBonus = params.maccBonus + 25
    end

    -- Calcluate the hitRate of magic skills (These are always damageSpell)
    hitRate = xi.magic.getMagicHitRate(avatar, target, skillType, spellElement, params.effect, effectRes, params.maccBonus, params.dStat, skillchainCount, true, true)

    -- (These are always damageSpell)
    resist  = xi.magic.getMagicResist(hitRate, target, spellElement, effectRes, skillchainCount, params.effect, avatar, true)

    -- Nether Blast does not resist. It only echecks for BDT at the end.
    if params.netherBlast then
        resist = 1
    end

    return resist
end

-- Prepares the day/weather bonus for avatar magical BPs
xi.summon.calculateDayAndWeather = function(avatar, target, skill, spellElement)
    local dayAndWeather = 1 -- The variable we want to calculate
    local weather       = avatar:getWeather()
    local dayElement    = VanadielDayElement()
    local elementalObi  = { xi.mod.FORCE_FIRE_DWBONUS, xi.mod.FORCE_ICE_DWBONUS, xi.mod.FORCE_WIND_DWBONUS, xi.mod.FORCE_EARTH_DWBONUS, xi.mod.FORCE_LIGHTNING_DWBONUS, xi.mod.FORCE_WATER_DWBONUS, xi.mod.FORCE_LIGHT_DWBONUS, xi.mod.FORCE_DARK_DWBONUS }

    -- Calculate Weather bonus
    if math.random() < 0.33 or avatar:getMod(elementalObi[spellElement]) >= 1 then
        if weather == xi.magic.singleWeatherStrong[spellElement] then
            dayAndWeather = dayAndWeather + 0.10
            if avatar:getMod(xi.mod.IRIDESCENCE) >= 1 then
                dayAndWeather = dayAndWeather + 0.10
            end
        elseif weather == xi.magic.singleWeatherWeak[spellElement] then
            dayAndWeather = dayAndWeather - 0.10
        elseif weather == xi.magic.doubleWeatherStrong[spellElement] then
            dayAndWeather = dayAndWeather + 0.25
            if avatar:getMod(xi.mod.IRIDESCENCE) >= 1 then
                dayAndWeather = dayAndWeather + 0.10
            end
        elseif weather == xi.magic.doubleWeatherWeak[spellElement] then
            dayAndWeather = dayAndWeather - 0.25
        end
    end

    -- Calculate day bonus
    if dayElement == spellElement then
        dayAndWeather = dayAndWeather + avatar:getMod(xi.mod.DAY_NUKE_BONUS) / 100 -- sorc. tonban(+1)/zodiac ring
        if math.random() < 0.33 or avatar:getMod(elementalObi[spellElement]) >= 1 then
            dayAndWeather = dayAndWeather + 0.10
        end
    elseif dayElement == xi.magic.elementDescendant[spellElement] then
        if math.random() < 0.33 or avatar:getMod(elementalObi[spellElement]) >= 1 then
            dayAndWeather = dayAndWeather - 0.10
        end
    end

    -- Cap bonuses from both day and weather
    if dayAndWeather > 1.4 then
        dayAndWeather = 1.4
    end

    return dayAndWeather
end

-- Prepares the magic burst damage
xi.summon.calculateIfMagicBurst = function(avatar, target, skill, spellElement)
    return xi.spells.damage.calculateIfMagicBurst(avatar, target, skill, spellElement)
end

-- Apply status effects from magical BPs
xi.summon.applyBloodPactStatusEffect = function(avatar, target, resist, params)
    -- If the target already has the status effect, return immediately
    if params.effect and target:hasStatusEffect(params.effect) then
        return
    end

    if
        params.effect and
        params.chance and
        params.chance * resist > math.random() * 150 and
        params.duration * resist > 0
    then
        target:addStatusEffect(params.effect, params.power, params.tick, params.duration * resist)
    elseif
        params.effect and
        params.duration * resist > 0 and
        not params.chance
    then
        target:addStatusEffect(params.effect, params.power, params.tick, params.duration * resist)
    end
end

xi.summon.avatarMagicSkill = function(avatar, target, skill, wsParams)
    -- Formula:
    -- ((Lvl+2 + WSC) x fTP + dstat)
    -- x Magic Burst bonus
    -- x Resist
    -- x Day&Weather Bonus
    -- x MAB/MDB
    -- x MDT

    local finalDamage = 0 -- final return value

    -- Populate some default values in wsParams if necessary
    if wsParams.effect and not wsParams.tick then
        wsParams.tick = 0
    end

    if wsParams.effect and not wsParams.power then
        wsParams.power = 1
    end

    -- Get tabled variables
    local bpParams   = xi.summon.calculateMagicBloodPactParams(avatar, target, skill, wsParams)
    local spellElement = utils.ternary((wsParams.element ~= nil), wsParams.element, xi.magic.ele.NONE)
    local skillType    = utils.ternary((wsParams.element ~= nil), xi.skill.ELEMENTAL_MAGIC, nil)
    local sdtMod       = utils.ternary((wsParams.element ~= nil), xi.summon.sdtModTable[wsParams.element], nil)

    -- Form skillchain
    local _, skillchainCount = xi.magic.FormMagicBurst(wsParams.element, target)

    -- Variables / Steps to calculate final damage
    local wsc           = xi.summon.calculateMagicWsc(avatar, wsParams, bpParams.alpha)
    local ftp           = xi.summon.fTP(bpParams.tp, wsParams.ftp000,  wsParams.ftp150,  wsParams.ftp300, xi.attackType.MAGICAL)
    local lv2           = utils.ternary((wsParams.hybrid == true), math.floor(10 + 0.5 * avatar:getMainLvl()), avatar:getMainLvl() + 2)
    local resist        = xi.summon.calculateResist(avatar, target, skill, skillType, spellElement, skillchainCount, wsParams)
    local magicBurst    = xi.summon.calculateIfMagicBurst(avatar, target, skill, spellElement)
    local weatherBonus  = xi.summon.calculateDayAndWeather(avatar, target, skill, spellElement)
    local mab           = 100 + avatar:getMod(xi.mod.MATT)
    local mdb           = 100 + target:getMod(xi.mod.MDEF)
    local mdef          = mab / mdb
    -- magic SDT range from -10000 to 10000 with positive values meaning less damage
    local mdt           = utils.ternary((sdtMod ~= nil), 1 - (target:getMod(sdtMod) / 10000), 1)
    local bonus         = xi.settings.main.WEAPON_SKILL_POWER

    -- Account for potentially 0 MDT
    if mdt <= 0 then
        mdt = 1
    end

    -- Apply any status effects
    xi.summon.applyBloodPactStatusEffect(avatar, target, resist, wsParams)

    -- ((Lvl+2 + WSC) x fTP + dstat)
    finalDamage = math.floor(((lv2 + wsc) * ftp) + bpParams.dStat)
    -- x Magic Burst
    finalDamage = math.floor(finalDamage * magicBurst)
    -- x Resist
    finalDamage = math.floor(finalDamage * resist)
    -- x Weather & Day Bonus
    finalDamage = math.floor(finalDamage * weatherBonus)
    -- x MAB / MDB
    finalDamage = math.floor(finalDamage * mdef)
    -- x MDT
    finalDamage = math.floor(finalDamage * mdt)
    -- x Server WS Bonus
    finalDamage = math.floor(finalDamage * bonus)

    -- @TODO: Need to just return the clamped dmg, but it requires updating all magic BP scripts
    return { dmg = utils.clamp(finalDamage, 0, 99999) }
end
