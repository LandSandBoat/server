-----------------------------------
-- Area: Southern SandOria [S]
--  NPC: Geltpix
-- !pos 154 -2 103 80
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria_[S]/IDs")
require("scripts/globals/shop")
-----------------------------------

local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local stock =
    {
        4116, 4500,  -- Hi-Potion
        4132, 28000, -- Hi-Ether
        1021, 500,   -- Hatchet
        2554, 100,   -- Asphodel
    }

    player:showText(npc, ID.text.DONT_HURT_GELTPIX)
    xi.shop.general(player, stock)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
