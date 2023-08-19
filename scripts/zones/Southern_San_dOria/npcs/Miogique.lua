-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Miogique
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
        12552, 14256, 1,    -- Chainmail
        12680,  7783, 1,    -- Chain Mittens
        12672, 23846, 1,    -- Gauntlets
        12424,  9439, 1,    -- Iron Mask
        12442, 13179, 2,    -- Studded Bandana
        12698, 11012, 2,    -- Studded Gloves
        12570, 20976, 2,    -- Studded Vest
        12449,  1504, 3,    -- Brass Cap
        12577,  2286, 3,    -- Brass Harness
        12705,  1255, 3,    -- Brass Mittens
        12448,   154, 3,    -- Bronze Cap
        12576,   576, 3,    -- Bronze Harness
        12704,   128, 3,    -- Bronze Mittens
        12440,   396, 3,    -- Leather Bandana
        12696,   331, 3,    -- Leather Gloves
        12568,   618, 3,    -- Leather Vest
    }

    player:showText(npc, ID.text.RAIMBROYS_SHOP_DIALOG + 1)
    xi.shop.nation(player, stock, xi.nation.SANDORIA)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
