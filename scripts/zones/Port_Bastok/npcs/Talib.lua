-----------------------------------
-- Area: Port Bastok
--  NPC: Talib
-- Starts Quest: Beauty and the Galka
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/quests")
local ID = require("scripts/zones/Port_Bastok/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.BEAUTY_AND_THE_GALKA) == QUEST_ACCEPTED then
        if trade:hasItemQty(642, 1) and trade:getItemCount() == 1 then
            player:startEvent(3)
        end
    end
end

entity.onTrigger = function(player, npc)
    local beautyAndTheGalka = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.BEAUTY_AND_THE_GALKA)
    local shadyBusiness = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.SHADY_BUSINESS)

    if
        beautyAndTheGalka == QUEST_ACCEPTED or
        player:getCharVar("BeautyAndTheGalkaDenied") >= 1
    then
        player:startEvent(4)
    elseif shadyBusiness == QUEST_COMPLETED then
        player:startEvent(90)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 2 and option == 0 then
        player:addQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.BEAUTY_AND_THE_GALKA)
    elseif csid == 2 and option == 1 then
        player:setCharVar("BeautyAndTheGalkaDenied", 1)
    elseif csid == 3 then
        player:tradeComplete()
        player:addKeyItem(xi.ki.PALBOROUGH_MINES_LOGS)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.PALBOROUGH_MINES_LOGS)
    end
end

return entity
