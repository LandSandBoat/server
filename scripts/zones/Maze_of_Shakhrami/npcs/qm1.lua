-----------------------------------
-- Area: Maze of Shakhrami
--  NPC: ???
-- Spawns Aroma Crawler - RSE Satchets
-----------------------------------
local ID = zones[xi.zone.MAZE_OF_SHAKHRAMI]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local playerRace = player:getRace()
    local raceOffset = 0

    if playerRace >= 6 then -- will subtract 1 from playerRace calculations for loot starting at taru female, because taru satchet encompasses both sexes
        raceOffset = 1
    end

    if
        VanadielRSELocation() == 2 and
        VanadielRSERace() == playerRace and
        not player:hasItem(18246 + playerRace - raceOffset)
    then
        npcUtil.popFromQM(player, npc, ID.mob.AROMA_CRAWLER, { claim = true, hide = math.random(600, 1800), look = true, radius = 1 })  -- ??? despawns and respawns 10-30 minutes after NM dies

        local item = 18246 + playerRace - raceOffset
        GetMobByID(ID.mob.AROMA_CRAWLER):addListener('ITEM_DROPS', 'ITEM_DROPS_RSE', function(mob, loot)
            loot:addItem(item, xi.drop_rate.UNCOMMON)
        end)

        local newSpawn = math.random(1, 3) -- determine new spawn point for ???
        if newSpawn == 1 then
            npcUtil.queueMove(npc, { 188.893, -0.568, 102.911 })
        elseif newSpawn == 2 then
            npcUtil.queueMove(npc, { 113.680, -0.660, -97.914 }) -- TODO: get 100% accurate spawn point from retail
        else
            npcUtil.queueMove(npc, { -150.508, -9.176, 139.733 }) -- TODO: get 100% accurate spawn point from retail
        end
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

return entity
