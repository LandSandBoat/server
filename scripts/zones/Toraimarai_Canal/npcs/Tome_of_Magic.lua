-----------------------------------
-- Area: Toraimarai Canal
--  NPC: Tome of Magic (Needed for Mission)
-- Involved In Windurst Mission 7-1
-- !zone 169
-----------------------------------
local ID = zones[xi.zone.TORAIMARAI_CANAL]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local offset = npc:getID() - ID.npc.TOME_OF_MAGIC_OFFSET

    if offset >= 0 and offset <= 3 then
        player:startEvent(65 + offset)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
