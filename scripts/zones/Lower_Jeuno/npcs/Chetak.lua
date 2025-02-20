-----------------------------------
-- Area: Lower Jeuno
--  NPC: Chetak
-----------------------------------
local ID = zones[xi.zone.LOWER_JEUNO]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        12466, 20000, -- Red Cap
        12467, 45760, -- Wool Cap
        12474, 11166, -- Wool Hat
        12594, 32500, -- Gambison
        12610, 33212, -- Cloak
        12595, 68640, -- Wool Gambison
        12602, 18088, -- Wool Robe
        12609,  9527, -- Black Tunic
        12722, 16900, -- Bracers
        12738, 15732, -- Linen Mitts
        12730, 10234, -- Wool Cuffs
        12737,  4443, -- White Mitts
    }

    player:showText(npc, ID.text.ORTHONS_GARMENT_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
