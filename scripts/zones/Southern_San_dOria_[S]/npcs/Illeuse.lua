-----------------------------------
-- Area: Southern SandOria [S]
--  NPC: Illeuse
-- !pos -44.203 2 -36.216 80
-----------------------------------
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
    if (player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.GIFTS_OF_THE_GRIFFON) == QUEST_ACCEPTED and player:getCharVar("GiftsOfGriffonProg") == 2) then
        local mask = player:getCharVar("GiftsOfGriffonPlumes")
        if (trade:hasItemQty(2528, 1) and trade:getItemCount() == 1 and not player:getMaskBit(mask, 2)) then
            player:startEvent(31) -- Gifts of Griffon Trade
        end
    end
end

function onTrigger(player, npc)
    player:startEvent(617) -- Default Dialogue
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 31) then -- Gifts of Griffon Trade
        player:tradeComplete()
        local mask = player:getCharVar("GiftsOfGriffonPlumes")
        player:setMaskBit(mask, "GiftsOfGriffonPlumes", 2, true)
    end
end
