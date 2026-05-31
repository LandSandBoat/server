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

local posBannerTable =
{
    [xi.zone.BEAUCEDINE_GLACIER] =
    {
        -- { x, y, z, rot }
        {},
        {},
        {},
        {},
        {},
    },

    [xi.zone.BUBURIMU_PENINSULA] =
    {
        {  315.895,  361.453,  -0.025,  17 },
        {  527.885,  -40.241,   0.486, 157 },
        { -132.589, -314.261,  20.000, 230 },
        { -446.510, -282.799,  -8.799, 240 },
        {  101.491,  199.798, -23.090, 218 },
    },

    [xi.zone.CAPE_TERIGGAN] =
    {
        {},
        {},
        {},
        {},
        {},
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
        {},
        {},
        {},
        {},
        {},
    },

    [xi.zone.PASHHOW_MARSHLANDS] =
    {
        {},
        {},
        {},
        {},
        {},
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
        {},
        {},
        {},
        {},
        {},
    },

    [xi.zone.VALKURM_DUNES] =
    {
        {},
        {},
        {},
        {},
        {},
    },

    [xi.zone.XARCABARD] =
    {
        {},
        {},
        {},
        {},
        {},
    },

    [xi.zone.YHOATOR_JUNGLE] =
    {
        {},
        {},
        {},
        {},
        {},
    },

    [xi.zone.YUHTUNGA_JUNGLE] =
    {
        {},
        {},
        {},
        {},
        {},
    },
}

-- CP awarded on collection, by count of participated regions the nation controls. Tiers 1-8 based on Wiki.
-- The data appears to follow a cubic, but then 13 would be 27,175 CP. This seems abnormal.
-- TODO: Update 9-13. Wiki only holds information up to 8 regions. Though, I do question the validity of 8.
local cpRewardTable =
{
    -- [regionsControlled] = cp
    [0]  = 0,
    [1]  = 3000,
    [2]  = 4200,
    [3]  = 4800,
    [4]  = 5160,
    [5]  = 5430,
    [6]  = 5700,
    [7]  = 6105,
    [8]  = 7320,
    [9]  = 7320,
    [10] = 7320,
    [11] = 7320,
    [12] = 7320,
    [13] = 7320,
}


-- Fill out by mob species.
local nmPoolTable =
{
    [xi.zone.BEAUCEDINE_GLACIER] =
    {

    },

    [xi.zone.BUBURIMU_PENINSULA] =
    {
        { -- Hobgoblin
            zones[xi.zone.BUBURIMU_PENINSULA].mob.HOBGOBLIN_BEASTMASTER,
            zones[xi.zone.BUBURIMU_PENINSULA].mob.HOBGOBLIN_BLACK_MAGE,
            zones[xi.zone.BUBURIMU_PENINSULA].mob.HOBGOBLIN_DARK_KNIGHT,
            zones[xi.zone.BUBURIMU_PENINSULA].mob.HOBGOBLIN_RANGER,
            zones[xi.zone.BUBURIMU_PENINSULA].mob.HOBGOBLIN_RED_MAGE,
            zones[xi.zone.BUBURIMU_PENINSULA].mob.HOBGOBLIN_THIEF,
            zones[xi.zone.BUBURIMU_PENINSULA].mob.HOBGOBLIN_WARRIOR,
            zones[xi.zone.BUBURIMU_PENINSULA].mob.HOBGOBLIN_WHITE_MAGE,
        },

        { -- Theoyaguda
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

-- CLEARED -> HIDDEN. This is called from a 30-second timer callback.
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

        -- The banner will disappear after 30 seconds.
        npc:timer(30 * 1000, function(npcArg)
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

xi.expeditionaryForce.initZone = function(zone)
    local zoneId = zone:getID()
    local ID     = zones[zoneId]

    -- Set the banner to a random position and set the status to normal
    local banner = GetNPCByID(ID.npc.BEASTMENS_BANNER)
    local pos = posBannerTable[zoneId][math.random(#posBannerTable[zoneId])] -- TODO: when table is filled out, this can just be 5
    banner:setPos(pos[1], pos[2], pos[3], pos[4])
    banner:setStatus(xi.status.NORMAL) -- forces visible even if the SQL ships hidden

    -- Reset to IDLE on respawn
    local zoneData = expForceZoneData[zoneId]
    if zoneData ~= nil then
        zoneData.state = bannerState.IDLE
    end
end


xi.expeditionaryForce.onBannerTrigger = function(player, npc)
    local zoneId   = npc:getZoneID()
    local ID       = zones[zoneId]

    -- Get data for the zone
    local zoneData = expForceZoneData[zoneId]

    -- Data does not exist yet
    if zoneData == nil then
        zoneData =
        {
            state           = bannerState.IDLE,
            nms             = {},
            gone            = {},
            creditNation    = nil,
            chainCount      = 0,
            lastKillTime    = 0,
        }
        expForceZoneData[zoneId] = zoneData
    end

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


-- Called from mob lua files
xi.expeditionaryForce.onMobDeath = function(mob, player)
    local zoneId   = mob:getZoneID()
    local ID       = zones[zoneId]
    local zoneData = expForceZoneData[zoneId]

    -- AWARD INFLUENCE
    -- Check for a chain
    local now = GetSystemTime()

    -- Increment chain
    if now - zoneData.lastKillTime <= 900 then -- Chain timeout in seconds TODO: Verify time
        zoneData.chainCount = zoneData.chainCount + 1

    -- Reset chain
    else
        zoneData.chainCount = 1
    end

    -- Set timer for next chain count
    zoneData.lastKillTime = now

    -- Give influence
    -- TODO: IMPLEMENT

    -- AWARD TITLES AND MESSAGES
    local region = mob:getCurrentRegion()
    for _, member in pairs(player:getAlliance()) do
        local memberNation = member:getNation()

        -- Only apply to the alliance members within 50 yalms
        if member:checkDistance(mob) <= 50 then

            -- Only give title to a member with the KI and in the correct nation
            -- TODO: Verify you have to have the KI
            if 
                memberNation == zoneData.creditNation and
                member:hasKeyItem(regionKITable[region])
            then
                member:setTitle(xi.title.EXPEDITIONARY_TROOPER)
            end

            -- Send messages to everyone in the alliance within the 50 yalm distance
            -- TODO: Check if the message goes to just alliance or everyone
            if memberNation == xi.nation.SANDORIA then
                member:messageText(member, ID.text.EXP_FORCE_KILL_SANDORIA, 5) -- 5 = Grey: messageText event
                member:messageSpecial(ID.text.REGION_POINTS_SANDORIA) -- showText event

            elseif memberNation == xi.nation.BASTOK then
                member:messageText(member, ID.text.EXP_FORCE_KILL_BASTOK, 5) -- 5 = Grey: messageText event
                member:messageSpecial(ID.text.REGION_POINTS_BASTOK) -- showText event

            elseif memberNation == xi.nation.WINDURST then
                member:messageText(member, ID.text.EXP_FORCE_KILL_WINDURST, 5) -- 5 = Grey: messageText event
                member:messageSpecial(ID.text.REGION_POINTS_WINDURST) -- showText event
            end
        end
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

        -- The banner will disappear after 30 seconds.
        local ID     = zones[zoneId]
        local banner = GetNPCByID(ID.npc.BEASTMENS_BANNER)
        banner:timer(30 * 1000, function(npcArg)
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