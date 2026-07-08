-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Mazween
-----------------------------------
local ID = zones[xi.zone.AHT_URHGAN_WHITEGATE]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.SCROLL_OF_SLEEPGA,       11200, },
        { xi.item.SCROLL_OF_SLEEP_II,      18720, },
        { xi.item.SCROLL_OF_POISON_II,     25200, },
        { xi.item.SCROLL_OF_BIO_II,        14000, },
        { xi.item.SCROLL_OF_POISONGA,       5160, },
        { xi.item.SCROLL_OF_STONE_III,     19932, },
        { xi.item.SCROLL_OF_WATER_III,     22682, },
        { xi.item.SCROLL_OF_AERO_III,      27744, },
        { xi.item.SCROLL_OF_FIRE_III,      33306, },
        { xi.item.SCROLL_OF_BLIZZARD_III,  39368, },
        { xi.item.SCROLL_OF_THUNDER_III,   45930, },
        { xi.item.SCROLL_OF_ABSORB_TP,     27000, },
        { xi.item.SCROLL_OF_DRAIN_II,      30780, },
        { xi.item.SCROLL_OF_DREAD_SPIKES,  70560, },
        { xi.item.SCROLL_OF_ABSORB_ACC,    44000, },
        { xi.item.SCROLL_OF_ASPIR_II,      79800, },
    }

    player:showText(npc, ID.text.MAZWEEN_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
