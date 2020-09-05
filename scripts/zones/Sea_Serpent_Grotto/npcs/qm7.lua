-----------------------------------
-- Area: Sea Serpent Grotto
--  NPC: ??? Used for Rhapsodies of Vanadiel Mission 1-14 The Ties that Bind
-- !pos 110.909 -0.095 -6.851 176
-----------------------------------
local ID = require("scripts/zones/Sea_Serpent_Grotto/IDs")
require("scripts/globals/missions")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:getCurrentMission(ROV) == tpz.mission.id.rov.THE_TIES_THAT_BIND then
        player:startEvent(34)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 34 then
        player:completeMission(ROV, tpz.mission.id.rov.THE_TIES_THAT_BIND)
        player:addMission(ROV, tpz.mission.id.rov.IMPURITY)
    end
end