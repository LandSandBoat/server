-----------------------------------
-- Area: Kazham
--  NPC: Ghemi Senterilo
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Kazham/IDs")
require("scripts/globals/shop")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local stock =
    {
        4468,   72,    -- Pamamas
        4432,   54,    -- Kazham Pineapple
        4390,   36,    -- Mithran Tomato
        612,    54,    -- Kazham Peppers
        628,   236,    -- Cinnamon
        632,   109,    -- Kukuru Bean
        5187,  156,    -- Elshimo Coconut
        5604,  154,    -- Elshimo Pachira Fruit
        -- 2869, 9100,    -- Kazham Waystone (SOA)
        -- 731,  2877,    -- Aquilaria Log (Abyssea)
    }

    player:showText(npc, ID.text.GHEMISENTERILO_SHOP_DIALOG)
    if player:hasKeyItem(xi.ki.AIRSHIP_PASS_FOR_KAZHAM) then
        xi.shop.general(player, stock, xi.quest.fame_area.WINDURST)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
