-----------------------------------
-- Area: Bastok Mines
--  NPC: Phara
-- Involved in Quest: The Talekeeper's Truth
-- !pos 75 0 -80 234
-----------------------------------
local ID = require("scripts/zones/Bastok_Mines/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local theDoorman = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_DOORMAN)

    if
        theDoorman == QUEST_COMPLETED and
        player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_TALEKEEPER_S_TRUTH) == QUEST_AVAILABLE
    then
        player:startEvent(154) -- New standard dialog
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 154 then
        player:setCharVar("theTalekeeperTruthCS", 1)
    end
end

return entity
