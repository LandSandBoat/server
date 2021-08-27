-----------------------------------
-- Area: Southern SandOria [S]
--  NPC: Illeuse
-- !pos -44.203 2 -36.216 80
-- Involved in WOTG21: Proof of Valor, Gifts of the Griffon
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if (player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.GIFTS_OF_THE_GRIFFON) == QUEST_ACCEPTED and player:getCharVar("GiftsOfGriffonProg") == 2) then
        local mask = player:getCharVar("GiftsOfGriffonPlumes")
        if (trade:hasItemQty(2528, 1) and trade:getItemCount() == 1 and not utils.mask.getBit(mask, 2)) then
            player:startEvent(31) -- Gifts of Griffon Trade
        end
    end
end

entity.onTrigger = function(player, npc)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 31) then -- Gifts of Griffon Trade
        player:tradeComplete()
        player:setCharVar("GiftsOfGriffonPlumes", utils.mask.setBit(player:getCharVar("GiftsOfGriffonPlumes"), 2, true))
    end
end

return entity
