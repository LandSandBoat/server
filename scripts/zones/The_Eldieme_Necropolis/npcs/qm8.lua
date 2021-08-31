-----------------------------------
-- Area: The Eldieme Necropolis
--  NPC: qm8 (??? - Ancient Papyrus Shreds)
-- Involved in Quest: In Defiant Challenge
-- !pos 105.275 -32 92.551 195
-----------------------------------
local func = require("scripts/zones/The_Eldieme_Necropolis/globals")
require("scripts/globals/keyitems")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    func.papyrusQmOnTrigger(player, xi.ki.ANCIENT_PAPYRUS_SHRED2)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
