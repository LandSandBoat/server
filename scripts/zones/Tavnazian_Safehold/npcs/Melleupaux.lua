-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Melleupaux
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Tavnazian_Safehold/IDs")
require("scripts/globals/shop")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local stock =
    {
        16450, 1867,    -- Dagger
        16566, 8478,    -- Longsword
        17335,    8,    -- Rusty Bolt
    }

    if player:getCurrentMission(COP) >= tpz.mission.id.cop.SHELTERING_DOUBT then
        table.insert(stock, 18375)    -- Falx
        table.insert(stock, 93240)
        table.insert(stock, 18214)    -- Voulge
        table.insert(stock, 51905)
    end

    player:showText(npc, ID.text.MELLEUPAUX_SHOP_DIALOG)
    tpz.shop.general(player, stock)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
