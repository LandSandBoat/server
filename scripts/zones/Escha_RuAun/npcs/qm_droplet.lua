-----------------------------------
-- Area: Escha - Ru'Aun (289)
-- NPC: ??? that gives Eschan Droplet
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if not player:hasItem(xi.item.CLUMP_OF_ESCHAN_DROPLETS, xi.inv.TEMPITEMS) then
        player:addTempItem(xi.item.CLUMP_OF_ESCHAN_DROPLETS)
    else
        player:messageSpecial(zones[xi.zones.ESCHA_RUAUN].text.NOTHING_OUT_OF_ORDINARY)
    end
end

return entity
