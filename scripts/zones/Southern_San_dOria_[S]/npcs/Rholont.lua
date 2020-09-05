-----------------------------------
-- Area: Southern SandOria [S]
--  NPC: Rholont
-- !pos -168 -2 56 80
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria_[S]/IDs")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    if (player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.GIFTS_OF_THE_GRIFFON) == QUEST_ACCEPTED and player:getCharVar("GiftsOfGriffonProg") == 1) then
        player:startEvent(23) -- Gifts of Griffon Start

    elseif (player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.GIFTS_OF_THE_GRIFFON) == QUEST_ACCEPTED and player:getCharVar("GiftsOfGriffonProg") == 2 and player:getCharVar("GiftsOfGriffonPlumes") == 127) then
        player:startEvent(24) -- Gifts of Griffon Quest Complete

    elseif (player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.CLAWS_OF_THE_GRIFFON) == QUEST_AVAILABLE and player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.GIFTS_OF_THE_GRIFFON) == QUEST_COMPLETED and player:getMainLvl() >= 15) then
        player:startEvent(47) -- Claws of Griffon Start

    elseif (player:getCharVar("BoyAndTheBeast") == 1) then
        player:startEvent(56)

    elseif (player:getCharVar("BoyAndTheBeast") > 1 and player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.BOY_AND_THE_BEAST) ~= QUEST_COMPLETED) then
        player:startEvent(57)

    elseif (player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.BOY_AND_THE_BEAST) == QUEST_COMPLETED and player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.WRATH_OF_THE_GRIFFON) == QUEST_AVAILABLE) then
        player:startEvent(59)
    elseif (player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.WRATH_OF_THE_GRIFFON) == QUEST_ACCEPTED) then
        if (player:getCharVar("WrathOfTheGriffon") < 2) then
            player:startEvent(61)
        elseif (player:getCharVar("WrathOfTheGriffon") == 2) then
            player:startEvent(60)
        end
    else
        player:startEvent(32) -- Default Dialogue
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 47) then
        player:addQuest(CRYSTAL_WAR, tpz.quest.id.crystalWar.CLAWS_OF_THE_GRIFFON)
    elseif (csid == 23) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 2528)
        else
            player:setCharVar("GiftsOfGriffonProg", 2)
            player:addItem(2528, 7) -- Plume d'or
            player:messageSpecial(ID.text.ITEM_OBTAINED, 2528)
        end

    elseif (csid == 24) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 812)
        else
            player:addItem(812, 1)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 812)
            player:setCharVar("GiftsOfGriffonProg", 0)
            player:setCharVar("GiftsOfGriffonPlumes", 0)
            player:completeQuest(CRYSTAL_WAR, tpz.quest.id.crystalWar.GIFTS_OF_THE_GRIFFON)
        end
    elseif (csid == 56) then
        player:setCharVar("BoyAndTheBeast", 2)
    elseif (csid == 59) then
        player:addQuest(CRYSTAL_WAR, tpz.quest.id.crystalWar.WRATH_OF_THE_GRIFFON)
    elseif (csid == 60) then
        player:completeQuest(CRYSTAL_WAR, tpz.quest.id.crystalWar.WRATH_OF_THE_GRIFFON)
        player:setCharVar("WrathOfTheGriffon", 0)
        player:addKeyItem(tpz.ki.MILITARY_SCRIP)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.MILITARY_SCRIP)
    end

end
