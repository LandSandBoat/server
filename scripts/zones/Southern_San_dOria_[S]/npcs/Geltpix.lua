-----------------------------------
-- Area: Southern SandOria [S]
--  NPC: Geltpix
-- !pos 154 -2 103 80
-----------------------------------
local ID = zones[xi.zone.SOUTHERN_SAN_DORIA_S]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        4116, 4500,  -- Hi-Potion
        4132, 28000, -- Hi-Ether
        1021, 500,   -- Hatchet
        2554, 100,   -- Asphodel
    }

    player:showText(npc, ID.text.DONT_HURT_GELTPIX)
    xi.shop.general(player, stock)
end

return entity
