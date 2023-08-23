-----------------------------------
-- Area: Cape_Teriggan
--  NPC: Beastmen_s_Banner
-- !pos 162.059 -0.859 250.538 113
-----------------------------------
local ID = zones[xi.zone.CAPE_TERIGGAN]
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
