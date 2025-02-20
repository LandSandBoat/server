-----------------------------------
-- Area: Windurst Woods
--  NPC: Spare Two
--  Involved in quest: A Greeting Cardian
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local aGreetingCardian = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.A_GREETING_CARDIAN)
    local agcCs = player:getCharVar('AGreetingCardian_Event')

    if aGreetingCardian == xi.questStatus.QUEST_ACCEPTED and agcCs == 2 then
        player:startEvent(295) -- A Greeting Cardian step two
    else
        player:startEvent(279) -- standard dialog
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 295 then
        player:setCharVar('AGreetingCardian_Event', 3)
    end
end

return entity
