-----------------------------------
-- Area: Selbina (249)
--  NPC: Tonasav
-- Type: ROV NPC
-----------------------------------
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player,npc,trade)
end

entity.onTrigger = function(player,npc)
    if
        (player:getCurrentMission(ROV) == xi.mission.id.rov.THE_BEGINNING and player:getCharVar("RhapsodiesStatus") == 2) or
        player:getCurrentMission(ROV) >= xi.mission.id.rov.FLAMES_OF_PRAYER
    then
        player:startEvent(371)
    else
        player:startEvent(372)
    end
end

entity.onEventUpdate = function(player,csid,option)
end

entity.onEventFinish = function(player,csid,option)
    if csid == 371 and option == 1 then
        player:setPos(0, 0, 0, 0, 252)
    end
end

return entity
