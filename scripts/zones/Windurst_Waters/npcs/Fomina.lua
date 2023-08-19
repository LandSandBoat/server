-----------------------------------
-- Area: Windurst Waters
--  NPC: Fomina
-- Only sells when Windurst controlls Elshimo Lowlands
-- Confirmed shop stock, August 2013
-----------------------------------
local ID = zones[xi.zone.WINDURST_WATERS]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local regionOwner = GetRegionOwner(xi.region.ELSHIMOLOWLANDS)

    if regionOwner ~= xi.nation.WINDURST then
        player:showText(npc, ID.text.FOMINA_CLOSED_DIALOG)
    else
        player:showText(npc, ID.text.FOMINA_OPEN_DIALOG)

        local stock =
        {
            612,     55,  -- Kazham Peppers
            4432,    55,  -- Kazham Pineapple
            4390,    36,  -- Mithran Tomato
            626,    234,  -- Black Pepper
            630,     88,  -- Ogre Pumpkin
            632,    110,  -- Kukuru Bean
            1411,  1656   -- Phalaenopsis
        }
        xi.shop.general(player, stock, xi.quest.fame_area.WINDURST)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
