-----------------------------------
-- Area: Bibiki Bay
--  NPC: Warmachine
-- !pos -345.236 -3.188 -976.563 4
-----------------------------------
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Bibiki_Bay/IDs")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

local ColoredDrop = 4258+math.random(0, 7)

    -- COP mission
    if (player:getCurrentMission(COP) == xi.mission.id.cop.THREE_PATHS and player:getCharVar("COP_Louverance_s_Path") == 2) then
        player:startEvent(33)
    elseif (player:getCurrentMission(COP) == xi.mission.id.cop.DAWN and player:getCharVar("COP_3-taru_story")== 1) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, ColoredDrop)
        else
            player:setCharVar("ColoredDrop", ColoredDrop)
            player:startEvent(43)
        end
    -- standard dialog
    else

    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if (csid == 33) then
        player:setCharVar("COP_Louverance_s_Path", 3)
    elseif (csid == 43) then
        local ColoredDropID=player:getCharVar("ColoredDrop")
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, ColoredDropID)
        else
            player:addItem(ColoredDropID)
            player:messageSpecial(ID.text.ITEM_OBTAINED, ColoredDropID)
            player:setCharVar("COP_3-taru_story", 2)
            player:setCharVar("ColoredDrop", 0)
        end
    end

end

return entity
