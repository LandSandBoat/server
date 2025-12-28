-----------------------------------
-- Area: Windurst Woods
--  NPC: Manyny
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.SCROLL_OF_SINEWY_ETUDE,     3556 }, --Sinewy Etude
        { xi.item.SCROLL_OF_DEXTROUS_ETUDE,   3182 }, --Dextrous Etude
        { xi.item.SCROLL_OF_VIVACIOUS_ETUDE,  2496 }, --Vivacious Etude
        { xi.item.SCROLL_OF_QUICK_ETUDE,      2163 }, --Quick Etude
        { xi.item.SCROLL_OF_LEARNED_ETUDE,    1772 }, --Learned Etude
        { xi.item.SCROLL_OF_SPIRITED_ETUDE,   1431 }, --Spirited Etude
        { xi.item.SCROLL_OF_ENCHANTING_ETUDE, 1131 }, --Enchanting Etude
    }

    player:showText(npc, zones[xi.zone.WINDURST_WOODS].text.MANYNY_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
