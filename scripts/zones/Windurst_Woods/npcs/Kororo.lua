-----------------------------------
-- Area: Windurst Woods
--  NPC: Kororo
-- Type: Standard NPC
-- !pos -11.883 -3.75 5.508 241
-- Starts quest: A Greeting Cardian
-- Involved in quests: Lost Chick
-----------------------------------
local ID = require("scripts/zones/Windurst_Woods/IDs")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    local C2000 = player:getQuestStatus(tpz.quest.log_id.WINDURST, tpz.quest.id.windurst.THE_ALL_NEW_C_2000) -- previous quest in line
    local AGreetingCardian = player:getQuestStatus(tpz.quest.log_id.WINDURST, tpz.quest.id.windurst.A_GREETING_CARDIAN)
    local LPB = player:getQuestStatus(tpz.quest.log_id.WINDURST, tpz.quest.id.windurst.LEGENDARY_PLAN_B)
    local AGCcs = player:getCharVar("AGreetingCardian_Event")
    local AGCtime = player:getCharVar("AGreetingCardian_timer")

    if C2000 == QUEST_ACCEPTED then
        player:startEvent(291)

    -- A Greeting Cardian
    elseif C2000 == QUEST_COMPLETED and AGreetingCardian == QUEST_AVAILABLE and player:getFameLevel(WINDURST) >= 3 then
        player:startEvent(296) -- A Greeting Cardian quest start
    elseif AGreetingCardian == QUEST_ACCEPTED and AGCcs == 3 then
        if player:needToZone() or os.time() < AGCtime then
            player:startEvent(277) -- standard dialog if 1 minute has not passed
        else
            player:startEvent(298) -- A Greeting Cardian part two
        end
    elseif AGreetingCardian == QUEST_ACCEPTED and AGCcs == 5 then
        player:startEvent(303) -- A Greeting Cardian finish

    -- Might be Legendary Plan B, most likely Lost Chick related.
    -- only activates before LPB completes so leaving it in as is for now
    elseif LPB == QUEST_ACCEPTED then
        player:startEvent(312, 0, 529, 940, 858)

    else
        player:startEvent(277) -- standard dialog
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    -- A Greeting Cardian
    if csid == 296 then
        player:addQuest(tpz.quest.log_id.WINDURST, tpz.quest.id.windurst.A_GREETING_CARDIAN)
        player:setCharVar("AGreetingCardian_Event", 2)
        player:setCharVar("AGreetingCardian_timer", os.time() + 60)
        player:needToZone(true) -- wait one minute and zone after this step
    elseif csid == 298 then
        player:setCharVar("AGreetingCardian_Event", 4)
    elseif csid == 303 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 13330) -- Tourmaline Earring
        else
            player:addItem(13330)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 13330) -- Tourmaline Earring
            player:addFame(WINDURST, 30)
            player:completeQuest(tpz.quest.log_id.WINDURST, tpz.quest.id.windurst.A_GREETING_CARDIAN)
            player:needToZone(true) -- zone before starting Legendary Plan B
            player:setCharVar("AGreetingCardian_timer", 0)
            player:setCharVar("AGreetingCardian_Event", 0) -- finish cleanup of A Greeting Cardian variables
        end
    end
end

return entity
