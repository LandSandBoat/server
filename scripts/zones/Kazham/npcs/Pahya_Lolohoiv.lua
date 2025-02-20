-----------------------------------
-- Area: Kazham
--  NPC: Pahya Lolohoiv
-----------------------------------
local ID = zones[xi.zone.KAZHAM]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        4509,   10,    -- Distilled Water
        4150, 2387,    -- Eye Drops
        4148,  290,    -- Antidote
        4151,  736,    -- Echo Drops
        4112,  837,    -- Potion
        4128, 4445,    -- Ether
        924,   556,    -- Fiend Blood
        943,   294,    -- Poison Dust
    }

    player:showText(npc, ID.text.PAHYALOLOHOIV_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
