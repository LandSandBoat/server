-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Ashene
-- Standard Merchant NPC
-- !pos 70 0 61 230
-----------------------------------
local ID = zones[xi.zone.SOUTHERN_SAN_DORIA]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local stock =
    {
        16455,  4309, 1,    -- Baselard
        16532, 16934, 1,    -- Gladius
        16545, 21067, 1,    -- Broadsword
        16576, 35769, 1,    -- Hunting Sword
        16524, 13406, 1,    -- Fleuret
        16450,  1827, 2,    -- Dagger
        16536,  7128, 2,    -- Iron Sword
        16566,  8294, 2,    -- Longsword
        16448,   140, 3,    -- Bronze Dagger
        16449,   837, 3,    -- Brass Dagger
        16531,  3523, 3,    -- Brass Xiphos
        16535,   241, 3,    -- Bronze Sword
        16565,  1674, 3,    -- Spatha
    }

    player:showText(npc, ID.text.ASH_THADI_ENE_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.SANDORIA)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
