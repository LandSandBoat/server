-----------------------------------
-- Expeditionary Force
-----------------------------------
require('scripts/globals/npc_util')
-----------------------------------
xi = xi or {}
xi.expeditionaryForce = xi.expeditionaryForce or {}

-----------------------------------
-- Feature Enable
-----------------------------------
-- This is temporary and only used to slowly enable zones as data is filled in.
-- This is accessed only by conquest.lua
-- TODO: Remove these checks after all zones have been implemented

xi.expeditionaryForce.enabled = false

xi.expeditionaryForce.enabledTable =
{
    [xi.zone.BEAUCEDINE_GLACIER]     = false,
    [xi.zone.BUBURIMU_PENINSULA]     = true,
    [xi.zone.CAPE_TERIGGAN]          = false,
    [xi.zone.EASTERN_ALTEPA_DESERT]  = false,
    [xi.zone.JUGNER_FOREST]          = false,
    [xi.zone.MERIPHATAUD_MOUNTAINS]  = false,
    [xi.zone.PASHHOW_MARSHLANDS]     = false,
    [xi.zone.QUFIM_ISLAND]           = false,
    [xi.zone.THE_SANCTUARY_OF_ZITAH] = false,
    [xi.zone.VALKURM_DUNES]          = false,
    [xi.zone.XARCABARD]              = false,
    [xi.zone.YHOATOR_JUNGLE]         = false,
    [xi.zone.YUHTUNGA_JUNGLE]        = false,
}

-----------------------------------
-- Retail differences and unknowns
-----------------------------------
-- Was unable to verify behavior with two groups from different nations in the same zone so relied on Wiki.
-- Mobs in older zones spawn at a random 0 - 360 degrees from the banner. Newer zones use 0 - 180 degrees equally spaced. I used 0 - 360 degrees for all zones.
-- Was unable to verify if giving a title had a distance restriction. Set this to a standard exp distance.
-- Was unable to verify the conditionas that participation recording occured.
-- For treasure opening, was unable to verify if non-treasure (like maps or quest items) also awarded influence. Opted to not include those to be conservative.
-- CP rewards in conquest.lua were verified for 0 - 2 regions, but external references were used for 3 - 13 regions.
-- Glyph positions for Bastok have been confirmed. The other 6 glyphs were estimated at 3.5 yalms in front of the gate guards.
-- The order of how text appears in the log for treasure opening is technically wrong. The influence message should appear after the loot message.
-- Mobs do not use confrontation on retail. The way it works is only level synched players can engage the mobs. Mobs can engage anyone. Other mobs can engage level synched players.
-- Avatar levels were not verified on retail, so they were set to pet levels.

-----------------------------------
-- Data
-----------------------------------
-- Runtime state. One record per EF zone, built lazily on zone initialize.
-- If you modify this lua file during runtime, you must relaunch map as expForceZoneData is erased.
local expForceZoneData = {}

-----------------------------------
-- Enums
-----------------------------------
local bannerState =
{
    IDLE    = 0,
    ACTIVE  = 1,
    CLEARED = 2,
    HIDDEN  = 3,
}

-----------------------------------
-- Tables
-----------------------------------

local levelTable =
{
    -- [zoneId] = level_cap
    [xi.zone.BEAUCEDINE_GLACIER]     = 40,
    [xi.zone.BUBURIMU_PENINSULA]     = 30,
    [xi.zone.CAPE_TERIGGAN]          = 99, -- Uncapped
    [xi.zone.EASTERN_ALTEPA_DESERT]  = 50,
    [xi.zone.JUGNER_FOREST]          = 30,
    [xi.zone.MERIPHATAUD_MOUNTAINS]  = 30,
    [xi.zone.PASHHOW_MARSHLANDS]     = 30,
    [xi.zone.QUFIM_ISLAND]           = 30,
    [xi.zone.THE_SANCTUARY_OF_ZITAH] = 40,
    [xi.zone.VALKURM_DUNES]          = 30,
    [xi.zone.XARCABARD]              = 50,
    [xi.zone.YHOATOR_JUNGLE]         = 50,
    [xi.zone.YUHTUNGA_JUNGLE]        = 40,
}

local bannerTable =
{
    [xi.zone.BEAUCEDINE_GLACIER] =
    {
        -- position = { x, y, z, rot }
        { position = {  193.614,   -0.307,  -35.663, 255 }, mobFamily = xi.mobFamily.GIGAS },  -- I-8
        { position = {   20.169,  -80.061,  180.063, 224 }, mobFamily = xi.mobFamily.GIGAS },  -- H-7
        { position = { -326.264,  -99.694,  140.523, 220 }, mobFamily = xi.mobFamily.GIGAS },  -- F-7
        { position = {  255.402,    0.072,  382.940, 110 }, mobFamily = xi.mobFamily.GOBLIN }, -- J-6
        { position = { -173.299,  -81.847,  150.200, 246 }, mobFamily = xi.mobFamily.GOBLIN }, -- G-7
    },

    [xi.zone.BUBURIMU_PENINSULA] =
    {
        { position = {  101.491,  -23.090,  199.798, 218 }, mobFamily = xi.mobFamily.GOBLIN },
        { position = {  527.885,    0.486,  -40.241, 157 }, mobFamily = xi.mobFamily.GOBLIN },
        { position = {  315.895,   -0.025,  361.453,  17 }, mobFamily = xi.mobFamily.YAGUDO },
        { position = { -132.589,   20.000, -314.261, 230 }, mobFamily = xi.mobFamily.YAGUDO },
        { position = { -446.510,   -8.799, -282.799, 240 }, mobFamily = xi.mobFamily.YAGUDO },
    },

    [xi.zone.CAPE_TERIGGAN] =
    {
        { position = {  126.583,   -0.194, -117.367,  75 }, mobFamily = xi.mobFamily.GOBLIN }, -- I-9
        { position = { -213.169,   -3.320,  254.085, 181 }, mobFamily = xi.mobFamily.GOBLIN }, -- G-6
        { position = {  251.977,    5.241,   50.698, 128 }, mobFamily = xi.mobFamily.GOBLIN }, -- J-8
        { position = {  -29.071,   -9.694,  224.300,  46 }, mobFamily = xi.mobFamily.GOBLIN }, -- H-7
        { position = {  162.059,   -0.740,  250.538, 139 }, mobFamily = xi.mobFamily.GOBLIN }, -- I-6
    },

    [xi.zone.EASTERN_ALTEPA_DESERT] =
    {
        { position = {  -63.319, -10.629,  408.180,  77 }, mobFamily = xi.mobFamily.ANTICA }, -- G-5
        { position = {  463.219, -10.608,  248.849, 212 }, mobFamily = xi.mobFamily.ANTICA }, -- J-6
        { position = {  329.054,   6.684, -330.958, 201 }, mobFamily = xi.mobFamily.ANTICA }, -- J-10
        { position = { -332.218,  -1.203,  126.229,  60 }, mobFamily = xi.mobFamily.GOBLIN }, -- E-7
        { position = {   27.934, -10.019,  398.640, 126 }, mobFamily = xi.mobFamily.GOBLIN }, -- H-6

    },

    [xi.zone.JUGNER_FOREST] =
    {
        { position = {  279.408, -15.592, -547.181, 176 }, mobFamily = xi.mobFamily.ORC },    -- J-11
        { position = { -159.588,   0.647,  386.042,  17 }, mobFamily = xi.mobFamily.ORC },    -- G-6
        { position = {    3.419, -16.000, -642.232,   7 }, mobFamily = xi.mobFamily.ORC },    -- H-12
        { position = {  448.240,   0.212, -157.228, 225 }, mobFamily = xi.mobFamily.GOBLIN }, -- K-9
        { position = {  600.809,   0.873,  217.453, 130 }, mobFamily = xi.mobFamily.GOBLIN }, -- L-7
    },

    [xi.zone.MERIPHATAUD_MOUNTAINS] =
    {
        { position = {  199.396,   -0.723, -527.072, 169 }, mobFamily = xi.mobFamily.GOBLIN }, -- H-11
        { position = {  342.918,   -1.109,  529.219, 226 }, mobFamily = xi.mobFamily.GOBLIN }, -- I-5
        { position = {  592.850,  -16.741, -518.802, 227 }, mobFamily = xi.mobFamily.YAGUDO }, -- K-11
        { position = { -536.930,    4.317,  338.845, 200 }, mobFamily = xi.mobFamily.YAGUDO }, -- D-6
        { position = { -559.025,  -16.761,   47.233,  72 }, mobFamily = xi.mobFamily.YAGUDO }, -- D-8
    },

    [xi.zone.PASHHOW_MARSHLANDS] =
    {
        { position = { -172.764,   25.125,   93.640, 154 }, mobFamily = xi.mobFamily.GOBLIN }, -- G-8
        { position = {  261.910,   24.213,  211.070,  85 }, mobFamily = xi.mobFamily.GOBLIN }, -- J-7
        { position = {  140.080,   23.971, -411.951, 112 }, mobFamily = xi.mobFamily.QUADAV }, -- I-11
        { position = { -447.851,   24.305, -219.899, 113 }, mobFamily = xi.mobFamily.QUADAV }, -- E-10
        { position = { -460.959,   24.203,  469.851, 223 }, mobFamily = xi.mobFamily.QUADAV }, -- E-5
    },

    [xi.zone.QUFIM_ISLAND] =
    {
        {},
        {},
        {},
        {},
        {},
    },

    [xi.zone.THE_SANCTUARY_OF_ZITAH] =
    {
        { position = {  643.619,    0.842, -176.843, 128 }, mobFamily = xi.mobFamily.GOBLIN }, -- L-10
        { position = {  174.336,   -1.015, -413.606,  59 }, mobFamily = xi.mobFamily.GOBLIN }, -- I-11
        { position = { -512.058,   -0.975,  253.275,  37 }, mobFamily = xi.mobFamily.GOBLIN }, -- E-7
        { position = {  429.298,    0.084, -604.489, 231 }, mobFamily = xi.mobFamily.GOBLIN }, -- J-12
        { position = { -399.822,    0.162, -168.998, 174 }, mobFamily = xi.mobFamily.GOBLIN }, -- E-10
    },

    [xi.zone.VALKURM_DUNES] =
    {
        { position = { -522.404,   -8.175,  113.667, 141 }, mobFamily = xi.mobFamily.ORC },
        { position = {  643.175,   -0.592,    8.854,  10 }, mobFamily = xi.mobFamily.ORC },
        { position = {  478.713,  -16.140,  365.873,  28 }, mobFamily = xi.mobFamily.GOBLIN }, -- J-6
        { position = { -352.679,   -8.856,  327.661,  18 }, mobFamily = xi.mobFamily.QUADAV },
        { position = { -116.204,    4.000, -113.608, 160 }, mobFamily = xi.mobFamily.QUADAV },
    },

    [xi.zone.XARCABARD] =
    {
        { position = {   32.788,  -24.162, -205.200,   6 }, mobFamily = xi.mobFamily.GIGAS },  -- G-9
        { position = { -160.590,  -24.169,  -87.061, 174 }, mobFamily = xi.mobFamily.GIGAS },  -- F-8
        { position = {  153.000,  -36.438,   23.500,  16 }, mobFamily = xi.mobFamily.GIGAS },  -- H-7
        { position = {   47.461,  -36.500,   66.281, 201 }, mobFamily = xi.mobFamily.GOBLIN }, -- G-7
        { position = {  320.399,   -8.190,  167.796,  52 }, mobFamily = xi.mobFamily.GOBLIN }, -- I-6
    },

    [xi.zone.YHOATOR_JUNGLE] =
    {
        { position = {  -54.134,    0.344, -405.397, 199 }, mobFamily = xi.mobFamily.GOBLIN },   -- H-10
        { position = { -196.704,    0.000, -149.953,  75 }, mobFamily = xi.mobFamily.GOBLIN },   -- G-9
        { position = { -289.835,    0.000, -357.025,   5 }, mobFamily = xi.mobFamily.TONBERRY }, -- F-10
        { position = {  366.014,   -0.176, -394.801,  96 }, mobFamily = xi.mobFamily.TONBERRY }, -- J-10
        { position = { -176.760,    0.162,   26.774,  40 }, mobFamily = xi.mobFamily.TONBERRY }, -- G-8
    },

    [xi.zone.YUHTUNGA_JUNGLE] =
    {
        { position = {  -63.927,   -0.042, -126.052, 153 }, mobFamily = xi.mobFamily.SAHAGIN }, -- H-9
        { position = {  102.301,    0.600,  442.978,  17 }, mobFamily = xi.mobFamily.SAHAGIN }, -- I-6
        { position = { -305.061,   16.186, -438.904, 132 }, mobFamily = xi.mobFamily.SAHAGIN }, -- G-11
        { position = {  381.229,    3.908,  148.721, 115 }, mobFamily = xi.mobFamily.GOBLIN },  -- K-8
        { position = { -647.367,    0.000,   42.053,  28 }, mobFamily = xi.mobFamily.GOBLIN },  -- E-8
    },
}

local nmRangeTable =
{
    [xi.zone.BEAUCEDINE_GLACIER] =
    {

    },

    [xi.zone.BUBURIMU_PENINSULA] =
    {
        baseId = zones[xi.zone.BUBURIMU_PENINSULA].mob.HOBGOBLIN_WARRIOR,
        count  = 18, -- Number of Expeditionary Force mobs and pets in zone
    },

    [xi.zone.CAPE_TERIGGAN] =
    {

    },

    [xi.zone.EASTERN_ALTEPA_DESERT] =
    {

    },

    [xi.zone.JUGNER_FOREST] =
    {

    },

    [xi.zone.MERIPHATAUD_MOUNTAINS] =
    {

    },

    [xi.zone.PASHHOW_MARSHLANDS] =
    {

    },

    [xi.zone.QUFIM_ISLAND] =
    {

    },

    [xi.zone.THE_SANCTUARY_OF_ZITAH] =
    {

    },

    [xi.zone.VALKURM_DUNES] =
    {

    },

    [xi.zone.XARCABARD] =
    {

    },

    [xi.zone.YHOATOR_JUNGLE] =
    {

    },

    [xi.zone.YUHTUNGA_JUNGLE] =
    {

    },
}

local regionKITable =
{
    [xi.region.ARAGONEU]         = xi.ki.ARAGONEU_EF_INSIGNIA,
    [xi.region.DERFLAND]         = xi.ki.DERFLAND_EF_INSIGNIA,
    [xi.region.ELSHIMO_LOWLANDS] = xi.ki.ELSHIMO_LOWLANDS_EF_INSIGNIA,
    [xi.region.ELSHIMO_UPLANDS]  = xi.ki.ELSHIMO_UPLANDS_EF_INSIGNIA,
    [xi.region.FAUREGANDI]       = xi.ki.FAUREGANDI_EF_INSIGNIA,
    [xi.region.KOLSHUSHU]        = xi.ki.KOLSHUSHU_EF_INSIGNIA,
    [xi.region.KUZOTZ]           = xi.ki.KUZOTZ_EF_INSIGNIA,
    [xi.region.LITELOR]          = xi.ki.LITELOR_EF_INSIGNIA,
    [xi.region.NORVALLEN]        = xi.ki.NORVALLEN_EF_INSIGNIA,
    [xi.region.QUFIMISLAND]      = xi.ki.QUFIM_EF_INSIGNIA,
    [xi.region.VALDEAUNIA]       = xi.ki.VALDEAUNIA_EF_INSIGNIA,
    [xi.region.VOLLBOW]          = xi.ki.VOLLBOW_EF_INSIGNIA,
    [xi.region.ZULKHEIM]         = xi.ki.ZULKHEIM_EF_INSIGNIA,
}

-----------------------------------
-- Local functions
-----------------------------------

-- Apply the EF level restriction to one player.
-- ON_ZONE makes it wear when the player zones out.
-- CONFRONTATION hard-gates the NMs to capped players.
-- subPower = 1 makes it so xp rate is applied to your actual level, not your restricted level.
local function addLevelRestriction(player, levelCap)
    local cap = levelCap
    if levelCap == 99 then
        cap = xi.settings.main.MAX_LEVEL
    end

    player:addStatusEffect(xi.effect.LEVEL_RESTRICTION, {
        power    = cap,
        subPower = 1, -- exp uses actual level and not the restricted level.
        duration = 900, -- 15 min if not removed at the banner or zone
        origin   = player,
        flag     = xi.effectFlag.ON_ZONE + xi.effectFlag.CONFRONTATION,
    })
end

-- Add the CONFRONTATION to the NMs. The level restriction already won't apply to mobs. I just need the CONFRONTATION flag and matching power.
local function addConfrontationGate(mob, levelCap)
    local cap = levelCap
    if levelCap == 99 then
        cap = xi.settings.main.MAX_LEVEL
    end

    mob:addStatusEffect(xi.effect.LEVEL_RESTRICTION, {
        power    = cap,
        origin   = mob,
        flag     = xi.effectFlag.CONFRONTATION,
    })
end

local function getNMPoolByFamily(zoneId, mobFamily)
    local nmRange = nmRangeTable[zoneId]
    local pool    = {}

    for offset = 0, nmRange.count - 1 do
        local mobId = nmRange.baseId + offset
        local mob   = GetMobByID(mobId)
        if mob ~= nil and mob:getFamily() == mobFamily then
            table.insert(pool, mobId)
        end
    end

    return pool
end

-- Spawn 4 NMs at the banner
local function spawnBattleNMs(player, banner, zoneData)
    local zoneId     = banner:getZoneID()
    local levelCap   = levelTable[zoneId]
    local bannerInfo = bannerTable[zoneId][zoneData.bannerIndex]
    local candidates = utils.shuffle(getNMPoolByFamily(zoneId, bannerInfo.mobFamily))
    local bx, by, bz = unpack(bannerInfo.position)

    for i = 1, 4 do
        local mobId = candidates[i]

        -- Catch case when pool has fewer than 4 mobs
        if mobId == nil then
            break
        end

        -- Spawn is a normal distribution with a mean of 3.5 and standard deviation of 1.5.
        -- The spawn distance is also restricted to [2.0, 7.5]. This is based on 234 samples.
        local distance = utils.randomNormal(3.5, 1.5, 2.0, 7.5)

        -- Scatter around the banner in random direction.
        local angle = math.random() * 2 * math.pi                       -- 0 to 360 degrees
        local pos   = GetFurthestValidPosition(banner, distance, angle) -- Drops mob on valid ground and snaps closer if terrain blocks the distance.

        local mob = GetMobByID(mobId)
        if mob == nil then
            break
        end

        if pos ~= nil then
            mob:setSpawn(pos.x, pos.y, pos.z, 0)

        -- Account for weird situation where the GetFurthestValidPosition can't find any position due to navmesh
        else
            mob:setSpawn(bx, by, bz, 0)
        end

        mob:spawn()
        mob:lookAt(player:getPos()) -- face whoever triggered the banner
        addConfrontationGate(mob, levelCap)
        mob:updateClaim(player)
        table.insert(zoneData.nms, mobId)

        zoneData.numAlive = zoneData.numAlive + 1
    end
end

-- CLEARED -> HIDDEN. This is called from a 60-second timer callback.
local function hideBanner(zoneId, banner)
    local zoneData = expForceZoneData[zoneId]

    -- Make the banner disappear
    banner:setStatus(xi.status.DISAPPEAR)

    -- Clean up data and set HIDDEN state
    zoneData.nms          = {}
    zoneData.gone         = {}
    zoneData.numAlive     = 0
    zoneData.creditNation = nil
    zoneData.state        = bannerState.HIDDEN

    -- Respawn the banner in 5 minutes
    banner:timer(5 * 60 * 1000, function(npcArg)
        xi.expeditionaryForce.initZone(npcArg:getZone())
    end)
end

-- Safety check every 60s while banner is active. Catches the case where a DESPAWN listener misses.
local function watchDog(npc)
    local zoneId   = npc:getZoneID()
    local zoneData = expForceZoneData[zoneId]

    -- Only continue running if the state is ACTIVE
    if zoneData.state ~= bannerState.ACTIVE then
        return
    end

    -- Any NM still in the world (alive or corpse)?
    local anyPresent = false
    for _, mobId in ipairs(zoneData.nms) do
        local mob = GetMobByID(mobId)
        if mob ~= nil and mob:isSpawned() then
            anyPresent = true
            break
        end
    end

    -- None are present but we never ended
    if not anyPresent then
        zoneData.state = bannerState.CLEARED

        -- The banner will disappear after 60 seconds.
        npc:timer(60 * 1000, function(npcArg)
            hideBanner(npcArg:getZoneID(), npcArg)
        end)

    -- Check again in 60 seconds
    else
        npc:timer(60 * 1000, function(npcArg)
            watchDog(npcArg)
        end)
    end
end

-- Log EF participation for a region by setting its bit.
local function recordParticipation(player, regionId)
    local participation = player:getCharVar('[ExpForce]Participation')
    player:setCharVar('[ExpForce]Participation', bit.bor(participation, bit.lshift(1, regionId)))
end

-- Mark a mob as gone. When all NMs are accounted for, transition to CLEARED.
-- This fires during onDeath and onDespawn as the flag needs to update on the death of the last mob or despawn of the last mob if the mob is not killed.
local function removeNMFromList(mob)
    local zoneId = mob:getZoneID()
    local zoneData = expForceZoneData[zoneId]

    local mobId = mob:getID()

    -- Check if mob is already in list
    if not zoneData.gone[mobId] then
        -- Add the mob to the gone list
        zoneData.gone[mobId] = true
        zoneData.numAlive    = zoneData.numAlive - 1

        -- Battle is cleared
        if zoneData.numAlive <= 0 then
            zoneData.state = bannerState.CLEARED

            -- The banner will disappear after 60 seconds.
            local ID     = zones[zoneId]
            local banner = GetNPCByID(ID.npc.BEASTMENS_BANNER)
            if banner == nil then
                return
            end

            banner:timer(60 * 1000, function(npcArg)
                hideBanner(npcArg:getZoneID(), npcArg)
            end)
        end
    end
end

-- This checks if the expeditionary force is allowed to be spawned.
-- A player must have the KI and the region must not be owned by the player's nation or ally.
-- All checks are necessary just in case the player is holding the key item after tally update.
local function expForceAvailableToPlayer(player, region)
    local ownerNation  = GetRegionOwner(region)
    local playerNation = player:getNation()

    return
        player:hasKeyItem(regionKITable[region]) and
        ownerNation ~= playerNation and
        not xi.conquest.areAllies(playerNation, ownerNation)
end

-----------------------------------
-- Public functions
-----------------------------------

-- This code runs whenever the zone is initialized as well as every time the Expeditionary Force has been reset.
xi.expeditionaryForce.initZone = function(zone)
    local zoneId = zone:getID()
    local ID     = zones[zoneId]

    -- Build the zone's runtime record
    local zoneData = expForceZoneData[zoneId]
    -- This branch is for when the zone is initialized
    if zoneData == nil then
        zoneData =
        {
            state        = bannerState.IDLE,
            nms          = {},
            gone         = {},
            numAlive     = 0,
            creditNation = nil,
            bannerIndex  = nil,
        }
        expForceZoneData[zoneId] = zoneData

    -- This branch runs when respawning a banner
    else
        zoneData.state        = bannerState.IDLE
        zoneData.nms          = {}
        zoneData.gone         = {}
        zoneData.numAlive     = 0
        zoneData.creditNation = nil
    end

    -- Set the banner to a random position and set the status to normal
    local banner           = GetNPCByID(ID.npc.BEASTMENS_BANNER)
    local bannerOptions    = bannerTable[zoneId]
    local lastBannerIndex  = zoneData.bannerIndex
    local newBannerIndex

    if banner == nil then
        return
    end

    -- When the zone loads, there are no previous positions so we can pick from any of the available options.
    if lastBannerIndex == nil then
        newBannerIndex = math.random(#bannerOptions)

    -- We will just roll 1 less number. If we happen to land on the previous index, we just select the last value in the position table.
    -- Note: If you only have one banner position, this will break! This should never happen as all zones have more than 1 banner position.
    else
        newBannerIndex = math.random(#bannerOptions - 1)
        if newBannerIndex == lastBannerIndex then
            newBannerIndex = #bannerOptions
        end
    end

    local pos = bannerOptions[newBannerIndex].position
    banner:setPos(pos[1], pos[2], pos[3], pos[4])
    banner:setStatus(xi.status.NORMAL) -- forces visible

    -- Store the position index for later to make sure the banner does not spawn in the same place twice in a row
    zoneData.bannerIndex = newBannerIndex
end

-- Handle all states of the Beastmen's Banner
-- The flow of Expeditionary Force goes from IDLE to ACTIVE to CLEARED to HIDDEN then back to IDLE
xi.expeditionaryForce.onBannerTrigger = function(player, npc)
    local zoneId   = npc:getZoneID()
    local ID       = zones[zoneId]
    local zoneData = expForceZoneData[zoneId]

    -- IDLE
    if zoneData.state == bannerState.IDLE then
        local region = npc:getCurrentRegion()

        -- Find out if an alliance member in the zone has level sync already. If so, they can not activate the flag.
        local allianceMemberCapped = false
        for _, member in pairs(player:getAlliance()) do
            if
                member:getZoneID() == zoneId and
                member:hasStatusEffect(xi.effect.LEVEL_RESTRICTION)
            then
                allianceMemberCapped = true
                break -- No need to keep checking
            end
        end

        -- Gate is if no alliance member is level synched, player has key item, nation does not hold the region, nation's ally does not hold the region.
        if
            expForceAvailableToPlayer(player, region) and
            not allianceMemberCapped
        then
            -- Credit nation is based on the player who clicked the banner, not the player who killed the nm.
            zoneData.creditNation = player:getNation()

            -- Level cap every alliance member in zone
            -- Get members in-range
            for _, member in pairs(player:getAlliance()) do
                if member:getZoneID() == zoneId then
                    -- Add level restriction if in zone
                    addLevelRestriction(member, levelTable[zoneId])

                    -- Display banner message to all members who have been level restricted
                    member:messageSpecial(ID.text.BEASTMEN_BANNER_CURSE) -- There was a curse on the beastmen's banner!
                end
            end

            -- Spawn 4 NMs at the banner
            spawnBattleNMs(player, npc, zoneData)
            zoneData.state = bannerState.ACTIVE

            -- Launch Watch Dog function: this will catch if an NM's despawn doesn't trigger.
            watchDog(npc)

        -- If the player is ineligable to initiate, just send a message.
        else
            player:messageSpecial(ID.text.BEASTMEN_BANNER) -- There is a beastmen's banner.
        end

    -- ACTIVE: Mobs exist
    elseif zoneData.state == bannerState.ACTIVE then
        -- Remove level restriction if it exists.
        if player:hasStatusEffect(xi.effect.LEVEL_RESTRICTION) then
            player:delStatusEffect(xi.effect.LEVEL_RESTRICTION)
        end

        -- Anyone not level restricted can click to get level restriction. No checks.
        addLevelRestriction(player, levelTable[zoneId])

        -- Display banner message
        player:messageSpecial(ID.text.BEASTMEN_BANNER_CURSE) -- There was a curse on the beastmen's banner!

    -- CLEARED: All mobs despawned
    elseif zoneData.state == bannerState.CLEARED then
        -- Remove clicker's level cap
        if player:hasStatusEffect(xi.effect.LEVEL_RESTRICTION) then
            player:delStatusEffect(xi.effect.LEVEL_RESTRICTION)
            player:messageSpecial(ID.text.BEASTMEN_BANNER_LIFTED) -- The curse of the beastmen's banner has been lifted!

        -- Default banner text.
        else
            player:messageSpecial(ID.text.BEASTMEN_BANNER) -- There is a beastmen's banner.
        end
    end

    -- HIDDEN: Banner is invisible and not clickable
end

-- Called from mob lua files. Fires once per alliance member in zone.
xi.expeditionaryForce.onMobDeath = function(mob, player, optParams)
    -- This should never happen as pets are attributed to owner, but just in case pet kills during player zone.
    if not player then
        return
    end

    local zoneId   = mob:getZoneID()
    local ID       = zones[zoneId]
    local zoneData = expForceZoneData[zoneId]
    local creditNation = zoneData.creditNation

    -- These occur once per kill.
    if optParams.isKiller then
        removeNMFromList(mob)

        -- AWARD INFLUENCE
        AddConquestInfluence(xi.settings.main.EXP_FORCE_MOBKILL_INFLUENCE, creditNation, mob:getCurrentRegion())

        -- SEND ZONE MESSAGE
        for _, person in pairs(mob:getZone():getPlayers()) do
            if creditNation == xi.nation.SANDORIA then
                person:messageText(person, ID.text.EXP_FORCE_KILL_SANDORIA, 5) -- 5 = Grey: messageText event

            elseif creditNation == xi.nation.BASTOK then
                person:messageText(person, ID.text.EXP_FORCE_KILL_BASTOK, 5) -- 5 = Grey: messageText event

            elseif creditNation == xi.nation.WINDURST then
                person:messageText(person, ID.text.EXP_FORCE_KILL_WINDURST, 5) -- 5 = Grey: messageText event
            end
        end
    end

    -- AWARD TITLE AND PARTICIPATION
    -- You don't need to be participating in Expeditionary Force or even be the right level to get the title.
    if player:checkDistance(mob) <= 50 then -- TODO: Verify that there is a distance based restriction. Set it to standard xp restriction.
        -- Award all alliance members title
        player:addTitle(xi.title.EXPEDITIONARY_TROOPER)

        -- Mark all alliance members participating in Expeditionary Force with participation
        -- TODO: Verify what conditions require recording participation.
        local regionId = mob:getCurrentRegion()
        if
            player:hasKeyItem(regionKITable[regionId]) and
            player:hasStatusEffect(xi.effect.LEVEL_RESTRICTION)
        then
            recordParticipation(player, regionId)
        end
    end

    -- MESSAGE
    -- "x's region points have increased"
    if creditNation == xi.nation.SANDORIA then
        player:messageSpecial(ID.text.REGION_POINTS_SANDORIA) -- showText event

    elseif creditNation == xi.nation.BASTOK then
        player:messageSpecial(ID.text.REGION_POINTS_BASTOK)   -- showText event

    elseif creditNation == xi.nation.WINDURST then
        player:messageSpecial(ID.text.REGION_POINTS_WINDURST) -- showText event
    end
end

-- Fires on despawn. This is for if mobs despawn naturally without death. 3 minute depsawn timer.
xi.expeditionaryForce.onMobDespawn = function(mob)
    removeNMFromList(mob)
end

-- Award influence for opening a chest/coffer with the region's insignia.
-- Caller checks the insignia and resolves the regionId.
-- TODO: This is only wired to give influence when a non-quest item and non-map key item is obtained. Double check this.
xi.expeditionaryForce.onChestOpen = function(player)
    local regionId = player:getCurrentRegion()
    local insignia = regionKITable[regionId]

    -- Only give influence if this is a EF region, the player has the KI, and the player's nation or allied nation does not control the region.
    if
        insignia ~= nil and
        expForceAvailableToPlayer(player, regionId)
    then

        player:gainInfluencePoints(xi.settings.main.EXP_FORCE_TREASURE_INFLUENCE)

        -- Nation flavor text
        local ID           = zones[player:getZoneID()]
        local playerNation = player:getNation()

        if playerNation == xi.nation.SANDORIA then
            player:messageSpecial(ID.text.EXP_FORCE_CHEST_SANDORIA)

        elseif playerNation == xi.nation.BASTOK then
            player:messageSpecial(ID.text.EXP_FORCE_CHEST_BASTOK)

        elseif playerNation == xi.nation.WINDURST then
            player:messageSpecial(ID.text.EXP_FORCE_CHEST_WINDURST)
        end

        recordParticipation(player, regionId)
    end
end

-- Dispose of every Expeditionary Force insignia the player is holding.
-- Called on a nation change, since insignias are tied to the player's old allegiance.
-- Returns true if at least one insignia was removed.
xi.expeditionaryForce.disposeInsigniaNationSwap = function(player)
    local removed = false

    for _, ki in pairs(regionKITable) do
        if player:hasKeyItem(ki) then
            player:delKeyItem(ki)
            removed = true
        end
    end

    return removed
end

-- Pets called mid-fight (call beast, astral flow) miss the gate at spawn. Need to apply manually.
xi.expeditionaryForce.gatePet = function(mob)
    addConfrontationGate(mob, levelTable[mob:getZoneID()])
end
