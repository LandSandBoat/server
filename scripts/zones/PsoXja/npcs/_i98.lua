-----------------------------------
-- Area: Pso'Xja
--  NPC: Stone Gate
-----------------------------------
local ID = require("scripts/zones/PsoXja/IDs")
require("scripts/globals/missions")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if (player:getCurrentMission(COP) == tpz.mission.id.cop.THE_ENDURING_TUMULT_OF_WAR and player:getCharVar("PromathiaStatus")==3 and not GetMobByID(ID.mob.NUNYUNUWI):isSpawned()) then
        SpawnMob(ID.mob.NUNYUNUWI):updateClaim(player)
    elseif ( (player:getCurrentMission(COP) == tpz.mission.id.cop.THE_ENDURING_TUMULT_OF_WAR and player:getCharVar("PromathiaStatus")==4) or player:hasCompletedMission(COP, tpz.mission.id.cop.THE_ENDURING_TUMULT_OF_WAR) or player:hasCompletedMission(COP, tpz.mission.id.cop.THE_LAST_VERSE)) then
        if (player:getZPos() < 318) then
            player:startEvent(69)
        else
            player:startEvent(70)
        end
    else
        player:messageSpecial(ID.text.DOOR_LOCKED)
    end
    return 1
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
