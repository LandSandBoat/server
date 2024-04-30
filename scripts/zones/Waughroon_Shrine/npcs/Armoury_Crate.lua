-----------------------------------
-- Area: Waughroon Shrine
--  NPC: Armoury Crate
-----------------------------------
local entity = {}

local loot =
{
    -- BCNM The Worm's Turn
    [65] =
    {
        {
            { itemid = xi.item.NONE,                  droprate = 125 }, -- nothing
            { itemid = xi.item.FIRE_SPIRIT_PACT,      droprate = 125 }, -- fire_spirit_pact
            { itemid = xi.item.SCROLL_OF_PHALANX,     droprate = 125 }, -- scroll_of_phalanx
            { itemid = xi.item.SCROLL_OF_UTSUSEMI_NI, droprate = 125 }, -- scroll_of_utsusemi_ni
            { itemid = xi.item.SCROLL_OF_ERASE,       droprate = 125 }, -- scroll_of_erase
            { itemid = xi.item.SCROLL_OF_ICE_SPIKES,  droprate = 125 }, -- scroll_of_ice_spikes
            { itemid = xi.item.SCROLL_OF_ABSORB_STR,  droprate = 125 }, -- scroll_of_absorb-str
            { itemid = xi.item.SCROLL_OF_REFRESH,     droprate = 125 }, -- scroll_of_refresh
        },

        {
            { itemid = xi.item.NONE,              droprate = 125 }, -- nothing
            { itemid = xi.item.ENHANCING_EARRING, droprate = 125 }, -- enhancing_earring
            { itemid = xi.item.SPIRIT_TORQUE,     droprate = 125 }, -- spirit_torque
            { itemid = xi.item.GUARDING_GORGET,   droprate = 125 }, -- guarding_gorget
            { itemid = xi.item.NEMESIS_EARRING,   droprate = 125 }, -- nemesis_earring
            { itemid = xi.item.EARTH_MANTLE,      droprate = 125 }, -- earth_mantle
            { itemid = xi.item.STRIKE_SHIELD,     droprate = 125 }, -- strike_shield
            { itemid = xi.item.SHIKAR_BOW,        droprate = 125 }, -- shikar_bow
        },

        {
            { itemid = xi.item.OAK_LOG,      droprate = 500 }, -- oak_log
            { itemid = xi.item.ROSEWOOD_LOG, droprate = 500 }, -- rosewood_log
        },

        {
            { itemid = xi.item.GOLD_BEASTCOIN,    droprate = 500 }, -- gold_beastcoin
            { itemid = xi.item.MYTHRIL_BEASTCOIN, droprate = 500 }, -- mythril_beastcoin
        },

        {
            { itemid = xi.item.BLACK_PEARL, droprate = 200 }, -- black_pearl
            { itemid = xi.item.AMETRINE,    droprate = 200 }, -- ametrine
            { itemid = xi.item.YELLOW_ROCK, droprate = 200 }, -- yellow_rock
            { itemid = xi.item.PERIDOT,     droprate = 200 }, -- peridot
            { itemid = xi.item.TURQUOISE,   droprate = 200 }, -- turquoise
        },

        {
            { itemid = xi.item.NONE,     droprate = 800 }, -- nothing
            { itemid = xi.item.RERAISER, droprate = 200 }, -- reraiser
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
