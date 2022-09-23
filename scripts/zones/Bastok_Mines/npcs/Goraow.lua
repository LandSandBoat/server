-----------------------------------
-- Area: Bastok Mines
--  NPC: Goraow
-- Starts Quests: Vengeful Wrath
-- !pos 38 .1 14 234
-----------------------------------
local ID = require("scripts/zones/Bastok_Mines/IDs")
require("scripts/globals/settings")
require("scripts/globals/quests")
require("scripts/globals/titles")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.VENGEFUL_WRATH) ~= QUEST_AVAILABLE then
        if
            trade:hasItemQty(501, 1) == true and
            trade:getItemCount() == 1
        then
            player:startEvent(107)
        end
    end
end

entity.onTrigger = function(player, npc)
    if
        player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.VENGEFUL_WRATH) == QUEST_AVAILABLE and
        player:getFameLevel(xi.quest.fame_area.BASTOK) >= 3
    then
        player:startEvent(106)
    else
        player:startEvent(105)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 106 then
        player:addQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.VENGEFUL_WRATH)
    elseif csid == 107 then
        if player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.VENGEFUL_WRATH) == QUEST_ACCEPTED then
            player:addTitle(xi.title.AVENGER)
            player:addFame(xi.quest.fame_area.BASTOK, 120)
        else
            player:addFame(xi.quest.fame_area.BASTOK, 8)
        end

        player:tradeComplete()
        player:addGil(xi.settings.main.GIL_RATE * 900)
        player:messageSpecial(ID.text.GIL_OBTAINED, xi.settings.main.GIL_RATE * 900)
        player:completeQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.VENGEFUL_WRATH) -- for save fame
    end
end

return entity
