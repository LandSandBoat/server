-----------------------------------
-- Area: Port Bastok
--  NPC: Bagnobrok
-- Movalpolos Regional Merchant
-----------------------------------
local ID = zones[xi.zone.PORT_BASTOK]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if GetRegionOwner(xi.region.MOVALPOLOS) ~= xi.nation.BASTOK then
        player:showText(npc, ID.text.BAGNOBROK_CLOSED_DIALOG)
    else
        local stock =
        {
            640,    11,    -- Copper Ore
            4450,  694,    -- Coral Fungus
            4375, 4032,    -- Danceshroom
            1650, 6500,    -- Kopparnickel Ore
            5165,  736,    -- Movalpolos Water
        }

        player:showText(npc, ID.text.BAGNOBROK_OPEN_DIALOG)
        xi.shop.general(player, stock, xi.quest.fame_area.BASTOK)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
