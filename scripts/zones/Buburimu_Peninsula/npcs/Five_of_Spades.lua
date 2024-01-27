-----------------------------------
-- Area: Buburimu Peninsula
--  NPC: Five of Spades
--  Invloved in quests: A Greeting Cardian
-----------------------------------
local ID = zones[xi.zone.BUBURIMU_PENINSULA]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local aGreetingCardian = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.A_GREETING_CARDIAN)
    local aGCcs = player:getCharVar('AGreetingCardian_Event')

    if aGreetingCardian == QUEST_ACCEPTED and aGCcs == 4 then
        player:startEvent(1) -- A Greeting Cardian step three
    else
        player:showText(npc, ID.text.FIVEOFSPADES_DIALOG) -- Standard Dialog
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 1 then
        player:setCharVar('AGreetingCardian_Event', 5)
    end
end

return entity
