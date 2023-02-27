-----------------------------------
-- Global, independent functions for physical calculations.
-- Includes:
-- fSTR, fSTR2
-----------------------------------
xi = xi or {}
xi.combat = xi.combat or {}
xi.combat.physical = xi.combat.physical or {}
-----------------------------------

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
