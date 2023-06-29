-----------------------------------
-- Area: Al'Taieu
--  NPC: Crystalline Field
-- !pos -0.078 -10 -462.53 33
-----------------------------------
local ID = require("scripts/zones/AlTaieu/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if
        player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.GARDEN_OF_ANTIQUITY) or
        (
            player:getCurrentMission(xi.mission.log_id.COP) == xi.mission.id.cop.GARDEN_OF_ANTIQUITY and
            player:getCharVar('Mission[6][800]Status') == 2
        )
    then
        player:startEvent(100)
    else
        player:messageSpecial(ID.text.IMPERVIOUS_FIELD_BLOCKS)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 100 and option == 1 then
        player:setPos(-20.1, 0.62, -363, 190, xi.zone.GRAND_PALACE_OF_HUXZOI)
    end
end

return entity
