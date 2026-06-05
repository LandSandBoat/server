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
        -- { x, y, z, rot }
        { position = {  193.614, -35.663,  -0.307, 255 }, mobFamily = mobFamilies.GIGAS }, -- I-8 (Gigas)
        {   20.169, 180.063, -80.061, 224 }, -- H-7 (Gigas)
        { -326.264, 140.523, -99.694, 220 }, -- F-7 (Gigas)
        {  255.402, 382.940,   0.072, 110 }, -- J-6 (Hobgoblin)
        { -173.299, 150.200, -81.847, 246 }, -- G-7 (Hobgoblin)
    },

    [xi.zone.BUBURIMU_PENINSULA] =
    {
        {  101.491,  199.798, -23.090, 218 }, -- (Hobgoblin)
        {  527.885,  -40.241,   0.486, 157 }, -- (Hobgoblin)
        {  315.895,  361.453,  -0.025,  17 }, -- (Theoyagudo)
        { -132.589, -314.261,  20.000, 230 }, -- (Theoyagudo)
        { -446.510, -282.799,  -8.799, 240 }, -- (Theoyagudo)

    },

    [xi.zone.CAPE_TERIGGAN] =
    {
        {  126.583, -117.367, -0.194,  75 }, -- I-9 (Hobgoblin)
        { -213.169,  254.085, -3.320, 181 }, -- G-6 (Hobgoblin)
        {  251.977,   50.698,  5.241, 128 }, -- J-8 (Hobgoblin)
        {  -29.071,  224.300, -9.694,  46 }, -- H-7 (Hobgoblin)
        {  162.059,  250.538, -0.740, 139 }, -- I-6 (Hobgoblin)
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
        {  199.396, -527.072,  -0.723, 169 }, -- H-11 (Hobgoblin)
        {  342.918,  529.219,  -1.109, 226 }, -- I-5  (Hobgoblin)
        {  592.850, -518.802, -16.741, 227 }, -- K-11 (Theoyagudo)
        { -536.930,  338.845,   4.317, 200 }, -- D-6  (Theoyagudo)
        { -559.025,   47.233, -16.761,  72 }, -- D-8  (Theoyagudo)
    },

    [xi.zone.PASHHOW_MARSHLANDS] =
    {
        { -172.764,   93.640, 25.125, 154 }, -- G-8  (Hobgoblin)
        {  261.910,  211.070, 24.213,  85 }, -- J-7  (Hobgoblin)
        {  140.080, -411.951, 23.971, 112 }, -- I-11 (Metaquadav)
        { -447.851, -219.899, 24.305, 113 }, -- E-10 (Metaquadav)
        { -460.959,  469.851, 24.203, 223 }, -- E-5  (Metaquadav)
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
        {  643.619, -176.843,  0.842, 128 }, -- L-10 (Hobgoblin)
        {  174.336, -413.606, -1.015,  59 }, -- I-11 (Hobgoblin)
        { -512.058,  253.275, -0.975,  37 }, -- E-7  (Hobgoblin)
        {  429.298, -604.489,  0.084, 231 }, -- J-12 (Hobgoblin)
        { -399.822, -168.998,  0.162, 174 }, -- E-10 (Hobgoblin)
    },

    [xi.zone.VALKURM_DUNES] =
    {
        { -522.404,  113.667,  -8.175, 141 }, --     (Halforc)
        {  643.175,    8.854,  -0.592,  10 }, --     (Halforc)
        {  478.713,  365.873, -16.140,  28 }, -- J-6 (Hobgoblin)
        { -352.679,  327.661,  -8.856,  18 }, --     (Metaquadav)
        { -116.204, -113.608,   4.000, 160 }, --     (Metaquadav)
    },

    [xi.zone.XARCABARD] =
    {
        {   32.788, -205.200, -24.162,   6 }, -- G-9 (Gigas)
        { -160.590,  -87.061, -24.169, 174 }, -- F-8 (Gigas)
        {  153.000,   23.500, -36.438,  16 }, -- H-7 (Gigas)
        {   47.461,   66.281, -36.500, 201 }, -- G-7 (Hobgoblin)
        {  320.399,  167.796,  -8.190,  52 }, -- I-6 (Hobgoblin)
    },

    [xi.zone.YHOATOR_JUNGLE] =
    {

        {  -54.134, -405.397,  0.344, 199 }, -- H-10 (Hobgoblin)
        { -196.704, -149.953,  0.000,  75 }, -- G-9  (Hobgoblin)
        { -289.835, -357.025,  0.000,   5 }, -- F-10 (Noctonberry)
        {  366.014, -394.801, -0.176,  96 }, -- J-10 (Noctonberry)
        { -176.760,   26.774,  0.162,  40 }, -- G-8  (Noctonberry)
    },

    [xi.zone.YUHTUNGA_JUNGLE] =
    {
        {  -63.927, -126.052, -0.042, 153 }, -- H-9  (Demisahagin)
        {  102.301,  442.978,  0.600,  17 }, -- I-6  (Demisahagin)
        { -305.061, -438.904, 16.186, 132 }, -- G-11 (Demisahagin)
        {  381.229,  148.721,  3.908, 115 }, -- K-8  (Hobgoblin)
        { -647.367,   42.053,  0.000,  28 }, -- E-8  (Hobgoblin)
    },
}

-- CP awarded on collection, by count of participated regions the nation controls. 
-- When looking at the wiki, the data appears to follow a cubic. Extrapolating that would put 13 to be 27,175 CP.
-- Instead the data from https://ffxiclopedia.fandom.com/wiki/Talk:Expeditionary_Force is used as it is more conservative.
local cpRewardTable =
{
    -- [regionsControlled] = cp
    [0]  = 0,
    [1]  = 3000,
    [2]  = 4200,
    [3]  = 4680, -- +480 per region
    [4]  = 5160,
    [5]  = 5640,
    [6]  = 6120,
    [7]  = 6600,
    [8]  = 7080,
    [9]  = 7560,
    [10] = 8040,
    [11] = 8520,
    [12] = 9000,
    [13] = 9480,
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
    local zoneId   = banner:getZoneID()
    local levelCap = levelTable[zoneId]
    local pool     = nmPoolTable[zoneId]
    local family   = pool[math.random(#pool)]
    local offsets  = { { 2, 0 }, { -2, 0 }, { 0, 2 }, { 0, -2 } }

    local candidates = {}
    for _, mobId in ipairs(family) do
        table.insert(candidates, mobId)
    end

    local bx, by, bz = banner:getXPos(), banner:getYPos(), banner:getZPos()
    local brot       = banner:getRotPos()

    for i = 1, 4 do
        if #candidates == 0 then
            break
        end

        local pick  = math.random(#candidates)
        local mobId = candidates[pick]
        table.remove(candidates, pick)

        local mob = SpawnMob(mobId)
        if mob ~= nil then
            local off = offsets[i]
            mob:setSpawn(bx + off[1], by, bz + off[2], brot)
            mob:setPos(bx + off[1], by, bz + off[2], brot)
            addConfrontationGate(mob, levelCap)
            mob:updateClaim(player)
            table.insert(zoneData.nms, mobId)
        end
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

local function recordParticipation(player, regionId)
    -- TODO: IMPLEMENT
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
            state              = bannerState.IDLE,
            nms                = {},
            gone               = {},
            creditNation       = nil,
            lastBannerPosIndex = nil,
        }
        expForceZoneData[zoneId] = zoneData
    end

    -- Set the banner to a random position and set the status to normal
    local banner       = GetNPCByID(ID.npc.BEASTMENS_BANNER)
    local positions    = posBannerTable[zoneId]
    local lastPosIndex = zoneData.lastBannerPosIndex
    local posIndex

    -- When the zone loads, there are no previous positions so we can pick from any of the available options.
    if lastPosIndex == nil then
        posIndex = math.random(#positions)
    
    -- We will just roll 1 less number. If we happen to land on the last index, we just select the last value in the position table.
    -- Note: If you only have one banner position, this will break! This should never happen as all zones have more than 1 position.
    else
        posIndex = math.random(#positions - 1)
        if posIndex == lastPosIndex then
            posIndex = #positions
        end
    end

    local pos = positions[posIndex]
    banner:setPos(pos[1], pos[2], pos[3], pos[4])
    banner:setStatus(xi.status.NORMAL) -- forces visible even if the SQL ships hidden

    -- Store the position index for later to make sure the banner does not spawn in the same place twice
    zoneData.lastBannerPosIndex = posIndex

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

    -- AWARD TITLE
    -- Give title to everyone in the alliance regardless of nation or KI
    if player:checkDistance(mob) <= 50 then -- TODO: Check distance
        player:addTitle(xi.title.EXPEDITIONARY_TROOPER)
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
        insignia ~= nil or
        not player:hasKeyItem(insignia)
    then
        
        -- Influence gained ranges from about 2.5 % - 0.5 % per chest
        -- Since LSB uses linear scale, give about 1 % influence each chest
        -- 1 % influence is equvalent to 667 xp in unowned region.
        -- TODO: Modify to scaling in the future
        -- TODO: Have them gain 50 influence
        
        -- Display message
        -- TODO: Get Zone ID
        -- TODO: Add messages to zone

        recordParticipation(player, regionId)
    end
end