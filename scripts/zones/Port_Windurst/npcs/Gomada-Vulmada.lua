-----------------------------------
-- Area: Port Windurst
--  NPC: Gomada-Vulmada
-----------------------------------
require("scripts/globals/quests")
require("scripts/settings/main")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)

end

entity.onTrigger = function(player, npc)
    local InspectorsGadget     = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.INSPECTOR_S_GADGET)
    local OnionRings           = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.ONION_RINGS)
    local CryingOverOnions     = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.CRYING_OVER_ONIONS)
    local ThePromise = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_PROMISE)

    if ThePromise == QUEST_COMPLETED then
        local Message = math.random(0, 1)

        if Message == 1 then
            player:startEvent(528)
        else
            player:startEvent(540)
        end
    elseif ThePromise == QUEST_ACCEPTED then
        player:startEvent(518)
    elseif CryingOverOnions == QUEST_COMPLETED then
        player:startEvent(507)
    elseif CryingOverOnions == QUEST_ACCEPTED then
        player:startEvent(500)
    elseif OnionRings == QUEST_COMPLETED then
        player:startEvent(442)
    elseif OnionRings == QUEST_ACCEPTED then
        player:startEvent(435)
    elseif InspectorsGadget == QUEST_COMPLETED then
        player:startEvent(425)
    elseif InspectorsGadget == QUEST_ACCEPTED then
        player:startEvent(417)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
