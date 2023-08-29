-----------------------------------
-- Area: Lower Jeuno
--  NPC: Mataligeat
-- !pos -24 0 -60 245
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- THE OLD MONUMENT
    if player:getCharVar('TheOldMonument_Event') == 1 then
        player:startEvent(141) -- looks like his girlfriend dumped him

    -- PAINFUL MEMORY
    elseif player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.PAINFUL_MEMORY) == QUEST_ACCEPTED then
        player:startEvent(140) -- he's forgotten why he took up the lute in the first place

    -- THE REQUIEM
    elseif
        player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.THE_REQUIEM) == QUEST_ACCEPTED and
        player:getCharVar('TheRequiemCS') == 3
    then
        player:startEvent(142) -- huh? the bard interred inside eldieme?

    -- PATH OF THE BARD
    elseif player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.PATH_OF_THE_BARD) == QUEST_COMPLETED then
        player:startEvent(143) -- so now you're one of us, huh?

    -- DEFAULT RESPONSE
    else
        player:startEvent(144) -- have you heard of lewenhart?
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
