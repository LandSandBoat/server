-----------------------------------
-- Area: Port Windurst
--  NPC: Kucha Malkobhi
-----------------------------------
local ID = zones[xi.zone.PORT_WINDURST]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        12635, 273,    -- Tarutaru Kaftan
        12756, 163,    -- Tarutaru Mitts
        12886, 236,    -- Tarutaru Braccae
        13007, 163,    -- Tarutaru Clomps
        12636, 273,    -- Mithran Separates
        12757, 163,    -- Mithran Gauntlets
        12887, 236,    -- Mithran Loincloth
        13008, 163,    -- Mithran Gaiters
    }

    player:showText(npc, ID.text.KUCHAMALKOBHI_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
