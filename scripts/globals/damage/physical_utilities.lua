-----------------------------------
-- Global, independent functions for physical calculations.
-- Includes:
-- fSTR, fSTR2, WSC, fTP

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
require("scripts/globals/items")
-----------------------------------
xi = xi or {}
xi.combat = xi.combat or {}
xi.combat.physical = xi.combat.physical or {}
-----------------------------------
local wsElementalProperties =
{
-- [Resonance] = { None, Fire, Ice, Wind, Earth, Thunder, Water, Light, Dark },
    [       0] = {    0,    0,   0,    0,     0,       0,     0,     0,    0 }, -- Lv 0, NONE
    [       1] = {    0,    0,   0,    0,     0,       0,     0,     1,    0 }, -- Lv 1, Transfixion
    [       2] = {    0,    0,   0,    0,     0,       0,     0,     0,    1 }, -- Lv 1, Compression
    [       3] = {    0,    1,   0,    0,     0,       0,     0,     0,    0 }, -- Lv 1, Liquefaction
    [       4] = {    0,    0,   0,    0,     1,       0,     0,     0,    0 }, -- Lv 1, Scission
    [       5] = {    0,    0,   0,    0,     0,       0,     1,     0,    0 }, -- Lv 1, Reverberation
    [       6] = {    0,    0,   0,    1,     0,       0,     0,     0,    0 }, -- Lv 1, Detonation
    [       7] = {    0,    0,   1,    0,     0,       0,     0,     0,    0 }, -- Lv 1, Induration
    [       8] = {    0,    0,   0,    0,     0,       1,     0,     0,    0 }, -- Lv 1, Impaction
    [       9] = {    0,    0,   0,    0,     1,       0,     0,     0,    1 }, -- Lv 2, Gravitation
    [      10] = {    0,    0,   1,    0,     0,       0,     1,     0,    0 }, -- Lv 2, Distorsion
    [      11] = {    0,    1,   0,    0,     0,       0,     0,     1,    0 }, -- Lv 2, Fusion
    [      12] = {    0,    0,   0,    1,     0,       1,     0,     0,    0 }, -- Lv 2, Fragmentation
    [      13] = {    0,    1,   0,    1,     0,       1,     0,     1,    0 }, -- Lv 3, Light
    [      14] = {    0,    0,   1,    0,     1,       0,     1,     0,    1 }, -- Lv 3, Darkness
    [      15] = {    0,    1,   0,    1,     0,       1,     0,     1,    0 }, -- Lv 4, Light
    [      16] = {    0,    0,   1,    0,     1,       0,     1,     0,    1 }, -- Lv 4, Darkness
}

local elementalGorget = -- Ordered by element.
{
    xi.items.FLAME_GORGET,
    xi.items.SNOW_GORGET,
    xi.items.BREEZE_GORGET,
    xi.items.SOIL_GORGET,
    xi.items.THUNDER_GORGET,
    xi.items.AQUA_GORGET,
    xi.items.LIGHT_GORGET,
    xi.items.SHADOW_GORGET
}

local elementalBelt = -- Ordered by element.
{
    xi.items.FLAME_BELT,
    xi.items.SNOW_BELT,
    xi.items.BREEZE_BELT,
    xi.items.SOIL_BELT,
    xi.items.THUNDER_BELT,
    xi.items.AQUA_BELT,
    xi.items.LIGHT_BELT,
    xi.items.SHADOW_BELT
}

-- "fSTR" in English Wikis. "SV function" in JP wiki and Studio Gobli.
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

-- "fSTR2" in English Wikis. "SV function" in JP wiki and Studio Gobli.
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

    fSTR = utils.clamp(fSTR2 / 2, fSTRlowerCap, fSTRupperCap)

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

-- TP Multiplier calculations.
xi.combat.physical.calculateFTP = function(actor, wsTP1000, wsTP2000, wsTP3000)
    local fTP     = 1
    local actorTP = actor:getTP()

    ------------------------------
    -- Regular fTP
    ------------------------------
    if actorTP >= 2000 then
        fTP = wsTP2000 + (((wsTP3000 - wsTP2000) / 1000) * (actorTP - 2000))
    elseif actorTP >= 1000 then
        fTP = wsTP1000 + (((wsTP2000 - wsTP1000) / 1000) * (actorTP - 1000))
    end

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
            neckItem == xi.items.FOTIA_GORGET
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
            waistItem == xi.items.FOTIA_BELT
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
                headItem == xi.items.MEKIRA_OTO or
                headItem == xi.items.MEKIRA_OTO_P1
            then
                headFtpBonus = 0.1
            elseif headItem == xi.items.GAVIALIS_HELM then
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
            if handsItem == xi.items.ATHOSS_GLOVES then
                handsFtpBonus = 0.06
            end
        end
    end

    -- Add all bonuses and return.
    fTP = fTP + neckFtpBonus + waistFtpBonus + headFtpBonus + handsFtpBonus

    return fTP
end

xi.combat.physical.calculatePDIF = function(actor, additionalParamsHere)
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
