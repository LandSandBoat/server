-----------------------------------
-- Area: Windurst Waters
--  NPC: Naiko-Paneiko
-- Involved In Quest: Making Headlines, Riding on the Clouds
-- !pos -246 -5 -308 238
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters/IDs")
require("scripts/globals/settings")
require("scripts/globals/titles")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)

    if (player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.RIDING_ON_THE_CLOUDS) == QUEST_ACCEPTED and player:getCharVar("ridingOnTheClouds_4") == 2) then
        if (trade:hasItemQty(1127, 1) and trade:getItemCount() == 1) then -- Trade Kindred seal
            player:setCharVar("ridingOnTheClouds_4", 0)
            player:tradeComplete()
            player:addKeyItem(tpz.ki.SPIRITED_STONE)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.SPIRITED_STONE)
        end
    end

end

function onTrigger(player, npc)

    function testflag(set, flag)
        return (set % (2*flag) >= flag)
    end

    MakingHeadlines = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.MAKING_HEADLINES)

    if (MakingHeadlines == 0) then
        player:startEvent(665) -- Quest Start
    elseif (MakingHeadlines == 1) then
        prog = player:getCharVar("QuestMakingHeadlines_var")
        --     Variable to track if player has talked to 4 NPCs and a door
        --     1 = Kyume
        --    2 = Yujuju
        --    4 = Hiwom
        --    8 = Umumu
        --    16 = Mahogany Door
        if (testflag(tonumber(prog), 1) == false or testflag(tonumber(prog), 2) == false or testflag(tonumber(prog), 4) == false or testflag(tonumber(prog), 8) == false) then
            rand = math.random(1, 2)
            if (rand == 1) then
                player:startEvent(666) -- Quest Reminder 1
            else
                player:startEvent(671) -- Quest Reminder 2
            end
        elseif (testflag(tonumber(prog), 8) == true and testflag(tonumber(prog), 16) == false) then
            player:startEvent(673) -- Advises to validate story
        elseif (prog == 31) then
            rand = math.random(1, 2)
            if (rand == 1) then
                player:startEvent(674) -- Quest finish 1
            elseif (scoop == 4 and door == 1) then
                player:startEvent(670)    -- Quest finish 2
            end
        end
    else
        player:startEvent(663) -- Standard conversation
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 665) then
        player:addQuest(WINDURST, tpz.quest.id.windurst.MAKING_HEADLINES)
    elseif (csid == 670 or csid == 674) then
        player:addTitle(tpz.title.EDITORS_HATCHET_MAN)
        player:addGil(GIL_RATE*560)
        player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*560)
        player:delKeyItem(tpz.ki.WINDURST_WOODS_SCOOP)
        player:delKeyItem(tpz.ki.WINDURST_WALLS_SCOOP)
        player:delKeyItem(tpz.ki.WINDURST_WATERS_SCOOP)
        player:delKeyItem(tpz.ki.PORT_WINDURST_SCOOP)
        player:setCharVar("QuestMakingHeadlines_var", 0)
        player:addFame(WINDURST, 30)
        player:completeQuest(WINDURST, tpz.quest.id.windurst.MAKING_HEADLINES)
    end

end
