-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Taumila
-- Starts and Finishes Quest: Tiger's Teeth (R)
-- !pos -140 -5 -8 230
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/titles")
require("scripts/globals/shop")
require("scripts/globals/quests")
local ID = require("scripts/zones/Southern_San_dOria/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.TIGER_S_TEETH) ~= QUEST_AVAILABLE then
        if trade:hasItemQty(884, 3) and trade:getItemCount() == 3 then
            player:startEvent(572)
        end
    end
end

entity.onTrigger = function(player, npc)
    local tigersTeeth = player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.TIGER_S_TEETH)

    if
        player:getFameLevel(xi.quest.fame_area.SANDORIA) >= 3 and
        tigersTeeth == QUEST_AVAILABLE
    then
        player:startEvent(574)
    elseif tigersTeeth == QUEST_ACCEPTED then
        player:startEvent(575)
    elseif tigersTeeth == QUEST_COMPLETED then
        player:startEvent(573)
    else
        player:startEvent(571)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 574 and option == 0 then
        player:addQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.TIGER_S_TEETH)
    elseif csid == 572 then
        player:tradeComplete()
        player:addTitle(xi.title.FANG_FINDER)
        npcUtil.giveCurrency(player, 'gil', 2100)
        if player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.TIGER_S_TEETH) == QUEST_ACCEPTED then
            player:addFame(xi.quest.fame_area.SANDORIA, 30)
            player:completeQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.TIGER_S_TEETH)
        else
            player:addFame(xi.quest.fame_area.SANDORIA, 5)
        end
    end
end

return entity
