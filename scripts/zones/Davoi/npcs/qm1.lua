-----------------------------------
-- Area: Davoi
--  NPC: ??? (qm1)
-- Involved in Quest: To Cure a Cough
-- !pos -115.830 -0.427 -184.289 149
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
local ID = require("scripts/zones/Davoi/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local toCureaCough = player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.TO_CURE_A_COUGH)

    if
        toCureaCough == QUEST_ACCEPTED and
        not player:hasKeyItem(xi.ki.THYME_MOSS)
    then
        player:addKeyItem(xi.ki.THYME_MOSS)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.THYME_MOSS)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
