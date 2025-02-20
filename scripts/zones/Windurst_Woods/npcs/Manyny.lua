-----------------------------------
-- Area: Windurst Woods
--  NPC: Manyny
-----------------------------------
local ID = zones[xi.zone.WINDURST_WOODS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        5032,  3112,       --Sinewy Etude
        5033,  2784,       --Dextrous Etude
        5034,  2184,       --Vivacious Etude
        5035,  1892,       --Quick Etude
        5036,  1550,       --Learned Etude
        5037,  1252,       --Spirited Etude
        5038,   990        --Enchanting Etude
    }
    player:showText(npc, ID.text.MANYNY_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
