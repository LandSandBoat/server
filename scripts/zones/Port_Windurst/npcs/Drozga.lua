-----------------------------------
-- Area: Port Windurst
--  NPC: Drozga
-----------------------------------
local ID = zones[xi.zone.PORT_WINDURST]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        12432, 1493,    -- Faceguard
        12560, 2296,    -- Scale Mail
        12688, 1225,    -- Scale Fng. Gnt.
        12816, 1843,    -- Scale Cuisses
        12944, 1117,    -- Scale Greaves
        13192,  437,    -- Leather Belt
        13327, 1287,    -- Silver Earring
        13469, 1287,    -- Leather Ring
    }

    player:showText(npc, ID.text.DROZGA_SHOP_DIALOG)
    xi.shop.general(player, stock, xi.fameArea.WINDURST)
end

return entity
