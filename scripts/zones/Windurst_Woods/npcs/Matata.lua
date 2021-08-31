-----------------------------------
-- Area: Windurst Woods
--  NPC: Matata
-- Type: Standard NPC
-- Involved in quest: In a Stew
-- !pos 131 -5 -109 241
-----------------------------------
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local IAS = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.IN_A_STEW)
    local IASvar = player:getCharVar("IASvar")
    local CB = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.CHOCOBILIOUS)

    -- IN A STEW
    if IAS == QUEST_ACCEPTED and IASvar == 1 then
        player:startEvent(233, 0, 0, 4545) -- In a Stew in progress
    elseif IAS == QUEST_ACCEPTED and IASvar == 2 then
        player:startEvent(237) -- In a Stew reminder
    elseif IAS == QUEST_COMPLETED then
        player:startEvent(241) -- new dialog after In a Stew

    -- CHOCOBILIOUS
    elseif CB == QUEST_COMPLETED then
        player:startEvent(226) -- Chocobilious complete

    -- STANDARD DIALOG
    else
        player:startEvent(223)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    -- IN A STEW
    if csid == 233 then
        player:setCharVar("IASvar", 2)
    end
end

return entity
