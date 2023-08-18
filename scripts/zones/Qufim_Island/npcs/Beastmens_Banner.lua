-----------------------------------
-- Area: Qufim_Island
--  NPC: Beastmen_s_Banner
-- !pos 0.348 -20.126 73.479 126
-----------------------------------
local ID = zones[xi.zone.QUFIM_ISLAND]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.BEASTMEN_BANNER)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
