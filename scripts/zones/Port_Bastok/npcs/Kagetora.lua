-----------------------------------
-- Area: Port Bastok
--  NPC: Kagetora
-- Involved in Quest: Ayame and Kaede, 20 in Pirate Years
-- !pos -96 -2 29 236
-----------------------------------
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getCharVar("twentyInPirateYearsCS") == 1 then
        player:startEvent(261)
    elseif
        player:getCharVar("FadedPromises") == 2 and
        player:hasKeyItem(xi.ki.DIARY_OF_MUKUNDA)
    then
        player:startEvent(296)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 261 then
        player:setCharVar("twentyInPirateYearsCS", 2)
    elseif csid == 296 then
        player:setCharVar("FadedPromises", 3)
    end
end

return entity
