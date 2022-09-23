-----------------------------------
-- Area: Ghelsba_Outpost
--  NPC: Armoury Crate
-- Ghelsba_Outpost Armoury_Crate
-----------------------------------
local entity = {}

require("scripts/globals/bcnm")
require("scripts/globals/battlefield")
-----------------------------------
local loot =
{
    -- BCNM Wings of Fury
    [34] =
    {
        {
            {itemid = 891, droprate = 1000}, -- Bat Fang
        },
        {
            {itemid = 4900, droprate = 306}, -- Thunder Spirit Pact
            {itemid = 4744, droprate = 319}, -- Scroll Of Invisible
            {itemid = 4745, droprate = 125}, -- Scroll Of Sneak
            {itemid = 4746, droprate = 222}, -- Scroll Of Deodorize
        },
        {
            {itemid = 17786, droprate = 153}, -- Ganko
            {itemid = 18170, droprate = 139}, -- Platoon Edge
            {itemid = 16687, droprate = 83}, -- Platoon Axe
            {itemid = 17571, droprate = 97}, -- Platoon Pole
            {itemid = 17993, droprate = 125}, -- Platoon Dagger
            {itemid = 749, droprate = 444},  -- Mythril Beastcoin
            {itemid = 773, droprate = 56},   -- Translucent Rock
        },
        {
            {itemid = 17820, droprate = 111}, -- Gunromaru
            {itemid = 17993, droprate = 139}, -- Platoon Dagger
            {itemid = 18170, droprate = 139}, -- Platoon Edge
            {itemid = 18085, droprate = 42}, -- Platoon Lance
            {itemid = 16959, droprate = 181}, -- Platoon Sword
            {itemid = 774, droprate = 97},   -- Purple Rock
            {itemid = 769, droprate = 69},   -- Red Rock
            {itemid = 776, droprate = 14},   -- White Rock
            {itemid = 775, droprate = 28},   -- Black Rock
            {itemid = 772, droprate = 28},   -- Green Rock
            {itemid = 771, droprate = 14},   -- Yellow Rock
            {itemid = 770, droprate = 69},   -- Blue Rock
        },
        {
            {itemid =     0, droprate = 389}, -- nothing
            {itemid = 13548, droprate = 167}, -- astral_ring
            {itemid =   922, droprate = 444}, -- bat_wing
        },
    },

    -- BCNM Petrifying Pair
    [35] =
    {
        {
            {itemid = 852, droprate = 1000}, -- Lizard Skin
        },
        {
            {itemid =     0, droprate =  900}, -- nothing
            {itemid = 13014, droprate =  100}, -- leaping_boots
        },
        {
            {itemid = 15282, droprate =   50}, -- Katana Obi
            {itemid = 15275, droprate =   75}, -- Rapier Belt
            {itemid = 15278, droprate =  175}, -- Scythe Belt
            {itemid =   694, droprate =  175}, -- Chestnut Log
            {itemid =   690, droprate =  350}, -- Elm Log
            {itemid =   652, droprate =  100}, -- Steel Ingot
        },
        {
            {itemid =     0, droprate =  925}, -- nothing (50%)
            {itemid = 15282, droprate =   50}, -- Katana Obi
            {itemid = 15275, droprate =   75}, -- Rapier Belt
            {itemid = 15278, droprate =  175}, -- Scythe Belt
            {itemid =   694, droprate =  175}, -- Chestnut Log
            {itemid =   690, droprate =  350}, -- Elm Log
            {itemid =   652, droprate =  100}, -- Steel Ingot
        },
        {
            {itemid = 15285, droprate = 105}, -- Avatar Belt
            {itemid = 15279, droprate = 105}, -- Pick Belt
            {itemid = 651, droprate = 131},  -- Iron Ingot
            {itemid = 643, droprate = 131},  -- Chunk Of Iron Ore
            {itemid = 644, droprate = 79},   -- Chunk Of Mythril Ore
            {itemid = 736, droprate = 79},   -- Chunk Of Silver Ore
            {itemid = 795, droprate = 131},  -- Lapis Lazuli
        },
        {
            {itemid = 17867, droprate = 552}, -- Jug Of Cold Carrion Broth
            {itemid = 4877, droprate = 263}, -- Scroll Of Absorb-agi
            {itemid = 4878, droprate = 210}, -- Scroll Of Absorb-int
            {itemid = 4876, droprate = 289}, -- Scroll Of Absorb-vit
            {itemid = 4868, droprate = 105}, -- Scroll Of Dispel
            {itemid = 4751, droprate = 79},  -- Scroll Of Erase
            {itemid = 5070, droprate = 421}, -- Scroll Of Magic Finale
            {itemid = 4947, droprate = 79},  -- Scroll Of Utsusemi Ni
        },
        {
            {itemid =     0, droprate =  736}, -- nothing (25%)
            {itemid = 15271, droprate =  200}, -- Axe Belt
            {itemid = 15272, droprate =  125}, -- Cestus Belt
            {itemid =   809, droprate =   10}, -- Clear Topaz
            {itemid = 15276, droprate =   75}, -- Dagger Belt
            {itemid =   645, droprate =  100}, -- Darksteel Ore
            {itemid = 15281, droprate =   25}, -- Gun Belt
            {itemid =  4132, droprate =  175}, -- Hi-ether
            {itemid = 15284, droprate =  200}, -- Lance Belt
            {itemid =   796, droprate =   75}, -- Light Opal
            {itemid = 15273, droprate =  175}, -- Mace Belt
            {itemid =   653, droprate =  200}, -- Mythril Ingot
            {itemid =   799, droprate =   25}, -- Onyx
            {itemid = 15283, droprate =  250}, -- Sarashi
            {itemid = 15277, droprate =  100}, -- Shield Belt
            {itemid = 15280, droprate =  100}, -- Song Belt
            {itemid = 15274, droprate =  150}, -- Staff Belt
            {itemid =   744, droprate =  100}, -- Silver Ingot
            {itemid =   806, droprate =  125}, -- Tourmaline
        },
        {
            {itemid =     0, droprate = 2210}, -- nothing (50%)
            {itemid = 15271, droprate =  200}, -- Axe Belt
            {itemid = 15272, droprate =  125}, -- Cestus Belt
            {itemid =   809, droprate =   10}, -- Clear Topaz
            {itemid = 15276, droprate =   75}, -- Dagger Belt
            {itemid =   645, droprate =  100}, -- Darksteel Ore
            {itemid = 15281, droprate =   25}, -- Gun Belt
            {itemid =  4132, droprate =  175}, -- Hi-ether
            {itemid = 15284, droprate =  200}, -- Lance Belt
            {itemid =   796, droprate =   75}, -- Light Opal
            {itemid = 15273, droprate =  175}, -- Mace Belt
            {itemid =   653, droprate =  200}, -- Mythril Ingot
            {itemid =   799, droprate =   25}, -- Onyx
            {itemid = 15283, droprate =  250}, -- Sarashi
            {itemid = 15277, droprate =  100}, -- Shield Belt
            {itemid = 15280, droprate =  100}, -- Song Belt
            {itemid = 15274, droprate =  150}, -- Staff Belt
            {itemid =   744, droprate =  100}, -- Silver Ingot
            {itemid =   806, droprate =  125}, -- Tourmaline
        },
    },

    -- BCNM Toadal Recall
    [36] =
    {
        {
            {itemid =  4386, droprate = 1000}, -- king_truffle
        },
        {
            {itemid = 17880, droprate = 1000}, -- jug_of_seedbed_soil
        },
        {
            {itemid =     0, droprate =  200}, -- nothing
            {itemid = 12403, droprate =  200}, -- magicians_shield
            {itemid = 12389, droprate =  200}, -- mercenarys_targe
            {itemid = 12399, droprate =  200}, -- beaters_aspis
            {itemid = 12394, droprate =  200}, -- pilferers_aspis
        },
        {
            {itemid =     0, droprate =  250}, -- nothing
            {itemid = 13667, droprate =  250}, -- trimmers_mantle
            {itemid = 13671, droprate =  250}, -- genin_mantle
            {itemid = 13663, droprate =  250}, -- warlocks_mantle
        },
        {
            {itemid =     0, droprate =  625}, -- nothing
            {itemid =  4947, droprate =  125}, -- scroll_of_utsusemi_ni
            {itemid =  4714, droprate =  125}, -- scroll_of_phalanx
            {itemid =  4751, droprate =  125}, -- scroll_of_erase
        },
        {
            {itemid =     0, droprate =  250}, -- nothing
            {itemid =  1601, droprate =  250}, -- mannequin_head
            {itemid =  1602, droprate =  250}, -- mannequin_body
            {itemid =  1603, droprate =  250}, -- mannequin_hands
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

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
