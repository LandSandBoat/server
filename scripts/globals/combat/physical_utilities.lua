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
    -- [Skillchain type             ] = { Fire, Ice, Wind, Earth, Thunder, Water, Light, Dark },
    [xi.skillchainType.NONE         ] = { 0, 0, 0, 0, 0, 0, 0, 0 }, -- Lv0 None
    [xi.skillchainType.LIQUEFACTION ] = { 1, 0, 0, 0, 0, 0, 0, 0 }, -- Lv1 Fire
    [xi.skillchainType.INDURATION   ] = { 0, 1, 0, 0, 0, 0, 0, 0 }, -- Lv1 Ice
    [xi.skillchainType.DETONATION   ] = { 0, 0, 1, 0, 0, 0, 0, 0 }, -- Lv1 Wind
    [xi.skillchainType.SCISSION     ] = { 0, 0, 0, 1, 0, 0, 0, 0 }, -- Lv1 Earth
    [xi.skillchainType.IMPACTION    ] = { 0, 0, 0, 0, 1, 0, 0, 0 }, -- Lv1 Thunder
    [xi.skillchainType.REVERBERATION] = { 0, 0, 0, 0, 0, 1, 0, 0 }, -- Lv1 Water
    [xi.skillchainType.TRANSFIXION  ] = { 0, 0, 0, 0, 0, 0, 1, 0 }, -- Lv1 Light
    [xi.skillchainType.COMPRESSION  ] = { 0, 0, 0, 0, 0, 0, 0, 1 }, -- Lv1 Dark
    [xi.skillchainType.FUSION       ] = { 1, 0, 0, 0, 0, 0, 1, 0 }, -- Lv2 Fire & Light
    [xi.skillchainType.DISTORTION   ] = { 0, 1, 0, 0, 0, 1, 0, 0 }, -- Lv2 Ice & Water
    [xi.skillchainType.FRAGMENTATION] = { 0, 0, 1, 0, 1, 0, 0, 0 }, -- Lv2 Wind & Thunder
    [xi.skillchainType.GRAVITATION  ] = { 0, 0, 0, 1, 0, 0, 0, 1 }, -- Lv2 Earth & Dark
    [xi.skillchainType.LIGHT        ] = { 1, 0, 1, 0, 1, 0, 1, 0 }, -- Lv3 Fire, Wind, Thunder, Light
    [xi.skillchainType.DARKNESS     ] = { 0, 1, 0, 1, 0, 1, 0, 1 }, -- Lv3 Ice, Earth, Water, Dark
    [xi.skillchainType.LIGHT_II     ] = { 1, 0, 1, 0, 1, 0, 1, 0 }, -- Lv4 Fire, Wind, Thunder, Light
    [xi.skillchainType.DARKNESS_II  ] = { 0, 1, 0, 1, 0, 1, 0, 1 }, -- Lv4 Ice, Earth, Water, Dark
}

-- Table with pDIF caps per weapon/skill type.
xi.combat.physical.pDifWeaponCapTable =
{
    -- [Skill/weapon type used] = { pre-cRatio caps, pre-randomizer pDIF cap }, Values from: https://www.bg-wiki.com/ffxi/PDIF
    [xi.skill.NONE            ] = { 3,      3    }, -- We will use this for mobs.
    [xi.skill.HAND_TO_HAND    ] = { 3.875,  3.5  },
    [xi.skill.DAGGER          ] = { 3.625,  3.25 },
    [xi.skill.SWORD           ] = { 3.625,  3.25 },
    [xi.skill.GREAT_SWORD     ] = { 4.125,  3.75 },
    [xi.skill.AXE             ] = { 3.625,  3.25 },
    [xi.skill.GREAT_AXE       ] = { 4.125,  3.75 },
    [xi.skill.SCYTHE          ] = { 4.375,  4    },
    [xi.skill.POLEARM         ] = { 4.125,  3.75 },
    [xi.skill.KATANA          ] = { 3.625,  3.25 },
    [xi.skill.GREAT_KATANA    ] = { 3.875,  3.5  },
    [xi.skill.CLUB            ] = { 3.625,  3.25 },
    [xi.skill.STAFF           ] = { 4.125,  3.75 },
    [xi.skill.AUTOMATON_MELEE ] = { 3,      3    }, -- Unknown value. Copy of value below.
    [xi.skill.AUTOMATON_RANGED] = { 3,      3    }, -- Unknown value. Reference found in an old post: https://forum.square-enix.com/ffxi/archive/index.php/t-52778.html?s=d906df07788334a185a902b0a6ae6a99
    [xi.skill.AUTOMATON_MAGIC ] = { 3,      3    }, -- Unknown value. Here for completion sake.
    [xi.skill.ARCHERY         ] = { 3.2375, 3.25 },
    [xi.skill.MARKSMANSHIP    ] = { 3.475,  3.5  },
    [xi.skill.THROWING        ] = { 3.2375, 3.25 },
}

local shieldSizeToBlockRateTable =
{
    [1] =  55, -- Buckler
    [2] =  40, -- Round
    [3] =  45, -- Kite
    [4] =  30, -- Tower
    [5] =  50, -- Aegis and Srivatsa
    [6] = 100, -- Ochain  https://www.bg-wiki.com/ffxi/Category:Shields
}

-- WARNING: This function is used in src/map/attack.cpp "ProcessDamage" function.
-- If you update these parameters, update them there as well.
---@param actor CBaseEntity
---@param target CBaseEntity
---@param slot xi.slot
---@param physicalAttackType xi.physicalAttackType
---@param isH2H boolean
---@param isFirstSwing boolean
---@param isSneakAttack boolean
---@param isTrickAttack boolean
---@param damageRatio number
xi.combat.physical.calculateAttackDamage = function(actor, target, slot, physicalAttackType, isH2H, isFirstSwing, isSneakAttack, isTrickAttack, damageRatio)
    local bonusBasePhysicalDamage = 0
    local damage                  = 0

    -- Sneak Attack
    if isSneakAttack then
        bonusBasePhysicalDamage = math.floor(bonusBasePhysicalDamage + actor:getStat(xi.mod.DEX) * (1 + actor:getMod(xi.mod.SNEAK_ATK_DEX) / 100))
    end

    -- Trick Attack
    if isTrickAttack then
        bonusBasePhysicalDamage = math.floor(bonusBasePhysicalDamage + actor:getStat(xi.mod.AGI) * (1 + actor:getMod(xi.mod.TRICK_ATK_AGI) / 100))
    end

    -- Consume Mana
    bonusBasePhysicalDamage = bonusBasePhysicalDamage + xi.combat.damage.consumeManaAddition(actor)

    -- Apply damage ratio multiplier.
    local baseDamage = 0

    if isH2H then
        local naturalH2hDamage = math.floor(actor:getSkillLevel(xi.skill.HAND_TO_HAND) * 0.11) + 3

        if actor:isMob() then
            local mobH2HPenalty = 1.0
            local regionID      = actor:getCurrentRegion()
            local fSTR          = xi.combat.physical.calculateMeleeStatFactor(actor, target)

            if regionID <= xi.region.LIMBUS then
                mobH2HPenalty = 0.425 -- Vanilla - COP
            else
                mobH2HPenalty = 0.650
            end

            baseDamage = actor:getWeaponDmg() + bonusBasePhysicalDamage

            if physicalAttackType == xi.physicalAttackType.KICK then
                local kickPenalty = 2 / 3 -- Per Jimmy, kicks get a second penalty, then fSTR is added
                local kickDamage  = actor:getMod(xi.mod.KICK_DMG)

                -- Per Jimmy, kick damage penalty for mobs can only be damage * h2h penalty * kickpenalty + fstr
                -- The math doesn't work in any other way, which is strange given fSTR is before the penalty on non-kicks
                baseDamage = (baseDamage + kickDamage) * mobH2HPenalty * kickPenalty + fSTR
            else
                baseDamage = (baseDamage + fSTR) * mobH2HPenalty
            end
        elseif physicalAttackType == xi.physicalAttackType.KICK then
            baseDamage = naturalH2hDamage + actor:getMod(xi.mod.KICK_DMG) + bonusBasePhysicalDamage + xi.combat.physical.calculateMeleeStatFactor(actor, target)
        else
            baseDamage = naturalH2hDamage + actor:getWeaponDmg() + bonusBasePhysicalDamage + xi.combat.physical.calculateMeleeStatFactor(actor, target)
        end
    elseif slot == xi.slot.MAIN then
        baseDamage = actor:getWeaponDmg() + bonusBasePhysicalDamage + xi.combat.physical.calculateMeleeStatFactor(actor, target)
    elseif slot == xi.slot.SUB then
        baseDamage = actor:getOffhandDmg() + bonusBasePhysicalDamage + xi.combat.physical.calculateMeleeStatFactor(actor, target)
    elseif slot == xi.slot.AMMO then
        baseDamage = actor:getRangedDmg() + xi.combat.physical.calculateRangedStatFactor(actor, target)
    end

    damage = math.floor(baseDamage * damageRatio)

    -- Scarlet Delirium multiplier.
    damage = math.floor(damage * xi.combat.damage.scarletDeliriumMultiplier(actor))

    -- Double/Triple Attack multipliers.
    local multiAttackMultiplier = 1
    if physicalAttackType == xi.physicalAttackType.DOUBLE then
        multiAttackMultiplier = 1 + actor:getMod(xi.mod.DOUBLE_ATTACK_DMG) / 100
    elseif physicalAttackType == xi.physicalAttackType.TRIPLE then
        multiAttackMultiplier = 1 + actor:getMod(xi.mod.TRIPLE_ATTACK_DMG) / 100
    end

    damage = math.floor(damage * multiAttackMultiplier)

    -- Soul Eater additive damage.
    damage = damage + xi.combat.damage.souleaterAddition(actor)

    -- Damage multipliers
    damage = actor:addDamageFromMultipliers(damage, physicalAttackType, slot, isFirstSwing)

    -- Sneak Attack Augment
    if
        actor:getMod(xi.mod.AUGMENTS_SA) > 0 and
        isSneakAttack and
        actor:hasStatusEffect(xi.effect.SNEAK_ATTACK)
    then
        damage = math.floor(damage * (1 + actor:getMod(xi.mod.AUGMENTS_SA) / 100))
    end

    -- Trick Attack Augment
    if
        actor:getMod(xi.mod.AUGMENTS_TA) > 0 and
        isTrickAttack and
        actor:hasStatusEffect(xi.effect.TRICK_ATTACK)
    then
        damage = math.floor(damage * (1 + actor:getMod(xi.mod.AUGMENTS_TA) / 100))
    end

    --- Low level mobs can get negative fSTR so low they crater their (base weapon damage + fstr) to below 0.
    --- Absorption isn't possible at this point in the calculation, so zero it.
    if damage < 0 then
        damage = 0
    end

    -- Apply Restraint Weaponskill Damage
    if
        isFirstSwing and
        actor:hasStatusEffect(xi.effect.RESTRAINT)
    then
        local effect = actor:getStatusEffect(xi.effect.RESTRAINT)
        local power  = effect and effect:getPower() or 30

        if
            effect and
            power < 30
        then
            local jpBonus = actor:getJobPointLevel(xi.jp.RESTRAINT) * 2

            -- Convert weapon delay and divide
            -- Pull remainder of previous hit's value from Effect Sub Power
            local boostPerRound = (3 * actor:getBaseDelay() / 50) / 385
            local remainder     = effect:getSubPower() / 100

            -- Calculate bonuses from Enhances Restraint, Job Point upgrades, and remainder from previous hit
            boostPerRound = remainder + boostPerRound * (1 + actor:getMod(xi.Mod.ENHANCES_RESTRAINT) / 100) * (1 + jpBonus / 100)

            -- Calculate new remainder and multiply by 100 so significant digits aren't lost
            remainder     = math.floor((1 - (math.ceil(boostPerRound) - boostPerRound)) * 100)
            boostPerRound = math.floor(boostPerRound)

            -- Cap total power to +30% WSD
            if power + boostPerRound > 30 then
                boostPerRound = 30 - power
            end

            effect:setPower(power + boostPerRound)
            effect:setSubPower(remainder)
            actor:setMod(xi.mod.ALL_WSDMG_FIRST_HIT, boostPerRound)
        end
    end

    -- TODO: add charutils::TrySkillUP call
    return damage
end

-- 'fSTR' in English Wikis. 'SV function' in JP wiki and Studio Gobli.
-- BG wiki: https://www.bg-wiki.com/ffxi/FSTR
-- Gobli Wiki: https://w-atwiki-jp.translate.goog/studiogobli/pages/14.html?_x_tr_sl=auto&_x_tr_tl=en&_x_tr_hl=en&_x_tr_pto=wapp
-- Mob calculation: https://docs.google.com/spreadsheets/d/1YBoveP-weMdidrirY-vPDzHyxbEI2ryECINlfCnFkLI/edit?gid=224123492#gid=224123492&range=C50
xi.combat.physical.calculateMeleeStatFactor = function(actor, target)
    local fSTR = 0 -- The variable we want to calculate.

    -- Early return: Mobs at or under lvl 1.
    if actor:isMob() and actor:getMainLvl() <= 1 then
        return 1
    end

    -- Calculate statDiff.
    local statDiff = actor:getStat(xi.mod.STR) - target:getStat(xi.mod.VIT)

    -- Pets and Mobs.
    if actor:isMob() or actor:isPet() then
        fSTR = math.floor((statDiff + 4) / 4)
        fSTR = utils.clamp(fSTR, -20, 24)

        return fSTR
    end

    -- Players and Trusts
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

    -- Early return: Mobs at or under lvl 1.
    if actor:isMob() and actor:getMainLvl() <= 1 then
        return 1
    end

    -- Calculate statDiff.
    local statDiff = actor:getStat(xi.mod.STR) - target:getStat(xi.mod.VIT)

    -- Pets and Mobs.
    if actor:isMob() or actor:isPet() then
        fSTR = math.floor((statDiff + 4) / 2)
        fSTR = utils.clamp(fSTR, -20, 24)

        return fSTR
    end

    -- Players and Trusts
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

    -- Sanitize parameters.
    local strMultiplier = wsSTRmod or 0
    local dexMultiplier = wsDEXmod or 0
    local vitMultiplier = wsVITmod or 0
    local agiMultiplier = wsAGImod or 0
    local intMultiplier = wsINTmod or 0
    local mndMultiplier = wsMNDmod or 0
    local chrMultiplier = wsCHRmod or 0

    -- wscSTAT = actor stat * (WS stat modifier + Actor-specific WS stat modifier)
    local wscSTR = math.floor(actor:getStat(xi.mod.STR) * (strMultiplier + actor:getMod(xi.mod.WS_STR_BONUS) / 100))
    local wscDEX = math.floor(actor:getStat(xi.mod.DEX) * (dexMultiplier + actor:getMod(xi.mod.WS_DEX_BONUS) / 100))
    local wscVIT = math.floor(actor:getStat(xi.mod.VIT) * (vitMultiplier + actor:getMod(xi.mod.WS_VIT_BONUS) / 100))
    local wscAGI = math.floor(actor:getStat(xi.mod.AGI) * (agiMultiplier + actor:getMod(xi.mod.WS_AGI_BONUS) / 100))
    local wscINT = math.floor(actor:getStat(xi.mod.INT) * (intMultiplier + actor:getMod(xi.mod.WS_INT_BONUS) / 100))
    local wscMND = math.floor(actor:getStat(xi.mod.MND) * (mndMultiplier + actor:getMod(xi.mod.WS_MND_BONUS) / 100))
    local wscCHR = math.floor(actor:getStat(xi.mod.CHR) * (chrMultiplier + actor:getMod(xi.mod.WS_CHR_BONUS) / 100))

    finalWSC = wscSTR + wscDEX + wscVIT + wscAGI + wscINT + wscMND + wscCHR

    return finalWSC
end

-- TP factor equation. Used to determine TP modifer across all cases of 'X varies with TP'
xi.combat.physical.calculateTPfactor = function(actorTP, tpModifierTable)
    if not tpModifierTable then
        return 0
    end

    local tpFactor = tpModifierTable[1] -- Assume this will be used for monstrosity fixed TP moved someday.

    if actorTP >= 2000 then
        tpFactor = tpModifierTable[2] + (actorTP - 2000) * (tpModifierTable[3] - tpModifierTable[2]) / 1000
    elseif actorTP >= 1000 then
        tpFactor = tpModifierTable[1] + (actorTP - 1000) * (tpModifierTable[2] - tpModifierTable[1]) / 1000
    end

    return tpFactor
end

-- TP Multiplier calculations.
xi.combat.physical.calculateFTPBonus = function(actor)
    local fTPBonus = 0

    -- Early return: Gear bonuses only come from gear.
    if actor:getObjType() ~= xi.objType.PC then
        return fTPBonus
    end

    -- Early return: Gear bonuses only apply to weaponskills with elemental properties.
    local scProp1, scProp2, scProp3 = actor:getWSSkillchainProp()
    if
        scProp1 == xi.skillchainType.NONE and
        scProp2 == xi.skillchainType.NONE and
        scProp3 == xi.skillchainType.NONE
    then
        return fTPBonus
    end

    -- fTP bonuses from gear.
    local dayElement = VanadielDayElement()

    for elementChecked = xi.element.FIRE, xi.element.DARK do
        if
            wsElementalProperties[scProp1][elementChecked] == 1 or
            wsElementalProperties[scProp2][elementChecked] == 1 or
            wsElementalProperties[scProp3][elementChecked] == 1
        then
            fTPBonus = fTPBonus + actor:getMod(xi.data.element.getElementalFTPModifier(elementChecked)) / 256

            if dayElement == elementChecked then
                fTPBonus = fTPBonus + actor:getMod(xi.mod.DAY_FTP_BONUS) / 256
            end
        end
    end

    fTPBonus = fTPBonus + actor:getMod(xi.mod.ANY_FTP_BONUS) / 256

    return fTPBonus
end

---@param wRatio number
---@param pDifFinalCap number
xi.combat.physical.wRatioCapPC = function(wRatio, pDifFinalCap)
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
        pDifUpperCap = math.min(wRatio + 0.375, pDifFinalCap)
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

    return pDifLowerCap, pDifUpperCap
end

-- wRatio cap for non-PCs
---@param wRatio number
---@param pDifFinalCap number
xi.combat.physical.wRatioCapOthers = function(wRatio, pDifFinalCap)
    local pDifUpperCap = 0
    local pDifLowerCap = 0

    -- see https://www.ffxiah.com/forum/topic/58479/monster-pdif-curves-and-other-info/
    -- pDIF upper cap.
    if wRatio < 0.55 then
        pDifUpperCap = 0.6 + 760 / 1024 * wRatio
    elseif wRatio <= 0.8 then
        pDifUpperCap = 1
    elseif wRatio < 1.2 then
        pDifUpperCap = 1 + 1127 / 1024 * (wRatio - 0.8)
    elseif wRatio < 1.5 then
        pDifUpperCap = 1474 / 1024 + 1105 / 1024 * (wRatio - 1235 / 1024)
    else
        pDifUpperCap = math.min(1803 / 1024 + 1070 / 1024 * (wRatio - 1.5), pDifFinalCap)
    end

    -- pDIF lower cap.
    if wRatio <= 0.4 then
        pDifLowerCap = 0.25
    elseif wRatio < 1.35 then
        pDifLowerCap = 0.25 + (827 / 1024) * (wRatio - 0.4)
    elseif wRatio <= 1.60 then
        pDifLowerCap = 1
    else
        pDifLowerCap = 1 + (1120 / 1024) * (wRatio - 1.59)
    end

    return pDifLowerCap, pDifUpperCap
end

-- WARNING: This function is used in src/utils/battleutils.cpp "GetDamageRatio" function.
-- If you update this parameters, update them there aswell.
---@param actor CBaseEntity
---@param target CBaseEntity
---@param weaponType xi.skill
---@param wsAttackMod number
---@param isCritical boolean
---@param applyLevelCorrection boolean
---@param tpIgnoresDefense boolean
---@param tpFactor number
---@param isWeaponskill boolean
---@param weaponSlot xi.slot
---@param isCannonball boolean
xi.combat.physical.calculateMeleePDIF = function(actor, target, weaponType, wsAttackMod, isCritical, applyLevelCorrection, tpIgnoresDefense, tpFactor, isWeaponskill, weaponSlot, isCannonball)
    local pDif = 0

    ----------------------------------------
    -- Step 1: Attack / Defense Ratio
    ----------------------------------------
    local baseRatio     = 0
    local actorAttack   = 0
    local targetDefense = math.max(1, target:getStat(xi.mod.DEF))
    local flourishBonus = 1
    local firstCap      = xi.combat.physical.pDifWeaponCapTable[weaponType][1]
    -- Actor Weaponskill Specific Attack modifiers.
    if isWeaponskill then
        local flourishEffect = actor:getStatusEffect(xi.effect.BUILDING_FLOURISH)

        if flourishEffect and flourishEffect:getPower() >= 2 then -- 2 or more Finishing Moves used.
            local meritCount = flourishEffect:getSubPower()

            flourishBonus = 1.25 + 0.01 * meritCount -- +1% attack bonus per merit -- TODO: do the merits apply even when FMs are < 2?
        end
    end

    -- TODO: it is unknown if ws attack mod and flourish bonus are additive or multiplicative
    actorAttack = math.max(1, math.floor(actor:getStat(xi.mod.ATT, weaponSlot) * wsAttackMod * flourishBonus))

    -- Target Defense Modifiers.
    if tpIgnoresDefense then
        local ignoreDefenseFactor = 1 - tpFactor

        targetDefense = math.max(1, math.floor(targetDefense * ignoreDefenseFactor))
    end

    if isCannonball then
        actorAttack = actor:getStat(xi.mod.DEF)
    end

    -- Actor Attack / Target Defense ratio
    if targetDefense ~= 0 then
        baseRatio = actorAttack / targetDefense
    end

    -- Apply cap to baseRatio.
    baseRatio = utils.clamp(baseRatio, 0, firstCap)

    ----------------------------------------
    -- Step 2: cRatio (Level correction, corrected ratio) Zone based!
    ----------------------------------------
    local levelDifFactor = 0

    if applyLevelCorrection then
        levelDifFactor = (actor:getMainLvl() - target:getMainLvl()) * 3 / 64 -- 3/64 from JP model which fits better
    end

    -- Only players suffer from negative level difference.
    if
        not actor:isPC() and
        levelDifFactor < 0
    then
        levelDifFactor = 0
    end

    -- Players do not get positive level correction, only monsters
    if
        actor:isPC() and
        levelDifFactor > 0
    then
        levelDifFactor = 0
    end

    ----------------------------------------
    -- Step 3: wRatio and pDif Caps (Melee)
    ----------------------------------------
    local wRatio             = baseRatio + (isCritical and 1 or 0)
    local pDifUpperCap       = 0
    local pDifLowerCap       = 0
    local damageLimitPlus    = actor:getMod(xi.mod.DAMAGE_LIMIT) / 100
    local damageLimitPercent = 1 + actor:getMod(xi.mod.DAMAGE_LIMITP) / 100
    local pDifFinalCap       = (xi.combat.physical.pDifWeaponCapTable[weaponType][2] + damageLimitPlus) * damageLimitPercent + (isCritical and 1 or 0)

    if actor:isPC() then
        -- https://www.bg-wiki.com/ffxi/PDIF#Average_Melee_pDIF(qRatio)
        -- This is also known as "pDIF spike"
        if wRatio > 0.5 and wRatio < 1.5 then -- 0.5 and 1.5 are 0% chance
            local sRatio = (0.5 - math.abs(wRatio - 1)) * 1.2

            sRatio = utils.clamp(sRatio, 0, 1 / 3) -- 1/3 (one-third), not 0.33

            if math.random(1, 10000) / 10000 <= sRatio then
                return 1.0
            end
        end

        pDifLowerCap, pDifUpperCap = xi.combat.physical.wRatioCapPC(wRatio, pDifFinalCap)
    else -- Mobs and pets, unconfirmed if pets use this same formula
        -- https://www.ffxiah.com/forum/topic/58479/monster-pdif-curves-and-other-info/#3751498
        -- This is also known as "pDIF spike"
        local sRatio = 0

        if wRatio > 0.0 and wRatio < 0.75 then
            sRatio = -5 / 9 + (10 / 9) * wRatio
        elseif wRatio <= 1.3 then
            sRatio = 0.3
        else
            sRatio = 5 / 3 - (270 / 256) * wRatio
        end

        sRatio = utils.clamp(sRatio, 0, 0.3)

        if math.random(1, 10000) / 10000 <= sRatio then
            return 1.0
        end

        pDifLowerCap, pDifUpperCap = xi.combat.physical.wRatioCapOthers(wRatio, pDifFinalCap)
    end

    -- Apply level correction to UL/LL
    -- https://www.ffxiah.com/forum/topic/57989/post-2016-level-correction-testing/
    pDifLowerCap = pDifLowerCap + levelDifFactor
    pDifUpperCap = pDifUpperCap + levelDifFactor

    pDif = math.random(pDifLowerCap * 1000, pDifUpperCap * 1000) / 1000

    ----------------------------------------
    -- Step 4: Apply weapon type caps.
    ----------------------------------------
    pDif = utils.clamp(pDif, 0, pDifFinalCap)

    ----------------------------------------
    -- Step 5: Melee random factor.
    ----------------------------------------
    local meleeRandom = 1 + math.random(0, 5) * 0.01 -- 5 distinct values

    pDif = pDif * meleeRandom

    -- Crit damage bonus is a final modifier
    if isCritical then
        local critDamageBonus = utils.clamp(actor:getMod(xi.mod.CRIT_DMG_INCREASE) - target:getMod(xi.mod.CRIT_DEF_BONUS), 0, 100)
        pDif                  = pDif * (100 + critDamageBonus) / 100
    end

    return pDif
end

---@param actor CBaseEntity
---@param target CBaseEntity
---@param weaponType xi.skill
---@param wsAttackMod number
---@param isCritical boolean
---@param applyLevelCorrection boolean
---@param tpIgnoresDefense boolean
---@param tpFactor number
---@param isWeaponskill boolean
---@param bonusRangedAttack integer
xi.combat.physical.calculateRangedPDIF = function(actor, target, weaponType, wsAttackMod, isCritical, applyLevelCorrection, tpIgnoresDefense, tpFactor, isWeaponskill, bonusRangedAttack)
    local pDif = 0

    ----------------------------------------
    -- Step 1: Attack / Defense Ratio
    ----------------------------------------
    local baseRatio       = 0
    local actorAttack     = 0
    local targetDefense   = math.max(1, target:getStat(xi.mod.DEF))
    local flourishBonus   = 1
    local firstCap        = xi.combat.physical.pDifWeaponCapTable[weaponType][1]
    local distancePenalty = 0

    if not actor:isMob() then
        distancePenalty = xi.combat.ranged.attackDistancePenalty(actor, target)
    end

    -- Actor Weaponskill Specific Attack modifiers.
    -- TODO: verify this actually works on ranged WS
    if isWeaponskill then
        local flourishEffect = actor:getStatusEffect(xi.effect.BUILDING_FLOURISH)

        if flourishEffect and flourishEffect:getPower() >= 2 then -- 2 or more Finishing Moves used.
            local meritCount = flourishEffect:getSubPower()

            flourishBonus = 1.25 + 0.01 * meritCount -- +1% attack bonus per merit -- TODO: do the merits apply even when FMs are < 2?
        end
    end

    -- TODO: it is unknown if ws attack mod and flourish bonus are additive or multiplicative
    actorAttack = math.max(1, math.floor((actor:getStat(xi.mod.RATT) + bonusRangedAttack - distancePenalty) * wsAttackMod * flourishBonus))

    -- Target Defense Modifiers.
    local ignoreDefenseFactor = 1

    if tpIgnoresDefense then
        ignoreDefenseFactor = 1 - tpFactor
    end

    targetDefense = math.floor(targetDefense * ignoreDefenseFactor)

    if targetDefense ~= 0 then
        baseRatio = actorAttack / targetDefense
    end

    -- Apply cap to baseRatio.
    baseRatio = utils.clamp(baseRatio, 0, firstCap)

    ----------------------------------------
    -- Step 2: cRatio (Level correction, corrected ratio) Zone based!
    ----------------------------------------
    local levelDifFactor = 0

    if applyLevelCorrection then
        levelDifFactor = (actor:getMainLvl() - target:getMainLvl()) * 0.025
    end

    -- Only players suffer from negative level difference.
    if
        not actor:isPC() and
        levelDifFactor < 0
    then
        levelDifFactor = 0
    end

    -- Players do not get positive level correction, only monsters
    if
        actor:isPC() and
        levelDifFactor > 0
    then
        levelDifFactor = 0
    end

    local cRatio = utils.clamp(baseRatio + levelDifFactor, 0, 10) -- Clamp for the lower limit, mainly.

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
    local damageLimitPlus    = actor:getMod(xi.mod.DAMAGE_LIMIT) / 100
    local damageLimitPercent = 1 + actor:getMod(xi.mod.DAMAGE_LIMITP) / 100
    local pDifFinalCap       = (xi.combat.physical.pDifWeaponCapTable[weaponType][2] + damageLimitPlus) * damageLimitPercent -- Added damage limit bonuses

    pDif = utils.clamp(pDif, 0, pDifFinalCap)

    ----------------------------------------
    -- Step 5: Ranged critical factor. Bypasses caps.
    ----------------------------------------
    if isCritical then
        pDif = pDif * 1.25
    end

    -- Step 6: Distance correction and True Shot.
    -- TODO: Implement distance correction and True shot...

    -- Crit damage bonus is a final modifier
    if isCritical then
        local critDamageBonus = utils.clamp(actor:getMod(xi.mod.CRIT_DMG_INCREASE) + actor:getMod(xi.mod.RANGED_CRIT_DMG_INCREASE) - target:getMod(xi.mod.CRIT_DEF_BONUS), 0, 100)
        pDif = pDif * (100 + critDamageBonus) / 100
    end

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
    -- TODO: do any Trusts or mobs ever get Fencer bonuses?

    if actor:getObjType() == xi.objType.PC then
        local mainEquip = actor:getStorageItem(0, 0, xi.slot.MAIN)
        local subEquip  = actor:getStorageItem(0, 0, xi.slot.SUB)
        if
            mainEquip and
            not mainEquip:isTwoHanded() and                                                      -- No 2 handed weapons.
            not mainEquip:isHandToHand() and                                                     -- No 2 handed weapons.
            (subEquip == nil or subEquip:getSkillType() == xi.skill.NONE or subEquip:isShield()) -- Only shields allowed in sub.
        then
            fencerBonus = actor:getMod(xi.mod.FENCER_CRITHITRATE) / 100
        end
    end

    return fencerBonus
end

-- Critical rate from Building Flourish.
-- TODO: Study case where if we can attach modifiers to the effect itself, both this and the effect may need refactoring.
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
xi.combat.physical.calculateSwingCriticalRate = function(actor, target, actorTP, optCritModTable)
    -- See reference at https://www.bg-wiki.com/ffxi/Critical_Hit_Rate
    local finalCriticalRate     = 0
    local baseCriticalRate      = 0.05
    local statBonus             = xi.combat.physical.criticalRateFromStatDiff(actor, target)
    local inninBonus            = xi.combat.physical.criticalRateFromInnin(actor, target)
    local fencerBonus           = xi.combat.physical.criticalRateFromFencer(actor)
    local buildingFlourishBonus = xi.combat.physical.criticalRateFromFlourish(actor)
    local modifierBonus         = actor:getMod(xi.mod.CRITHITRATE) / 100
    local meritBonus            = actor:getMerit(xi.merit.CRIT_HIT_RATE) / 100
    local targetCriticalEvasion = target:getMod(xi.mod.CRITICAL_HIT_EVASION) / 100
    local targetMeritPenalty    = target:getMerit(xi.merit.ENEMY_CRIT_RATE) / 100
    local tpFactor              = 0

    -- For weaponskills.
    if optCritModTable then
        tpFactor = xi.combat.physical.calculateTPfactor(actorTP, optCritModTable)
    end

    -- Add all different bonuses and clamp.
    finalCriticalRate = baseCriticalRate + statBonus + inninBonus + fencerBonus + buildingFlourishBonus + modifierBonus + meritBonus - targetCriticalEvasion - targetMeritPenalty + tpFactor

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

xi.combat.physical.canParry = function(defender, attacker)
    local canParry = false

    if
        defender:isFacing(attacker) and
        defender:isEngaged()
    then
        if defender:isPC() and defender:getSkillRank(xi.skill.PARRY) > 0 then
            local mainWeapon = defender:getEquippedItem(xi.slot.MAIN)
            if mainWeapon then
                canParry = mainWeapon:getSkillType() ~= xi.skill.HAND_TO_HAND
            end
        elseif
            defender:isMob() or
            defender:isPet() or
            defender:isTrust()
        then
            canParry = defender:getMobMod(xi.mobMod.CAN_PARRY) > 0
        end
    end

    return canParry
end

xi.combat.physical.calculateParryRate = function(defender, attacker)
    local parryRate = 0

    -- http://wiki.ffxiclopedia.org/wiki/Talk:Parrying_Skill
    -- {(Parry Skill x .125) + ([Player Agi - Enemy Dex] x .125)} x Diff

    local parrySkill = defender:getSkillLevel(xi.skill.PARRY) + defender:getMod(xi.mod.PARRY)

    if defender:isPC() then
        parrySkill = parrySkill + defender:getILvlParry()
    end

    local levelDiffMult = 1 + (defender:getMainLvl() - attacker:getMainLvl()) / 15

    -- two handed weapons get a bonus
    if defender:isPC() and defender:isWeaponTwoHanded() then
        levelDiffMult = levelDiffMult + 0.1
    end

    levelDiffMult = utils.clamp(levelDiffMult, 0.4, 1.4)

    local attackerDex = attacker:getStat(xi.mod.DEX)
    local defenderAgi = defender:getStat(xi.mod.AGI)

    parryRate = utils.clamp(((parrySkill * 0.1 + (defenderAgi - attackerDex) * 0.125 + 10.0) * levelDiffMult), 5, 25)

    -- Issekigan grants parry rate bonus
    -- from best available data if you already capped out at 25% parry it grants another 25% bonus for ~50% parry rate
    if defender:hasStatusEffect(xi.effect.ISSEKIGAN) then
        parryRate = parryRate + defender:getStatusEffect(xi.effect.ISSEKIGAN):getPower()
    end

    -- Inquartata grants a flat parry rate bonus
    parryRate = parryRate + defender:getMod(xi.mod.INQUARTATA)

    return parryRate
end

xi.combat.physical.canGuard = function(defender, attacker)
    local canGuard = false

    -- per testing done by Genome guard can proc when petrified, stunned, or asleep
    -- https://genomeffxi.livejournal.com/18269.html
    if
        defender:isFacing(attacker) and
        defender:isEngaged()
    then
        if defender:isPC() and defender:getSkillRank(xi.skill.GUARD) > 0 then
            local mainWeapon = defender:getEquippedItem(xi.slot.MAIN)
            canGuard = (not mainWeapon) or mainWeapon:getSkillType() == xi.skill.HAND_TO_HAND
        elseif
            defender:isMob() or
            defender:isPet() or
            defender:isTrust()
        then
            canGuard = (defender:getMainJob() == xi.job.MNK or defender:getMainJob() == xi.job.PUP) and defender:getMobMod(xi.mobMod.CANNOT_GUARD) == 0
        end
    end

    return canGuard
end

xi.combat.physical.calculateGuardRate = function(defender, attacker)
    local guardRate = 0

    -- default to using actual skill
    local guardSkill = defender:getSkillLevel(xi.skill.GUARD)

    -- non-players do not have guard skill set on creation
    -- so use max skill at the level for the job
    if defender:isPet() then
        guardSkill = defender:getMaxSkillLevel(defender:getMainLvl(), defender:getMainJob(), xi.skill.GUARD)
    elseif defender:isTrust() then
        -- TODO: check trust type for ilvl > 99 when implemented
        guardSkill = defender:getMaxSkillLevel(math.min(defender:getMainLvl(), 99), defender:getMainJob(), xi.skill.GUARD)
    end

    guardSkill = guardSkill + defender:getMod(xi.mod.GUARD) + guardSkill * (defender:getMod(xi.mod.GUARD_PERCENT) / 100)

    -- current assumption (from core) is that guard and parry Ilvl are the same
    if defender:isPC() then
        guardSkill = guardSkill + defender:getILvlParry()
    end

    local levelDiffMult = 1 + (defender:getMainLvl() - attacker:getMainLvl()) / 15
    levelDiffMult = utils.clamp(levelDiffMult, 0.4, 1.4)

    local attackerDex = attacker:getStat(xi.mod.DEX)
    local defenderAgi = defender:getStat(xi.mod.AGI)

    -- Dodge's guard bonus goes over the cap
    guardRate = utils.clamp(((guardSkill * 0.1 + (defenderAgi - attackerDex) * 0.125 + 10) * levelDiffMult), 5, 25) + defender:getMod(xi.mod.ADDITIVE_GUARD)

    return guardRate
end

xi.combat.physical.canBlock = function(defender, attacker)
    local canBlock = false

    if defender:isFacing(attacker) and not defender:hasPreventActionEffect() then
        if defender:isPC() and defender:getSkillRank(xi.skill.SHIELD) > 0 then
            local shield = defender:getEquippedItem(xi.slot.SUB)
            if shield then
                canBlock = shield:isShield()
            end
        elseif
            defender:isMob() or
            defender:isPet() or
            defender:isTrust()
        then
            canBlock = defender:getMobMod(xi.mobMod.CAN_SHIELD_BLOCK) > 0
        end
    end

    return canBlock
end

xi.combat.physical.calculateBlockRate = function(defender, attacker)
    local blockRate = 0
    local shieldSize = 3
    local skillModifier = 0
    local palisadeMod = defender:getMod(xi.mod.PALISADE_BLOCK_BONUS)
    local reprisalMult = 1.0

    -- assume bare hands case
    local attackerSkillType = xi.skill.HAND_TO_HAND
    if not attacker:isUsingH2H() then
        attackerSkillType = attacker:getWeaponSkillType(xi.slot.MAIN)
    end

    local attackSkill = attacker:getSkillLevel(attackerSkillType)
    local blockSkill = defender:getSkillLevel(xi.skill.SHIELD)

    if defender:isPC() then
        local shield = defender:getEquippedItem(xi.slot.SUB)
        -- already checked in canBlock but check again here to make sure
        if shield and shield:isShield() then
            shieldSize = shield:getShieldSize()
        else
            return 0
        end
    elseif
        defender:isMob() or
        defender:isPet() or
        defender:isTrust()
    then
        -- already checked in canBlock but check again here to make sure
        if defender:getMobMod(xi.mobMod.CAN_SHIELD_BLOCK) > 0 then
            blockRate = defender:getMod(xi.mod.SHIELDBLOCKRATE)
            -- automations are a special case
            if defender:isAutomaton() then
                skillModifier = (defender:getSkillLevel(xi.skill.AUTOMATON_MELEE) - attackSkill) * 0.215
                return math.max(0, blockRate + skillModifier)
            -- mobs and trusts use max skill for job and level
            elseif defender:isTrust() then
                -- TODO: check trust type for ilvl > 99 when implemented
                blockSkill = defender:getMaxSkillLevel(math.min(defender:getMainLvl(), 99), defender:getMainJob(), xi.skill.SHIELD)
            else
                blockSkill = defender:getMaxSkillLevel(defender:getMainLvl(), defender:getMainJob(), xi.skill.SHIELD)
            end
        else -- No block mobmod so zero rate
            return 0
        end
    end

    if defender:isPC() then
        -- get blockrate from table and use default value of 0
        blockRate = shieldSizeToBlockRateTable[shieldSize] or 0
    end

    -- Check for Reprisal and adjust skill and block rate bonus multiplier
    if defender:hasStatusEffect(xi.effect.REPRISAL) then
        blockSkill   = blockSkill * 1.15
        reprisalMult = 1.5

        -- Adamas and Priwen set the multiplier to 3.0x while equipped
        if defender:getMod(xi.mod.REPRISAL_BLOCK_BONUS) > 0 then
            reprisalMult = 3.0
        end
    end

    skillModifier = (blockSkill - attackSkill) * 0.2325

    -- Add skill and Palisade bonuses and multiply by Reprisals bonus
    blockRate = (blockRate + skillModifier + palisadeMod) * reprisalMult

    -- Apply the lower and upper caps
    blockRate = utils.clamp(blockRate, 5, 100)

    return blockRate
end

xi.combat.physical.getDamageReductionForBlock = function(defender, attacker, damage)
    -- save original damage for comparison
    local originalDamage = damage

    -- do not reduce if damage is negative
    if damage > 0 then
        -- shield def bonus is a flat raw damage reduction that occurs before absorb
        damage = math.max(0, damage - defender:getMod(xi.mod.SHIELD_DEF_BONUS))

        if defender:isPC() then
            local shield = defender:getEquippedItem(xi.slot.SUB)
            local absorb = utils.clamp(100 - shield:getShieldAbsorptionRate(), 0, 100)
            damage = math.floor(damage * (absorb / 100))
        else
            damage = math.floor(damage * 0.5)
        end
    end

    -- return the difference between original and new damage
    -- in other words the damage reduction (as a flat value)
    return originalDamage - damage
end

xi.combat.physical.isBlocked = function(defender, attacker)
    local blocked = false
    if
        xi.combat.physical.canBlock(defender, attacker) and
        xi.combat.physical.calculateBlockRate(defender, attacker) > math.random(1, 100)
    then
        defender:trySkillUp(xi.skill.SHIELD, attacker:getMainLvl())
        blocked = true
    end

    return blocked
end

xi.combat.physical.isParried = function(defender, attacker)
    local parried = false

    if xi.combat.physical.canParry(defender, attacker) then
        local isPC = defender:isPC()

        if xi.combat.physical.calculateParryRate(defender, attacker) > math.random(1, 100) then
            parried = true

            -- https://www.bg-wiki.com/ffxi/Turms_Mittens
            if
                defender:getMod(xi.mod.PARRY_HP_RECOVERY) > 0 and
                not defender:hasStatusEffect(xi.effect.CURSE_II)
            then
                local recoveryValue = defender:getMod(xi.mod.PARRY_HP_RECOVERY)
                defender:addHP(recoveryValue)
            end

            if isPC then
                -- handle tactical parry
                if defender:hasTrait(xi.trait.TACTICAL_PARRY) then
                    defender:addTP(defender:getMod(xi.mod.TACTICAL_PARRY))
                end
            end
        end

        -- Handle skill ups.
        if
            isPC and
            (parried or                                  -- We parried
            not xi.settings.map.PARRY_OLD_SKILLUP_STYLE) -- Old style skillup is not enabled
        then
                defender:trySkillUp(xi.skill.PARRY, attacker:getMainLvl())
        end
    end

    return parried
end

xi.combat.physical.isGuarded = function(defender, attacker)
    local guarded = false
    if
        xi.combat.physical.canGuard(defender, attacker) and
        xi.combat.physical.calculateGuardRate(defender, attacker) > math.random(1, 100)
    then
        guarded = true
        if defender:isPC() then
            defender:trySkillUp(xi.skill.GUARD, attacker:getMainLvl())
            -- handle tactical guard
            if defender:hasTrait(xi.trait.TACTICAL_GUARD) then
                defender:addTP(defender:getMod(xi.mod.TACTICAL_GUARD))
            end
        end
    end

    return guarded
end
