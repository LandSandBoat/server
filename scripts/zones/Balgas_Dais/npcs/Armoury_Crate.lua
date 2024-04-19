-----------------------------------
-- Area: Balgas Dais
--  NPC: Armoury Crate
-- Balgas Dais Burning Circle Armoury Crate
-----------------------------------
local entity = {}

local loot =
{
    -- BCNM Treasure and Tribulations
    [100] =
    {
        {
            { itemid = xi.item.GUARDIANS_RING, droprate =  75 }, -- Guardians Ring
            { itemid = xi.item.KAMPFER_RING,   droprate =  32 }, -- Kampfer Ring
            { itemid = xi.item.CONJURERS_RING, droprate =  54 }, -- Conjurers Ring
            { itemid = xi.item.SHINOBI_RING,   droprate =  32 }, -- Shinobi Ring
            { itemid = xi.item.SLAYERS_RING,   droprate =  97 }, -- Slayers Ring
            { itemid = xi.item.SORCERERS_RING, droprate =  75 }, -- Sorcerers Ring
            { itemid = xi.item.SOLDIERS_RING,  droprate = 108 }, -- Soldiers Ring
            { itemid = xi.item.TAMERS_RING,    droprate =  22 }, -- Tamers Ring
            { itemid = xi.item.TRACKERS_RING,  droprate =  65 }, -- Trackers Ring
            { itemid = xi.item.DRAKE_RING,     droprate =  32 }, -- Drake Ring
            { itemid = xi.item.FENCERS_RING,   droprate =  32 }, -- Fencers Ring
            { itemid = xi.item.MINSTRELS_RING, droprate =  86 }, -- Minstrels Ring
            { itemid = xi.item.MEDICINE_RING,  droprate =  86 }, -- Medicine Ring
            { itemid = xi.item.ROGUES_RING,    droprate =  75 }, -- Rogues Ring
            { itemid = xi.item.RONIN_RING,     droprate =  11 }, -- Ronin Ring
            { itemid = xi.item.PLATINUM_RING,  droprate =  32 }, -- Platinum Ring
        },

        {
            { itemid = xi.item.ASTRAL_RING,              droprate = 376 }, -- Astral Ring
            { itemid = xi.item.PLATINUM_RING,            droprate =  22 }, -- Platinum Ring
            { itemid = xi.item.SCROLL_OF_QUAKE,          droprate =  65 }, -- Scroll Of Quake
            { itemid = xi.item.RAM_SKIN,                 droprate =  10 }, -- Ram Skin
            { itemid = xi.item.RERAISER,                 droprate =  11 }, -- Reraiser
            { itemid = xi.item.MYTHRIL_INGOT,            droprate =  22 }, -- Mythril Ingot
            { itemid = xi.item.LIGHT_SPIRIT_PACT,        droprate =  10 }, -- Light Spirit Pact
            { itemid = xi.item.SCROLL_OF_FREEZE,         droprate =  32 }, -- Scroll Of Freeze
            { itemid = xi.item.SCROLL_OF_REGEN_III,      droprate =  43 }, -- Scroll Of Regen Iii
            { itemid = xi.item.SCROLL_OF_RAISE_II,       droprate =  32 }, -- Scroll Of Raise Ii
            { itemid = xi.item.PETRIFIED_LOG,            droprate =  11 }, -- Petrified Log
            { itemid = xi.item.CORAL_FRAGMENT,           droprate =  11 }, -- Coral Fragment
            { itemid = xi.item.MAHOGANY_LOG,             droprate =  11 }, -- Mahogany Log
            { itemid = xi.item.CHUNK_OF_PLATINUM_ORE,    droprate =  43 }, -- Chunk Of Platinum Ore
            { itemid = xi.item.CHUNK_OF_GOLD_ORE,        droprate = 108 }, -- Chunk Of Gold Ore
            { itemid = xi.item.CHUNK_OF_DARKSTEEL_ORE,   droprate =  32 }, -- Chunk Of Darksteel Ore
            { itemid = xi.item.CHUNK_OF_MYTHRIL_ORE,     droprate =  65 }, -- Chunk Of Mythril Ore
            { itemid = xi.item.GOLD_INGOT,               droprate =  10 }, -- Gold Ingot
            { itemid = xi.item.DARKSTEEL_INGOT,          droprate =  11 }, -- Darksteel Ingot
            { itemid = xi.item.PLATINUM_INGOT,           droprate =  11 }, -- Platinum Ingot
            { itemid = xi.item.EBONY_LOG,                droprate =  11 }, -- Ebony Log
            { itemid = xi.item.RAM_HORN,                 droprate =  11 }, -- Ram Horn
            { itemid = xi.item.DEMON_HORN,               droprate =  11 }, -- Demon Horn
            { itemid = xi.item.MANTICORE_HIDE,           droprate =   9 }, -- Manticore Hide
            { itemid = xi.item.WYVERN_SKIN,              droprate =  11 }, -- Wyvern Skin
            { itemid = xi.item.HANDFUL_OF_WYVERN_SCALES, droprate =  11 }, -- Handful Of Wyvern Scales
        },
    },

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
