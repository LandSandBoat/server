-----------------------------------
-- Area: Port Windurst
--  NPC: Guruna-Maguruna
-----------------------------------
local ID = zones[xi.zone.PORT_WINDURST]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        12593, 12355, 2,    -- Cotton Doublet
        12721,  6696, 2,    -- Cotton Gloves
        13085,   972, 3,    -- Hemp Gorget
        12592,  2470, 3,    -- Doublet
        12600,   216, 3,    -- Robe
        12568,   604, 3,    -- Leather Vest
        12608,  1260, 3,    -- Tunic
        12601,  2776, 3,    -- Linen Robe
        12720,  1363, 3,    -- Gloves
        12728,   118, 3,    -- Cuffs
        12696,   324, 3,    -- Leather Gloves
        12736,   589, 3,    -- Mitts
        12729,  1570, 3,    -- Linen Cuffs
    }

    player:showText(npc, ID.text.GURUNAMAGURUNA_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.WINDURST)
end

return entity
