-----------------------------------
-- Area: Port Bastok
--  NPC: Kagetora
-- Involved in Quest: Ayame and Kaede, 20 in Pirate Years
-- !pos -96 -2 29 236
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.AYAME_AND_KAEDE) == QUEST_ACCEPTED then
        local ayameAndKaede = player:getCharVar("AyameAndKaede_Event")

        if ayameAndKaede == 0 then
            player:startEvent(241)
        elseif ayameAndKaede > 2 then
            player:startEvent(244)
        else
            player:startEvent(23)
        end
    elseif player:getCharVar("twentyInPirateYearsCS") == 1 then
        player:startEvent(261)
    else
        player:startEvent(23)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 241 then
        player:setCharVar("AyameAndKaede_Event", 1)
    elseif csid == 261 then
        player:setCharVar("twentyInPirateYearsCS", 2)
    end
end

return entity
