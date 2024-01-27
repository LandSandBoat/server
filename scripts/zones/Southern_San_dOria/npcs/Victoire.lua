-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Victoire
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
        12432, 1450,    -- Faceguard
        12464, 1936,    -- Headgear
        12560, 2230,    -- Scale Mail
        12592, 2745,    -- Doublet
        12688, 1190,    -- Scale Fng. Gnt.
        12720, 1515,    -- Gloves
        12816, 1790,    -- Scale Cuisses
        12848, 2110,    -- Brais
        12944, 1085,    -- Scale Greaves
        12976, 1410,    -- Gaiters
    }

    player:showText(npc, ID.text.CARAUTIA_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
