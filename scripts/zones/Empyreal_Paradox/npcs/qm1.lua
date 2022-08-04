-----------------------------------
-- Area: Empyreal_Paradox
--  NPC: ??? (qm1)
-----------------------------------
local ID = require("scripts/zones/Empyreal_Paradox/IDs")
require("scripts/globals/missions")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player,npc)
    player:messageSpecial(ID.text.QM_TEXT)
end

entity.onEventUpdate = function(player,csid,option,extras)
end

entity.onEventFinish = function(player,csid,option)
end

return entity
