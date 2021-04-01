-----------------------------------
-- Area: Hall of Transference
--  NPC: Cermet Gate - Holla
-- !pos -219 -6 280 14
-----------------------------------
local ID = require("scripts/zones/Hall_of_Transference/IDs")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getCurrentMission(COP) > xi.mission.id.cop.BELOW_THE_ARKS then
        player:startEvent(150)
    else
        player:messageSpecial(ID.text.NO_RESPONSE_OFFSET + 1) -- The door is firmly shut.
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 150 and option == 1 then
        player:setPos(92.033, 0, 80.380, 255, 16) -- To Promyvion Holla {R}
    end
end

return entity
