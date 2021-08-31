-----------------------------------
-- Area: Hall of Transference
--  NPC: Large Apparatus (Left) - Dem
-- !pos -239 -41 -270 14
-----------------------------------
local ID = require("scripts/zones/Hall_of_Transference/IDs")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getCurrentMission(COP) == xi.mission.id.cop.BELOW_THE_ARKS and player:getCharVar("PromathiaStatus") == 1 then
        player:startEvent(160)
    else
        player:messageSpecial(ID.text.NO_RESPONSE_OFFSET)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 160 then
        player:setPos(185.891, 0, -52.331, 128, 18) -- To Promyvion Dem {R}
    end
end

return entity
