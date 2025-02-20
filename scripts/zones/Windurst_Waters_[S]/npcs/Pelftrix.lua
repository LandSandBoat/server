-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Pelftrix
-----------------------------------
local ID = zones[xi.zone.WINDURST_WATERS_S]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        4116, 4500,  -- Hi-Potion
        4132, 28000, -- Hi-Ether
        1020, 300,   -- Sickle
        1021, 500,   -- Hatchet
    }

    player:showText(npc, ID.text.PELFTRIX_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
