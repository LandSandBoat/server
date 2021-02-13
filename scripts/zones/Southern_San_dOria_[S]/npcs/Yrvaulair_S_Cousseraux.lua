-----------------------------------
-- Area: Southern SandOria [S]
--  NPC: Yrvaulair S Cousseraux
-- !pos 0 1 -78 80
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:showText(npc, 11692) -- Not once in the four hundred years since the dawn of the Royal Knights has the kingdom found itself in such peril. Let us take up our pikes and stand our ground to ensure another four centuries of prosperity!
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
