-----------------------------------
-- Area: Port Windurst
--  NPC: Drozga
-- Standard Merchant NPC
-----------------------------------
local ID = zones[xi.zone.PORT_WINDURST]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local stock =
    {
        12432, 1493,    -- Faceguard
        12560, 2296,    -- Scale Mail
        12688, 1225,    -- Scale Fng. Gnt.
        12816, 1843,    -- Scale Cuisses
        12944, 1117,    -- Scale Greaves
        13192,  437,    -- Leather Belt
        13327, 1287,    -- Silver Earring
        13469, 1287,    -- Leather Ring
    }

    player:showText(npc, ID.text.DROZGA_SHOP_DIALOG)
    xi.shop.general(player, stock, xi.quest.fame_area.WINDURST)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
