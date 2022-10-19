-----------------------------------
-- Area: Beaucedine Glacier
--  NPC: Potete
-- !pos 104.907 -21.249 141.391 111
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- CoP ?-?: MISSING DIALOG (NEEDS RESEARCH!)
    -- player:startEvent(217)
    -- Tells location of Prishe (https://youtu.be/gVWzFDHf5v8)
    -- I think its linked to Ulima's Quest on Three Paths (Where Messengers Gather)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
