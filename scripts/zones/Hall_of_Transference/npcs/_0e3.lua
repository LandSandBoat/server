-----------------------------------
-- Area: Hall of Transference
--  NPC: Large Apparatus (Left) - Holla
-- !pos -239 -1 290 14
-----------------------------------
local ID = require("scripts/zones/Hall_of_Transference/IDs")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getCurrentMission(COP) == tpz.mission.id.cop.BELOW_THE_ARKS and player:getCharVar("PromathiaStatus") == 1 then
        player:startEvent(160)
    else
        player:messageSpecial(ID.text.NO_RESPONSE_OFFSET)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 160 then
        player:setPos(92.033, 0, 80.380, 255, 16) -- To Promyvion Holla {R}
    end
end

return entity
