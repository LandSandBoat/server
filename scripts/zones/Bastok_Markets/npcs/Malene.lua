-----------------------------------
-- Area: Bastok Markets
--  NPC: Malene
-- Type: Quest NPC
-- !pos -173 -5 64 235
-----------------------------------
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if (player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_COLD_LIGHT_OF_DAY) >= QUEST_AVAILABLE and npcUtil.tradeHas(trade, 550)) then
        player:startEvent(104)
    end
end

entity.onTrigger = function(player, npc)
    if (player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.WISH_UPON_A_STAR) == QUEST_ACCEPTED and player:getCharVar("WishUponAStar_Status") == 1) then -- Quest: Wish Upon a Star
        player:startEvent(330)
    else -- Quest: The Cold Light of Day
        player:startEvent(102)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    -- THE COLD LIGHT OF DAY
    if (csid == 102) then
        if (player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_COLD_LIGHT_OF_DAY) == QUEST_AVAILABLE) then
            player:addQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_COLD_LIGHT_OF_DAY)
        end
    elseif (csid == 104) then
        local fame = player:hasCompletedQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_COLD_LIGHT_OF_DAY) and 8 or 50
        if (npcUtil.completeQuest(player, BASTOK, xi.quest.id.bastok.THE_COLD_LIGHT_OF_DAY, {title= xi.title.CRAB_CRUSHER, gil=500, fame=fame})) then
            player:confirmTrade()
        end

    -- WISH UPON A STAR
    elseif (csid == 330) then
        player:setCharVar("WishUponAStar_Status", 2)
    end
end

return entity
