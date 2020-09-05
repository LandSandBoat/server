-----------------------------------
-- Area: Valley of Sorrows
--  NPC: qm2 (???)
-- Note: Used to rank 9.1 San d'oria
-- !pos 91 -3 -16 128
-----------------------------------
local ID = require("scripts/zones/Valley_of_Sorrows/IDs")
require("scripts/globals/status")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if (player:getCurrentMission(SANDORIA) == tpz.mission.id.sandoria.BREAKING_BARRIERS and player:getCharVar("MissionStatus") == 1) then
        player:addKeyItem(tpz.ki.FIGURE_OF_TITAN)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.FIGURE_OF_TITAN)
        player:setCharVar("MissionStatus", 2)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
