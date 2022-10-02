-----------------------------------
-- Area: Windurst Waters
--  NPC: Moreno-Toeno
-- !pos 169 -1.25 159 238
-----------------------------------
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if (player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.MAKING_THE_GRADE) == QUEST_ACCEPTED) then
        player:startEvent(444) -- During Making the GRADE
    else   --  Will run through these iffame is not high enough for other quests
        local rand = math.random(1, 2)

        if rand == 1 then
            player:startEvent(441) -- Standard Conversation 1
        else
            player:startEvent(469) -- Standard Conversation 2
        end
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
