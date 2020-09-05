-----------------------------------
-- Area: Chamber of Oracles
--  NPC: Armoury Crate
-------------------------------------
require("scripts/globals/battlefield")
require("scripts/globals/bcnm")
-------------------------------------

local loot =
{
    -- BCNM Legion XI Comitatensis
    [193] =
    {
        {
            {itemid =     0, droprate =  100}, -- nothing
            {itemid = 13148, droprate =  150}, -- evasion_torque
            {itemid = 13149, droprate =  150}, -- parrying_torque
            {itemid = 13151, droprate =  150}, -- guarding_torque
            {itemid = 13159, droprate =  150}, -- ninjutsu_torque
            {itemid = 13161, droprate =  150}, -- wind_torque
            {itemid = 13158, droprate =  150}, -- summoning_torque
        },
        {
            {itemid =     0, droprate =  100}, -- nothing
            {itemid = 13152, droprate =  150}, -- divine_torque
            {itemid = 13153, droprate =  150}, -- dark_torque
            {itemid = 13154, droprate =  150}, -- enhancing_torque
            {itemid = 13155, droprate =  150}, -- enfeebling_torque
            {itemid = 13156, droprate =  150}, -- elemental_torque
            {itemid = 13157, droprate =  150}, -- healing_torque
        },
        {
            {itemid =   803, droprate =  100}, -- sunstone
            {itemid =   737, droprate =  100}, -- chunk_of_gold_ore
            {itemid =   784, droprate =  100}, -- jadeite
            {itemid =   810, droprate =  100}, -- fluorite
            {itemid =   654, droprate =  100}, -- darksteel_ingot
            {itemid =   805, droprate =  100}, -- zircon
            {itemid =   801, droprate =  100}, -- chrysoberyl
            {itemid =   802, droprate =  100}, -- moonstone
            {itemid =   797, droprate =  100}, -- painite
            {itemid =   652, droprate =  100}, -- steel_ingot
        },
        {
            {itemid =     0, droprate =  500}, -- nothing
            {itemid =  4621, droprate =  500}, -- scroll_of_raise_ii
        },
        {
            {itemid =     0, droprate =  950}, -- nothing
            {itemid =  4175, droprate =   50}, -- vile_elixir_+1
        },
        {
            {itemid =   771, droprate =   50}, -- yellow_rock
            {itemid =   776, droprate =   50}, -- white_rock
            {itemid =   702, droprate =  125}, -- ebony_log
            {itemid =   751, droprate =  775}, -- platinum_beastcoin
        },
        {
            {itemid =     0, droprate =  600}, -- nothing
            {itemid =  1260, droprate =   50}, -- chunk_of_water_ore
            {itemid =  1256, droprate =   50}, -- chunk_of_ice_ore
            {itemid =  1259, droprate =   50}, -- chunk_of_lightning_ore
            {itemid =  1258, droprate =   50}, -- chunk_of_earth_ore
            {itemid =  1255, droprate =   50}, -- chunk_of_fire_ore
            {itemid =  1261, droprate =   50}, -- chunk_of_light_ore
            {itemid =  1262, droprate =   50}, -- chunk_of_dark_ore
            {itemid =  1257, droprate =   50}, -- chunk_of_wind_ore
        },
    },
    -- KSNM Eye of the Storm
    [198] =
    {
        {
            {itemid = 1124, droprate = 1000}, -- Wyvern Wing
        },
        {
            {itemid = 1122, droprate = 1000}, -- Wyvern Skin
        },

        {
            {itemid = 65535, droprate = 1000, amount = 24000},  -- gil

        },
        {
            {itemid = 836, droprate = 216}, -- Damascene Cloth
            {itemid = 658, droprate = 295}, -- Damascus Ingot
            {itemid = 17938, droprate = 239}, -- Woodville's Axe
            {itemid = 17998, droprate = 231}, -- Thanatos Baselard
            {itemid = 17579, droprate = 231}, -- Wyvern Perch
            {itemid = 18373, droprate = 231}, -- Balin's Sword
            {itemid = 1110, droprate = 231}, -- Beetle Blood
        },
        {
            {itemid = 18092, droprate = 104}, -- Bourdonasse
            {itemid = 4175, droprate = 86}, -- Vile Elixir +1
            {itemid = 4174, droprate = 22}, -- Vile Elixir
            {itemid = 19025, droprate = 146}, -- Pole Grip
            {itemid = 19024, droprate = 240}, -- Sword Strap
        },
        {
            {itemid = 17246, droprate = 287}, -- Ziska's Crossbow
            {itemid = 17790, droprate = 216}, -- Unji
            {itemid = 17999, droprate = 198}, -- Taillifer's Dagger
            {itemid = 18089, droprate = 287}, -- Schiltron Spear
            {itemid = 4774, droprate = 287}, -- Thunder III
        },
        {
            {itemid = 887, droprate = 52}, -- Coral Fragment
            {itemid = 645, droprate = 56}, -- Chunk Of Darksteel Ore
            {itemid = 902, droprate = 41}, -- Demon Horn
            {itemid = 702, droprate = 63}, -- Ebony Log
            {itemid = 737, droprate = 52}, -- Chunk Of Gold Ore
            {itemid = 823, droprate = 26}, -- Spool Of Gold Thread
            {itemid = 1465, droprate = 11}, -- Slab Of Granite
            {itemid = 4173, droprate = 37}, -- Hi-reraiser
            {itemid = 700, droprate = 101}, -- Mahogany Log
            {itemid = 653, droprate = 30}, -- Mythril Ingot
            {itemid = 644, droprate = 52}, -- Chunk Of Mythril Ore
            {itemid = 703, droprate = 116}, -- Petrified Log
            {itemid = 844, droprate = 15}, -- Phoenix Feather
            {itemid = 942, droprate = 56}, -- Philosophers Stone
            {itemid = 738, droprate = 45}, -- Chunk Of Platinum Ore
            {itemid = 830, droprate = 22}, -- Square Of Rainbow Cloth
            {itemid = 895, droprate = 67}, -- Ram Horn
            {itemid = 1132, droprate = 119}, -- Square Of Raxa
            {itemid = 4172, droprate = 45}, -- Reraiser
            {itemid = 0, droprate = 400} -- Nothing
        },
        {
            {itemid = 836, droprate = 56}, -- Square Of Damascene Cloth
            {itemid = 658, droprate = 93}, -- Damascus Ingot
            {itemid = 837, droprate = 56}, -- Spool Of Malboro Fiber
            {itemid = 942, droprate = 157}, -- Philosophers Stone
            {itemid = 844, droprate = 176}, -- Phoenix Feather
            {itemid = 1132, droprate = 109}, -- Square Of Raxa
            {itemid = 0, droprate = 500}, -- Nothing
        }
    }

}

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local battlefield = player:getBattlefield()
    if battlefield then
        tpz.battlefield.HandleLootRolls(battlefield, loot[battlefield:getID()], nil, npc)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
