-----------------------------------
-- Area: Windurst Woods
--  NPC: Manyny
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.SCROLL_OF_SINEWY_ETUDE,     3420 }, --Sinewy Etude
        { xi.item.SCROLL_OF_DEXTROUS_ETUDE,   3060 }, --Dextrous Etude
        { xi.item.SCROLL_OF_VIVACIOUS_ETUDE,  2400 }, --Vivacious Etude
        { xi.item.SCROLL_OF_QUICK_ETUDE,      2080 }, --Quick Etude
        { xi.item.SCROLL_OF_LEARNED_ETUDE,    1704 }, --Learned Etude
        { xi.item.SCROLL_OF_SPIRITED_ETUDE,   1376 }, --Spirited Etude
        { xi.item.SCROLL_OF_ENCHANTING_ETUDE, 1088 }, --Enchanting Etude
    }

    player:showText(npc, zones[xi.zone.WINDURST_WOODS].text.MANYNY_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
