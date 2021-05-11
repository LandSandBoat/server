-----------------------------------
-- Area: West Ronfaure
--  NPC: Aaveleon
-- Involved in Quest: A Sentry's Peril
-- !pos -431 -45 343 100
-----------------------------------
local ID = require("scripts/zones/West_Ronfaure/IDs")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_PICKPOCKET) == QUEST_ACCEPTED then
        player:messageSpecial(ID.text.AAVELEON_HEALED + 26)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
