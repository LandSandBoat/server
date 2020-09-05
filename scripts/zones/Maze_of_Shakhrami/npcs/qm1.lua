-----------------------------------
-- Area: Maze of Shakhrami
-- NPC: ??? - 17588711
-- Spawns Aroma Crawler - RSE Satchets
-----------------------------------
local ID = require("scripts/zones/Maze_of_Shakhrami/IDs")
require("scripts/globals/npc_util")
-----------------------------------


function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local playerRace = player:getRace()
    local raceOffset = 0

    if playerRace >= 6 then -- will subtract 1 from playerRace calculations for loot starting at taru female, because taru satchet encompasses both sexes
        raceOffset = 1
    end

    if VanadielRSELocation() == 2 and VanadielRSERace() == playerRace and not player:hasItem(18246 + playerRace - raceOffset) then

        npcUtil.popFromQM(player, npc, ID.mob.AROMA_CRAWLER, {claim=true, hide=math.random(600, 1800), look=true, radius=1})  -- ??? despawns and respawns 10-30 minutes after NM dies

        for i = 1, 7 do
            SetDropRate(172, 18246 + i, 0) -- zeros all satchet drop rates
        end
        SetDropRate(172, 18246 + playerRace - raceOffset, 130) -- adds 13% drop rate to specific week's race

        local newSpawn = math.random(1, 3) -- determine new spawn point for ???
        if newSpawn == 1 then
            npcUtil.queueMove(npc, {188.893, -0.568, 102.911})
        elseif newSpawn == 2 then
            npcUtil.queueMove(npc, {113.680, -0.660, -97.914}) -- TODO: get 100% accurate spawn point from retail
        else
            npcUtil.queueMove(npc, {-150.508, -9.176, 139.733}) -- TODO: get 100% accurate spawn point from retail
        end
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
