-----------------------------------
-- Area: Southern SandOria [S]
--  NPC: Elnonde
-- !pos 86 2 -0 80
-----------------------------------
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
    if (player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.GIFTS_OF_THE_GRIFFON) == QUEST_ACCEPTED and player:getCharVar("GiftsOfGriffonProg") == 2) then
        local mask = player:getCharVar("GiftsOfGriffonPlumes")
        if (trade:hasItemQty(2528, 1) and trade:getItemCount() == 1 and not player:getMaskBit(mask, 5)) then
            player:startEvent(30) -- Gifts of Griffon Trade
        end
    end
end

function onTrigger(player, npc)
    player:startEvent(615) -- Default Dialogue
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 30) then -- Gifts Of Griffon Trade
        player:tradeComplete()
        local mask = player:getCharVar("GiftsOfGriffonPlumes")
        player:setMaskBit(mask, "GiftsOfGriffonPlumes", 5, true)
    end
end
