-----------------------------------
-- Area: Port Bastok
--  NPC: Corann
-- Start & Finishes Quest: The Quadav's Curse
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/settings")
local ID = require("scripts/zones/Port_Bastok/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local theQuadav = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_QUADAV_S_CURSE)

    if theQuadav == QUEST_ACCEPTED then
        local count = trade:getItemCount()
        local quadavBack = trade:hasItemQty(596, 1)

        if count == 1 and quadavBack == true then
            player:startEvent(81)
        end
    end
end

entity.onTrigger = function(player, npc)
    local theQuadav = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_QUADAV_S_CURSE)
    local outOfOneShell = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.OUT_OF_ONE_S_SHELL)

    if outOfOneShell == QUEST_COMPLETED then
        player:startEvent(88)
    elseif theQuadav == QUEST_COMPLETED then
        player:startEvent(87)
    elseif theQuadav == QUEST_AVAILABLE then
        player:startEvent(80)
    else
        player:startEvent(38)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 80 then
        player:addQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_QUADAV_S_CURSE)
    elseif csid == 81 then
        player:tradeComplete()
        player:completeQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_QUADAV_S_CURSE)
        player:addFame(xi.quest.fame_area.BASTOK, 120)
        player:addItem(12832)
        player:messageSpecial(ID.text.ITEM_OBTAINED, 12832)
    end
end

return entity
