-----------------------------------
-- Area: Norg
--  NPC: Muzaffar
-- Standard Info NPC
-- Quests: Black Market
-- !pos 16.678, -2.044, -14.600 252
-----------------------------------
local ID = require("scripts/zones/Norg/IDs")
require("scripts/globals/titles")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local count = trade:getItemCount()
    local NorthernFurs = trade:hasItemQty(1199, 4)
    local EasternPottery = trade:hasItemQty(1200, 4)
    local SouthernMummies = trade:hasItemQty(1201, 4)
    if (player:getQuestStatus(tpz.quest.log_id.OUTLANDS, tpz.quest.id.outlands.BLACK_MARKET) == QUEST_ACCEPTED or player:getQuestStatus(tpz.quest.log_id.OUTLANDS, tpz.quest.id.outlands.BLACK_MARKET) == QUEST_COMPLETED) then
        if (NorthernFurs and count == 4) then
            player:tradeComplete()
            player:startEvent(17, 1199, 1199)
        elseif (EasternPottery and count == 4) then
            player:tradeComplete()
            player:startEvent(18, 1200, 1200)
        elseif (SouthernMummies and count == 4) then
            player:tradeComplete()
            player:startEvent(19, 1201, 1201)
        end
    end
end

entity.onTrigger = function(player, npc)
    if (player:getQuestStatus(tpz.quest.log_id.OUTLANDS, tpz.quest.id.outlands.BLACK_MARKET) == QUEST_ACCEPTED or player:getQuestStatus(tpz.quest.log_id.OUTLANDS, tpz.quest.id.outlands.BLACK_MARKET) == QUEST_COMPLETED) then
        player:startEvent(16)
    else
        player:startEvent(15)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 15 and option == 1) then
        player:addQuest(tpz.quest.log_id.OUTLANDS, tpz.quest.id.outlands.BLACK_MARKET)
    elseif (csid == 17) then
        player:addGil(GIL_RATE*1500)
        player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*1500)
        if (player:getQuestStatus(tpz.quest.log_id.OUTLANDS, tpz.quest.id.outlands.BLACK_MARKET) == QUEST_ACCEPTED) then
            player:completeQuest(tpz.quest.log_id.OUTLANDS, tpz.quest.id.outlands.BLACK_MARKET)
        end
        player:addFame(NORG, 40)
        player:addTitle(tpz.title.BLACK_MARKETEER)
        player:startEvent(20)
    elseif (csid == 18) then
        player:addGil(GIL_RATE*2000)
        player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*2000)
        if (player:getQuestStatus(tpz.quest.log_id.OUTLANDS, tpz.quest.id.outlands.BLACK_MARKET) == QUEST_ACCEPTED) then
            player:completeQuest(tpz.quest.log_id.OUTLANDS, tpz.quest.id.outlands.BLACK_MARKET)
        end
        player:addFame(NORG, 50)
        player:addTitle(tpz.title.BLACK_MARKETEER)
        player:startEvent(20)
    elseif (csid == 19) then
        player:addGil(GIL_RATE*3000)
        player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*3000)
        if (player:getQuestStatus(tpz.quest.log_id.OUTLANDS, tpz.quest.id.outlands.BLACK_MARKET) == QUEST_ACCEPTED) then
            player:completeQuest(tpz.quest.log_id.OUTLANDS, tpz.quest.id.outlands.BLACK_MARKET)
        end
        player:addFame(NORG, 80)
        player:addTitle(tpz.title.BLACK_MARKETEER)
        player:startEvent(20)
    end
end

return entity
