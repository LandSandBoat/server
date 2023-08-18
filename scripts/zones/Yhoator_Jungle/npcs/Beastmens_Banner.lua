-----------------------------------
-- Area: Yhoator Jungle
--  NPC: Beastmen_s_Banner
-- !pos 366.014 -0.185 -394.801 124
-----------------------------------
local ID = zones[xi.zone.YHOATOR_JUNGLE]
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
