-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Capucine
-- Standard Merchant NPC
-----------------------------------
local ID = zones[xi.zone.SOUTHERN_SAN_DORIA]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local stock =
    {
        12473, 1904,    -- Poet's Circlet
        12608, 1288,    -- Tunic
        12601, 2838,    -- Linen Robe
        12736,  602,    -- Mitts
        12729, 1605,    -- Linen Cuffs
        12864,  860,    -- Slacks
        12857, 2318,    -- Linen Slops
        12992,  556,    -- Solea
        12985, 1495,    -- Holly Clogs
    }

    player:showText(npc, ID.text.CAPUCINE_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
