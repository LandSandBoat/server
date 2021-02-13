-----------------------------------
-- Area: Temple of Uggalepih
--  NPC: Granite Door
-- Involved in Missions: San dOria Mission 8-2
-- !pos -50 -17 -154
-----------------------------------
local ID = require("scripts/zones/Temple_of_Uggalepih/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getCurrentMission(SANDORIA) == tpz.mission.id.sandoria.LIGHTBRINGER and player:getCharVar("MissionStatus") == 5 then
        if
            player:hasKeyItem(tpz.ki.PIECE_OF_A_BROKEN_KEY1) and
            player:hasKeyItem(tpz.ki.PIECE_OF_A_BROKEN_KEY2) and
            player:hasKeyItem(tpz.ki.PIECE_OF_A_BROKEN_KEY3) and
            not GetMobByID(ID.mob.NIO_A):isSpawned() and
            not GetMobByID(ID.mob.NIO_HUM):isSpawned()
        then
            if player:getCharVar("Mission8-2Kills") > 0 then
                player:startEvent(65)
            else
                SpawnMob(ID.mob.NIO_A)
                SpawnMob(ID.mob.NIO_HUM)
            end
        end
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 65 then
        player:setCharVar("Mission8-2Kills", 0)
        player:setCharVar("MissionStatus", 6)
    end
end

return entity
