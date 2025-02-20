-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Gavrie
-----------------------------------
local ID = zones[xi.zone.AHT_URHGAN_WHITEGATE]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        4150,  2595,    -- Eye Drops
        4148,   316,    -- Antidote
        4151,   800,    -- Echo Drops
        4112,   910,    -- Potion
        4128,  4832,    -- Ether
        4155,  3360,    -- Remedy
        4509,    12,    -- Distilled Water
        18731,   50,    -- Automaton Oil
        18732,  250,    -- Automaton Oil +1
        18733,  500,    -- Automaton Oil +2
        19185, 1000     -- Automaton Oil +3
    }

    player:showText(npc, ID.text.GAVRIE_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
