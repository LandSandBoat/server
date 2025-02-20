-----------------------------------
-- Area: Nashmau
--  NPC: Mamaroon
-----------------------------------
local ID = zones[xi.zone.NASHMAU]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        4860,  27000,    -- Scroll of Stun
        4708,   5160,    -- Scroll of Enfire
        4709,   4098,    -- Scroll of Enblizzard
        4710,   2500,    -- Scroll of Enaero
        4711,   2030,    -- Scroll of Entone
        4712,   1515,    -- Scroll of Enthunder
        4713,   7074,    -- Scroll of Enwater
        4859,   9000,    -- Scroll of Shock Spikes
        2502,  29950,    -- White Puppet Turban
        2501,  29950,    -- Black Puppet Turban
        4706, 100800,    -- Scroll of Enlight
        4707, 100800,    -- Scroll of Endark
    }

    player:showText(npc, ID.text.MAMAROON_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
