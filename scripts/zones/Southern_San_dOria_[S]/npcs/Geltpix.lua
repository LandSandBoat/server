-----------------------------------
-- Area: Southern SandOria [S]
--  NPC: Geltpix
-- !pos 154 -2 103 80
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.HI_POTION,  4500 },
        { xi.item.HI_ETHER,  28000 },
        { xi.item.HATCHET,     500 },
        { xi.item.ASPHODEL,    100 },
    }

    player:showText(npc, zones[xi.zone.SOUTHERN_SAN_DORIA_S].text.DONT_HURT_GELTPIX)
    xi.shop.general(player, stock)
end

return entity
