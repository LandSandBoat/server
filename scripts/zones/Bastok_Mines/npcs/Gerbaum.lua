-----------------------------------
-- Area: Bastok Mines
--  NPC: Gerbaum
-- Starts & Finishes Repeatable Quest: Minesweeper (100%)
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/quests")
require("scripts/globals/settings")
local ID = require("scripts/zones/Bastok_Mines/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local count = trade:getItemCount()
    local ZeruhnSoot = trade:hasItemQty(560, 3)

    if (ZeruhnSoot == true and count == 3) then
        local MineSweep = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.MINESWEEPER)
        if (MineSweep >= 1) then
            player:tradeComplete()
            player:startEvent(109)
        end
    end
end

entity.onTrigger = function(player, npc)
    local MineSweep = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.MINESWEEPER)

    if (MineSweep == 0) then
        player:startEvent(108)
    else
        rand = math.random(1, 2)
        if (rand == 1) then
            player:startEvent(22)
        else
            player:startEvent(23)
        end
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    local MineSweep = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.MINESWEEPER)

    if (csid == 108) then
        if (MineSweep == 0) then
            player:addQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.MINESWEEPER)
        end
    elseif (csid == 109) then
        if (MineSweep == 1) then
            player:completeQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.MINESWEEPER)
            player:addFame(BASTOK, 75)
            player:addTitle(xi.title.ZERUHN_SWEEPER)
        else
            player:addFame(BASTOK, 8)
        end
        player:addGil(GIL_RATE*150)
        player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*150)
    end
end

return entity
