-----------------------------------
-- Area: Port Bastok
--  NPC: Zoby Quhyo
-- Elshimo Lowlands Regional Merchant
-----------------------------------
local ID = zones[xi.zone.PORT_BASTOK]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if GetRegionOwner(xi.region.ELSHIMOLOWLANDS) ~= xi.nation.BASTOK then
        player:showText(npc, ID.text.ZOBYQUHYO_CLOSED_DIALOG)
    else
        local stock =
        {
            626,   234,    -- Black Pepper
            612,    55,    -- Kazham Peppers
            4432,   55,    -- Kazham Pineapple
            632,   110,    -- Kukuru Bean
            4390,   36,    -- Mithran Tomato
            630,    88,    -- Ogre Pumpkin
            1411, 1656,    -- Phalaenopsis
        }

        player:showText(npc, ID.text.ZOBYQUHYO_OPEN_DIALOG)
        xi.shop.general(player, stock, xi.quest.fame_area.BASTOK)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
