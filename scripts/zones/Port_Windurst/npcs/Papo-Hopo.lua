-----------------------------------
-- Area: Port Windurst
--  NPC: Papo-Hopo
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
            player:startEvent(537)
        else
            player:startEvent(525)
        end
    elseif ThePromise == QUEST_ACCEPTED then
        player:startEvent(515)
    elseif CryingOverOnions == QUEST_COMPLETED then
        player:startEvent(509)
    elseif CryingOverOnions == QUEST_ACCEPTED then
        local CryingOverOnionsVar = player:getCharVar("CryingOverOnions")

        if CryingOverOnionsVar >= 1 then
            player:startEvent(508)
        else
            player:startEvent(501)
        end
    elseif OnionRings == QUEST_COMPLETED then
        player:startEvent(441)
    elseif OnionRings == QUEST_ACCEPTED then
        player:startEvent(434)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
