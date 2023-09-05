-----------------------------------
-- Area: Chamber of Oracles
--  NPC: Armoury Crate
-----------------------------------
require("scripts/globals/battlefield")
require("scripts/globals/bcnm")
-----------------------------------
local entity = {}

local loot =
{
    -- BCNM Legion XI Comitatensis
    [193] =
    {
        {
            { itemid =     0, droprate = 100 }, -- nothing
            { itemid = 13148, droprate = 150 }, -- evasion_torque
            { itemid = 13149, droprate = 150 }, -- parrying_torque
            { itemid = 13151, droprate = 150 }, -- guarding_torque
            { itemid = 13159, droprate = 150 }, -- ninjutsu_torque
            { itemid = 13161, droprate = 150 }, -- wind_torque
            { itemid = 13158, droprate = 150 }, -- summoning_torque
        },

        {
            { itemid =     0, droprate = 100 }, -- nothing
            { itemid = 13152, droprate = 150 }, -- divine_torque
            { itemid = 13153, droprate = 150 }, -- dark_torque
            { itemid = 13154, droprate = 150 }, -- enhancing_torque
            { itemid = 13155, droprate = 150 }, -- enfeebling_torque
            { itemid = 13156, droprate = 150 }, -- elemental_torque
            { itemid = 13157, droprate = 150 }, -- healing_torque
        },

        {
            { itemid = 803, droprate = 100 }, -- sunstone
            { itemid = 737, droprate = 100 }, -- chunk_of_gold_ore
            { itemid = 784, droprate = 100 }, -- jadeite
            { itemid = 810, droprate = 100 }, -- fluorite
            { itemid = 654, droprate = 100 }, -- darksteel_ingot
            { itemid = 805, droprate = 100 }, -- zircon
            { itemid = 801, droprate = 100 }, -- chrysoberyl
            { itemid = 802, droprate = 100 }, -- moonstone
            { itemid = 797, droprate = 100 }, -- painite
            { itemid = 652, droprate = 100 }, -- steel_ingot
        },

        {
            { itemid =    0, droprate = 500 }, -- nothing
            { itemid = 4621, droprate = 500 }, -- scroll_of_raise_ii
        },

        {
            { itemid =    0, droprate = 950 }, -- nothing
            { itemid = 4175, droprate =  50 }, -- vile_elixir_+1
        },

        {
            { itemid = 771, droprate =  50 }, -- yellow_rock
            { itemid = 776, droprate =  50 }, -- white_rock
            { itemid = 702, droprate = 125 }, -- ebony_log
            { itemid = 751, droprate = 775 }, -- platinum_beastcoin
        },

        {
            { itemid =    0, droprate = 600 }, -- nothing
            { itemid = 1260, droprate =  50 }, -- chunk_of_water_ore
            { itemid = 1256, droprate =  50 }, -- chunk_of_ice_ore
            { itemid = 1259, droprate =  50 }, -- chunk_of_lightning_ore
            { itemid = 1258, droprate =  50 }, -- chunk_of_earth_ore
            { itemid = 1255, droprate =  50 }, -- chunk_of_fire_ore
            { itemid = 1261, droprate =  50 }, -- chunk_of_light_ore
            { itemid = 1262, droprate =  50 }, -- chunk_of_dark_ore
            { itemid = 1257, droprate =  50 }, -- chunk_of_wind_ore
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

    -- KSNM Eye of the Storm
    [198] =
    {
        {
            { itemid = 1124, droprate = 1000 }, -- Wyvern Wing
        },

        {
            { itemid = 1122, droprate = 1000 }, -- Wyvern Skin
        },

        {
            { itemid = 65535, droprate = 1000, amount = 24000 }, -- gil

        },

        {
            { itemid = 17938, droprate = 150 }, -- Woodville's Axe
            { itemid = 17998, droprate = 150 }, -- Thanatos Baselard
            { itemid = 17579, droprate = 200 }, -- Wyvern Perch
            { itemid = 18373, droprate = 300 }, -- Balin's Sword
        },

        {
            { itemid = xi.items.BOURDONASSE,    droprate = 150 },
            { itemid = xi.items.VILE_ELIXIR,    droprate = 150 },
            { itemid = xi.items.VILE_ELIXIR_P1, droprate = 150 },
            { itemid = xi.items.POLE_GRIP,      droprate = 150 },
            { itemid = xi.items.SWORD_STRAP,    droprate = 350 },
            { itemid = xi.items.CLAYMORE_GRIP,  droprate =  50 },
        },

        {
            { itemid =     0, droprate = 100 }, -- Nothing
            { itemid = 17246, droprate = 200 }, -- Ziska's Crossbow
            { itemid = 17790, droprate = 150 }, -- Unji
            { itemid = 17999, droprate = 200 }, -- Taillifer's Dagger
            { itemid = 18089, droprate = 350 }, -- Schiltron Spear
        },

        {
            { itemid =     0, droprate =  780 }, -- Nothing
            { itemid =  4774, droprate =  85 }, -- Thunder III
            { itemid =  4774, droprate =  50 }, -- Cure V
            { itemid =  4774, droprate =  85 }, -- Shell IV
        },

        {
            { itemid =  644, droprate =  50 }, -- Chunk Of Mythril Ore
            { itemid =  645, droprate =  50 }, -- Chunk Of Darksteel Ore
            { itemid =  653, droprate =  50 }, -- Mythril Ingot
            { itemid =  700, droprate =  75 }, -- Mahogany Log
            { itemid =  702, droprate =  60 }, -- Ebony Log
            { itemid =  703, droprate =  75 }, -- Petrified Log
            { itemid =  737, droprate =  50 }, -- Chunk Of Gold Ore
            { itemid =  738, droprate =  50 }, -- Chunk Of Platinum Ore
            { itemid =  823, droprate =  50 }, -- Spool Of Gold Thread
            { itemid =  830, droprate =  50 }, -- Square Of Rainbow Cloth
            { itemid =  844, droprate =  20 }, -- Phoenix Feather
            { itemid =  887, droprate =  50 }, -- Coral Fragment
            { itemid =  895, droprate =  50 }, -- Ram Horn
            { itemid =  902, droprate =  50 }, -- Demon Horn
            { itemid =  942, droprate =  50 }, -- Philosophers Stone
            { itemid = 1132, droprate = 120 }, -- Square Of Raxa
            { itemid = 1465, droprate =  25 }, -- Slab Of Granite
            { itemid = 4172, droprate =  50 }, -- Reraiser
            { itemid = 4173, droprate =  25 }, -- Hi-reraiser
        },
        {
            { itemid =    0,                  droprate = 575 }, -- Nothing
            { itemid = xi.items.BEETLE_BLOOD, droprate =  85 },
            { itemid =  658,                  droprate =  85 }, -- Damascus Ingot
            { itemid =  836,                  droprate =  65 }, -- Square Of Damascene Cloth
            { itemid =  837,                  droprate =  45 }, -- Spool Of Malboro Fiber
            { itemid =  844,                  droprate = 100 }, -- Phoenix Feather
            { itemid =  942,                  droprate =  65 }, -- Philosophers Stone
            { itemid = 1132,                  droprate =  65 }, -- Square Of Raxa
        }
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
            { itemid = 4174,  droprate = 350 }, -- Vile Elixir
            { itemid = 4175,  droprate = 100 }, -- Vile Elixir +1
            { itemid = 4613,  droprate = 100 }, -- Cure V
            { itemid = xi.items.POLE_GRIP,     droprate = 250 },
            { itemid = xi.items.SPEAR_STRAP,   droprate = 100 },
            { itemid = xi.items.CLAYMORE_GRIP, droprate = 100 },
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
}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local battlefield = player:getBattlefield()
    if battlefield then
        xi.battlefield.HandleLootRolls(battlefield, loot[battlefield:getID()], nil, npc)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
