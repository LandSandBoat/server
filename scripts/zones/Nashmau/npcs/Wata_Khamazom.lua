-----------------------------------
-- Area: Nashmau
--  NPC: Wata Khamazom
-- Standard Merchant NPC
-----------------------------------
local ID = zones[xi.zone.NASHMAU]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local stock =
    {
        17152,    44,    -- Shortbow
        17153,   536,    -- Self Bow
        17154,  7920,    -- Wrapped Bow
        17160,   492,    -- Longbow
        17162, 21812,    -- Great Bow
        17318,     4,    -- Wooden Arrow
        17320,     8,    -- Iron Arrow
        17321,    18,    -- Silver Arrow
        17322,   140,    -- Fire Arrow
        17336,     6,    -- Crossbow Bolt
        18258,   248,    -- Throwing Tomahawk
    }

    player:showText(npc, ID.text.WATAKHAMAZOM_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
