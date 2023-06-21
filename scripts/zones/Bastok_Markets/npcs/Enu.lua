-----------------------------------
-- Area: Bastok Markets
--  NPC: Enu
-- !pos -253.673 -13 -92.326 235
-----------------------------------
local ID = require("scripts/zones/Bastok_Markets/IDs")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if trade:hasItemQty(1192, 1) and trade:getItemCount() == 1 then -- Quest: Wish Upon a Star - Trade Fallen Star
        if player:getCharVar("WishUponAStar_Status") == 3 then
            if
                player:getWeather() == xi.weather.NONE and
                (VanadielTOTD() == xi.time.NIGHT or VanadielTOTD() == xi.time.MIDNIGHT)
            then
                player:startEvent(334) -- Trade accepeted
            else
                player:startEvent(337) -- Player has to wait for clear weather
            end
        end
    end
end

entity.onTrigger = function(player, npc)
    if player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.WISH_UPON_A_STAR) == QUEST_COMPLETED then -- Quest: Wish Upon a Star - Quest has been completed.
        player:startEvent(335)
    elseif player:getCharVar("WishUponAStar_Status") == 2 then -- Quest: Wish Upon a Star - Player has spoken with Malene
        player:startEvent(332)
    elseif player:getCharVar("WishUponAStar_Status") == 3 then -- Quest: Wish Upon a Star - Enu has asked player to give her a fallen star
        player:startEvent(333)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 332 then -- Quest: Wish Upon a Star
        player:setCharVar("WishUponAStar_Status", 3)
    elseif csid == 334 then -- Quest: Wish Upon a Star - Traded Fallen Star
        player:tradeComplete()
        player:completeQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.WISH_UPON_A_STAR)
        player:setCharVar("WishUponAStar_Status", 0)
        player:addFame(xi.quest.fame_area.BASTOK, 50)
        player:addItem(1236, 4) -- Reward for quest completion: Cactus Stems x 4
        player:messageSpecial(ID.text.ITEM_OBTAINED, 1236)
    end
end

return entity
