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

function onTrade(player, npc, trade)

count = trade:getItemCount()
ZeruhnSoot = trade:hasItemQty(560, 3)

    if (ZeruhnSoot == true and count == 3) then
        MineSweep = player:getQuestStatus(BASTOK, tpz.quest.id.bastok.MINESWEEPER)
        if (MineSweep >= 1) then
            player:tradeComplete()
            player:startEvent(109)
        end
    end

end

function onTrigger(player, npc)

MineSweep = player:getQuestStatus(BASTOK, tpz.quest.id.bastok.MINESWEEPER)

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

function onEventUpdate(player, csid, option)
    -- printf("CSID2: %u", csid)
    -- printf("RESULT2: %u", option)
end

function onEventFinish(player, csid, option)

MineSweep = player:getQuestStatus(BASTOK, tpz.quest.id.bastok.MINESWEEPER)

    if (csid == 108) then
        if (MineSweep == 0) then
            player:addQuest(BASTOK, tpz.quest.id.bastok.MINESWEEPER)
        end
    elseif (csid == 109) then
        if (MineSweep == 1) then
            player:completeQuest(BASTOK, tpz.quest.id.bastok.MINESWEEPER)
            player:addFame(BASTOK, 75)
            player:addTitle(tpz.title.ZERUHN_SWEEPER)
        else
            player:addFame(BASTOK, 8)
        end
        player:addGil(GIL_RATE*150)
        player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*150)
    end

end
