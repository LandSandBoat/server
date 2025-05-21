-----------------------------------
-- Area: Buburimu Peninsula
--  NPC: Five of Spades
--  Invloved in quests: A Greeting Cardian
-----------------------------------
local ID = zones[xi.zone.BUBURIMU_PENINSULA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local aGreetingCardian = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.A_GREETING_CARDIAN)
    local aGCcs = player:getCharVar('AGreetingCardian_Event')

    if aGreetingCardian == xi.questStatus.QUEST_ACCEPTED and aGCcs == 4 then
        player:startEvent(1) -- A Greeting Cardian step three
    else
        player:showText(npc, ID.text.FIVEOFSPADES_DIALOG) -- Standard Dialog
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 1 then
        player:setCharVar('AGreetingCardian_Event', 5)
    end
end

return entity
