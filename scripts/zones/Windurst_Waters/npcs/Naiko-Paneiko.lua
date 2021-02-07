-----------------------------------
-- Area: Windurst Waters
--  NPC: Naiko-Paneiko
-- Involved In Quest: Making Headlines, Riding on the Clouds
-- !pos -246 -5 -308 238
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/settings")
require("scripts/globals/titles")
require("scripts/globals/quests")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)

    if (player:getQuestStatus(tpz.quest.log_id.JEUNO, tpz.quest.id.jeuno.RIDING_ON_THE_CLOUDS) == QUEST_ACCEPTED and player:getCharVar("ridingOnTheClouds_4") == 2) then
        if (trade:hasItemQty(1127, 1) and trade:getItemCount() == 1) then -- Trade Kindred seal
            player:setCharVar("ridingOnTheClouds_4", 0)
            player:tradeComplete()
            player:addKeyItem(tpz.ki.SPIRITED_STONE)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.SPIRITED_STONE)
        end
    end

end

entity.onTrigger = function(player, npc)

    function testflag(set, flag)
        return (set % (2*flag) >= flag)
    end

    local MakingHeadlines = player:getQuestStatus(tpz.quest.log_id.WINDURST, tpz.quest.id.windurst.MAKING_HEADLINES)

    if (MakingHeadlines == QUEST_AVAILABLE) then
        player:startEvent(665) -- Quest Start
    elseif (MakingHeadlines == QUEST_ACCEPTED) then
        local prog = player:getCharVar("QuestMakingHeadlines_var")
        --     Variable to track if player has talked to 4 NPCs and a door
        --     1 = Kyume
        --    2 = Yujuju
        --    4 = Hiwom
        --    8 = Umumu
        --    16 = Mahogany Door
        if (testflag(tonumber(prog), 1) == false or testflag(tonumber(prog), 2) == false or testflag(tonumber(prog), 4) == false or testflag(tonumber(prog), 8) == false) then
            local rand = math.random(1, 2)
            if (rand == 1) then
                player:startEvent(666) -- Quest Reminder 1
            else
                player:startEvent(671) -- Quest Reminder 2
            end
        elseif (testflag(tonumber(prog), 8) == true and testflag(tonumber(prog), 16) == false) then
            player:startEvent(673) -- Advises to validate story
        elseif (prog == 31) then
            local rand = math.random(1, 2)
            if (rand == 1) then
                player:startEvent(674) -- Quest finish 1
            else
                player:startEvent(670)    -- Quest finish 2
            end
        end
    else
        player:startEvent(663) -- Standard conversation
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if (csid == 665) then
        player:addQuest(tpz.quest.log_id.WINDURST, tpz.quest.id.windurst.MAKING_HEADLINES)
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
        player:completeQuest(tpz.quest.log_id.WINDURST, tpz.quest.id.windurst.MAKING_HEADLINES)
    end

end

return entity
