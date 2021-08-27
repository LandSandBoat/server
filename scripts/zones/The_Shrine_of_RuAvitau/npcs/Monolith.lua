-----------------------------------
-- Area: The Shrine of Ru'Avitau
--  NPC: Monolith
-- !pos <many>
-----------------------------------
local ID = require("scripts/zones/The_Shrine_of_RuAvitau/IDs")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local offset = npc:getID() - ID.npc.MONOLITH_OFFSET
    if (offset >= 0 and offset <= 38) then
        local colorTouched = ID.npc.MONOLITHS[offset / 2]
        for i = 0, 21 do
            local anim = ID.npc.DOORS[i] == colorTouched and xi.anim.OPEN_DOOR or xi.anim.CLOSE_DOOR
            GetNPCByID(ID.npc.DOOR_OFFSET + i):setAnimation(anim)
        end
        for i = 0, 19 do
            local anim = ID.npc.MONOLITHS[i] == colorTouched and xi.anim.OPEN_DOOR or xi.anim.CLOSE_DOOR
            GetNPCByID(ID.npc.MONOLITH_OFFSET + (i * 2) - 1):setAnimation(anim)
        end
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
