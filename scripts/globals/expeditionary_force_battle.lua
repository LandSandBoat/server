-----------------------------------
-- Expeditionary Force - In-zone battle
-----------------------------------
require('scripts/globals/expeditionary_force_data')
-----------------------------------
xi = xi or {}
xi.expeditionaryForce = xi.expeditionaryForce or {}

xi.expeditionaryForce.bannerState = { IDLE = 0, ACTIVE = 1, CLEARED = 2, HIDDEN = 3 }

-- Runtime state. One record per EF zone, built lazily on the first banner click.
-- If you modify this file during runtime, you must relaunch map as zoneData is erased.
xi.expeditionaryForce.zoneData = {}

-- TODO: XP uses the capped level. Update level_restriction to take a flag that skips the m_mlvl override for XP, so capped players earn at their real level.
-- Apply the EF level restriction to one player.
-- ON_ZONE makes it wear when the player zones out.
-- CONFRONTATION hard-gates the NMs to capped players.
local function addLevelRestriction(player, levelCap)
    local cap = levelCap
    if levelCap == 99 then
        cap = xi.settings.main.MAX_LEVEL
    end

    local config = xi.expeditionaryForce.config
    local flags = 0
    if config.capWearsOnZone then
        flags = flags + xi.effectFlag.ON_ZONE
    end

    if config.capUsesConfrontation then
        flags = flags + xi.effectFlag.CONFRONTATION
    end

    player:addStatusEffect(xi.effect.LEVEL_RESTRICTION,
        { power = cap, duration = config.capLingerTime, origin = player, flag = flags })
end

-- Add the CONFRONTATION to the NMs. The level restriction already won't apply to mobs. I just need the CONFRONTATION flag and matching power.
local function addConfrontationGate(mob, levelCap)
    if not xi.expeditionaryForce.config.capUsesConfrontation then
        return
    end

    local cap = levelCap
    if levelCap == 99 then
        cap = xi.settings.main.MAX_LEVEL
    end

    mob:addStatusEffect(xi.effect.LEVEL_RESTRICTION,
        { power = cap, duration = xi.expeditionaryForce.config.capLingerTime,
          origin = mob, flag = xi.effectFlag.CONFRONTATION })
end

-- Pick up to 4 mob ids from a pool.
local function pickFour(pool)
    local family = pool[math.random(#pool)]

    local pickFrom = {}
    for i, id in ipairs(family) do
        pickFrom[i] = id
    end

    local result = {}
    for _ = 1, 4 do
        if #pickFrom == 0 then
            break
        end
        local idx = math.random(#pickFrom)
        table.insert(result, pickFrom[idx])
        table.remove(pickFrom, idx)
    end

    return result
end

-- Look up the EF region whose zone this banner sits in. nil if none / region disabled.
local function regionFromZoneId(zoneId)
    for regionId, region in pairs(xi.expeditionaryForce.regions) do
        if region.enabled and region.zoneId == zoneId then
            return regionId
        end
    end

    return nil
end

-- Get the static banner NPC in a zone.
local function getBannerNpc(zoneId)
    local zone = GetZone(zoneId)
    if zone == nil then
        return nil
    end

    local banners = zone:queryEntitiesByName('Beastmens_Banner')
    return banners and banners[1] or nil
end

-- Mark a mob as despawned. When all NMs are accounted for, transition to CLEARED.
local function markMobGone(zoneId, mobId)
    local zoneData = xi.expeditionaryForce.zoneData[zoneId]
    if zoneData == nil or zoneData.state ~= xi.expeditionaryForce.bannerState.ACTIVE then
        return
    end

    if zoneData.gone[mobId] then
        return
    end

    zoneData.gone[mobId] = true

    local goneCount = 0
    for _ in pairs(zoneData.gone) do
        goneCount = goneCount + 1
    end

    if goneCount < #zoneData.nms then
        return
    end

    local npc = getBannerNpc(zoneId)
    if npc ~= nil then
        xi.expeditionaryForce.onBattleCleared(npc, zoneData)
    end
end

-- Called from server.lua at server start. Enable the banner.
xi.expeditionaryForce.onServerStart = function()
    for regionId, region in pairs(xi.expeditionaryForce.regions) do
        if region.zoneId ~= nil then
            local zone = GetZone(region.zoneId)
            if zone ~= nil then
                local banners = zone:queryEntitiesByName('Beastmens_Banner')
                local banner  = banners and banners[1] or nil
                if banner == nil then
                    printf('[ExpeditionaryForce] No Beastmens_Banner NPC in zone %d.', region.zoneId)
                elseif xi.expeditionaryForce.isRegionActive(regionId) then
                    local pos = region.bannerSpawns[math.random(#region.bannerSpawns)]
                    banner:setPos(pos[1], pos[2], pos[3], pos[4])
                    banner:setStatus(xi.status.NORMAL) -- forces visible even if the SQL ships hidden
                else
                    banner:setStatus(xi.status.DISAPPEAR)
                end
            end
        end
    end
end

-- Banner click. Called from each EF zone's per-NPC Beastmens_Banner.lua script.
xi.expeditionaryForce.onBannerTrigger = function(player, npc)
    if not xi.expeditionaryForce.enabled then
        return
    end

    local zoneId   = npc:getZoneID()
    local zoneData = xi.expeditionaryForce.zoneData[zoneId]

    if zoneData == nil then
        local regionId = regionFromZoneId(zoneId)
        if regionId == nil then
            return
        end

        -- House each instance in the zone data.
        zoneData =
        {
            state           = xi.expeditionaryForce.bannerState.IDLE,
            regionId        = regionId,
            nms             = {},
            gone            = {},
            creditNation    = nil,
            creditedPlayers = {},
            chainCount      = 0,
            lastKillTime    = 0,
        }
        xi.expeditionaryForce.zoneData[zoneId] = zoneData
    end

    local state  = xi.expeditionaryForce.bannerState
    local region = xi.expeditionaryForce.regions[zoneData.regionId]

    if zoneData.state == state.IDLE then
        -- IDLE: needs the region's insignia. No other requirements.
        if not player:hasKeyItem(region.insignia) then
            player:messageSpecial(zones[zoneId].text.BEASTMEN_BANNER)
            return
        end

        xi.expeditionaryForce.startBattle(player, npc, zoneData)
    elseif zoneData.state == state.ACTIVE then
        -- ACTIVE: anyone can click to get the level restriction. No KI required.
        xi.expeditionaryForce.applyLevelRestriction(player, region)
    elseif zoneData.state == state.CLEARED then
        -- CLEARED: click removes the clicker's level cap.
        player:delStatusEffect(xi.effect.LEVEL_RESTRICTION)
    end
    -- HIDDEN: banner is invisible / not clickable.
end

-- Apply the level restriction to a single player if they do not already have it.
xi.expeditionaryForce.applyLevelRestriction = function(player, region)
    if not player:hasStatusEffect(xi.effect.LEVEL_RESTRICTION) then
        addLevelRestriction(player, region.levelCap)
    end
end

-- Award influence for one EF NM kill. Chains per zone.
-- TODO: Real formula. Placeholder is base * chain.
-- TODO: Wire to player:gainInfluencePoints once binding lands.
xi.expeditionaryForce.awardKillInfluence = function(killer, mob, region, zoneData)
    local config = xi.expeditionaryForce.config
    local now    = GetSystemTime()

    -- Check for a chain
    if now - zoneData.lastKillTime <= config.chainTimeout then
        -- Increment chain
        zoneData.chainCount = zoneData.chainCount + 1
    else
        -- Reset chain
        zoneData.chainCount = 1
    end

    -- Set timer for next chain check
    zoneData.lastKillTime = now

    -- Assuming linear. TODO: Figure out actual formula.
    local amount = config.baseKillInfluence * zoneData.chainCount
    printf('[ExpeditionaryForce] would award %d influence to nation %d (zone %d, chain %d)',
        amount, zoneData.creditNation or -1, mob:getZoneID(), zoneData.chainCount)

    -- TODO: Give influence
end

-- Award influence for opening a chest/coffer with the region's insignia.
-- Caller checks the insignia and resolves the regionId.
-- TODO: Real formula. Placeholder constant.
-- TODO: Wire to player:gainInfluencePoints once binding lands.
xi.expeditionaryForce.awardChestInfluence = function(player, regionId)
    local amount = xi.expeditionaryForce.config.baseChestInfluence
    printf('[ExpeditionaryForce] would award %d chest influence to %s (nation %d, region %d)',
        amount, player:getName(), player:getNation(), regionId)

    -- TODO: Give influence
end

-- Grant Expeditionary Trooper title to credited players still in the zone.
-- Credited players who zoned out are skipped.
xi.expeditionaryForce.awardCreditedTitles = function(zoneData, zoneId)
    for playerId in pairs(zoneData.creditedPlayers) do
        local p = GetPlayerByID(playerId)
        if p ~= nil and p:getZoneID() == zoneId then
            p:setTitle(xi.title.EXPEDITIONARY_TROOPER)
        end
    end
end

-- Validate and start a battle.
xi.expeditionaryForce.startBattle = function(player, npc, zoneData)
    local region = xi.expeditionaryForce.regions[zoneData.regionId]
    local config = xi.expeditionaryForce.config

    -- Cannot start while anyone in the clicker's party is still level-capped.
    for _, member in pairs(player:getParty()) do
        if member:hasStatusEffect(xi.effect.LEVEL_RESTRICTION) then
            return
        end
    end

    -- nmPool must be populated. 
    -- TODO: Remove this once we finish the entire nmPool
    if region.nmPool == nil or #region.nmPool == 0 then
        printf('[ExpeditionaryForce] nmPool empty for region %d; cannot start.', zoneData.regionId)
        return
    end

    -- Credit nation is based on the player who clicked the flag
    zoneData.creditNation    = player:getNation()
    zoneData.creditedPlayers = {}
    zoneData.nms             = {}
    zoneData.gone            = {}

    -- Cap every party member in the zone.
    -- Get in-range members for credit.
    for _, member in pairs(player:getParty()) do
        if member:getZoneID() == player:getZoneID() then
            addLevelRestriction(member, region.levelCap)
            if member:checkDistance(npc) <= config.creditRange then
                zoneData.creditedPlayers[member:getID()] = true
            end
        end
    end

    -- Spawn 4 NMs at the banner. Default mob AI handles deaggro/despawn.
    local zone       = npc:getZone()
    local bx, by, bz = npc:getXPos(), npc:getYPos(), npc:getZPos()
    local brot       = npc:getRotPos()
    local offsets    = { { 2, 0 }, { -2, 0 }, { 0, 2 }, { 0, -2 } }
    local spawnIndex = 1
    for _, mobName in ipairs(pickFour(region.nmPool)) do
        local entities = zone:queryEntitiesByName(mobName)
        local entity   = entities[1]
        if entity == nil then
            printf('[ExpeditionaryForce] No entity "%s" in zone %d; skipping.', mobName, zone:getID())
        else
            local mobId = entity:getID()
            local mob   = SpawnMob(mobId)

            if mob ~= nil then
                local off = offsets[spawnIndex] or { 0, 0 }
                mob:setSpawn(bx + off[1], by, bz + off[2], brot)
                mob:setPos(bx + off[1], by, bz + off[2], brot)
                addConfrontationGate(mob, region.levelCap)
                mob:updateClaim(player)
                spawnIndex = spawnIndex + 1
                table.insert(zoneData.nms, mobId)

                mob:addListener('DEATH', 'EF_NM_DEATH', function(mobArg, killerArg)
                    mobArg:removeListener('EF_NM_DEATH')
                    local zd = xi.expeditionaryForce.zoneData[mobArg:getZoneID()]
                    if zd == nil then
                        return
                    end
                    xi.expeditionaryForce.awardKillInfluence(killerArg, mobArg, region, zd)
                    xi.expeditionaryForce.awardCreditedTitles(zd, mobArg:getZoneID())
                end)

                mob:addListener('DESPAWN', 'EF_NM_DESPAWN', function(mobArg)
                    mobArg:removeListener('EF_NM_DESPAWN')
                    markMobGone(mobArg:getZoneID(), mobArg:getID())
                end)
            end
        end
    end

    -- Abort if nothing actually spawned.
    if #zoneData.nms == 0 then
        printf('[ExpeditionaryForce] No NMs spawned for region %d; aborting battle.', zoneData.regionId)
        for _, member in pairs(player:getParty()) do
            if member:getZoneID() == player:getZoneID() then
                member:delStatusEffect(xi.effect.LEVEL_RESTRICTION)
            end
        end

        return
    end

    zoneData.state = xi.expeditionaryForce.bannerState.ACTIVE
    xi.expeditionaryForce.watchDog(npc)
end

-- Safety check every 30s while banner is active. Catches the case where a DESPAWN listener misses.
xi.expeditionaryForce.watchDog = function(npc)
    local zoneData = xi.expeditionaryForce.zoneData[npc:getZoneID()]
    if zoneData == nil or zoneData.state ~= xi.expeditionaryForce.bannerState.ACTIVE then
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

    if not anyPresent then
        xi.expeditionaryForce.onBattleCleared(npc, zoneData)
        return
    end

    npc:timer(30000, function(npcArg)
        xi.expeditionaryForce.watchDog(npcArg)
    end)
end

-- All NMs gone. Enter CLEARED. Click during this window removes the cap.
xi.expeditionaryForce.onBattleCleared = function(npc, zoneData)
    zoneData.state = xi.expeditionaryForce.bannerState.CLEARED

    npc:timer(xi.expeditionaryForce.config.capRemovalWindow * 1000, function(npcArg)
        local zd = xi.expeditionaryForce.zoneData[npcArg:getZoneID()]
        if zd ~= nil and zd.state == xi.expeditionaryForce.bannerState.CLEARED then
            xi.expeditionaryForce.hideBanner(npcArg)
        end
    end)
end

-- CLEARED -> HIDDEN. Hide the banner and schedule its respawn at a new random slot.
-- Level caps linger until capLingerTime expires or the player zones if they did not click banner.
xi.expeditionaryForce.hideBanner = function(npc)
    local zoneId   = npc:getZoneID()
    local zoneData = xi.expeditionaryForce.zoneData[zoneId]
    if zoneData == nil then
        return
    end

    -- Defensive: clean up any stragglers. This should hopefully never do anything.
    for _, mobId in ipairs(zoneData.nms) do
        local mob = GetMobByID(mobId)
        if mob ~= nil and mob:isSpawned() then
            DespawnMob(mobId)
        end
    end

    zoneData.nms             = {}
    zoneData.gone            = {}
    zoneData.creditNation    = nil
    zoneData.creditedPlayers = {}
    zoneData.state           = xi.expeditionaryForce.bannerState.HIDDEN

    npc:setStatus(xi.status.DISAPPEAR)

    npc:timer(xi.expeditionaryForce.config.bannerRespawn * 1000, function(npcArg)
        xi.expeditionaryForce.respawnBanner(npcArg)
    end)
end

-- HIDDEN -> IDLE. Bring the banner back at a new random slot.
xi.expeditionaryForce.respawnBanner = function(npc)
    local zoneId   = npc:getZoneID()
    local zoneData = xi.expeditionaryForce.zoneData[zoneId]
    if zoneData == nil then
        return
    end

    local region = xi.expeditionaryForce.regions[zoneData.regionId]
    if region == nil or region.bannerSpawns == nil or #region.bannerSpawns == 0 then
        return
    end

    local pos = region.bannerSpawns[math.random(#region.bannerSpawns)]
    npc:setPos(pos[1], pos[2], pos[3], pos[4])
    npc:setStatus(xi.status.NORMAL)
    zoneData.state = xi.expeditionaryForce.bannerState.IDLE
end