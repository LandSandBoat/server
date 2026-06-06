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

xi.expeditionaryForce.enabled = true

xi.expeditionaryForce.enabledTable =
{
    [xi.zone.BEAUCEDINE_GLACIER    ] = false,
    [xi.zone.BUBURIMU_PENINSULA    ] = true,
    [xi.zone.CAPE_TERIGGAN         ] = false,
    [xi.zone.EASTERN_ALTEPA_DESERT ] = false,
    [xi.zone.JUGNER_FOREST         ] = false,
    [xi.zone.MERIPHATAUD_MOUNTAINS ] = false,
    [xi.zone.PASHHOW_MARSHLANDS    ] = false,
    [xi.zone.QUFIM_ISLAND          ] = false,
    [xi.zone.THE_SANCTUARY_OF_ZITAH] = false,
    [xi.zone.VALKURM_DUNES         ] = false,
    [xi.zone.XARCABARD             ] = false,
    [xi.zone.YHOATOR_JUNGLE        ] = false,
    [xi.zone.YUHTUNGA_JUNGLE       ] = false,
}

-----------------------------------
-- Data
-----------------------------------
-- Runtime state. One record per EF zone, built lazily on the first banner click.
-- If you modify this file during runtime, you must relaunch map as expForceZoneData is erased.
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

local mobFamilies = 
{
    DEMISAHAGIN = 0,
    GIGAS = 1,
    HALFORC = 2,
    HOBGOBLIN = 3,
    METAQUADAV = 4,
    NOCTONBERRY = 5,
    THEOYAGUDO = 6,
}


-----------------------------------
-- Tables
-----------------------------------

local levelTable =
{
    -- [zoneId] = level_cap
    [xi.zone.BEAUCEDINE_GLACIER    ] = 40,
    [xi.zone.BUBURIMU_PENINSULA    ] = 30,
    [xi.zone.CAPE_TERIGGAN         ] = 99, -- Uncapped
    [xi.zone.EASTERN_ALTEPA_DESERT ] = 50,
    [xi.zone.JUGNER_FOREST         ] = 30,
    [xi.zone.MERIPHATAUD_MOUNTAINS ] = 30,
    [xi.zone.PASHHOW_MARSHLANDS    ] = 30,
    [xi.zone.QUFIM_ISLAND          ] = 30,
    [xi.zone.THE_SANCTUARY_OF_ZITAH] = 40,
    [xi.zone.VALKURM_DUNES         ] = 30,
    [xi.zone.XARCABARD             ] = 50,
    [xi.zone.YHOATOR_JUNGLE        ] = 50,
    [xi.zone.YUHTUNGA_JUNGLE       ] = 40,
}

local bannerTable =
{
    [xi.zone.BEAUCEDINE_GLACIER] =
    {
        -- position = { x, y, z, rot }
        { position = {  193.614,   -0.307,  -35.663, 255 }, mobFamily = mobFamilies.GIGAS },     -- I-8
        { position = {   20.169,  -80.061,  180.063, 224 }, mobFamily = mobFamilies.GIGAS },     -- H-7
        { position = { -326.264,  -99.694,  140.523, 220 }, mobFamily = mobFamilies.GIGAS },     -- F-7
        { position = {  255.402,    0.072,  382.940, 110 }, mobFamily = mobFamilies.HOBGOBLIN }, -- J-6
        { position = { -173.299,  -81.847,  150.200, 246 }, mobFamily = mobFamilies.HOBGOBLIN }, -- G-7
    },

    [xi.zone.BUBURIMU_PENINSULA] =
    {
        { position = {  101.491,  -23.090,  199.798, 218 }, mobFamily = mobFamilies.HOBGOBLIN },
        { position = {  527.885,    0.486,  -40.241, 157 }, mobFamily = mobFamilies.HOBGOBLIN },
        { position = {  315.895,   -0.025,  361.453,  17 }, mobFamily = mobFamilies.THEOYAGUDO },
        { position = { -132.589,   20.000, -314.261, 230 }, mobFamily = mobFamilies.THEOYAGUDO },
        { position = { -446.510,   -8.799, -282.799, 240 }, mobFamily = mobFamilies.THEOYAGUDO },
    },

    [xi.zone.CAPE_TERIGGAN] =
    {
        { position = {  126.583,   -0.194, -117.367,  75 }, mobFamily = mobFamilies.HOBGOBLIN }, -- I-9
        { position = { -213.169,   -3.320,  254.085, 181 }, mobFamily = mobFamilies.HOBGOBLIN }, -- G-6
        { position = {  251.977,    5.241,   50.698, 128 }, mobFamily = mobFamilies.HOBGOBLIN }, -- J-8
        { position = {  -29.071,   -9.694,  224.300,  46 }, mobFamily = mobFamilies.HOBGOBLIN }, -- H-7
        { position = {  162.059,   -0.740,  250.538, 139 }, mobFamily = mobFamilies.HOBGOBLIN }, -- I-6
    },

    [xi.zone.EASTERN_ALTEPA_DESERT] =
    {
        {},
        {},
        {},
        {},
        {},
    },

    [xi.zone.JUGNER_FOREST] =
    {
        {},
        {},
        {},
        {},
        {},
    },

    [xi.zone.MERIPHATAUD_MOUNTAINS] =
    {
        { position = {  199.396,   -0.723, -527.072, 169 }, mobFamily = mobFamilies.HOBGOBLIN },  -- H-11
        { position = {  342.918,   -1.109,  529.219, 226 }, mobFamily = mobFamilies.HOBGOBLIN },  -- I-5
        { position = {  592.850,  -16.741, -518.802, 227 }, mobFamily = mobFamilies.THEOYAGUDO }, -- K-11
        { position = { -536.930,    4.317,  338.845, 200 }, mobFamily = mobFamilies.THEOYAGUDO }, -- D-6
        { position = { -559.025,  -16.761,   47.233,  72 }, mobFamily = mobFamilies.THEOYAGUDO }, -- D-8
    },

    [xi.zone.PASHHOW_MARSHLANDS] =
    {
        { position = { -172.764,   25.125,   93.640, 154 }, mobFamily = mobFamilies.HOBGOBLIN },  -- G-8
        { position = {  261.910,   24.213,  211.070,  85 }, mobFamily = mobFamilies.HOBGOBLIN },  -- J-7
        { position = {  140.080,   23.971, -411.951, 112 }, mobFamily = mobFamilies.METAQUADAV }, -- I-11
        { position = { -447.851,   24.305, -219.899, 113 }, mobFamily = mobFamilies.METAQUADAV }, -- E-10
        { position = { -460.959,   24.203,  469.851, 223 }, mobFamily = mobFamilies.METAQUADAV }, -- E-5
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
        { position = {  643.619,    0.842, -176.843, 128 }, mobFamily = mobFamilies.HOBGOBLIN }, -- L-10
        { position = {  174.336,   -1.015, -413.606,  59 }, mobFamily = mobFamilies.HOBGOBLIN }, -- I-11
        { position = { -512.058,   -0.975,  253.275,  37 }, mobFamily = mobFamilies.HOBGOBLIN }, -- E-7
        { position = {  429.298,    0.084, -604.489, 231 }, mobFamily = mobFamilies.HOBGOBLIN }, -- J-12
        { position = { -399.822,    0.162, -168.998, 174 }, mobFamily = mobFamilies.HOBGOBLIN }, -- E-10
    },

    [xi.zone.VALKURM_DUNES] =
    {
        { position = { -522.404,   -8.175,  113.667, 141 }, mobFamily = mobFamilies.HALFORC },
        { position = {  643.175,   -0.592,    8.854,  10 }, mobFamily = mobFamilies.HALFORC },
        { position = {  478.713,  -16.140,  365.873,  28 }, mobFamily = mobFamilies.HOBGOBLIN }, -- J-6
        { position = { -352.679,   -8.856,  327.661,  18 }, mobFamily = mobFamilies.METAQUADAV },
        { position = { -116.204,    4.000, -113.608, 160 }, mobFamily = mobFamilies.METAQUADAV },
    },

    [xi.zone.XARCABARD] =
    {
        { position = {   32.788,  -24.162, -205.200,   6 }, mobFamily = mobFamilies.GIGAS },     -- G-9
        { position = { -160.590,  -24.169,  -87.061, 174 }, mobFamily = mobFamilies.GIGAS },     -- F-8
        { position = {  153.000,  -36.438,   23.500,  16 }, mobFamily = mobFamilies.GIGAS },     -- H-7
        { position = {   47.461,  -36.500,   66.281, 201 }, mobFamily = mobFamilies.HOBGOBLIN }, -- G-7
        { position = {  320.399,   -8.190,  167.796,  52 }, mobFamily = mobFamilies.HOBGOBLIN }, -- I-6
    },

    [xi.zone.YHOATOR_JUNGLE] =
    {
        { position = {  -54.134,    0.344, -405.397, 199 }, mobFamily = mobFamilies.HOBGOBLIN },   -- H-10
        { position = { -196.704,    0.000, -149.953,  75 }, mobFamily = mobFamilies.HOBGOBLIN },   -- G-9
        { position = { -289.835,    0.000, -357.025,   5 }, mobFamily = mobFamilies.NOCTONBERRY }, -- F-10
        { position = {  366.014,   -0.176, -394.801,  96 }, mobFamily = mobFamilies.NOCTONBERRY }, -- J-10
        { position = { -176.760,    0.162,   26.774,  40 }, mobFamily = mobFamilies.NOCTONBERRY }, -- G-8
    },

    [xi.zone.YUHTUNGA_JUNGLE] =
    {
        { position = {  -63.927,   -0.042, -126.052, 153 }, mobFamily = mobFamilies.DEMISAHAGIN }, -- H-9
        { position = {  102.301,    0.600,  442.978,  17 }, mobFamily = mobFamilies.DEMISAHAGIN }, -- I-6
        { position = { -305.061,   16.186, -438.904, 132 }, mobFamily = mobFamilies.DEMISAHAGIN }, -- G-11
        { position = {  381.229,    3.908,  148.721, 115 }, mobFamily = mobFamilies.HOBGOBLIN },   -- K-8
        { position = { -647.367,    0.000,   42.053,  28 }, mobFamily = mobFamilies.HOBGOBLIN },   -- E-8
    },
}


-- Fill out by mob species.
local nmPoolTable =
{
    [xi.zone.BEAUCEDINE_GLACIER] =
    {

    },

    [xi.zone.BUBURIMU_PENINSULA] =
    {
        [mobFamilies.HOBGOBLIN] = 
        {
            zones[xi.zone.BUBURIMU_PENINSULA].mob.HOBGOBLIN_BEASTMASTER,
            zones[xi.zone.BUBURIMU_PENINSULA].mob.HOBGOBLIN_BLACK_MAGE,
            zones[xi.zone.BUBURIMU_PENINSULA].mob.HOBGOBLIN_DARK_KNIGHT,
            zones[xi.zone.BUBURIMU_PENINSULA].mob.HOBGOBLIN_RANGER,
            zones[xi.zone.BUBURIMU_PENINSULA].mob.HOBGOBLIN_RED_MAGE,
            zones[xi.zone.BUBURIMU_PENINSULA].mob.HOBGOBLIN_THIEF,
            zones[xi.zone.BUBURIMU_PENINSULA].mob.HOBGOBLIN_WARRIOR,
            zones[xi.zone.BUBURIMU_PENINSULA].mob.HOBGOBLIN_WHITE_MAGE,
        },

        [mobFamilies.THEOYAGUDO] = 
        {
            zones[xi.zone.BUBURIMU_PENINSULA].mob.THEOYAGUDO_BARD,
            zones[xi.zone.BUBURIMU_PENINSULA].mob.THEOYAGUDO_BLACK_MAGE,
            zones[xi.zone.BUBURIMU_PENINSULA].mob.THEOYAGUDO_MONK,
            zones[xi.zone.BUBURIMU_PENINSULA].mob.THEOYAGUDO_NINJA,
            zones[xi.zone.BUBURIMU_PENINSULA].mob.THEOYAGUDO_SAMURAI,
            zones[xi.zone.BUBURIMU_PENINSULA].mob.THEOYAGUDO_SUMMONER,
            zones[xi.zone.BUBURIMU_PENINSULA].mob.THEOYAGUDO_WHITE_MAGE,
        },
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
local function addLevelRestriction(player, levelCap)
    local cap = levelCap
    if levelCap == 99 then
        cap = xi.settings.main.MAX_LEVEL
    end

    player:addStatusEffect(xi.effect.LEVEL_RESTRICTION, {
        power    = cap,
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
        duration = 900,
        origin   = mob,
        flag     = xi.effectFlag.CONFRONTATION,
    })
end


-- Spawn 4 NMs at the banner
-- TODO: It appears mobs in older zones are at a random 0 - 360 from the banner. Newer zones use 0 - 180 equally spaced. Distance is from 2.5 - 7 yalms with preference towards 3 - 4 yalms.
-- TODO: It's possible that only certain mob groups spawn at specific banners. To capture this would take about 40+ hours.
local function spawnBattleNMs(player, banner, zoneData)
    local zoneId     = banner:getZoneID()
    local levelCap   = levelTable[zoneId]
    local bannerPool = bannerTable[zoneId]
    local bannerInfo = bannerPool[zoneData.bannerIndex]
    local mobFamily  = bannerInfo.mobFamily
    local zoneNMPool = nmPoolTable[zoneId]
    local nmPool     = zoneNMPool[mobFamily]

    local bannerPosition = bannerInfo.position
    local bx, by, bz     = bannerPosition[1], bannerPosition[2], bannerPosition[3]

    -- Create a new table with the pool shuffled
    local candidates = utils.shuffle(nmPool)

    for i = 1, 4 do
        local mobId = candidates[i]
        -- Catch case when pool has fewer than 4 mobs
        -- TODO: Remove this when feature is fully implemented
        if mobId == nil then
            break
        end

        -- Spawn is a normal distribution with a mean of 3.5 and standard deviation of 1.5.
        -- The spawn distance is also restricted to [2.0, 7.5]. This is based on 234 samples.
        local distance = utils.randomNormal(3.5, 1.5, 2.0, 7.5)

        -- Scatter around the banner in random direction.
        local angle = math.random() * 2 * math.pi                      -- 0 to 360 degrees
        local pos   = GetFurthestValidPosition(banner, distance, angle) -- Drops mob on valid ground and snaps closer if terrain blocks the distance.

        local mob = GetMobByID(mobId)

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
    end
end

-- CLEARED -> HIDDEN. This is called from a 60-second timer callback.
local function hideBanner(zoneId, banner)
    local zoneData = expForceZoneData[zoneId]

    -- Make the banner disappear
    banner:setStatus(xi.status.DISAPPEAR)

    -- Clean up data and set HIDDEN state
    zoneData.nms             = {}
    zoneData.gone            = {}
    zoneData.creditNation    = nil
    zoneData.state           = bannerState.HIDDEN

    -- Respawn the banner
    banner:timer(5 * 60 * 1000, function(npcArg)
        xi.expeditionaryForce.initZone(npcArg:getZone())
    end)
end

-- Safety check every 30s while banner is active. Catches the case where a DESPAWN listener misses.
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

    -- None are present but we never entered
    if not anyPresent then
        zoneData.state = bannerState.CLEARED

        -- The banner will disappear after 60 seconds.
        npc:timer(60 * 1000, function(npcArg)
            hideBanner(npcArg:getZoneID(), npcArg)
        end)

    -- Check again in 30 seconds
    else
        npc:timer(30 * 1000, function(npcArg)
            watchDog(npcArg)
        end)
    end
end

-- Log EF participation for a region by setting its bit.
local function recordParticipation(player, regionId)
    local participation = player:getCharVar('[ExpForce]Participation')
    player:setCharVar('[ExpForce]Participation', bit.bor(participation, bit.lshift(1, regionId)))
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
    if zoneData == nil then
        zoneData =
        {
            state        = bannerState.IDLE,
            nms          = {},
            gone         = {},
            creditNation = nil,
            bannerIndex  = nil,
        }
        expForceZoneData[zoneId] = zoneData
    end

    -- Set the banner to a random position and set the status to normal
    local banner           = GetNPCByID(ID.npc.BEASTMENS_BANNER)
    local bannerOptions    = bannerTable[zoneId]
    local lastBannerIndex  = zoneData.bannerIndex
    local newBannerIndex

    -- When the zone loads, there are no previous positions so we can pick from any of the available options.
    if lastBannerIndex == nil then
        newBannerIndex = math.random(#bannerOptions)
    
    -- We will just roll 1 less number. If we happen to land on the last index, we just select the last value in the position table.
    -- Note: If you only have one banner position, this will break! This should never happen as all zones have more than 1 position.
    else
        newBannerIndex = math.random(#bannerOptions - 1)
        if newBannerIndex == lastBannerIndex then
            newBannerIndex = #bannerOptions
        end
    end

    local pos = bannerOptions[newBannerIndex].position
    banner:setPos(pos[1], pos[2], pos[3], pos[4])
    banner:setStatus(xi.status.NORMAL) -- forces visible even if the SQL ships hidden

    -- Store the position index for later to make sure the banner does not spawn in the same place twice
    zoneData.bannerIndex = newBannerIndex

    -- Reset to IDLE on respawn
    zoneData.state = bannerState.IDLE
end


xi.expeditionaryForce.onBannerTrigger = function(player, npc)
    local zoneId   = npc:getZoneID()
    local ID       = zones[zoneId]
    local zoneData = expForceZoneData[zoneId]


    -- Handle all states of the Beastmen's Banner
    -- The flow of Expeditionary Force goes from IDLE to ACTIVE to CLEARED to HIDDEN then back to IDLE
    -- IDLE
    if zoneData.state == bannerState.IDLE then
        local region = npc:getCurrentRegion()

        -- Find out if an alliance member in the zone has level sync already
        local allianceMemberCapped = false
        for _, member in pairs(player:getAlliance()) do
            if member:getZoneID() == zoneId and member:hasStatusEffect(xi.effect.LEVEL_RESTRICTION) then
                allianceMemberCapped = true
                break -- No need to keep checking
            end
        end

        -- If the player does have the regions insignia (only gate)
        if
            player:hasKeyItem(regionKITable[region]) and
            not allianceMemberCapped
        then
            -- Credit nation is based on the player who clicked the banner
            zoneData.creditNation    = player:getNation()
            zoneData.nms             = {}
            zoneData.gone            = {}

            -- Level cap every alliance member in zone
            -- Get members in-range
            for _, member in pairs(player:getAlliance()) do
                if member:getZoneID() == zoneId then
                    -- Add level restriction if in zone
                    addLevelRestriction(member, levelTable[zoneId])

                    -- Display banner message
                    member:messageSpecial(ID.text.BEASTMEN_BANNER_CURSE) -- There was a curse on the beastmen's banner!
                end
            end

            -- Spawn 4 NMs at the banner
            spawnBattleNMs(player, npc, zoneData)
            zoneData.state = bannerState.ACTIVE

            -- Launch Watch Dog function: this will catch if an NM's despawn doesn't trigger.
            watchDog(npc)

        -- If the player does not have the regions insignia, just send a message.
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

        -- AWARD INFLUENCE
        -- https://bluebell.exblog.jp/1747138/ - Suggests 900 points
        AddConquestInfluence(900, creditNation, mob:getCurrentRegion()) -- TODO: verify influence amount

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
    if player:checkDistance(mob) <= 50 then -- TODO: Check distance
        -- Award all alliance members title
        player:addTitle(xi.title.EXPEDITIONARY_TROOPER)

        -- Mark all alliance members participating in Expeditionary Force with participation
        local regionId = mob:getCurrentRegion()
        if player:hasKeyItem(regionKITable[regionId]) then
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

-- Mark a mob as despawned. When all NMs are accounted for, transition to CLEARED.
xi.expeditionaryForce.onMobDespawn = function(mob)
    local zoneId   = mob:getZoneID()
    local zoneData = expForceZoneData[zoneId]

    -- Add the mob to the gone list
    zoneData.gone[mob:getID()] = true

    local goneCount = 0
    for _ in pairs(zoneData.gone) do
        goneCount = goneCount + 1
    end

    -- Figure out if number of mobs gone equials the number spawned
    -- Battle is cleared
    if goneCount >= #zoneData.nms then
        zoneData.state = bannerState.CLEARED

        -- The banner will disappear after 60 seconds.
        local ID     = zones[zoneId]
        local banner = GetNPCByID(ID.npc.BEASTMENS_BANNER)
        banner:timer(60 * 1000, function(npcArg)
            hideBanner(npcArg:getZoneID(), npcArg)
        end)
    end
end



-- Award influence for opening a chest/coffer with the region's insignia.
-- Caller checks the insignia and resolves the regionId.
-- TODO: Real formula. Placeholder constant.
-- TODO: Wire to player:gainInfluencePoints once binding lands.
xi.expeditionaryForce.onChestOpen = function(player)
    local regionId = player:getCurrentRegion()
    local insignia = regionKITable[regionId]

    -- Only give influence if this is a EF region and the player has the KI
    if
        insignia ~= nil and
        player:hasKeyItem(insignia)
    then
        
        -- Influence gained ranges from about 2.5 % - 0.5 % per chest
        -- Since LSB uses linear scale, give about 1 % influence each chest
        -- 1 % influence is equvalent to 667 xp in unowned region.

        -- Leveled from 7 - 34 and got about a 1 % swing. Opened a coffer and got a 2 % swing.
        -- TODO: Modify to scaling in the future
        -- TODO: Have them gain 50 influence
        
        -- Display message
        -- TODO: Get Zone ID
        -- TODO: Add messages to zone

        recordParticipation(player, regionId)
    end
end