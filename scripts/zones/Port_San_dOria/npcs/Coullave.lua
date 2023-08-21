-----------------------------------
-- Area: Port San d'Oria
--  NPC: Coullave
-- Standard Merchant NPC
-----------------------------------
local ID = zones[xi.zone.PORT_SAN_DORIA]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local stock =
    {
        4128,  4445, 1,    -- Ether
        17313, 1107, 1,    -- Grenade
        4112,   837, 1,    -- Potion
        704,     96, 2,    -- Bamboo Stick
        4151,   736, 2,    -- Echo Drops
        12456,  552, 2,    -- Hachimaki
        12584,  833, 2,    -- Kenpogi
        12968,  424, 2,    -- Kyahan
        13327, 1125, 2,    -- Silver Earring
        12840,  666, 2,    -- Sitabaki
        12712,  458, 2,    -- Tekko
        4148,   290, 3,    -- Antidote
        4150,  2387, 3,    -- Eye Drops
        13469, 1150, 3,    -- Leather Ring
    }

    player:showText(npc, ID.text.COULLAVE_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.SANDORIA)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
