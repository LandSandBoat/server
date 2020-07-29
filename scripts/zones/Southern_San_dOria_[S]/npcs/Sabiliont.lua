-----------------------------------
-- Area: Southern SandOria [S]
--  NPC: Sabiliont
-- !pos 9 2 -87 80
-----------------------------------
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
    if (player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.GIFTS_OF_THE_GRIFFON) == QUEST_ACCEPTED and player:getCharVar("GiftsOfGriffonProg") == 2) then
        local mask = player:getCharVar("GiftsOfGriffonPlumes")
        if (trade:hasItemQty(2528, 1) and trade:getItemCount() == 1 and not player:getMaskBit(mask, 4)) then
            player:startEvent(27) -- Gifts of Griffon Trade
        end
    end
end

function onTrigger(player, npc)
    player:showText(npc, 6999) -- (Couldn't find default dialogue) What are you doing here? This is no place for civillians
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 27) then -- Gifts Of Griffon Trade
        player:tradeComplete()
        local mask = player:getCharVar("GiftsOfGriffonPlumes")
        player:setMaskBit(mask, "GiftsOfGriffonPlumes", 4, true)
    end
end
