-----------------------------------
-- Area: Sacrificial Chamber
--  NPC: Armoury Crate
-----------------------------------
local entity = {}

local loot =
{
    -- BCNM Jungle Boogymen
    [129] =
    {
        {
            { itemid = xi.item.DARK_TORQUE,      droprate = 250 }, -- Dark Torque
            { itemid = xi.item.ELEMENTAL_TORQUE, droprate = 250 }, -- Elemental Torque
            { itemid = xi.item.HEALING_TORQUE,   droprate = 250 }, -- Healing Torque
            { itemid = xi.item.WIND_TORQUE,      droprate = 250 }, -- Wind Torque
        },

        {
            { itemid = xi.item.PLATINUM_BEASTCOIN,     droprate = 500 }, -- Platinum Beastcoin
            { itemid = xi.item.SCROLL_OF_ABSORB_STR,   droprate =  48 }, -- Scroll Of Absorb-STR
            { itemid = xi.item.SCROLL_OF_ERASE,        droprate = 143 }, -- Scroll Of Erase
            { itemid = xi.item.SCROLL_OF_PHALANX,      droprate = 119 }, -- Scroll Of Phalanx
            { itemid = xi.item.FIRE_SPIRIT_PACT,       droprate =  48 }, -- Fire Spirit Pact
            { itemid = xi.item.CHUNK_OF_FIRE_ORE,      droprate =  48 }, -- Chunk Of Fire Ore
            { itemid = xi.item.CHUNK_OF_ICE_ORE,       droprate =  48 }, -- Chunk Of Ice Ore
            { itemid = xi.item.CHUNK_OF_WIND_ORE,      droprate =  48 }, -- Chunk Of Wind Ore
            { itemid = xi.item.CHUNK_OF_EARTH_ORE,     droprate =  48 }, -- Chunk Of Earth Ore
            { itemid = xi.item.CHUNK_OF_LIGHTNING_ORE, droprate =  48 }, -- Chunk Of Lightning Ore
            { itemid = xi.item.CHUNK_OF_WATER_ORE,     droprate =  48 }, -- Chunk Of Water Ore
            { itemid = xi.item.CHUNK_OF_LIGHT_ORE,     droprate =  48 }, -- Chunk Of Light Ore
            { itemid = xi.item.CHUNK_OF_DARK_ORE,      droprate =  48 }, -- Chunk Of Dark Ore
        },

        {
            { itemid = xi.item.PLATINUM_BEASTCOIN, droprate = 833 }, -- Platinum Beastcoin
            { itemid = xi.item.CHUNK_OF_ICE_ORE,   droprate = 167 }, -- Chunk Of Ice Ore
        },

        {
            { itemid = xi.item.ENFEEBLING_TORQUE, droprate = 250 }, -- Enfeebling Torque
            { itemid = xi.item.EVASION_TORQUE,    droprate = 250 }, -- Evasion Torque
            { itemid = xi.item.GUARDING_TORQUE,   droprate = 250 }, -- Guarding Torque
            { itemid = xi.item.SUMMONING_TORQUE,  droprate = 250 }, -- Summoning Torque
        },

        {
            { itemid = xi.item.DARKSTEEL_INGOT,    droprate = 154 }, -- Darksteel Ingot
            { itemid = xi.item.PAINITE,            droprate = 154 }, -- Painite
            { itemid = xi.item.GOLD_INGOT,         droprate = 154 }, -- Gold Ingot
            { itemid = xi.item.AQUAMARINE,         droprate =  77 }, -- Aquamarine
            { itemid = xi.item.VILE_ELIXIR_P1,     droprate =  77 }, -- Vile Elixir +1
            { itemid = xi.item.MYTHRIL_INGOT,      droprate = 153 }, -- Mythril Ingot
            { itemid = xi.item.CHRYSOBERYL,        droprate =  30 }, -- Chrysoberyl
            { itemid = xi.item.MOONSTONE,          droprate =  30 }, -- Moonstone
            { itemid = xi.item.SUNSTONE,           droprate =  30 }, -- Sunstone
            { itemid = xi.item.ZIRCON,             droprate =  30 }, -- Zircon
            { itemid = xi.item.AQUAMARINE,         droprate =  30 }, -- Aquamarine
            { itemid = xi.item.EBONY_LOG,          droprate =  30 }, -- Ebony Log
            { itemid = xi.item.MAHOGANY_LOG,       droprate =  30 }, -- Mahogany Log
            { itemid = xi.item.PHILOSOPHERS_STONE, droprate =  30 }, -- Philosophers Stone
        },

        {
            { itemid = xi.item.DARKSTEEL_INGOT,            droprate =  77 }, -- Darksteel Ingot
            { itemid = xi.item.MOONSTONE,                  droprate = 134 }, -- Moonstone
            { itemid = xi.item.STEEL_INGOT,                droprate = 154 }, -- Steel Ingot
            { itemid = xi.item.CHRYSOBERYL,                droprate =  50 }, -- Chrysoberyl
            { itemid = xi.item.HI_RERAISER,                droprate = 154 }, -- Hi-reraiser
            { itemid = xi.item.JADEITE,                    droprate = 121 }, -- Jadeite
            { itemid = xi.item.SPOOL_OF_MALBORO_FIBER,     droprate =  10 }, -- Spool Of Malboro Fiber
            { itemid = xi.item.VIAL_OF_BLACK_BEETLE_BLOOD, droprate =  10 }, -- Vial Of Black Beetle Blood
            { itemid = xi.item.RED_ROCK,                   droprate =  30 }, -- Red Rock
            { itemid = xi.item.BLUE_ROCK,                  droprate =  30 }, -- Blue Rock
            { itemid = xi.item.YELLOW_ROCK,                droprate =  30 }, -- Yellow Rock
            { itemid = xi.item.GREEN_ROCK,                 droprate =  30 }, -- Green Rock
            { itemid = xi.item.TRANSLUCENT_ROCK,           droprate =  30 }, -- Translucent Rock
            { itemid = xi.item.PURPLE_ROCK,                droprate =  30 }, -- Purple Rock
            { itemid = xi.item.BLACK_ROCK,                 droprate =  30 }, -- Black Rock
            { itemid = xi.item.WHITE_ROCK,                 droprate =  30 }, -- White Rock
            { itemid = xi.item.FLUORITE,                   droprate =  50 }, -- Fluorite
        },
    },

    -- BCNM Amphibian Assault
    [130] =
    {
        {
            { itemid = xi.item.ENFEEBLING_TORQUE, droprate = 250 }, -- Enfeebling Torque
            { itemid = xi.item.DIVINE_TORQUE,     droprate = 250 }, -- Divine Torque
            { itemid = xi.item.SHIELD_TORQUE,     droprate = 250 }, -- Shield Torque
            { itemid = xi.item.STRING_TORQUE,     droprate = 250 }, -- String Torque
        },

        {
            { itemid = xi.item.ELEMENTAL_TORQUE, droprate = 250 }, -- Elemental Torque
            { itemid = xi.item.EVASION_TORQUE,   droprate = 250 }, -- Evasion Torque
            { itemid = xi.item.GUARDING_TORQUE,  droprate = 250 }, -- Guarding Torque
            { itemid = xi.item.ENHANCING_TORQUE, droprate = 250 }, -- Enhancing Torque
        },

        {
            { itemid = xi.item.CHUNK_OF_WATER_ORE,     droprate = 125 }, -- Chunk Of Water Ore
            { itemid = xi.item.CHUNK_OF_WIND_ORE,      droprate = 125 }, -- Chunk Of Wind Ore
            { itemid = xi.item.CHUNK_OF_ICE_ORE,       droprate = 125 }, -- Chunk Of Ice Ore
            { itemid = xi.item.CHUNK_OF_LIGHTNING_ORE, droprate = 125 }, -- Chunk Of Lightning Ore
            { itemid = xi.item.CHUNK_OF_LIGHT_ORE,     droprate = 125 }, -- Chunk Of Light Ore
            { itemid = xi.item.CHUNK_OF_FIRE_ORE,      droprate = 125 }, -- Chunk Of Fire Ore
            { itemid = xi.item.CHUNK_OF_DARK_ORE,      droprate = 125 }, -- Chunk Of Dark Ore
            { itemid = xi.item.CHUNK_OF_EARTH_ORE,     droprate = 125 }, -- Chunk Of Earth Ore
        },

        {
            { itemid = xi.item.NONE,             droprate = 750 }, -- nothing
            { itemid = xi.item.SUMMONING_TORQUE, droprate = 250 }, -- Summoning Torque
        },

        {
            { itemid = xi.item.NONE,               droprate = 200 }, -- nothing
            { itemid = xi.item.PLATINUM_BEASTCOIN, droprate = 800 }, -- Platinum Beastcoin
        },

        {
            { itemid = xi.item.NONE,                 droprate = 375 }, -- nothing
            { itemid = xi.item.FIRE_SPIRIT_PACT,     droprate = 125 }, -- Fire Spirit Pact
            { itemid = xi.item.SCROLL_OF_ABSORB_STR, droprate = 125 }, -- Scroll Of Absorb-str
            { itemid = xi.item.SCROLL_OF_ERASE,      droprate = 125 }, -- Scroll Of Erase
            { itemid = xi.item.SCROLL_OF_PHALANX,    droprate = 125 }, -- Scroll Of Phalanx
            { itemid = xi.item.SCROLL_OF_RAISE_II,   droprate = 125 }, -- Scroll Of Raise Ii
        },

        {
            { itemid = xi.item.NONE,           droprate = 888 }, -- nothing
            { itemid = xi.item.VILE_ELIXIR_P1, droprate =  56 }, -- Vile Elixir +1
            { itemid = xi.item.HI_RERAISER,    droprate =  56 }, -- Hi-reraiser
        },

        {
            { itemid = xi.item.FLUORITE,         droprate =  10 }, -- Fluorite
            { itemid = xi.item.PAINITE,          droprate =  50 }, -- Painite
            { itemid = xi.item.SUNSTONE,         droprate =  10 }, -- Sunstone
            { itemid = xi.item.JADEITE,          droprate = 150 }, -- Jadeite
            { itemid = xi.item.AQUAMARINE,       droprate =  50 }, -- Aquamarine
            { itemid = xi.item.MOONSTONE,        droprate = 150 }, -- Moonstone
            { itemid = xi.item.YELLOW_ROCK,      droprate =  50 }, -- Yellow Rock
            { itemid = xi.item.RED_ROCK,         droprate =  50 }, -- Red Rock
            { itemid = xi.item.WHITE_ROCK,       droprate = 100 }, -- White Rock
            { itemid = xi.item.GREEN_ROCK,       droprate =  50 }, -- Green Rock
            { itemid = xi.item.TRANSLUCENT_ROCK, droprate = 100 }, -- Translucent Rock
            { itemid = xi.item.CHRYSOBERYL,      droprate = 150 }, -- Chrysoberyl
            { itemid = xi.item.BLACK_ROCK,       droprate =  50 }, -- Black Rock
            { itemid = xi.item.PURPLE_ROCK,      droprate =  50 }, -- Purple Rock
        },

        {
            { itemid = xi.item.PLATINUM_BEASTCOIN,     droprate = 500 }, -- Platinum Beastcoin
            { itemid = xi.item.CORAL_FRAGMENT,         droprate = 222 }, -- Coral Fragment
            { itemid = xi.item.SPOOL_OF_MALBORO_FIBER, droprate =  10 }, -- Spool Of Malboro Fiber
            { itemid = xi.item.STEEL_INGOT,            droprate = 111 }, -- Steel Ingot
            { itemid = xi.item.EBONY_LOG,              droprate =  56 }, -- Ebony Log
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
