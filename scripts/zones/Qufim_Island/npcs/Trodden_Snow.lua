-----------------------------------
-- Area: Qufim Island
--  NPC: Trodden Snow
-- Mission: ASA - THAT_WHICH_CURDLES_BLOOD
-- Mission: ASA - SUGAR_COATED_DIRECTIVE
-- !pos -19 -17 104 126
-----------------------------------
local ID = require("scripts/zones/Qufim_Island/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.ASA_SNOW)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
