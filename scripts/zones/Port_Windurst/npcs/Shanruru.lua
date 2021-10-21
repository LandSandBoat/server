-----------------------------------
-- Area: Port Windurst
--  NPC: Shanruru
-- Involved in Quest: Riding on the Clouds
-- !pos -1 -6 187 240
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/quests")
local ID = require("scripts/zones/Port_Windurst/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local TruthJusticeOnionWay = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.TRUTH_JUSTICE_AND_THE_ONION_WAY)
    local InspectorsGadget     = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.INSPECTOR_S_GADGET)
    local OnionRings           = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.ONION_RINGS)

    if player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_PROMISE) == QUEST_COMPLETED then
        local Message = math.random(0, 1)

        if Message == 1 then
            player:startEvent(529)
        else
            player:startEvent(541)
        end
    elseif player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.CRYING_OVER_ONIONS) == QUEST_ACCEPTED then
        player:startEvent(504)
    elseif OnionRings == QUEST_COMPLETED then
        player:startEvent(446)
    elseif OnionRings == QUEST_ACCEPTED then
        player:startEvent(439)
    elseif InspectorsGadget == QUEST_COMPLETED then
        player:startEvent(428)
    elseif InspectorsGadget == QUEST_ACCEPTED then
        player:startEvent(420)
    elseif player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.KNOW_ONE_S_ONIONS) == QUEST_COMPLETED then
        player:startEvent(412)
    elseif TruthJusticeOnionWay == QUEST_COMPLETED then
        player:startEvent(384)
    elseif TruthJusticeOnionWay == QUEST_ACCEPTED then
        player:startEvent(377)
    else
        player:startEvent(367)
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
