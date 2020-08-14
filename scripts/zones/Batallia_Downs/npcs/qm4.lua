-----------------------------------
-- Area: Batallia Downs
--  NPC: qm4 (???)
--
-----------------------------------
local ID = require("scripts/zones/Batallia_Downs/IDs")
require("scripts/globals/missions")
require("scripts/globals/keyitems")
-----------------------------------

function onTrigger(player, npc)
    local missionProgress = player:getCharVar("COP_Tenzen_s_Path")
    if (player:getCurrentMission(COP) == tpz.mission.id.cop.THREE_PATHS and missionProgress == 5) then
        player:startEvent(0)
    elseif (player:getCurrentMission(COP) == tpz.mission.id.cop.THREE_PATHS and (missionProgress == 6 or missionProgress == 7) and player:hasKeyItem(tpz.ki.DELKFUTT_RECOGNITION_DEVICE) == false) then
        player:addKeyItem(tpz.ki.DELKFUTT_RECOGNITION_DEVICE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.DELKFUTT_RECOGNITION_DEVICE)
    end

end

function onTrade(player, npc, trade)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 0) then
        player:setCharVar("COP_Tenzen_s_Path", 6)
    end
end
