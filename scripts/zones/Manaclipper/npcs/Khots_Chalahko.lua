-----------------------------------
-- Area: Manaclipper
--  NPC: Khots Chalahko
-- Type: NPC
-- !pos 0.019 -4.674 -18.782 3
-----------------------------------
local ID = zones[xi.zone.MANACLIPPER]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.KHOTS_CHALAHKO_OFFSET)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
