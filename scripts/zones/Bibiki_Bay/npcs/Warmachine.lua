-----------------------------------
-- Area: Bibiki Bay
--  NPC: Warmachine
-- !pos -345.236 -3.188 -976.563 4
-----------------------------------
local ID = require("scripts/zones/Bibiki_Bay/IDs")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local coloredDrop = 4258 + math.random(0, 7)

    -- COP mission
    if
        player:getCurrentMission(xi.mission.log_id.COP) == xi.mission.id.cop.DAWN and
        player:getCharVar("COP_3-taru_story") == 1
    then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, coloredDrop)
        else
            player:setCharVar("ColoredDrop", coloredDrop)
            player:startEvent(43)
        end
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 43 then
        local coloredDropID = player:getCharVar("ColoredDrop")
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, coloredDropID)
        else
            player:addItem(coloredDropID)
            player:messageSpecial(ID.text.ITEM_OBTAINED, coloredDropID)
            player:setCharVar("COP_3-taru_story", 2)
            player:setCharVar("ColoredDrop", 0)
        end
    end
end

return entity
