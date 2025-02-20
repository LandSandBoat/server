-----------------------------------
-- Area: Nashmau
--  NPC: Poporoon
-----------------------------------
local ID = zones[xi.zone.NASHMAU]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        12952,   336,    -- Leather Highboots
        12953,  3438,    -- Lizard Ledelsens
        12954, 11172,    -- Studded Boots
        12955, 20532,    -- Cuir Highboots
    }

    player:showText(npc, ID.text.POPOROON_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
