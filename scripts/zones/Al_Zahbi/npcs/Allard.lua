-----------------------------------
-- Area: Al Zahbi
--  NPC: Allard
-----------------------------------
local ID = zones[xi.zone.AL_ZAHBI]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.RED_CAP,   20000, },
        { xi.item.GAMBISON,  32500, },
        { xi.item.BRACERS,   16900, },
        { xi.item.HOSE,      24500, },
        { xi.item.SOCKS,     16000, },
    }

    player:showText(npc, ID.text.ALLARD_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
