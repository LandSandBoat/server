-----------------------------------
-- Area: The Garden of Ru'Hmet
--  NPC: Cermet Portal
-- !pos -419 0.1 356 35
-----------------------------------
local ID = zones[xi.zone.THE_GARDEN_OF_RUHMET]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    -- This applies to pre-COP Dawn only.  Mission script overrides with the broken state.

    if player:getZPos() <= 360 then
        player:messageSpecial(ID.text.PORTAL_SEALED)
    else
        player:startEvent(139)
    end
end

return entity
