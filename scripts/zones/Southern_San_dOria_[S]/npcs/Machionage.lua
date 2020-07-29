-----------------------------------
-- Area: Southern SandOria [S]
--  NPC: Machionage
-- !pos -255 -3 109 80
-----------------------------------
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
    if (player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.GIFTS_OF_THE_GRIFFON) == QUEST_ACCEPTED and player:getCharVar("GiftsOfGriffonProg") == 2) then
        local mask = player:getCharVar("GiftsOfGriffonPlumes")
        if (trade:hasItemQty(2528, 1) and trade:getItemCount() == 1 and not player:getMaskBit(mask, 0)) then
            player:startEvent(28) -- Gifts of Griffon Trade
        end
    end
end

function onTrigger(player, npc)
    player:startEvent(619) -- Default Dialogue
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 28) then
        player:tradeComplete()
        local mask = player:getCharVar("GiftsOfGriffonPlumes")
        player:setMaskBit(mask, "GiftsOfGriffonPlumes", 0, true)
    end
end
