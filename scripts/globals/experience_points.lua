-----------------------------------
-- Experience Points Data & Calculations
-- https://wiki.ffo.jp/html/32.html
-----------------------------------
xi = xi or {}
xi.experiencePoints = xi.experiencePoints or {}

-----------------------------------
-- TODO: Audit this table. It's highly questionable in some spots.
-- Base experience by level difference, broken down into level brackets.
-- NOTE: If modified, this table *must* maintain the same number of entries for each level bracket.
-- Brackets    1-5 6-10 11-15 16-20 21-25 26-30 31-35 36-40 41-45 46-50 51-55 56-60 61-65 66-70 71-75 76-80 81-85 86-90 91-95 96-100
-----------------------------------
xi.experiencePoints.baseTable =
{
    [ 15] = {  800,  800,  800,  800,  800,  800,  800,  800,  800,  800,  800,  800,  800,  800,  800,  800,  800,  800,  800, 1500 },
    [ 14] = {  800,  800,  800,  800,  800,  800,  800,  800,  800,  800,  800,  800,  720,  720,  720,  720,  720,  720,  720, 1500 },
    [ 13] = {  800,  800,  800,  800,  800,  800,  720,  720,  720,  720,  720,  720,  630,  630,  630,  630,  630,  630,  630, 1500 },
    [ 12] = {  720,  720,  720,  720,  720,  720,  630,  630,  630,  630,  630,  630,  580,  580,  580,  580,  580,  580,  580, 1400 },
    [ 11] = {  630,  630,  630,  630,  630,  630,  580,  580,  580,  580,  580,  580,  530,  530,  530,  530,  530,  530,  530, 1300 },
    [ 10] = {  580,  580,  580,  580,  580,  580,  530,  530,  530,  530,  530,  530,  480,  480,  480,  480,  480,  480,  480, 1200 },
    [  9] = {  720,  720,  720,  720,  720,  720,  600,  600,  600,  600,  530,  480,  440,  440,  440,  400,  400,  400,  400, 1100 },
    [  8] = {  600,  600,  600,  600,  600,  600,  550,  550,  550,  530,  480,  430,  400,  400,  400,  380,  380,  380,  380, 1000 },
    [  7] = {  550,  550,  550,  550,  550,  550,  500,  500,  500,  470,  430,  380,  360,  360,  360,  340,  340,  340,  340,  900 },
    [  6] = {  450,  450,  450,  450,  450,  450,  450,  450,  450,  400,  370,  330,  320,  320,  320,  300,  300,  300,  300,  800 },
    [  5] = {  350,  350,  350,  350,  350,  350,  400,  400,  400,  340,  310,  280,  280,  280,  280,  260,  260,  260,  260,  700 },
    [  4] = {  310,  310,  310,  310,  310,  310,  300,  300,  300,  310,  280,  280,  280,  280,  260,  260,  240,  240,  240,  600 },
    [  3] = {  260,  260,  260,  260,  260,  260,  300,  300,  300,  300,  300,  300,  300,  300,  300,  320,  320,  320,  320,  500 },
    [  2] = {  240,  240,  240,  240,  240,  240,  250,  250,  250,  250,  250,  260,  260,  260,  260,  280,  280,  280,  280,  400 },
    [  1] = {  220,  220,  220,  220,  220,  220,  225,  225,  225,  225,  225,  230,  230,  230,  230,  240,  240,  240,  240,  300 },
    [  0] = {  200,  200,  200,  200,  200,  200,  200,  200,  200,  200,  200,  200,  200,  200,  200,  200,  200,  200,  200,  200 },
    [ -1] = {  180,  180,  180,  180,  180,  180,  186,  192,  192,  192,  192,  192,  192,  192,  195,  195,  195,  195,  195,  195 },
    [ -2] = {  160,  160,  160,  160,  160,  160,  172,  172,  180,  180,  186,  186,  186,  186,  190,  190,  190,  190,  190,  190 },
    [ -3] = {  140,  140,  150,  150,  150,  150,  160,  160,  170,  170,  180,  180,  180,  180,  184,  184,  184,  184,  184,  185 },
    [ -4] = {  130,  130,  140,  140,  140,  140,  150,  152,  160,  160,  170,  170,  172,  172,  180,  180,  180,  180,  180,  180 },
    [ -5] = {  120,  120,  130,  130,  130,  130,  140,  146,  152,  152,  160,  160,  166,  166,  172,  172,  172,  172,  172,  172 },
    [ -6] = {  100,  100,  120,  120,  120,  120,  130,  140,  146,  146,  152,  152,  160,  160,  166,  166,  166,  166,  166,  166 },
    [ -7] = {    0,   80,  110,  110,  110,  110,  120,  130,  140,  140,  146,  146,  152,  154,  160,  160,  160,  160,  160,  160 },
    [ -8] = {    0,   60,   90,   90,  100,  100,  110,  120,  130,  132,  140,  140,  146,  150,  155,  155,  155,  155,  155,  155 },
    [ -9] = {    0,    0,   80,   80,   80,   80,  100,  110,  120,  126,  132,  132,  140,  144,  150,  150,  150,  150,  150,  150 },
    [-10] = {    0,    0,    0,    0,   80,   80,   80,  100,  110,  120,  126,  126,  132,  140,  145,  145,  145,  145,  145,  145 },
    [-11] = {    0,    0,    0,    0,    0,    0,   60,   80,  100,  110,  120,  120,  126,  132,  140,  140,  140,  140,  140,  140 },
    [-12] = {    0,    0,    0,    0,    0,    0,    0,   60,   80,  100,  110,  112,  120,  126,  132,  132,  132,  132,  132,  132 },
    [-13] = {    0,    0,    0,    0,    0,    0,    0,    0,   60,   80,  100,  106,  112,  120,  126,  126,  126,  126,  126,  126 },
    [-14] = {    0,    0,    0,    0,    0,    0,    0,    0,    0,   60,   90,  100,  106,  112,  120,  120,  120,  120,  120,  120 },
    [-15] = {    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,   80,   90,  100,  106,  112,  112,  112,  112,  112,  112 },
    [-16] = {    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,   80,   80,  100,  106,  106,  106,  106,  106,  106 },
    [-17] = {    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,   60,   80,  100,  100,  100,  100,  100,  100 },
    [-18] = {    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,   60,   90,   90,   90,   90,   90,   90 },
    [-19] = {    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,   80,   80,   80,   80,   80,   80 },
    [-20] = {    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,   60,   70,   70,   70,   70,   70 },
    [-21] = {    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,   60,   60,   60,   60,   60 },
    [-22] = {    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,   55,   55,   55,   55,   55 },
    [-23] = {    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,   50,   50,   50,   50,   50 },
    [-24] = {    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,   48,   48,   48,   48,   48 },
    [-25] = {    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,   45,   45,   45,   45,   45 },
    [-26] = {    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,   42,   42,   42,   42,   42 },
    [-27] = {    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,   40,   40,   40,   40,   40 },
    [-28] = {    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,   38,   38,   38,   38,   38 },
    [-29] = {    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,   36,   36,   36,   36,   36 },
    [-30] = {    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,   34,   34,   34,   34,   34 },
    [-31] = {    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,   32,   32,   32,   32,   32 },
    [-32] = {    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,   30,   30,   30,   30,   30 },
    [-33] = {    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,   28,   28,   28,   28,   28 },
    [-34] = {    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,   26,   26,   26,   26,   26 },
    [-35] = {    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,   24,   24,   24,   24,   24 },
    [-36] = {    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,   22,   22,   22,   22,   22 },
    [-37] = {    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,   20,   20,   20,   20,   20 },
    [-38] = {    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,   19,   19,   19,   19,   19 },
    [-39] = {    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,   18,   18,   18,   18,   18 },
    [-40] = {    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,   17,   17,   17,   17,   17 },
    [-41] = {    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,   16,   16,   16,   16,   16 },
    [-42] = {    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,   15,   15,   15,   15,   15 },
    [-43] = {    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,   14,   14,   14,   14,   14 },
    [-44] = {    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0 },
}

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
local function isSanctionActive(member, regionId)
    return member:hasStatusEffect(xi.effect.SANCTION) and
        regionId >= xi.region.WEST_AHT_URHGAN and
        regionId <= xi.region.ALZADAAL and
        xi.besieged.getAstralCandescence() == 1
end

-- TODO: Sanction bonus magnitude is not documented on JP Wiki (https://wiki.ffo.jp/html/706.html); verify with captures. Set to 10% for now.
local function handleSanctionBonus(member, regionId)
    if isSanctionActive(member, regionId) then
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

-----------------------------------
-- Handle all experience point bonuses, including Dedication effects, RoV Key Items, Sanction, and EXP bonus gear/traits (Corsair Roll via xi.mod.EXP_BONUS)
-----------------------------------
local function handleExperienceBonuses(member, exp, regionId)
    local dedicationBonus = handleDedicationBonus(member, exp, regionId)
    local rhapsodiesBonus = handleRoVBonus(member)
    local sanctionBonus   = handleSanctionBonus(member, regionId)
    local totalBonus      = dedicationBonus + math.floor(exp * (member:getMod(xi.mod.EXP_BONUS) + rhapsodiesBonus + sanctionBonus) / 100)

    return math.max(exp + totalBonus, 0)
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

    experiencePoints = handleExperienceBonuses(member, experiencePoints, data.regionId)

    return { exp = math.floor(experiencePoints), chainActive = chainActive, chainWindow = chainWindow }
end
