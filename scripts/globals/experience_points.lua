-----------------------------------
-- Experience Points Data & Calculations
-- https://wiki.ffo.jp/html/32.html
-----------------------------------
xi = xi or {}
xi.experiencePoints = xi.experiencePoints or {}

-----------------------------------
-- Per monster experience points caps based on the players level.
-----------------------------------
xi.experiencePoints.perMonsterCaps =
{
    { maxLevel = 50,  cap = 400 },
    { maxLevel = 60,  cap = 500 },
    { maxLevel = 255, cap = 600 },
}

local function getPerMonsterCap(level)
    for _, entry in ipairs(xi.experiencePoints.perMonsterCaps) do
        if level <= entry.maxLevel then
            return entry.cap
        end
    end

    return xi.experiencePoints.perMonsterCaps[#xi.experiencePoints.perMonsterCaps].cap
end

-----------------------------------
-- Experience Points Chains
-----------------------------------
xi.experiencePoints.chainWindows =
{
    { maxLevel =   9, start =  50, windows = {  50,  40,  30,  20, 10 } },
    { maxLevel =  19, start = 100, windows = { 100,  80,  60,  40, 20 } },
    { maxLevel =  29, start = 150, windows = { 150, 120,  90,  60, 30 } },
    { maxLevel =  39, start = 200, windows = { 200, 160, 120,  80, 40 } },
    { maxLevel =  49, start = 250, windows = { 250, 200, 150, 100, 50 } },
    { maxLevel =  59, start = 300, windows = { 300, 240, 180, 120, 60 } },
    { maxLevel = 255, start = 350, windows = { 350, 280, 210, 140, 70 } },
}

xi.experiencePoints.chainMultipliers =
{
    1.0,  -- Chain 0
    1.2,  -- Chain 1
    1.25, -- Chain 2
    1.3,  -- Chain 3
    1.4,  -- Chain 4
    1.5   -- Chain 5+
}

local function getExperienceChainBracket(level)
    for _, bracket in ipairs(xi.experiencePoints.chainWindows) do
        if level <= bracket.maxLevel then
            return bracket
        end
    end

    return xi.experiencePoints.chainWindows[#xi.experiencePoints.chainWindows]
end

-----------------------------------
-- Experience share calculation based on party size and Signet status.
-----------------------------------
xi.experiencePoints.getExperienceShare = function(partySize, hasSignet)
    if partySize > 6 then
        return 1.8 / partySize
    end

    -- Share of experience each party member earns, with and without Signet active. Based off of party members within 100 yalms.
    local partyShare           = { 1.00, 0.60, 0.45, 0.40, 0.37, 0.35 }
    local partyShareWithSignet = { 1.00, 0.75, 0.55, 0.45, 0.39, 0.35 }

    local shareTable = hasSignet and partyShareWithSignet or partyShare

    return shareTable[math.max(partySize, 1)]
end

-----------------------------------
-- Signet
-----------------------------------
local function isSignetActive(member, regionId)
    return member:hasStatusEffect(xi.effect.SIGNET) and
        regionId >= xi.region.RONFAURE and
        regionId <= xi.region.JEUNO
end

-----------------------------------
-- Sanction
-----------------------------------
-- TODO: Will eventually have calculations for experience points bonuses based off Imperial Defense rating.
-- TODO: Sanction bonus magnitude is not documented on JP Wiki (https://wiki.ffo.jp/html/706.html); verify with captures. Set to 10% for now.
xi.experiencePoints.getSanctionBonus = function(member, regionId)
    if
        member:hasStatusEffect(xi.effect.SANCTION) and
        regionId >= xi.region.WEST_AHT_URHGAN and
        regionId <= xi.region.ALZADAAL and
        xi.besieged.getAstralCandescence() == 1
    then
        return 10
    end

    return 0
end

-----------------------------------
-- Dedication
-----------------------------------
local function handleDedicationBonus(member, exp, regionId)
    local dedication = member:getStatusEffect(xi.effect.DEDICATION)
    if
        not dedication or
        regionId == xi.region.ABYSSEA
    then
        return 0
    end

    local percentBonus    = dedication:getPower()
    local remainingCap    = dedication:getSubPower()
    local dedicationBonus = utils.clamp(math.floor(exp * percentBonus / 100), 0, remainingCap)

    remainingCap = remainingCap - dedicationBonus
    dedication:setSubPower(remainingCap)

    -- Consume Dedication effect if it's depleted.
    if remainingCap <= 0 then
        member:delStatusEffect(xi.effect.DEDICATION)
    end

    return dedicationBonus
end

-----------------------------------
-- Rhapsodies of Vanadiel
-----------------------------------
local experienceBonusKeyItems =
{
    xi.ki.RHAPSODY_IN_WHITE,
    xi.ki.RHAPSODY_IN_UMBER,
    xi.ki.RHAPSODY_IN_AZURE,
    xi.ki.RHAPSODY_IN_CRIMSON,
    xi.ki.RHAPSODY_IN_EMERALD,
    xi.ki.RHAPSODY_IN_MAUVE,
}

local function handleRoVBonus(member)
    local rhapsodiesBonus = 0
    for _, keyItem in ipairs(experienceBonusKeyItems) do
        if member:hasKeyItem(keyItem) then
            rhapsodiesBonus = rhapsodiesBonus + 30
        end
    end

    return rhapsodiesBonus
end

---@param member CBaseEntity
---@param mob CBaseEntity
---@param data table
---@return table|nil
xi.experiencePoints.calculate = function(member, mob, data)
    local experiencePoints = data.baseExp

    -- Experience points earned is graded against the highest contributing level in range. Members below it receive a scaled share.
    if
        data.highestMemberLevel > 50 or
        data.highestMemberLevel > data.memberLevel + 7
    then
        experiencePoints = experiencePoints * data.memberLevel / data.highestMemberLevel
    else
        experiencePoints = experiencePoints * data.memberTNL / data.highestMemberTNL
    end

    -- Party share of experience points, improved for small parties under Signet.
    experiencePoints = experiencePoints * xi.experiencePoints.getExperienceShare(data.partySize, isSignetActive(member, data.regionId))

    -- Monster-specific bonus (Some are worth extra experience points, this does not allow it to bypass the per-monster cap)
    local monsterBonus = mob:getMobMod(xi.mobMod.EXP_BONUS)

    experiencePoints = experiencePoints * (1 + monsterBonus / 100)

    -- Apply the per-monster experience cap before adding experience chains and additional multipliers like Dedication, Corsairs Roll etc.)
    experiencePoints = math.min(experiencePoints, getPerMonsterCap(data.memberLevel))

    -- Experience chains
    local chainActive = false
    local chainWindow = 0

    if data.mobDifficulty > xi.mobDifficulty.DECENT_CHALLENGE then
        local bracket = getExperienceChainBracket(mob:getMainLvl() + mob:getMod(xi.mod.EXP_LVL_MOD))

        if data.chainActive then
            local multipliers = xi.experiencePoints.chainMultipliers

            chainActive      = true
            experiencePoints = experiencePoints * multipliers[math.min(data.chainNumber + 1, #multipliers)]
            chainWindow      = bracket.windows[math.min(data.chainNumber + 1, #bracket.windows)]
        else
            chainWindow      = bracket.start
        end
    end

    -- Handle all experience point bonuses, including Dedication effects, RoV Key Items, Sanction, and EXP bonus gear/traits (Corsair Roll via xi.mod.EXP_BONUS)
    local dedicationBonus = handleDedicationBonus(member, experiencePoints, data.regionId)
    local rhapsodiesBonus = handleRoVBonus(member)
    local sanctionBonus   = xi.experiencePoints.getSanctionBonus(member, data.regionId)
    local totalBonus      = dedicationBonus + math.floor(experiencePoints * (member:getMod(xi.mod.EXP_BONUS) + rhapsodiesBonus + sanctionBonus) / 100)

    experiencePoints = math.max(experiencePoints + totalBonus, 0)

    return { exp = math.floor(experiencePoints), chainActive = chainActive, chainWindow = chainWindow }
end
