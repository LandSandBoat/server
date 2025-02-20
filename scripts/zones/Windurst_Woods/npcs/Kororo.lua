-----------------------------------
-- Area: Windurst Woods
--  NPC: Kororo
-- !pos -11.883 -3.75 5.508 241
-- Starts quest: A Greeting Cardian
-- Involved in quests: Lost Chick
-----------------------------------
local ID = zones[xi.zone.WINDURST_WOODS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local c2000 = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.THE_ALL_NEW_C_2000) -- previous quest in line
    local aGreetingCardian = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.A_GREETING_CARDIAN)
    local lpb = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.LEGENDARY_PLAN_B)
    local agccs = player:getCharVar('AGreetingCardian_Event')
    local agcTime = player:getCharVar('AGreetingCardian_timer')

    if c2000 == xi.questStatus.QUEST_ACCEPTED then
        player:startEvent(291)

    -- A Greeting Cardian
    elseif
        c2000 == xi.questStatus.QUEST_COMPLETED and
        aGreetingCardian == xi.questStatus.QUEST_AVAILABLE and
        player:getFameLevel(xi.fameArea.WINDURST) >= 3
    then
        player:startEvent(296) -- A Greeting Cardian quest start
    elseif aGreetingCardian == xi.questStatus.QUEST_ACCEPTED and agccs == 3 then
        if player:needToZone() or os.time() < agcTime then
            player:startEvent(277) -- standard dialog if 1 minute has not passed
        else
            player:startEvent(298) -- A Greeting Cardian part two
        end
    elseif aGreetingCardian == xi.questStatus.QUEST_ACCEPTED and agccs == 5 then
        player:startEvent(303) -- A Greeting Cardian finish

    -- Might be Legendary Plan B, most likely Lost Chick related.
    -- only activates before LPB completes so leaving it in as is for now
    elseif lpb == xi.questStatus.QUEST_ACCEPTED then
        player:startEvent(312, 0, 529, 940, 858)

    else
        player:startEvent(277) -- standard dialog
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    -- A Greeting Cardian
    if csid == 296 then
        player:addQuest(xi.questLog.WINDURST, xi.quest.id.windurst.A_GREETING_CARDIAN)
        player:setCharVar('AGreetingCardian_Event', 2)
        player:setCharVar('AGreetingCardian_timer', os.time() + 60)
        player:needToZone(true) -- wait one minute and zone after this step
    elseif csid == 298 then
        player:setCharVar('AGreetingCardian_Event', 4)
    elseif csid == 303 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.TOURMALINE_EARRING) -- Tourmaline Earring
        else
            player:addItem(xi.item.TOURMALINE_EARRING)
            player:messageSpecial(ID.text.ITEM_OBTAINED, xi.item.TOURMALINE_EARRING) -- Tourmaline Earring
            player:addFame(xi.fameArea.WINDURST, 30)
            player:completeQuest(xi.questLog.WINDURST, xi.quest.id.windurst.A_GREETING_CARDIAN)
            player:needToZone(true) -- zone before starting Legendary Plan B
            player:setCharVar('AGreetingCardian_timer', 0)
            player:setCharVar('AGreetingCardian_Event', 0) -- finish cleanup of A Greeting Cardian variables
        end
    end
end

return entity
