-----------------------------------
-- Einherjar: Chamber planner
-----------------------------------
xi = xi or {}
xi.einherjar = xi.einherjar or {}

local ID = zones[xi.zone.HAZHALM_TESTING_GROUNDS]

-- Merge two mob groups into one
-- Certain mob groups contain different models/jobs of the same mob family
local function mergeArrays(a, b)
    local result = {}
    for i = 1, #a do
        result[#result + 1] = a[i]
    end

    for i = 1, #b do
        result[#result + 1] = b[i]
    end

    return result
end

-- Ensure two concurrent chambers cannot plan the same mobs
local lockedMobs = {}

-- Removes lock on mob
xi.einherjar.unlockMob = function(mobId)
    lockedMobs[mobId] = nil
end

local mobPool =
{
    [xi.einherjar.wing.WING_1] =
    {
        ID.mob.BUGARD_X,
        ID.mob.CHIGOE,
        ID.mob.CRAVEN_EINHERJAR,
        ID.mob.DARK_ELEMENTAL,
        ID.mob.EINHERJAR_EATER,
        ID.mob.HAZHALM_BAT,
        ID.mob.HAZHALM_BATS,
        ID.mob.HYNDLA,
        ID.mob.INFECTED_WAMOURA,
        ID.mob.LOGI,
        ID.mob.NICKUR,
        ID.mob.ROTTING_HUSKARL_WAR,
        ID.mob.ROTTING_HUSKARL_BLM,
        ID.mob.SJOKRAKJEN,
    },
    [xi.einherjar.wing.WING_2] =
    {
        ID.mob.BATTLEMITE,
        ID.mob.CHIGOE,
        ID.mob.CORRUPT_EINHERJAR,
        ID.mob.CRAVEN_EINHERJAR_BHOOT,
        ID.mob.EINHERJAR_BREI,
        ID.mob.EINHERJAR_EATER,
        ID.mob.FLAMES_OF_MUSPELHEIM,
        ID.mob.GARDSVOR,
        ID.mob.HAZHALM_BAT,
        ID.mob.HAZHALM_BATS,
        ID.mob.HAZHALM_LEECH,
        ID.mob.ODINS_FOOL,
        mergeArrays(ID.mob.ROTTING_HUSKARL_DRK, ID.mob.ROTTING_HUSKARL_THF),
        ID.mob.SJOKRAKJEN,
        ID.mob.UTGARTH_BAT,
        ID.mob.UTGARTH_BATS,
        ID.mob.UTGARTH_LEECH,
        ID.mob.WALDGEIST,
        ID.mob.WINEBIBBER,
    },
    [xi.einherjar.wing.WING_3] =
    {
        ID.mob.AUDHUMBLA,
        ID.mob.BERSERKR,
        ID.mob.CORRUPT_EINHERJAR,
        ID.mob.DJIGGA,
        ID.mob.EXPERIMENTAL_POROGGO,
        ID.mob.FLAMES_OF_MUSPELHEIM,
        ID.mob.HAFGYGR,
        ID.mob.IDUN,
        ID.mob.INFECTED_WAMOURA,
        ID.mob.LIQUIFIED_EINHERJAR,
        ID.mob.LOGI,
        ID.mob.MARGYGR,
        ID.mob.MARID_X,
        ID.mob.MANTICORE_X,
        ID.mob.ODINS_JESTER,
        ID.mob.ORMR,
        ID.mob.SOULFLAYER,
        ID.mob.UTGARTH_BAT,
        ID.mob.UTGARTH_BATS,
        ID.mob.UTGARTH_LEECH,
        ID.mob.VAMPYR_DOG,
        ID.mob.VANQUISHED_EINHERJAR,
        ID.mob.WIVRE_X,
    },
}

-- Returns a random mob family for given chamber tier
-- Family is locked until explicitedly unlocked by chamber
local function getRandomMobFamily(chamberTier)
    local availableFamilies = {}

    -- Collect families that are not locked
    for _, mobFamily in ipairs(mobPool[chamberTier]) do
        -- No need to store all IDs, just check the first one
        if not lockedMobs[mobFamily[1]] then
            table.insert(availableFamilies, mobFamily)
        end
    end

    if #availableFamilies == 0 then
        return nil
    end

    -- Lock the selected family
    local selectedFamily = availableFamilies[math.random(#availableFamilies)]
    lockedMobs[selectedFamily[1]] = true

    return selectedFamily
end

local bossPool =
{
    [xi.einherjar.wing.WING_1] =
    {
        ID.mob.HAKENMANN,
        ID.mob.HILDESVINI,
        ID.mob.HIMINRJOT,
        ID.mob.HRAESVELG,
        ID.mob.MORBOL_EMPEROR,
        ID.mob.NIHHUS,
    },
    [xi.einherjar.wing.WING_2] =
    {
        ID.mob.ANDHRIMNIR,
        ID.mob.ARIRI_SAMARIRI,
        ID.mob.BALRAHN,
        ID.mob.HRUNGNIR,
        ID.mob.MOKKURALFI,
        ID.mob.TANNGRISNIR,
    },
    [xi.einherjar.wing.WING_3] =
    {
        ID.mob.DENDAINSONNE,
        ID.mob.FREKE,
        ID.mob.GORGIMERA,
        ID.mob.MOTSOGNIR,
        ID.mob.STOORWORM,
        ID.mob.VAMPYR_JARL,
    },
}

-- Returns a random boss for given chamber tier
-- Boss is locked until explicitly unlocked by chamber
local function getRandomBoss(chamberTier)
    local availableBosses = {}

    -- Collect bosses that are not locked
    for _, boss in ipairs(bossPool[chamberTier]) do
        if not lockedMobs[boss] then
            table.insert(availableBosses, boss)
        end
    end

    if #availableBosses == 0 then
        return nil
    end

    -- Select a random boss
    local index        = math.random(#availableBosses)
    local selectedBoss = availableBosses[index]

    -- Lock the selected boss and return it
    lockedMobs[selectedBoss] = true

    return selectedBoss
end

local specialPool =
{
    { ids = 0,                 chance =  2 },  -- Special mob may not spawn
    { ids = ID.mob.HUGINN,     chance = 30 },
    { ids = ID.mob.MUNINN,     chance = 30 },
    { ids = ID.mob.HEITHRUN,   chance =  8 },
    { ids = ID.mob.SAEHRIMNIR, chance = 30 },
}

-- Returns a random special mob
-- No lock is necessary since 9 copies exist
local function getRandomSpecial(chamberId)
    local rand       = math.random(1, 100)
    local cumulative = 0

    for _, choice in ipairs(specialPool) do
        cumulative = cumulative + choice.chance
        if rand <= cumulative then
            return choice.ids ~= 0 and choice.ids[chamberId] or 0
        end
    end
end

local function generateDistribution(familyCount, waveCount)
    local distribution = {}

    -- Start by giving each wave at least one family
    for i = 1, waveCount do
        distribution[i] = 1
    end

    -- Distribute remaining families with a max limit of 2 per wave
    local remainingFamilies = familyCount - waveCount
    local validWaves        = {}

    for i = 1, waveCount do
        table.insert(validWaves, i)
    end

    while remainingFamilies > 0 and #validWaves > 0 do
        local waveIndex         = validWaves[math.random(1, #validWaves)]
        distribution[waveIndex] = distribution[waveIndex] + 1
        remainingFamilies       = remainingFamilies - 1

        if distribution[waveIndex] == 2 then
            for i, v in ipairs(validWaves) do
                if v == waveIndex then
                    table.remove(validWaves, i)
                    break
                end
            end
        end
    end

    return distribution
end

local function getWaveCount(familyCount, chamberTier)
    if chamberTier == 1 then
        return 1  -- Always 1 wave
    end

    -- Generate wave count, but it cannot exceed family count
    local maxWaves = math.min(familyCount, (chamberTier == 2 and 2) or 3)

    if chamberTier == 2 then
        -- 1 or 2 waves (40%-60%)
        return math.random(1, 100) > 40 and maxWaves or 1
    elseif chamberTier == 3 then
        -- 1 to 3 waves (5%-45%-45%), but max cannot exceed family count
        local roll = math.random(1, 100)

        return (roll > 50 and maxWaves) or (roll > 5 and math.min(2, maxWaves)) or 1
    end
end

-- Generates a chamber plan based on the chamber ID and tier
-- All selected mobs are locked until released by the chamber
xi.einherjar.makeChamberPlan = function(chamberId)
    local chamberTier = math.ceil(chamberId / 3)
    local chamberConfig =
    {
        boss    = getRandomBoss(chamberTier),
        special = getRandomSpecial(chamberId),
        waves   = {}
    }

    local demonFamily =
    {
        ID.mob.HERVARTH,
        ID.mob.HJORVARTH,
        ID.mob.HRANI,
        ID.mob.ANGANTYR,
        ID.mob.BUI,
        ID.mob.BRAMI,
        ID.mob.BARRI,
        ID.mob.REIFNIR,
        ID.mob.TIND,
        ID.mob.TYRFING,
        ID.mob.HADDING_THE_ELDER,
        ID.mob.HADDING_THE_YOUNGER
    }

    if not chamberConfig.boss then
        print('ERROR: Einherjar unable to plan chamber: no boss available for tier ', chamberTier)
        return nil
    end

    -- Get family count first before deciding on number of waves
    local familyCount
    if chamberTier == 1 then
        -- 1 to 2 families (40%-60%) over 1 wave
        familyCount = math.random(1, 100) > 40 and 2 or 1
    elseif chamberTier == 2 then
        -- 2 to 3 families (75%-25%) over 1 or 2 waves (40%-60%)
        familyCount = math.random(1, 100) > 25 and 2 or 3
    elseif chamberTier == 3 then
        -- 2 to 4 families (25%-50%-25%) over 1, 2, or 3 waves (5%-45%-45%)
        local roll  = math.random(1, 100)
        familyCount = (roll > 75 and 4) or (roll > 25 and 3) or 2
    end

    local families = {}
    local isMotsognir = chamberConfig.boss == ID.mob.MOTSOGNIR
    local normalFamilyCount = isMotsognir and (familyCount - 1) or familyCount

    for j = 1, normalFamilyCount do
        local family = getRandomMobFamily(chamberTier)
        if not family then
            print('ERROR: Einherjar unable to plan chamber: no mob family available for tier ', chamberTier)
            xi.einherjar.unlockMob(chamberConfig.boss)
            for _, f in ipairs(families) do
                for _, id in ipairs(f) do
                    xi.einherjar.unlockMob(id)
                end
            end

            return nil
        end

        table.insert(families, family)
    end

    -- Enforce max 3 waves total
    local maxWaveCount = 3
    local waveCount = getWaveCount(familyCount, chamberTier)

    if isMotsognir and waveCount > maxWaveCount - 1 then
        waveCount = maxWaveCount - 1
    elseif waveCount > maxWaveCount then
        waveCount = maxWaveCount
    end

    -- Get wave count based on normal family count
    local normalWaveCount = isMotsognir and (waveCount - 1) or waveCount
    local distribution = generateDistribution(normalFamilyCount, normalWaveCount)

    local familyIndex = 1
    for _, numFamilies in ipairs(distribution) do
        local wave = {}

        for _ = 1, numFamilies do
            if families[familyIndex] then
                for _, id in ipairs(families[familyIndex]) do
                    table.insert(wave, id)
                end

                familyIndex = familyIndex + 1
            end
        end

        table.insert(chamberConfig.waves, wave)
    end

    if isMotsognir then
        table.insert(chamberConfig.waves, demonFamily)
    end

    chamberConfig.waveCount = #chamberConfig.waves
    return chamberConfig
end

-- Subdivides a list of mob IDs into random-sized subgroups
xi.einherjar.subDivideMobs = function(mobIds)
    local subdividedGroups = {}
    local shuffled         = utils.shuffle(mobIds)
    local index            = 1

    -- Divide into random-sized subgroups (between 2 and 5)
    while index <= #shuffled do
        local remaining = #shuffled - index + 1
        -- Random group size between 2 and 5, but not exceeding remaining mobs
        local groupSize = math.min(math.random(2, 5), remaining)
        local subGroup  = {}

        for i = 0, groupSize - 1 do
            table.insert(subGroup, shuffled[index + i])
        end

        table.insert(subdividedGroups, subGroup)
        index = index + groupSize
    end

    return subdividedGroups
end

xi.einherjar.getRandomPosForMobGroup = function(chamberId, min, max)
    local groupOffsetX = math.random(min, max)
    local groupOffsetZ = math.random(min, max)

    if math.random(1, 100) <= 50 then
        groupOffsetX = -groupOffsetX
    end

    if math.random(1, 100) <= 50 then
        groupOffsetZ = -groupOffsetZ
    end

    return
    {
        xi.einherjar.chambers[chamberId].center[1] + groupOffsetX,
        xi.einherjar.chambers[chamberId].center[2],
        xi.einherjar.chambers[chamberId].center[3] + groupOffsetZ
    }
end
