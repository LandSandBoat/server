-----------------------------------
-- Area: Port Windurst
--  NPC: Yafa Yaa
-----------------------------------
require("scripts/globals/quests")
require("scripts/settings/main")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local OnionRings       = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.ONION_RINGS)
    local CryingOverOnions = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.CRYING_OVER_ONIONS)
    local ThePromise       = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_PROMISE)

    if ThePromise == QUEST_COMPLETED then
        local Message = math.random(0, 1)

        if Message == 1 then
            player:startEvent(538)
        else
            player:startEvent(526)
        end
    elseif ThePromise == QUEST_ACCEPTED then
        player:startEvent(516)
    elseif CryingOverOnions == QUEST_COMPLETED then
        player:startEvent(506)
    elseif CryingOverOnions == QUEST_ACCEPTED then
        player:startEvent(499)
    elseif OnionRings == QUEST_COMPLETED then
        player:startEvent(444)
    elseif OnionRings == QUEST_ACCEPTED then
        player:startEvent(436)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
