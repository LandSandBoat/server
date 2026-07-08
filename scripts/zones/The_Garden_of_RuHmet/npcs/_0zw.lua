-----------------------------------
-- Area: The Garden of Ru'Hmet
--  NPC: Cermet Portal (Security Gate)
-----------------------------------
local ID = zones[xi.zone.THE_GARDEN_OF_RUHMET]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:getZPos() > 400 then
        player:messageSpecial(ID.text.PORTAL_WONT_OPEN_ON_THIS_SIDE)
        return
    end

    return -1
end

return entity
