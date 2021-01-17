-----------------------------------
-- Area: Windurst Woods
--  NPC: Spare Five
-- Working 100%
--  Involved in quest: A Greeting Cardian
-----------------------------------
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local AGreetingCardian = player:getQuestStatus(tpz.quest.log_id.WINDURST, tpz.quest.id.windurst.A_GREETING_CARDIAN)
    local AGCcs = player:getCharVar("AGreetingCardian_Event")

    if AGreetingCardian == QUEST_ACCEPTED and AGCcs == 2 then
        player:startEvent(295) -- A Greeting Cardian step two
    else
        player:startEvent(282) -- standard dialog
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 295 then
        player:setCharVar("AGreetingCardian_Event", 3)
    end
end

return entity
