-----------------------------------
-- Global, independent functions for physical calculations.
-- Includes:
-- fSTR, fSTR2, WSC, fTP, pDIF

-- For weapon skill:
-- Damage PER HIT = floor((D + fSTR + WSC) * fTP) * pDIF

-- Intended WS structure:
-- 1  - Calculate number of hits (max 8)
-- 1a - Calculate hits absorbed by blink and utsusemi, if aplicable.

-- 2  - Calculate first hit:
-- 2a - Calculate if first hit lands
-- 2b - Calculate if first hit crits
-- 2c - Calculate first hit DMG

-- 3  - Calculate, per hit, secondary hits, following the same structure as before, but simplified (no first-hit bonuses)

-- 4  - Add them all, and final operations/considerations.
-----------------------------------
xi = xi or {}
xi.combat = xi.combat or {}
xi.combat.physical = xi.combat.physical or {}
-----------------------------------
local wsElementalProperties =
{
    -- [Skillchain type             ] = { None, Fire, Ice, Wind, Earth, Thunder, Water, Light, Dark },
    [xi.skillchainType.NONE         ] = {    0,    0,   0,    0,     0,       0,     0,     0,    0 }, -- Lv0 None
    [xi.skillchainType.TRANSFIXION  ] = {    0,    0,   0,    0,     0,       0,     0,     1,    0 }, -- Lv1 Light
    [xi.skillchainType.COMPRESSION  ] = {    0,    0,   0,    0,     0,       0,     0,     0,    1 }, -- Lv1 Dark
    [xi.skillchainType.LIQUEFACTION ] = {    0,    1,   0,    0,     0,       0,     0,     0,    0 }, -- Lv1 Fire
    [xi.skillchainType.SCISSION     ] = {    0,    0,   0,    0,     1,       0,     0,     0,    0 }, -- Lv1 Earth
    [xi.skillchainType.REVERBERATION] = {    0,    0,   0,    0,     0,       0,     1,     0,    0 }, -- Lv1 Water
    [xi.skillchainType.DETONATION   ] = {    0,    0,   0,    1,     0,       0,     0,     0,    0 }, -- Lv1 Wind
    [xi.skillchainType.INDURATION   ] = {    0,    0,   1,    0,     0,       0,     0,     0,    0 }, -- Lv1 Ice
    [xi.skillchainType.IMPACTION    ] = {    0,    0,   0,    0,     0,       1,     0,     0,    0 }, -- Lv1 Thunder
    [xi.skillchainType.GRAVITATION  ] = {    0,    0,   0,    0,     1,       0,     0,     0,    1 }, -- Lv2 Earth & Dark
    [xi.skillchainType.DISTORTION   ] = {    0,    0,   1,    0,     0,       0,     1,     0,    0 }, -- Lv2 Ice & Water
    [xi.skillchainType.FUSION       ] = {    0,    1,   0,    0,     0,       0,     0,     1,    0 }, -- Lv2 Fire & Light
    [xi.skillchainType.FRAGMENTATION] = {    0,    0,   0,    1,     0,       1,     0,     0,    0 }, -- Lv2 Wind & Thunder
    [xi.skillchainType.LIGHT        ] = {    0,    1,   0,    1,     0,       1,     0,     1,    0 }, -- Lv3 Fire, Wind, Thunder, Light
    [xi.skillchainType.DARKNESS     ] = {    0,    0,   1,    0,     1,       0,     1,     0,    1 }, -- Lv3 Ice, Earth, Water, Dark
    [xi.skillchainType.LIGHT_II     ] = {    0,    1,   0,    1,     0,       1,     0,     1,    0 }, -- Lv4 Fire, Wind, Thunder, Light
    [xi.skillchainType.DARKNESS_II  ] = {    0,    0,   1,    0,     1,       0,     1,     0,    1 }, -- Lv4 Ice, Earth, Water, Dark
}

-- Table with pDIF caps per weapon/skill type.
local pDifWeaponCapTable =
{
    -- [Skill/weapon type used] = {pre-randomizer_pDIF_cap}, Values from: https://www.bg-wiki.com/ffxi/PDIF
    [xi.skill.NONE            ] = { 3    }, -- We will use this for mobs.
    [xi.skill.HAND_TO_HAND    ] = { 3.5  },
    [xi.skill.DAGGER          ] = { 3.25 },
    [xi.skill.SWORD           ] = { 3.25 },
    [xi.skill.GREAT_SWORD     ] = { 3.75 },
    [xi.skill.AXE             ] = { 3.25 },
    [xi.skill.GREAT_AXE       ] = { 3.75 },
    [xi.skill.SCYTHE          ] = { 4    },
    [xi.skill.POLEARM         ] = { 3.75 },
    [xi.skill.KATANA          ] = { 3.25 },
    [xi.skill.GREAT_KATANA    ] = { 3.5  },
    [xi.skill.CLUB            ] = { 3.25 },
    [xi.skill.STAFF           ] = { 3.75 },
    [xi.skill.AUTOMATON_MELEE ] = { 3    }, -- Unknown value. Copy of value below.
    [xi.skill.AUTOMATON_RANGED] = { 3    }, -- Unknown value. Reference found in an old post: https://forum.square-enix.com/ffxi/archive/index.php/t-52778.html?s=d906df07788334a185a902b0a6ae6a99
    [xi.skill.AUTOMATON_MAGIC ] = { 3    }, -- Unknown value. Here for completion sake.
    [xi.skill.ARCHERY         ] = { 3.25 },
    [xi.skill.MARKSMANSHIP    ] = { 3.5  },
    [xi.skill.THROWING        ] = { 3.25 },
}

local elementalGorget = -- Ordered by element.
{
    xi.item.FLAME_GORGET,
    xi.item.SNOW_GORGET,
    xi.item.BREEZE_GORGET,
    xi.item.SOIL_GORGET,
    xi.item.THUNDER_GORGET,
    xi.item.AQUA_GORGET,
    xi.item.LIGHT_GORGET,
    xi.item.SHADOW_GORGET
}

local elementalBelt = -- Ordered by element.
{
    xi.item.FLAME_BELT,
    xi.item.SNOW_BELT,
    xi.item.BREEZE_BELT,
    xi.item.SOIL_BELT,
    xi.item.THUNDER_BELT,
    xi.item.AQUA_BELT,
    xi.item.LIGHT_BELT,
    xi.item.SHADOW_BELT
}

-- 'fSTR' in English Wikis. 'SV function' in JP wiki and Studio Gobli.
-- BG wiki: https://www.bg-wiki.com/ffxi/FSTR
-- Gobli Wiki: https://w-atwiki-jp.translate.goog/studiogobli/pages/14.html?_x_tr_sl=auto&_x_tr_tl=en&_x_tr_hl=en&_x_tr_pto=wapp
xi.combat.physical.calculateMeleeStatFactor = function(actor, target)
    local fSTR = 0 -- The variable we want to calculate.

    -- Calculate statDiff.
    local statDiff     = actor:getStat(xi.mod.STR) - target:getStat(xi.mod.VIT)
    local weaponRank   = actor:getWeaponDmgRank()
    local statLowerCap = (7 + weaponRank * 2) * -2
    local statUpperCap = (14 + weaponRank * 2) * 2

    statDiff = utils.clamp(statDiff, statLowerCap, statUpperCap)

    -- Calculate fSTR based on stat difference.
    if statDiff >= 12 then
        fSTR = statDiff + 4
    elseif statDiff >= 6 then
        fSTR = statDiff + 6
    elseif statDiff >= 1 then
        fSTR = statDiff + 7
    elseif statDiff >= -2 then
        fSTR = statDiff + 8
    elseif statDiff >= -7 then
        fSTR = statDiff + 9
    elseif statDiff >= -15 then
        fSTR = statDiff + 10
    elseif statDiff >= -21 then
        fSTR = statDiff + 12
    else
        fSTR = statDiff + 13
    end

    -- Clamp fSTR.
    local fSTRupperCap = weaponRank + 8
    local fSTRlowerCap = weaponRank * -1

    if weaponRank == 0 then
        fSTRlowerCap = -1
    end

    fSTR = utils.clamp(fSTR / 4, fSTRlowerCap, fSTRupperCap)

    return fSTR
end

-- 'fSTR2' in English Wikis. 'SV function' in JP wiki and Studio Gobli.
-- BG wiki: https://www.bg-wiki.com/ffxi/FSTR
-- Gobli Wiki: https://w-atwiki-jp.translate.goog/studiogobli/pages/14.html?_x_tr_sl=auto&_x_tr_tl=en&_x_tr_hl=en&_x_tr_pto=wapp
xi.combat.physical.calculateRangedStatFactor = function(actor, target)
    local fSTR = 0 -- The variable we want to calculate.

    -- Calculate statDiff.
    local statDiff     = actor:getStat(xi.mod.STR) - target:getStat(xi.mod.VIT)
    local weaponRank   = actor:getWeaponDmgRank()
    local statLowerCap = (7 + weaponRank * 2) * -2
    local statUpperCap = (14 + weaponRank * 2) * 2

    statDiff = utils.clamp(statDiff, statLowerCap, statUpperCap)

    -- Calculate fSTR based on stat difference.
    if statDiff >= 12 then
        fSTR = statDiff + 4
    elseif statDiff >= 6 then
        fSTR = statDiff + 6
    elseif statDiff >= 1 then
        fSTR = statDiff + 7
    elseif statDiff >= -2 then
        fSTR = statDiff + 8
    elseif statDiff >= -7 then
        fSTR = statDiff + 9
    elseif statDiff >= -15 then
        fSTR = statDiff + 10
    elseif statDiff >= -21 then
        fSTR = statDiff + 12
    else
        fSTR = statDiff + 13
    end

    -- Clamp fSTR.
    local fSTRupperCap = (weaponRank + 8) * 2
    local fSTRlowerCap = weaponRank * -2

    if weaponRank == 0 then
        fSTRlowerCap = -2
    elseif weaponRank == 1 then
        fSTRlowerCap = -3
    end

    fSTR = utils.clamp(fSTR / 2, fSTRlowerCap, fSTRupperCap)

    return fSTR
end

-- Weapon Skill Secondary Attribute Modifier: Function used to get stat addition to base damage.
xi.combat.physical.calculateWSC = function(actor, wsSTRmod, wsDEXmod, wsVITmod, wsAGImod, wsINTmod, wsMNDmod, wsCHRmod)
    local finalWSC = 0

    -- wscSTAT = actor stat * (WS stat modifier + Actor-specific WS stat modifier)
    local wscSTR = actor:getStat(xi.mod.STR) * (wsSTRmod + actor:getMod(xi.mod.WS_STR_BONUS) / 100)
    local wscDEX = actor:getStat(xi.mod.DEX) * (wsDEXmod + actor:getMod(xi.mod.WS_DEX_BONUS) / 100)
    local wscVIT = actor:getStat(xi.mod.VIT) * (wsVITmod + actor:getMod(xi.mod.WS_VIT_BONUS) / 100)
    local wscAGI = actor:getStat(xi.mod.AGI) * (wsAGImod + actor:getMod(xi.mod.WS_AGI_BONUS) / 100)
    local wscINT = actor:getStat(xi.mod.INT) * (wsINTmod + actor:getMod(xi.mod.WS_INT_BONUS) / 100)
    local wscMND = actor:getStat(xi.mod.MND) * (wsMNDmod + actor:getMod(xi.mod.WS_MND_BONUS) / 100)
    local wscCHR = actor:getStat(xi.mod.CHR) * (wsCHRmod + actor:getMod(xi.mod.WS_CHR_BONUS) / 100)

    finalWSC = wscSTR + wscDEX + wscVIT + wscAGI + wscINT + wscMND + wscCHR

    return finalWSC
end

-- TP factor equation. Used to determine TP modifer across all cases of 'X varies with TP'
xi.combat.physical.calculateTPfactor = function(actor, TP1000, TP2000, TP3000)
    local tpFactor = 1
    local actorTP  = actor:getTP()

    if actorTP >= 2000 then
        tpFactor = TP2000 + (actorTP - 2000) * (TP3000 - TP2000) / 1000
    elseif actorTP >= 1000 then
        tpFactor = TP1000 + (actorTP - 1000) * (TP2000 - TP1000) / 1000
    end

    return tpFactor
end

-- TP Multiplier calculations.
xi.combat.physical.calculateFTP = function(actor, tpFactor)
    ------------------------------
    -- Regular fTP
    ------------------------------
    local fTP = tpFactor

    ------------------------------
    -- Equipment fTP bonuses.
    ------------------------------
    -- TODO: Use item mods and latents for the conditional fTP bonuses they provide.
    local scProp1, scProp2, scProp3 = actor:getWSSkillchainProp()
    local dayElement                = VanadielDayElement() + 1

    local neckFtpBonus  = 0
    local waistFtpBonus = 0
    local headFtpBonus  = 0
    local handsFtpBonus = 0

    if actor:getObjType() == xi.objType.PC then
        -- Calculate Neck fTP bonus.
        local neckItem    = actor:getEquipID(xi.slot.NECK)
        local neckElement = 1 -- We start at 1 for table lookup. 1 = no element.

        -- Get Gorget associated element.
        for i, v in ipairs(elementalGorget) do
            if neckItem == v then
                neckElement = neckElement + i

                break
            end
        end

        -- Compare WS elemental property with Gorget element.
        if
            wsElementalProperties[scProp1][neckElement] == 1 or
            wsElementalProperties[scProp2][neckElement] == 1 or
            wsElementalProperties[scProp3][neckElement] == 1 or
            neckItem == xi.item.FOTIA_GORGET
        then
            neckFtpBonus = 0.1
        end

        -- Calculate Waist fTP bonus.
        local waistItem    = actor:getEquipID(xi.slot.WAIST)
        local waistElement = 1 -- We start at 1 for table lookup. 1 = no element.

        -- Get Belt associated element.
        for i, v in ipairs(elementalBelt) do
            if waistItem == v then
                waistElement = waistElement + i

                break
            end
        end

        -- Compare WS elemental property with Belt element.
        if
            wsElementalProperties[scProp1][waistElement] == 1 or
            wsElementalProperties[scProp2][waistElement] == 1 or
            wsElementalProperties[scProp3][waistElement] == 1 or
            waistItem == xi.item.FOTIA_BELT
        then
            waistFtpBonus = 0.1
        end

        -- Claculate Head fTP bonus.
        local headItem = actor:getEquipID(xi.slot.HEAD)

        if
            wsElementalProperties[scProp1][dayElement] == 1 or
            wsElementalProperties[scProp2][dayElement] == 1 or
            wsElementalProperties[scProp3][dayElement] == 1
        then
            if
                headItem == xi.item.MEKIRA_OTO or
                headItem == xi.item.MEKIRA_OTO_P1
            then
                headFtpBonus = 0.1
            elseif headItem == xi.item.GAVIALIS_HELM then
                headFtpBonus = 0.117
            end
        end

        -- Calculate Hands fTP bonus.
        local handsItem = actor:getEquipID(xi.slot.HANDS)

        if
            wsElementalProperties[scProp1][dayElement] == 1 or
            wsElementalProperties[scProp2][dayElement] == 1 or
            wsElementalProperties[scProp3][dayElement] == 1
        then
            if handsItem == xi.item.ATHOSS_GLOVES then
                handsFtpBonus = 0.06
            end
        end
    end

    -- Add all bonuses and return.
    fTP = fTP + neckFtpBonus + waistFtpBonus + headFtpBonus + handsFtpBonus

    return fTP
end

xi.combat.physical.calculateMeleePDIF = function(actor, target, weaponType, wsAttackMod, isCritical, applyLevelCorrection, tpIgnoresDefense, tpFactor)
    local pDif = 0

    ----------------------------------------
    -- Step 1: Attack / Defense Ratio
    ----------------------------------------
    local baseRatio     = 0
    local actorAttack   = math.floor(actor:getStat(xi.mod.ATT) * wsAttackMod)
    local targetDefense = target:getStat(xi.mod.DEF)

    -- Actor Attack modifiers.
    if actor:hasStatusEffect(xi.effect.BUILDING_FLOURISH) then
        local flourishEffect = actor:getStatusEffect(xi.effect.BUILDING_FLOURISH)

        if flourishEffect:getPower() >= 2 then -- 2 or more Finishing Moves used.
            actorAttack = actorAttack + 25 + flourishEffect:getSubPower()
        end
    end

    -- Target Defense Modifiers.
    local ignoreDefenseFactor = 1

    if tpIgnoresDefense then
        ignoreDefenseFactor = tpFactor
    end

    targetDefense = math.floor(targetDefense * ignoreDefenseFactor)

    baseRatio = actorAttack / targetDefense

    -- Apply cap to baseRatio.
    baseRatio = utils.clamp(baseRatio, 0, 10) -- Can't be negative.

    ----------------------------------------
    -- Step 2: cRatio (Level correction, corrected ratio) Zone based!
    ----------------------------------------
    local levelDifFactor = 0

    if applyLevelCorrection then
        levelDifFactor = (target:getMainLvl() - actor:getMainLvl()) * 0.05
    end

    -- Only players suffer from negative level difference.
    if
        not actor:isPC() and
        levelDifFactor < 0
    then
        levelDifFactor = 0
    end

    local cRatio = utils.clamp(baseRatio - levelDifFactor, 0, 10) -- Clamp for the lower limit, mainly.

    ----------------------------------------
    -- Step 3: wRatio and pDif Caps (Melee)
    ----------------------------------------
    local wRatio       = cRatio + isCritical
    local pDifUpperCap = 0
    local pDifLowerCap = 0

    -- pDIF upper cap.
    if wRatio < 0.5 then
        pDifUpperCap = wRatio + 0.5
    elseif wRatio < 0.7 then
        pDifUpperCap = 1
    elseif wRatio < 1.2 then
        pDifUpperCap = wRatio + 0.3
    elseif wRatio < 1.5 then
        pDifUpperCap = wRatio + wRatio * 0.25
    else
        pDifUpperCap = utils.clamp(wRatio + 0.375, 1, 3)
    end

    -- pDIF lower cap.
    if wRatio < 0.38 then
        pDifLowerCap = 0
    elseif wRatio < 1.25 then
        pDifLowerCap = wRatio * 1176 / 1024 - 448 / 1024
    elseif wRatio < 1.51 then
        pDifLowerCap = 1
    elseif wRatio < 2.44 then
        pDifLowerCap = wRatio * 1176 / 1024 - 775 / 1024
    else
        pDifLowerCap = wRatio - 0.375
    end

    pDif = math.random(pDifLowerCap * 1000, pDifUpperCap * 1000) / 1000

    ----------------------------------------
    -- Step 4: Apply weapon type caps.
    ----------------------------------------
    local pDifFinalCap = pDifWeaponCapTable[weaponType][1] + isCritical -- TODO: Add 'Damage Limit +' Trait here.

    pDif = utils.clamp(pDif, 0, pDifFinalCap)

    ----------------------------------------
    -- Step 5: Melee random factor.
    ----------------------------------------
    local meleeRandom = math.random(100, 105) / 100

    pDif = pDif * meleeRandom

    return pDif
end

xi.combat.physical.calculateRangedPDIF = function(actor, target, weaponType, wsAttackMod, isCritical, applyLevelCorrection, tpIgnoresDefense, tpFactor)
    local pDif = 0

    ----------------------------------------
    -- Step 1: Attack / Defense Ratio
    ----------------------------------------
    local baseRatio     = 0
    local actorAttack   = math.floor(actor:getStat(xi.mod.RATT) * wsAttackMod)
    local targetDefense = target:getStat(xi.mod.DEF)

    -- Actor Ranged Attack modifiers.
    if actor:hasStatusEffect(xi.effect.BUILDING_FLOURISH) then
        local flourishEffect = actor:getStatusEffect(xi.effect.BUILDING_FLOURISH)

        if flourishEffect:getPower() >= 2 then -- 2 or more Finishing Moves used.
            actorAttack = actorAttack + 25 + flourishEffect:getSubPower()
        end
    end

    -- Target Defense Modifiers.
    local ignoreDefenseFactor = 1

    if tpIgnoresDefense then
        ignoreDefenseFactor = tpFactor
    end

    targetDefense = math.floor(targetDefense * ignoreDefenseFactor)

    baseRatio = actorAttack / targetDefense

    -- Apply cap to baseRatio.
    baseRatio = utils.clamp(baseRatio, 0, 10) -- Can't be negative.

    ----------------------------------------
    -- Step 2: cRatio (Level correction, corrected ratio) Zone based!
    ----------------------------------------
    local levelDifFactor = 0

    if applyLevelCorrection then
        levelDifFactor = (target:getMainLvl() - actor:getMainLvl()) * 0.05
    end

    -- Only players suffer from negative level difference.
    if
        not actor:isPC() and
        levelDifFactor < 0
    then
        levelDifFactor = 0
    end

    local cRatio = utils.clamp(baseRatio - levelDifFactor, 0, 10) -- Clamp for the lower limit, mainly.

    -- TODO: Presumably, pets get a Cap here if the target checks as 'Too Weak'. More info needed.

    ----------------------------------------
    -- Step 3: pDif Caps (Ranged)
    ----------------------------------------
    local pDifUpperCap = 0
    local pDifLowerCap = 0

    -- pDIF upper and lower caps.
    if cRatio < 0.9 then
        pDifUpperCap = cRatio * 10 / 9
        pDifLowerCap = cRatio
    elseif cRatio < 1.1 then
        pDifUpperCap = 1
        pDifLowerCap = 1
    else
        pDifUpperCap = cRatio
        pDifLowerCap = cRatio * 20 / 19 - 3 / 19
    end

    pDif = math.random(pDifLowerCap * 1000, pDifUpperCap * 1000) / 1000

    ----------------------------------------
    -- Step 4: Apply weapon type caps.
    ----------------------------------------
    local pDifFinalCap = pDifWeaponCapTable[weaponType][1] + isCritical -- TODO: Add 'Damage Limit +' Trait here.

    pDif = utils.clamp(pDif, 0, pDifFinalCap)

    ----------------------------------------
    -- Step 5: Ranged critical factor. Bypasses caps.
    ----------------------------------------
    if isCritical == 1 then
        pDif = pDif * 1.25
    end

    -- Step 6: Distance correction and True Shot.
    -- TODO: Implement distance correction and True shot...

    return pDif
end

-----------------------------------
-- Critical hit rate operations
-----------------------------------
-- dStat: Critical hit rate bonus from DEX vs AGI difference.
xi.combat.physical.criticalRateFromStatDiff = function(actor, target)
    local statBonus = 0

    local dDex = actor:getStat(xi.mod.DEX) - target:getStat(xi.mod.AGI)

    if dDex > 50 then
        statBonus = 0.15
    elseif dDex >= 40 then
        statBonus = (dDex - 35) / 100
    elseif dDex >= 30 then
        statBonus = 0.04
    elseif dDex >= 20 then
        statBonus = 0.03
    elseif dDex >= 14 then
        statBonus = 0.02
    elseif dDex >= 7 then
        statBonus = 0.01
    end

    return statBonus
end

-- Innin: Critical hit rate bonus when actor is behind target.
xi.combat.physical.criticalRateFromInnin = function(actor, target)
    local inninBonus = 0

    if
        actor:hasStatusEffect(xi.effect.INNIN) and
        actor:isBehind(target, 23)
    then
        inninBonus = actor:getStatusEffect(xi.effect.INNIN):getPower()
    end

    return inninBonus
end

-- Fencer: Critical hit rate bonus when actor is only wielding with main hand.
xi.combat.physical.criticalRateFromFencer = function(actor)
    local fencerBonus = 0

    local mainEquip = actor:getStorageItem(0, 0, xi.slot.MAIN)
    local subEquip  = actor:getStorageItem(0, 0, xi.slot.SUB)

    if
        actor:getObjType() == xi.objType.PC and
        mainEquip and
        not mainEquip:isTwoHanded() and                                                      -- No 2 handed weapons.
        not mainEquip:isHandToHand() and                                                     -- No 2 handed weapons.
        (subEquip == nil or subEquip:getSkillType() == xi.skill.NONE or subEquip:isShield()) -- Only shields allowed in sub.
    then
        fencerBonus = actor:getMod(xi.mod.FENCER_CRITHITRATE) / 100
    end

    return fencerBonus
end

-- Critical rate from Building Flourish.
-- TODO: Study case were if we can attach modifiers to the effect itself, both this and the effect may need refactoring.
xi.combat.physical.criticalRateFromFlourish = function(actor)
    local buildingFlourishBonus = 0

    if actor:hasStatusEffect(xi.effect.BUILDING_FLOURISH) then
        local effectPower    = actor:getStatusEffect(xi.effect.BUILDING_FLOURISH):getPower()
        local effectSubPower = actor:getStatusEffect(xi.effect.BUILDING_FLOURISH):getSubPower()

        if effectPower >= 3 then
            buildingFlourishBonus = (10 + effectSubPower) / 100
        end
    end

    return buildingFlourishBonus
end

-- Critical rate master function.
xi.combat.physical.calculateSwingCriticalRate = function(actor, target, isWeaponskill, TP1000, TP2000, TP3000)
    -- See reference at https://www.bg-wiki.com/ffxi/Critical_Hit_Rate
    local finalCriticalRate     = 0
    local baseCriticalRate      = 0.05
    local statBonus             = xi.combat.physical.criticalRateFromStatDiff(actor, target)
    local inninBonus            = xi.combat.physical.criticalRateFromInnin(actor, target)
    local fencerBonus           = xi.combat.physical.criticalRateFromFencer(actor)
    local buildingFlourishBonus = xi.combat.physical.criticalRateFromFlourish(actor)
    local modifierBonus         = actor:getMod(xi.mod.CRITHITRATE) / 100
    local meritBonus            = actor:getMerit(xi.merit.CRIT_HIT_RATE) / 100
    local targetModifierBonus   = target:getMod(xi.mod.ENEMYCRITRATE) / 100
    local meritPenalty          = target:getMerit(xi.merit.ENEMY_CRIT_RATE) / 100
    local tpFactor              = 0

    -- For weaponskills.
    if isWeaponskill then
        tpFactor = xi.combat.physical.calculateTPfactor(actor, TP1000, TP2000, TP3000)
    end

    -- Add all different bonuses and clamp.
    finalCriticalRate = baseCriticalRate + statBonus + inninBonus + fencerBonus + buildingFlourishBonus + modifierBonus + meritBonus + targetModifierBonus - meritPenalty + tpFactor

    return utils.clamp(finalCriticalRate, 0.05, 1) -- TODO: Need confirmation of no upper cap.
end

xi.combat.physical.calculateNumberOfHits = function(actor, additionalParamsHere)
end

-- Main Hit (First hit) Functions.
xi.combat.physical.calculateMainHitAccuracy = function(actor, additionalParamsHere)
end

xi.combat.physical.calculateMainHitCritical = function(actor, additionalParamsHere)
end

xi.combat.physical.calculateMainHitDamage = function(actor, additionalParamsHere)
end

-- Secondary Hits (All other) Functions.
xi.combat.physical.calculateSecondaryHitAccuracy = function(actor, additionalParamsHere)
end

xi.combat.physical.calculateSecondaryHitCritical = function(actor, additionalParamsHere)
end

xi.combat.physical.calculateSecondaryHitDamage = function(actor, additionalParamsHere)
end
