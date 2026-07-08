-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Dabih Jajalioh

-- TODO: Add support for occasional stock.
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.CHAMOMILE,  130 },
        { xi.item.WIJNRUIT,   120 },
        { xi.item.CARNATION,   60 },
        { xi.item.RED_ROSE,    80 },
        { xi.item.RAIN_LILY,   96 },
        { xi.item.LILAC,      120 },
        { xi.item.AMARYLLIS,  120 },
        { xi.item.MARGUERITE, 120 },
    }

    -- TODO: Use a Server Var to track shop sales.
    -- Hook to c++ side of shops or something.
    -- Then just check server var here and build stock based on level.

    -- { 574,     900 }, -- Fruit Seeds (Occasionally)
    -- { 1239,    490 }, -- Goblin Doll (Occasionally)
    -- { 1240,    165 }, -- Koma (Occasionally)
    -- { 1446,  50000 }, -- Lacquer Tree Log (Occasionally)
    -- { 1441, 250000 }, -- Libation Abjuration (Occasionally)
    -- { 630,      88 }, -- Ogre Pumpkin (Occasionally)
    -- { 4750, 500000 }, -- Scroll of Reraise III (Occasionally)
    -- { 1241,    354 }, -- Twinkle Powder (Occasionally)
    -- { 2312,   1040 }, -- Chocobo Egg (Occasionally)

    player:showText(npc, zones[xi.zone.RULUDE_GARDENS].text.DABIHJAJALIOH_SHOP_DIALOG)
    xi.shop.general(player, stock, xi.fameArea.JEUNO)
end

return entity
