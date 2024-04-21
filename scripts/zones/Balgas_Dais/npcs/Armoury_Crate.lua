-----------------------------------
-- Area: Balgas Dais
--  NPC: Armoury Crate
-- Balgas Dais Burning Circle Armoury Crate
-----------------------------------
local entity = {}

local loot =
{
    -- BCNM Royal Succession
    [108] =
    {
        {
            { itemid = xi.item.BUNCH_OF_WILD_PAMAMAS, droprate = 1000 }, -- bunch_of_wild_pamamas
        },

        {
            { itemid = xi.item.NONE,             droprate = 300 }, -- nothing
            { itemid = xi.item.DUSKY_STAFF,      droprate = 100 }, -- dusky_staff
            { itemid = xi.item.JONGLEURS_DAGGER, droprate = 100 }, -- jongleurs_dagger
            { itemid = xi.item.CALVELEYS_DAGGER, droprate = 100 }, -- calveleys_dagger
            { itemid = xi.item.SEALED_MACE,      droprate = 100 }, -- sealed_mace
            { itemid = xi.item.HIMMEL_STOCK,     droprate = 100 }, -- himmel_stock
            { itemid = xi.item.KAGEHIDE,         droprate = 100 }, -- kagehide
            { itemid = xi.item.OHAGURO,          droprate = 100 }, -- ohaguro
        },

        {
            { itemid =     xi.item.NONE, droprate = 100 }, -- nothing
            { itemid = xi.item.GENIN_EARRING, droprate = 300 }, -- genin_earring
            { itemid = xi.item.AGILE_GORGET, droprate = 300 }, -- agile_gorget
            { itemid = xi.item.JAGD_GORGET, droprate = 300 }, -- jagd_gorget
        },

        {
            { itemid =    xi.item.NONE, droprate = 370 }, -- nothing
            { itemid =  xi.item.TURQUOISE, droprate = 100 }, -- turquoise
            { itemid = xi.item.BUNCH_OF_PAMAMAS, droprate = 100 }, -- bunch_of_pamamas
            { itemid =  xi.item.SQUARE_OF_SILK_CLOTH, droprate = 110 }, -- square_of_silk_cloth
            { itemid =  xi.item.ROSEWOOD_LOG, droprate = 140 }, -- rosewood_log
            { itemid =  xi.item.PEARL, droprate = 180 }, -- pearl
        },

        {
            { itemid = xi.item.SCROLL_OF_PHALANX, droprate = 250 }, -- scroll_of_phalanx
            { itemid = xi.item.SCROLL_OF_ABSORB_STR, droprate = 250 }, -- scroll_of_absorb
            { itemid = xi.item.SCROLL_OF_REFRESH, droprate = 250 }, -- scroll_of_refresh
            { itemid = xi.item.SCROLL_OF_ERASE, droprate = 250 }, -- scroll_of_erase
        },

        {
            { itemid =   xi.item.NONE, droprate = 600 }, -- nothing
            { itemid = xi.item.GOLD_BEASTCOIN, droprate = 400 }, -- gold_beastcoin
        },
    },
}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local battlefield = player:getBattlefield()
    if battlefield then
        xi.battlefield.HandleLootRolls(battlefield, loot[battlefield:getID()], nil, npc)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
