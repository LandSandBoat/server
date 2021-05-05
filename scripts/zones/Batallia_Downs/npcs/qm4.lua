-----------------------------------
-- Area: Batallia Downs
--  NPC: qm4 (???)
-----------------------------------
local ID = require("scripts/zones/Batallia_Downs/IDs")
require("scripts/globals/missions")
require("scripts/globals/keyitems")
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    local missionProgress = player:getCharVar("COP_Tenzen_s_Path")
    if (player:getCurrentMission(COP) == xi.mission.id.cop.THREE_PATHS and missionProgress == 5) then
        player:startEvent(0)
    elseif (player:getCurrentMission(COP) == xi.mission.id.cop.THREE_PATHS and (missionProgress == 6 or missionProgress == 7) and player:hasKeyItem(xi.ki.DELKFUTT_RECOGNITION_DEVICE) == false) then
        player:addKeyItem(xi.ki.DELKFUTT_RECOGNITION_DEVICE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.DELKFUTT_RECOGNITION_DEVICE)
    end

end

entity.onTrade = function(player, npc, trade)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 0) then
        player:setCharVar("COP_Tenzen_s_Path", 6)
    end
end

return entity
