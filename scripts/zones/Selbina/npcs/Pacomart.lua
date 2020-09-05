-----------------------------------
-- Area: Selbina (248)
--  NPC: Pacomart
-- Type: ROV NPC
-----------------------------------
require("scripts/globals/missions")
-----------------------------------

function onTrade(player,npc,trade)
end

function onTrigger(player,npc)
    if
        (player:getCurrentMission(ROV) == tpz.mission.id.rov.THE_BEGINNING and player:getCharVar("RhapsodiesStatus") == 1) or
        player:getCurrentMission(ROV) >= tpz.mission.id.rov.FLAMES_OF_PRAYER
    then
        player:startEvent(179)
    else
        player:startEvent(180)
    end
end

function onEventUpdate(player,csid,option)
end

function onEventFinish(player,csid,option)
    if csid == 179 and option == 1 then
        player:setPos(0, 0, 0, 0, 252)
    end
end
