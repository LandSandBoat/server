-----------------------------------
-- Area: Batallia Downs
--  NPC: qm_chocobo_tale (???)
--  Quest: A Chocobo's tale
-----------------------------------
local ID = require("scripts/zones/Batallia_Downs/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.FIND_NOTHING)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
