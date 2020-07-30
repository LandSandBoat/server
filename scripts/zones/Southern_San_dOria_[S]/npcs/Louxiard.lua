-----------------------------------
-- Area: Southern SandOria [S]
--  NPC: Louxiard
-- !pos -93 -4 49 80
-----------------------------------
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
    if (player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.GIFTS_OF_THE_GRIFFON) == QUEST_ACCEPTED and player:getCharVar("GiftsOfGriffonProg") == 2) then
        local mask = player:getCharVar("GiftsOfGriffonPlumes")
        if (trade:hasItemQty(2528, 1) and trade:getItemCount() == 1 and not player:getMaskBit(mask, 1)) then
            player:startEvent(26) -- Gifts of Griffon Trade
        end
    end
end

function onTrigger(player, npc)

    if (player:getCampaignAllegiance() > 0 and player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.GIFTS_OF_THE_GRIFFON) == QUEST_AVAILABLE) then
        player:startEvent(21) -- Gifts of Griffon Quest Start

    elseif (player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.GIFTS_OF_THE_GRIFFON) == QUEST_ACCEPTED and player:getCharVar("GiftsOfGriffonProg") == 0) then
        player:startEvent(22) -- Gifts of Griffon Stage 2 Cutscene

    elseif (player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.GIFTS_OF_THE_GRIFFON) == QUEST_ACCEPTED and player:getCharVar("GiftsOfGriffonProg") == 1) then
        player:startEvent(39) -- Gifts of Griffon Stage 2 Dialogue
    else
        player:startEvent(37) -- Default Dialogue
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 21) then
        player:addQuest(CRYSTAL_WAR, tpz.quest.id.crystalWar.GIFTS_OF_THE_GRIFFON) -- Gifts of Griffon Quest Start

    elseif (csid == 22) then
        player:setCharVar("GiftsOfGriffonProg", 1) -- Gifts of Griffon Stage 2

    elseif (csid == 26) then
        player:tradeComplete()
        local mask = player:getCharVar("GiftsOfGriffonPlumes")
        player:setMaskBit(mask, "GiftsOfGriffonPlumes", 1, true)
    end
end
