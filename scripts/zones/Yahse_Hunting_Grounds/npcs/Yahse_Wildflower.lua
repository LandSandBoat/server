-----------------------------------
-- Area: Yahse Hunting Grounds
--  NPC: Yahse Wildflower
-- Involved in quest Children of the Rune
-- pos 370.6285 0.6692 153.3728
-----------------------------------
require("scripts/globals/npc_util")
local ID = require("scripts/zones/Yahse_Hunting_Grounds/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- CHILDREN OF THE RUNE
    if player:getQuestStatus(xi.quest.log_id.ADOULIN, xi.quest.id.adoulin.CHILDREN_OF_THE_RUNE) == QUEST_ACCEPTED then
        npcUtil.giveKeyItem(player, xi.ki.YAHSE_WILDFLOWER_PETAL)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
