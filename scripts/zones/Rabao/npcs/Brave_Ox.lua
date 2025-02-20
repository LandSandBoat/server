-----------------------------------
-- Area: Rabao
--  NPC: Brave Ox
-----------------------------------
local ID = zones[xi.zone.RABAO]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        4654,  77350,    -- Protect IV
        4736,  73710,    -- Protectra IV
        4868,  63700,    -- Dispel
        4860,  31850,    -- Stun
        4720,  31850,    -- Flash
        4750, 546000,    -- Reraise III
        4638,  78260,    -- Banish III
        4701,  20092,    -- Cura
        5082,  88389,    -- Cura II
        4702,  62192,    -- Sacrifice
        4703,  64584,    -- Esuna
        4704,  30967,    -- Auspice
        4614, 141137,    -- Cure VI
        4655, 103882,    -- Protect V
        4660, 125069,    -- Shell V
        5103, 140332,    -- Crusade
    }

    player:showText(npc, ID.text.BRAVEOX_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
