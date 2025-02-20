-----------------------------------
--  Colonization Reives
-- https://www.bg-wiki.com/ffxi/Category:Reive#Colonization_Reive
-- https://wiki.ffo.jp/html/28105.html
-----------------------------------
require('scripts/globals/utils')
-----------------------------------
xi = xi or {}
xi.reives = xi.reives or {}

-- NOTE: Reives collision blockers act like doors and blockers in other parts of the game.
--       One NPC acts as the visual element and another acts as the collision
--       blocker.
-- NOTE: Some zones have the collision and visual combined into one NPC (See Khamihr Drifts for an example).

-----------------------------------
-- Fetches the the mob ID of obstacles and returns the reive table number they belong to.
-- Used to track which obstacle IDs belong to which reives in the mob script.
-----------------------------------
xi.reives.findReiveNumByObstacle = function(zoneID, obstacleId)
    -- Access the zone data based on the zoneID
    local zoneData = xi.reives.zoneData[zoneID]

    if zoneData then
        -- Iterate through each reive in the zone's reive table.
        for reiveNum, reiveData in pairs(zoneData.reive) do
            -- Check if the obstacleId matches any of the obstacle IDs in the associated reive.
            for _, id in pairs(reiveData.obstacles) do
                if id == obstacleId then
                    return reiveNum
                end
            end
        end
    else
        -- print('No data found for zoneID:', zoneID)
    end

    -- Return nil if no matching reive was found
    return nil
end

-----------------------------------
-- Iterates through mobs located in the reive's obstacle table and tracks how many are active.
-- Used to track reive progress before triggering battle end/cleanup.
-- Note: "Would using a listener to handle incremental counting be better?"
-----------------------------------
xi.reives.checkObjectiveStatus = function(zoneID, reiveNum)
    -- Check if zoneID and reiveNum exist in the zoneData.
    local zoneData = xi.reives.zoneData[zoneID]
    if not zoneData or not zoneData.reive[reiveNum] then
        -- print('Invalid zoneID or reiveNum.')
        return false
    end

    local reiveData = zoneData.reive[reiveNum]
    local check = true

    -- Iterate over each obstacle in the reive's obstacle table.
    for _, id in ipairs(reiveData.obstacles) do
        local mob = GetMobByID(id)

        -- Ensure the mob is valid before calling isDead.
        if mob and not mob:isDead() then
            check = false
            break -- No need to check further if any obstacle is alive.
        end
    end

    return check -- If all obstacles are dead, return true (reive is completed)
end

-----------------------------------
-- Added to a reive obstacle's spawn script. Handles spawning and respawning of reives.
-----------------------------------
xi.reives.onMobSpawn = function(mob)
    local mobID  = mob:getID()
    local zoneID = mob:getZoneID()

    -- Iterate through each zone in zoneData
    for zone, data in pairs(xi.reives.zoneData) do
        if zone == zoneID then
            -- Iterate through each reive in the zone's reive table
            for i, reiveData in pairs(data.reive) do
                -- Check if the mobID matches any of the obstacle IDs
                for _, obstacleID in pairs(reiveData.obstacles) do
                    if mobID == obstacleID then
                        -- Call enableReive if the mobID matches an obstacleID
                        xi.reives.enableReive(zoneID, i)
                    end
                end
            end
        end
    end
end

-----------------------------------
-- Added to a reive obstacle's onMobDeath script. Handles disabling of reives.
-----------------------------------
xi.reives.onMobDeath = function(mob)
    -- Find the reive number based on the mob ID (which is an obstacle ID)
    local obstacleId = mob:getID()
    local zoneID     = mob:getZoneID()
    local reiveNum   = xi.reives.findReiveNumByObstacle(zoneID, obstacleId)

    if reiveNum then

        -- If no obstacles remain, or remaining obstacles match initial count, disable the reive
        if xi.reives.checkObjectiveStatus(zoneID, reiveNum) then
            xi.reives.disableReive(zoneID, reiveNum)
        end
    end
end

-----------------------------------
-- Set up the initial enableReive on zone start up.
-----------------------------------
xi.reives.setupZone = function(zone)
    local zoneID = zone:getID()

    if xi.settings.main.ENABLE_SOA == 1 then -- If SOA is enabled, spawn the zone's reives on zone initialize.
        for reiveNum, _ in ipairs(xi.reives.zoneData[zoneID].reive) do
            xi.reives.enableReive(zoneID, reiveNum)
        end
    end
end

-----------------------------------
-- xi.reives.enableReive = function(zoneID, reiveNum)
-- Contains functions used to start a reive.
-- zoneID:   Which zone this reive is located in (Data stored in globals/colonization_reive_data.lua)
-- reiveNum: Reive number passed from mob's onMobSpawn script using the xi.reives.onMobSpawn helper function.
-----------------------------------
xi.reives.enableReive = function(zoneID, reiveNum)
    local zoneData            = xi.reives.zoneData[zoneID]
    local reiveObjRespawnTime = 0
    local reiveMobRespawnTime = zoneData.reiveMobRespawnTime

    if not zoneData or not zoneData.reive[reiveNum] then
        -- print('Invalid zoneID or reiveNum.')

        return
    end

    local reiveData = zoneData.reive[reiveNum]

    -- Handle mobs
    for _, entryId in pairs(reiveData.mob) do
        local mob = GetMobByID(entryId)
        if mob then
            if not mob:isAlive() then
                SpawnMob(entryId)  -- Spawn the reive defenders
                -- TODO: Set name flags (sword)
            end

            mob:setRespawnTime(reiveMobRespawnTime)  -- Set respawn time of the reive defenders
        end
    end

    -- Handle obstacles
    for _, entryId in pairs(reiveData.obstacles) do
        local mob = GetMobByID(entryId)
        if mob then
            if not mob:isAlive() then
                SpawnMob(entryId)  -- Spawn the reive obstacles
                mob:setAnimation(xi.animation.CLOSE_DOOR)
            end

            mob:setAutoAttackEnabled(false)         -- Obstacles do not auto attack.
            mob:setMobAbilityEnabled(false)         -- Obstacles should not use mobskills.
            mob:setMobMod(xi.mobMod.NO_MOVE, 1)     -- Obstacles do not move.
            mob:setMobMod(xi.mobMod.NO_REST, 1)     -- Obstacles do not recover HP when not in combat.
            mob:setRespawnTime(reiveObjRespawnTime) -- Set the respawn time of obstacles to 0 while reive is active.
            -- TODO: Handle mob damage reduction based on keyitems the player has or doesn't have.
            -- TODO: Defender mobs should not aggro by default unless players are already in combat with the objectives.
        end
    end

    -- Handle collision objects
    for _, entryId in pairs(reiveData.collision) do
        local npc = GetNPCByID(entryId)
        if npc then
            npc:setAnimation(xi.animation.CLOSE_DOOR)  -- Close the collision blocker
        end
    end

    -- TODO:
    -- Handle announcement message when a reive spawns.
    -- Handle confrontation effect when a player walks into the reive battle area and the associated boundry fence.
    -- Players should get a count down if they attempt to leave the fenced area and will fail/get locked out of reive combat for a duration if they do not return.
    -- Lockout for leaving the area is 5 minutes.
end

-----------------------------------
-- xi.reives.disableReive = function(ID, reiveNum, respawnTime)
-- Contains functions to end a reive.
-- zoneID      : Zone the reive is located in.
-- reiveNum    : Reive number defined.
-----------------------------------
xi.reives.disableReive = function(zoneID, reiveNum)
    -- Access the zone data and reive data
    local zoneData = xi.reives.zoneData[zoneID]
    if not zoneData or not zoneData.reive[reiveNum] then
        -- print('Invalid zoneID or reiveNum.')
        return
    end

    local reiveData           = zoneData.reive[reiveNum]
    local reiveObjRespawnTime = zoneData.reiveObjRespawnTime
    local reiveMobRespawnTime = 0

    -- print('Reive Disabled', reiveNum)

    -- Handle mobs
    for _, entryId in pairs(reiveData.mob) do
        local mob = GetMobByID(entryId)
        if mob then
            mob:setRespawnTime(reiveMobRespawnTime) -- Sets RespawnTime of Adds to 0 so they don't respawn until the reive begins again.
            if mob:isSpawned() then
                DespawnMob(entryId) -- Despawn defender mobs on reive end.
                -- TODO: Mobs should go grey and fade away, instead of plain despawn
            end
        end
    end

    -- Handle obstacles
    for _, entryId in pairs(reiveData.obstacles) do
        local mob = GetMobByID(entryId)
        if mob then
            mob:setAnimation(xi.animation.OPEN_DOOR)
            mob:setRespawnTime(reiveObjRespawnTime) -- Set the time for the next reive spawn
            if mob:isSpawned() then
                DespawnMob(entryId)
            end
        end
    end

    -- Handle collision objects
    for _, entryId in pairs(reiveData.collision) do
        local npc = GetNPCByID(entryId)
        if npc then
            npc:setAnimation(xi.animation.OPEN_DOOR) -- Open the collision blocker until the next reive spawns
            -- print('collision open', reiveNum)
        end
    end

    -- TODO: Handle disabling of the confrontation effect/objective fence.
    -- TODO: Handle rewards after defeating the reive.
end
