-----------------------------------
-- Area: Giddeus
--  NPC: Alter of Offerings
-- Involved in Quest: A Crisis in the Making
-- !pos -137 17 177 145
-----------------------------------
local ID = require("scripts/zones/Giddeus/IDs")
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local crisisstatus = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.A_CRISIS_IN_THE_MAKING)
    if crisisstatus >= 1 and player:getCharVar("QuestCrisisMaking_var") == 1 then
        player:startEvent(53) -- A Crisis in the Making: Receive Offering
    else
        player:startEvent(60) -- Standard Message
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 53 and option == 1 then
        player:addKeyItem(39, xi.ki.OFF_OFFERING)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.OFF_OFFERING)
        player:setCharVar("QuestCrisisMaking_var", 2)
    end
end

return entity
