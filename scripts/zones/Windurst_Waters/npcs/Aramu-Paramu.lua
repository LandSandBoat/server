-----------------------------------
-- Area: Windurst Waters
--  NPC: Aramu-Paramu
-- Involved In Quest: Wondering Minstrel
-- !pos -63 -4 27 238
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local wonderingstatus = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.WONDERING_MINSTREL)
    if wonderingstatus == QUEST_ACCEPTED then
        player:startEvent(683) -- WONDERING_MINSTREL: Quest Accepted "i'm worried about Jatan-Paratan..."
    elseif wonderingstatus == QUEST_COMPLETED then
        player:startEvent(684) -- WONDERING_MINSTREL: Quest After "we all have our own problems, such is the spice of life..."
    else
        -- pick a random standard conversation? he has four but the wiki doesn't mention the conditions for them
        local choice = math.random(0, 3)
        player:startEvent(605 + choice)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
