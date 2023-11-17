-----------------------------------
-- Area: Chamber of Oracles
--  NPC: Armoury Crate
-----------------------------------
local entity = {}

local loot =
{
    -- BCNM Legion XI Comitatensis
    [193] =
    {
        {
            { itemid = xi.item.NONE,             droprate = 100 }, -- nothing
            { itemid = xi.item.EVASION_TORQUE,   droprate = 150 }, -- evasion_torque
            { itemid = xi.item.PARRYING_TORQUE,  droprate = 150 }, -- parrying_torque
            { itemid = xi.item.GUARDING_TORQUE,  droprate = 150 }, -- guarding_torque
            { itemid = xi.item.NINJUTSU_TORQUE,  droprate = 150 }, -- ninjutsu_torque
            { itemid = xi.item.WIND_TORQUE,      droprate = 150 }, -- wind_torque
            { itemid = xi.item.SUMMONING_TORQUE, droprate = 150 }, -- summoning_torque
        },

        {
            { itemid = xi.item.NONE,              droprate = 100 }, -- nothing
            { itemid = xi.item.DIVINE_TORQUE,     droprate = 150 }, -- divine_torque
            { itemid = xi.item.DARK_TORQUE,       droprate = 150 }, -- dark_torque
            { itemid = xi.item.ENHANCING_TORQUE,  droprate = 150 }, -- enhancing_torque
            { itemid = xi.item.ENFEEBLING_TORQUE, droprate = 150 }, -- enfeebling_torque
            { itemid = xi.item.ELEMENTAL_TORQUE,  droprate = 150 }, -- elemental_torque
            { itemid = xi.item.HEALING_TORQUE,    droprate = 150 }, -- healing_torque
        },

        {
            { itemid = xi.item.SUNSTONE,          droprate = 100 }, -- sunstone
            { itemid = xi.item.CHUNK_OF_GOLD_ORE, droprate = 100 }, -- chunk_of_gold_ore
            { itemid = xi.item.JADEITE,           droprate = 100 }, -- jadeite
            { itemid = xi.item.FLUORITE,          droprate = 100 }, -- fluorite
            { itemid = xi.item.DARKSTEEL_INGOT,   droprate = 100 }, -- darksteel_ingot
            { itemid = xi.item.ZIRCON,            droprate = 100 }, -- zircon
            { itemid = xi.item.CHRYSOBERYL,       droprate = 100 }, -- chrysoberyl
            { itemid = xi.item.MOONSTONE,         droprate = 100 }, -- moonstone
            { itemid = xi.item.PAINITE,           droprate = 100 }, -- painite
            { itemid = xi.item.STEEL_INGOT,       droprate = 100 }, -- steel_ingot
        },

        {
            { itemid = xi.item.NONE,               droprate = 500 }, -- nothing
            { itemid = xi.item.SCROLL_OF_RAISE_II, droprate = 500 }, -- scroll_of_raise_ii
        },

        {
            { itemid = xi.item.NONE,           droprate = 950 }, -- nothing
            { itemid = xi.item.VILE_ELIXIR_P1, droprate =  50 }, -- vile_elixir_+1
        },

        {
            { itemid = xi.item.YELLOW_ROCK,        droprate =  50 }, -- yellow_rock
            { itemid = xi.item.WHITE_ROCK,         droprate =  50 }, -- white_rock
            { itemid = xi.item.EBONY_LOG,          droprate = 125 }, -- ebony_log
            { itemid = xi.item.PLATINUM_BEASTCOIN, droprate = 775 }, -- platinum_beastcoin
        },

        {
            { itemid = xi.item.NONE,                   droprate = 600 }, -- nothing
            { itemid = xi.item.CHUNK_OF_WATER_ORE,     droprate =  50 }, -- chunk_of_water_ore
            { itemid = xi.item.CHUNK_OF_ICE_ORE,       droprate =  50 }, -- chunk_of_ice_ore
            { itemid = xi.item.CHUNK_OF_LIGHTNING_ORE, droprate =  50 }, -- chunk_of_lightning_ore
            { itemid = xi.item.CHUNK_OF_EARTH_ORE,     droprate =  50 }, -- chunk_of_earth_ore
            { itemid = xi.item.CHUNK_OF_FIRE_ORE,      droprate =  50 }, -- chunk_of_fire_ore
            { itemid = xi.item.CHUNK_OF_LIGHT_ORE,     droprate =  50 }, -- chunk_of_light_ore
            { itemid = xi.item.CHUNK_OF_DARK_ORE,      droprate =  50 }, -- chunk_of_dark_ore
            { itemid = xi.item.CHUNK_OF_WIND_ORE,      droprate =  50 }, -- chunk_of_wind_ore
        },
    },

    -- Cactuar Suave
    [197] =
    {
        {
            { itemid = 916,  droprate = 700 }, -- Cactuar Needle
            { itemid = 1236, droprate = 250 }, -- Cactus Stems
            { itemid = 1592, droprate =  50 }, -- Cactuar Root
        },
        {
            { itemid = 15152, droprate = 250 }, -- Cactuar Ribbon
            { itemid = 17577, droprate = 250 }, -- Capricorn staff
            { itemid = 17997, droprate = 250 }, -- Argent Dagger
            { itemid = 18372, droprate = 250 }, -- Balan's Sword
        },
        {
            { itemid = 17246, droprate = 200 }, -- Ziska's Crossbow
            { itemid = 17825, droprate = 200 }, -- Honebami
            { itemid = 17790, droprate = 200 }, -- Unji
            { itemid = 17999, droprate = 200 }, -- Taillefer's Dagger
            { itemid = 18089, droprate = 200 }, -- Schiltron Spear
        },
        {
            { itemid = 644,  droprate = 50 }, -- Chunk Of Mythril Ore
            { itemid = 645,  droprate = 50 }, -- Chunk Of Darksteel Ore
            { itemid = 700,  droprate = 50 }, -- Mahogany Log
            { itemid = 702,  droprate = 50 }, -- Ebony Log
            { itemid = 703,  droprate = 50 }, -- Petrified Log
            { itemid = 823,  droprate = 50 }, -- Spool Of Gold Thread
            { itemid = 830,  droprate = 50 }, -- Square Of Rainbow Cloth
            { itemid = 844,  droprate = 50 }, -- Phoenix Feather
            { itemid = 866,  droprate = 50 }, -- Handful Of Wyvern Scales
            { itemid = 887,  droprate = 50 }, -- Coral Fragment
            { itemid = 895,  droprate = 50 }, -- Ram Horn
            { itemid = 902,  droprate = 50 }, -- Demon Horn
            { itemid = 942,  droprate = 50 }, -- Philosophers Stone
            { itemid = 1465, droprate = 50 }, -- Slab Of Granite
            { itemid = 1132, droprate = 50 }, -- Square Of Raxa
            { itemid = 4174, droprate = 50 }, -- Vile Elixir
            { itemid = 4175, droprate = 50 }, -- Vile Elixir +1
            { itemid = 4613, droprate = 50 }, -- Cure V
            { itemid = 4659, droprate = 50 }, -- Shell IV
            { itemid = 4774, droprate = 50 }, -- Thunder III
        },
        {
            { itemid = 0,    droprate = 250 }, -- Nothing
            { itemid = 658,  droprate = 100 }, -- Damascus Ingot
            { itemid = 836,  droprate = 150 }, -- Square Of Damascene Cloth
            { itemid = 837,  droprate = 100 }, -- Spool Of Malboro Fiber
            { itemid = 942,  droprate = 100 }, -- Philosophers Stone
            { itemid = 844,  droprate =  50 }, -- Phoenix Feather
            { itemid = 1132, droprate = 250 }, -- Square Of Raxa
        },
    },

    -- The Scarlet King
    [199] =
    {
        {
            { itemid = 1116, droprate = 1000 }, -- Manticore Hair
        },
        {
            { itemid = 1163, droprate = 1000 }, -- Manticore Hide
        },
        {
            { itemid = 1110,  droprate = 200 }, -- Beetle Blood
            { itemid = 17579, droprate = 200 }, -- WWyvern Perch
            { itemid = 17825, droprate = 200 }, -- Honebami
            { itemid = 17997, droprate = 200 }, -- Argent Dagger
            { itemid = 17998, droprate = 200 }, -- Thanatos Baselard
        },
        {
            { itemid = 4659,  droprate = 250 }, -- Shell IV
            { itemid = 17577, droprate = 150 }, -- Capricorn Staff
            { itemid = 17938, droprate = 150 }, -- Woodville's Axe
            { itemid = 18048, droprate = 150 }, -- King Maker
            { itemid = 18211, droprate = 150 }, -- Gawain's Axe
            { itemid = 18372, droprate = 150 }, -- Balan's Sword
        },
        {
            { itemid =  4174,  droprate = 350 }, -- Vile Elixir
            { itemid =  4175,  droprate = 100 }, -- Vile Elixir +1
            { itemid =  4613,  droprate = 100 }, -- Cure V
            { itemid = 19025,  droprate = 250 }, -- Pole Grip
            { itemid = 19026,  droprate = 100 }, -- Spear Strap
            { itemid = 19027,  droprate = 100 }, -- Claymore Grip
        },
        {
            { itemid = 645,  droprate =  50 }, -- Chunk Of Darksteel Ore
            { itemid = 646,  droprate =  50 }, -- Chunk Of Adaman Ore
            { itemid = 700,  droprate = 100 }, -- Mahogany Log
            { itemid = 703,  droprate = 100 }, -- Petrified Log
            { itemid = 738,  droprate =  50 }, -- Chunk Of Platinum Ore
            { itemid = 739,  droprate =  50 }, -- Chunk Of Orichalcum Ore
            { itemid = 745,  droprate =  25 }, -- Gold Ingot
            { itemid = 746,  droprate =  50 }, -- Chunk Of Gold Ore
            { itemid = 830,  droprate =  25 }, -- Square Of Rainbow Cloth
            { itemid = 844,  droprate = 100 }, -- Phoenix Feather
            { itemid = 1132, droprate = 100 }, -- Square Of Raxa
            { itemid = 4172, droprate = 100 }, -- Reraiser
            { itemid = 4173, droprate =  50 }, -- Hi-reraiser
            { itemid = 4774, droprate = 150 }, -- Thunder III
        },
        {
            { itemid = 0,    droprate = 650 }, -- Nothing
            { itemid = 658,  droprate = 100 }, -- Damascus Ingot
            { itemid = 836,  droprate =  50 }, -- Square Of Damascene Cloth
            { itemid = 837,  droprate =  50 }, -- Spool Of Malboro Fiber
            { itemid = 942,  droprate =  50 }, -- Philosophers Stone
            { itemid = 1132, droprate = 100 }, -- Square Of Raxa
        }
    },

    -- KSNM Eye of the Storm
    [198] =
    {
        {
            { itemid = xi.item.WYVERN_WING, droprate = 1000 }, -- Wyvern Wing
        },

        {
            { itemid = xi.item.WYVERN_SKIN, droprate = 1000 }, -- Wyvern Skin
        },

        {
            { itemid = xi.item.GIL, droprate = 1000, amount = 24000 }, -- gil

        },

        {
            { itemid = xi.item.SQUARE_OF_DAMASCENE_CLOTH,  droprate = 216 }, -- Damascene Cloth
            { itemid = xi.item.DAMASCUS_INGOT,             droprate = 295 }, -- Damascus Ingot
            { itemid = xi.item.WOODVILLES_AXE,             droprate = 239 }, -- Woodville's Axe
            { itemid = xi.item.THANATOS_BASELARD,          droprate = 231 }, -- Thanatos Baselard
            { itemid = xi.item.WYVERN_PERCH,               droprate = 231 }, -- Wyvern Perch
            { itemid = xi.item.BALINS_SWORD,               droprate = 231 }, -- Balin's Sword
            { itemid = xi.item.VIAL_OF_BLACK_BEETLE_BLOOD, droprate = 231 }, -- Beetle Blood
        },

        {
            { itemid = xi.item.BOURDONASSE,    droprate = 104 }, -- Bourdonasse
            { itemid = xi.item.VILE_ELIXIR_P1, droprate =  86 }, -- Vile Elixir +1
            { itemid = xi.item.VILE_ELIXIR,    droprate =  22 }, -- Vile Elixir
            { itemid = xi.item.POLE_GRIP,      droprate = 146 }, -- Pole Grip
            { itemid = xi.item.SWORD_STRAP,    droprate = 240 }, -- Sword Strap
        },

        {
            { itemid = xi.item.ZISKAS_CROSSBOW,       droprate = 287 }, -- Ziska's Crossbow
            { itemid = xi.item.UNJI,                  droprate = 216 }, -- Unji
            { itemid = xi.item.TAILLEFERS_DAGGER,     droprate = 198 }, -- Taillifer's Dagger
            { itemid = xi.item.SCHILTRON_SPEAR,       droprate = 287 }, -- Schiltron Spear
            { itemid = xi.item.SCROLL_OF_THUNDER_III, droprate = 287 }, -- Thunder III
        },

        {
            { itemid = xi.item.CORAL_FRAGMENT,          droprate =  52 }, -- Coral Fragment
            { itemid = xi.item.CHUNK_OF_DARKSTEEL_ORE,  droprate =  56 }, -- Chunk Of Darksteel Ore
            { itemid = xi.item.DEMON_HORN,              droprate =  41 }, -- Demon Horn
            { itemid = xi.item.EBONY_LOG,               droprate =  63 }, -- Ebony Log
            { itemid = xi.item.CHUNK_OF_GOLD_ORE,       droprate =  52 }, -- Chunk Of Gold Ore
            { itemid = xi.item.SPOOL_OF_GOLD_THREAD,    droprate =  26 }, -- Spool Of Gold Thread
            { itemid = xi.item.SLAB_OF_GRANITE,         droprate =  11 }, -- Slab Of Granite
            { itemid = xi.item.HI_RERAISER,             droprate =  37 }, -- Hi-reraiser
            { itemid = xi.item.MAHOGANY_LOG,            droprate = 101 }, -- Mahogany Log
            { itemid = xi.item.MYTHRIL_INGOT,           droprate =  30 }, -- Mythril Ingot
            { itemid = xi.item.CHUNK_OF_MYTHRIL_ORE,    droprate =  52 }, -- Chunk Of Mythril Ore
            { itemid = xi.item.PETRIFIED_LOG,           droprate = 116 }, -- Petrified Log
            { itemid = xi.item.PHOENIX_FEATHER,         droprate =  15 }, -- Phoenix Feather
            { itemid = xi.item.PHILOSOPHERS_STONE,      droprate =  56 }, -- Philosophers Stone
            { itemid = xi.item.CHUNK_OF_PLATINUM_ORE,   droprate =  45 }, -- Chunk Of Platinum Ore
            { itemid = xi.item.SQUARE_OF_RAINBOW_CLOTH, droprate =  22 }, -- Square Of Rainbow Cloth
            { itemid = xi.item.RAM_HORN,                droprate =  67 }, -- Ram Horn
            { itemid = xi.item.SQUARE_OF_RAXA,          droprate = 119 }, -- Square Of Raxa
            { itemid = xi.item.RERAISER,                droprate =  45 }, -- Reraiser
            { itemid = xi.item.NONE,                    droprate = 400 }, -- Nothing
        },

        {
            { itemid = xi.item.SQUARE_OF_DAMASCENE_CLOTH, droprate =  56 }, -- Square Of Damascene Cloth
            { itemid = xi.item.DAMASCUS_INGOT,            droprate =  93 }, -- Damascus Ingot
            { itemid = xi.item.SPOOL_OF_MALBORO_FIBER,    droprate =  56 }, -- Spool Of Malboro Fiber
            { itemid = xi.item.PHILOSOPHERS_STONE,        droprate = 157 }, -- Philosophers Stone
            { itemid = xi.item.PHOENIX_FEATHER,           droprate = 176 }, -- Phoenix Feather
            { itemid = xi.item.SQUARE_OF_RAXA,            droprate = 109 }, -- Square Of Raxa
            { itemid = xi.item.NONE,                      droprate = 500 }, -- Nothing
        }
    }

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
