-----------------------------------
-- Area: Toraimarai Canal
--  NPC: Tome of Magic ( Needed for Mission )
-- Involved In Windurst Mission 7-1
-- !zone 169
-----------------------------------
local ID = require("scripts/zones/Toraimarai_Canal/IDs")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local offset = npc:getID() - ID.npc.TOME_OF_MAGIC_OFFSET

    if offset == 4 and player:getCurrentMission(WINDURST) == xi.mission.id.windurst.THE_SIXTH_MINISTRY and player:getMissionStatus(player:getNation()) == 1 then
        player:startEvent(69)
    elseif offset >= 0 and offset <= 3 then
        player:startEvent(65 + offset)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 69 then
        player:setMissionStatus(player:getNation(), 2)
    end
end

return entity
