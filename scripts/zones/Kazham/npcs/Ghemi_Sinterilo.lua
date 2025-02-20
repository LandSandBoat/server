-----------------------------------
-- Area: Kazham
--  NPC: Ghemi Senterilo
-----------------------------------
local ID = zones[xi.zone.KAZHAM]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        4468,   72,    -- Pamamas
        4432,   54,    -- Kazham Pineapple
        4390,   36,    -- Mithran Tomato
        612,    54,    -- Kazham Peppers
        628,   236,    -- Cinnamon
        632,   109,    -- Kukuru Bean
        5187,  156,    -- Elshimo Coconut
        5604,  154,    -- Elshimo Pachira Fruit
        2869, 9100,    -- Kazham Waystone
        731,  2877,    -- Aquilaria Log
    }

    player:showText(npc, ID.text.GHEMISENTERILO_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
