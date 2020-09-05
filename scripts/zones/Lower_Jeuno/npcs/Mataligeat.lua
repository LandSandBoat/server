-----------------------------------
-- Area: Lower Jeuno
--  NPC: Mataligeat
-- Standard Info NPC
-- !pos -24 0 -60 245
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local painfulMemory = player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.PAINFUL_MEMORY)
    local theRequiem = player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.THE_REQUIEM)
    local pathOfTheBard = player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.PATH_OF_THE_BARD)

    -- THE OLD MONUMENT
    if (player:getCharVar("TheOldMonument_Event") == 1) then
        player:startEvent(141) -- looks like his girlfriend dumped him

    -- PAINFUL MEMORY
    elseif (painfulMemory == QUEST_ACCEPTED) then
        player:startEvent(140) -- he's forgotten why he took up the lute in the first place

    -- THE REQUIEM
    elseif (theRequiem == QUEST_ACCEPTED and player:getCharVar("TheRequiemCS") == 3) then
        player:startEvent(142) -- huh? the bard interred inside eldieme?

    -- PATH OF THE BARD
    elseif (pathOfTheBard == QUEST_COMPLETED) then
        player:startEvent(143) -- so now you're one of us, huh?

    -- DEFAULT RESPONSE
    else
        player:startEvent(144) -- have you heard of lewenhart?
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
