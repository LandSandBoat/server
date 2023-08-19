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
            { itemid =    0, droprate = 125 }, -- nothing
            { itemid = 4896, droprate = 125 }, -- fire_spirit_pact
            { itemid = 4714, droprate = 125 }, -- scroll_of_phalanx
            { itemid = 4947, droprate = 125 }, -- scroll_of_utsusemi_ni
            { itemid = 4751, droprate = 125 }, -- scroll_of_erase
            { itemid = 4858, droprate = 125 }, -- scroll_of_ice_spikes
            { itemid = 4874, droprate = 125 }, -- scroll_of_absorb-str
            { itemid = 4717, droprate = 125 }, -- scroll_of_refresh
        },

        {
            { itemid =     0, droprate = 125 }, -- nothing
            { itemid = 13405, droprate = 125 }, -- enhancing_earring
            { itemid = 13129, droprate = 125 }, -- spirit_torque
            { itemid = 13127, droprate = 125 }, -- guarding_gorget
            { itemid = 13404, droprate = 125 }, -- nemesis_earring
            { itemid = 13623, droprate = 125 }, -- earth_mantle
            { itemid = 12350, droprate = 125 }, -- strike_shield
            { itemid = 17203, droprate = 125 }, -- shikar_bow
        },

        {
            { itemid = 699, droprate = 500 }, -- oak_log
            { itemid = 701, droprate = 500 }, -- rosewood_log
        },

        {
            { itemid = 748, droprate = 500 }, -- gold_beastcoin
            { itemid = 749, droprate = 500 }, -- mythril_beastcoin
        },

        {
            { itemid = 793, droprate = 200 }, -- black_pearl
            { itemid = 811, droprate = 200 }, -- ametrine
            { itemid = 771, droprate = 200 }, -- yellow_rock
            { itemid = 788, droprate = 200 }, -- peridot
            { itemid = 798, droprate = 200 }, -- turquoise
        },

        {
            { itemid =    0, droprate = 800 }, -- nothing
            { itemid = 4172, droprate = 200 }, -- reraiser
        },
    },

    -- BCNM Grimshell Shocktroopers
    [66] =
    {
        {
            { itemid =     0, droprate = 250 }, -- nothing
            { itemid = 13403, droprate = 125 }, -- assault_earring
            { itemid = 16788, droprate = 125 }, -- vassagos_scythe
            { itemid = 17615, droprate = 125 }, -- chicken_knife
            { itemid = 17430, droprate = 125 }, -- fey_wand
            { itemid = 12351, droprate = 125 }, -- astral_shield
            { itemid = 13624, droprate = 125 }, -- enhancing_mantle
        },

        {
            { itemid = 653, droprate = 250 }, -- mythril_ingot
            { itemid = 652, droprate = 250 }, -- steel_ingot
            { itemid = 745, droprate = 250 }, -- gold_ingot
            { itemid = 654, droprate = 250 }, -- darksteel_ingot
        },

        {
            { itemid = 702, droprate = 250 }, -- ebony_log
            { itemid = 801, droprate = 250 }, -- chrysoberyl
            { itemid = 810, droprate = 250 }, -- fluorite
            { itemid = 140, droprate = 250 }, -- jadeite
        },

        {
            { itemid =    0, droprate = 875 }, -- nothing
            { itemid = 4621, droprate = 125 }, -- scroll_of_raise_ii
        },

        {
            { itemid =    0, droprate = 800 }, -- nothing
            { itemid = 4621, droprate = 200 }, -- hi-reraiser
        },
    },

    -- BCNM 3, 2, 1...
    [69] =
    {
        {
            { itemid = 16897, droprate = 500 }, -- kageboshi
            { itemid = 16991, droprate = 500 }, -- odenta
        },

        {
            { itemid = 13251, droprate = 200 }, -- ocean_belt
            { itemid = 13252, droprate = 200 }, -- forest_belt
            { itemid = 13253, droprate = 200 }, -- steppe_belt
            { itemid = 13254, droprate = 200 }, -- jungle_belt
            { itemid = 13255, droprate = 200 }, -- desert_belt
        },

        {
            { itemid =    0, droprate = 250 }, -- nothing
            { itemid = 4814, droprate = 125 }, -- scroll_of_freeze
            { itemid = 4818, droprate = 125 }, -- scroll_of_quake
            { itemid = 4621, droprate = 125 }, -- scroll_of_raise_ii
            { itemid = 4719, droprate = 125 }, -- scroll_of_regen_iii
            { itemid = 4896, droprate = 125 }, -- fire_spirit_pact
            { itemid = 4902, droprate = 125 }, -- light_spirit_pact
        },

        {
            { itemid =   0, droprate = 800 }, -- nothing
            { itemid = 703, droprate = 200 }, -- petrified_log
        },
    },

    -- BCNM Birds of a Feather
    [73] =
    {
        {
            { itemid = 847, droprate = 1000 }, -- Bird Feather
        },

        {
            { itemid = 14735, droprate = 125 }, -- Ashigaru Earring
            { itemid = 14732, droprate = 125 }, -- Trimmers Earring
            { itemid = 14734, droprate = 125 }, -- Beaters Earring
            { itemid = 13437, droprate = 125 }, -- Healers Earring
            { itemid = 13435, droprate = 125 }, -- Mercenarys Earring
            { itemid = 14733, droprate = 125 }, -- Singers Earring
            { itemid = 13438, droprate = 125 }, -- Wizards Earring
            { itemid = 13436, droprate = 125 }, -- Wrestlers Earring
        },

        {
            { itemid =     0, droprate = 125 }, -- nothing
            { itemid = 15285, droprate = 125 }, -- Avatar Belt
            { itemid = 15276, droprate = 125 }, -- Dagger Belt
            { itemid = 15284, droprate = 125 }, -- Lance Belt
            { itemid = 15275, droprate = 125 }, -- Rapier Belt
            { itemid = 15283, droprate = 125 }, -- Sarashi
            { itemid = 15278, droprate = 125 }, -- Scythe Belt
            { itemid = 15277, droprate = 125 }, -- Shield Belt
        },

        {
            { itemid =    0, droprate = 500 }, -- nothing
            { itemid = 4868, droprate = 125 }, -- Scroll Of Dispel
            { itemid = 4751, droprate = 125 }, -- Scroll Of Erase
            { itemid = 5070, droprate = 125 }, -- Scroll Of Magic Finale
            { itemid = 4947, droprate = 125 }, -- Scroll Of Utsusemi Ni
        },

        {
            { itemid =    0, droprate = 136 }, -- nothing
            { itemid = 4570, droprate = 125 }, -- Bird Egg
            { itemid =  847, droprate =  50 }, -- Bird Feather
            { itemid =  694, droprate = 125 }, -- Chestnut Log
            { itemid =  690, droprate = 188 }, -- Elm Log
            { itemid = 4132, droprate =  63 }, -- Hi-ether
            { itemid = 4222, droprate = 313 }, -- Horn Quiver
        },

        {
            { itemid =   0, droprate = 123 }, -- nothing
            { itemid = 651, droprate =  63 }, -- Iron Ingot
            { itemid = 795, droprate = 125 }, -- Lapis Lazuli
            { itemid = 796, droprate = 125 }, -- Light Opal
            { itemid = 653, droprate =  63 }, -- Mythril Ingot
            { itemid = 644, droprate =  63 }, -- Chunk Of Mythril Ore
            { itemid = 799, droprate = 250 }, -- Onyx
            { itemid = 736, droprate =  63 }, -- Chunk Of Silver Ore
            { itemid = 744, droprate = 125 }, -- Silver Ingot
        },

    },

    -- BCNM Crustacean Conundrum
    [74] =
    {
        {
            { itemid = 4400, droprate = 1000 }, -- slice_of_land_crab_meat
        },

        {
            { itemid = 1602, droprate = 1000 }, -- mannequin_body
        },

        {
            { itemid =   0, droprate = 334 }, -- nothing
            { itemid = 881, droprate = 666 }, -- crab_shell
        },

        {
            { itemid =  4221, droprate = 444 }, -- beetle_quiver
            { itemid = 17877, droprate = 556 }, -- jug_of_fish_oil_broth
        },

        {
            { itemid =   0, droprate = 450 }, -- nothing
            { itemid = 650, droprate = 100 }, -- brass_ingot
            { itemid = 660, droprate = 150 }, -- bronze_sheet
            { itemid = 649, droprate = 300 }, -- bronze_ingot
        },

        {
            { itemid =    0, droprate = 300 }, -- nothing
            { itemid =  749, droprate = 500 }, -- mythril_beastcoin
            { itemid = 1603, droprate = 100 }, -- mannequin_hands
            { itemid = 1601, droprate = 100 }, -- mannequin_head
        },

        {
            { itemid =     0, droprate = 200 }, -- nothing
            { itemid = 17519, droprate = 100 }, -- platoon_cesti
            { itemid = 17993, droprate = 100 }, -- platoon_dagger
            { itemid = 16687, droprate = 100 }, -- platoon_axe
            { itemid = 17202, droprate = 100 }, -- platoon_bow
            { itemid = 18085, droprate = 100 }, -- platoon_lance
            { itemid = 16959, droprate = 100 }, -- platoon_sword
            { itemid = 17462, droprate = 100 }, -- platoon_mace
            { itemid = 18045, droprate = 100 }, -- platoon_zaghnal
        },
    },

    -- BCNM Grove Guardians
    [75] =
    {
        {
            { itemid = 1602, droprate = 1000 }, -- mannequin_body
        },

        {
            { itemid =    0, droprate = 800 }, -- nothing
            { itemid = 1603, droprate = 200 }, -- mannequin_hands
        },

        {
            { itemid =     0, droprate = 250 }, -- nothing
            { itemid = 13660, droprate = 250 }, -- wrestlers_mantle
            { itemid = 13673, droprate = 250 }, -- magicians_mantle
            { itemid = 13664, droprate = 250 }, -- pilferers_mantle
        },

        {
            { itemid =     0, droprate = 200 }, -- nothing
            { itemid = 12391, droprate = 200 }, -- healers_shield
            { itemid = 12401, droprate = 200 }, -- genin_aspis
            { itemid = 12396, droprate = 200 }, -- killer_targe
            { itemid = 15274, droprate = 200 }, -- staff_belt
        },

        {
            { itemid =   0, droprate = 250 }, -- nothing
            { itemid = 572, droprate = 250 }, -- bag_of_herb_seeds
            { itemid = 573, droprate = 250 }, -- bag_of_vegetable_seeds
            { itemid = 575, droprate = 250 }, -- bag_of_grain_seeds
        },

        {
            { itemid =    0, droprate = 500 }, -- nothing
            { itemid = 4868, droprate = 125 }, -- scroll_of_dispel
            { itemid = 4947, droprate = 125 }, -- scroll_of_utsusemi_ni
            { itemid = 5070, droprate = 125 }, -- scroll_of_magic_finale
            { itemid = 4751, droprate = 125 }, -- scroll_of_erase
        },

        {
            { itemid =    0, droprate = 800 }, -- nothing
            { itemid = 4223, droprate = 200 }, -- scorpion_quiver
        },
    },

    -- KSNM The Hills are Alive
    [76] =
    {
        {
            { itemid = 3343, droprate = 1000 }, -- Blue Pondweed
        },

        {
            { itemid = 18047, droprate = 188 }, -- Havoc Scythe
            { itemid = 17939, droprate =  27 }, -- Kriegsbeil
            { itemid = 17937, droprate = 170 }, -- Leopard Axe
            { itemid =  1441, droprate = 295 }, -- Libation Abjuration
            { itemid = 18351, droprate =  27 }, -- Meteor Cesti
            { itemid = 17464, droprate =  71 }, -- Purgatory Mace
            { itemid = 17575, droprate = 196 }, -- Somnus Signa
        },

        {
            { itemid = 18211, droprate =  45 }, -- Gawains Axe
            { itemid = 17576, droprate = 259 }, -- Grim Staff
            { itemid = 17245, droprate = 241 }, -- Grosveneurs Bow
            { itemid = 17838, droprate = 143 }, -- Harlequins Horn
            { itemid =  1442, droprate = 161 }, -- Oblation Abjuration
            { itemid = 17996, droprate = 143 }, -- Stylet
            { itemid = 17578, droprate =  36 }, -- Zen Pole
        },

        {
            { itemid =   683, droprate = 446 }, -- Adaman Chain
            { itemid =   908, droprate = 420 }, -- Adamantoise Shell
            { itemid =  1312, droprate =  71 }, -- Piece Of Angel Skin
            { itemid = 14080, droprate =  26 }, -- Strider Boots
        },

        {
            { itemid =  887, droprate = 116 }, -- Coral Fragment
            { itemid =  645, droprate =  89 }, -- Chunk Of Darksteel Ore
            { itemid =  902, droprate =  71 }, -- Demon Horn
            { itemid =  702, droprate = 152 }, -- Ebony Log
            { itemid =  737, droprate = 107 }, -- Chunk Of Gold Ore
            { itemid =  823, droprate =  89 }, -- Spool Of Gold Thread
            { itemid = 1465, droprate =  45 }, -- Slab Of Granite
            { itemid = 4173, droprate =  71 }, -- Hi-reraiser
            { itemid =  700, droprate = 107 }, -- Mahogany Log
            { itemid =  703, droprate = 223 }, -- Petrified Log
            { itemid =  738, droprate = 116 }, -- Chunk Of Platinum Ore
            { itemid =  830, droprate =  54 }, -- Square Of Rainbow Cloth
            { itemid =  895, droprate =  54 }, -- Ram Horn
            { itemid = 1132, droprate =  71 }, -- Square Of Raxa
            { itemid = 4172, droprate =  45 }, -- Reraiser
            { itemid =  866, droprate =  54 }, -- Handful Of Wyvern Scales
            { itemid = 4174, droprate =  63 }, -- Vile Elixir
            { itemid = 4175, droprate =  45 }, -- Vile Elixir +1
        },

        {
            { itemid =  683, droprate = 268 }, -- Adaman Chain
            { itemid = 1525, droprate = 121 }, -- Adamantoise Egg
            { itemid = 4205, droprate =  80 }, -- Agility Potion
            { itemid = 4201, droprate = 143 }, -- Dexterity Potion
            { itemid = 4199, droprate = 214 }, -- Strength Potion
            { itemid = 4203, droprate = 196 }, -- Vitality Potion
        },

        {
            { itemid =   646, droprate = 107 }, -- Chunk Of Adaman Ore
            { itemid =  4211, droprate =  89 }, -- Charisma Potion
            { itemid =   645, droprate = 179 }, -- Chunk Of Darksteel Ore
            { itemid =  4213, droprate = 134 }, -- Icarus Wing
            { itemid =  4207, droprate = 152 }, -- Intelligence Potion
            { itemid =  4209, droprate =  80 }, -- Mind Potion
            { itemid =   739, droprate =  80 }, -- Chunk Of Orichalcum Ore
            { itemid =   738, droprate = 107 }, -- Chunk Of Platinum Ore
            { itemid = 17698, droprate = 152 }, -- Princely Sword
        },

        {
            { itemid = 4135, droprate = 295 },  -- Hi-ether +3
            { itemid = 4119, droprate = 250 },  -- Hi-potion +3
            { itemid = 4173, droprate = 196 },  -- Hi-reraiser
            { itemid = 4175, droprate = 214 },  -- Vile Elixir +1
        },

        {
            { itemid =  887, droprate = 139 }, -- Coral Fragment
            { itemid =  645, droprate =  59 }, -- Chunk Of Darksteel Ore
            { itemid =  902, droprate =  50 }, -- Demon Horn
            { itemid =  702, droprate = 109 }, -- Ebony Log
            { itemid =  737, droprate =  69 }, -- Chunk Of Gold Ore
            { itemid = 1465, droprate =  99 }, -- Slab Of Granite
            { itemid = 4173, droprate =  79 }, -- Hi-reraiser
            { itemid =  700, droprate = 129 }, -- Mahogany Log
            { itemid =  644, droprate = 119 }, -- Chunk Of Mythril Ore
            { itemid =  844, droprate =  69 }, -- Phoenix Feather
            { itemid =  703, droprate = 168 }, -- Petrified Log
            { itemid =  738, droprate = 129 }, -- Chunk Of Platinum Ore
            { itemid =  895, droprate = 109 }, -- Ram Horn
            { itemid = 1132, droprate =  79 }, -- Square Of Raxa
            { itemid = 4174, droprate =  69 }, -- Vile Elixir
            { itemid =  866, droprate =  79 }, -- Handful Of Wyvern Scales
            { itemid = 4172, droprate =  50 }, -- Reraiser
            { itemid =  823, droprate =  89 }, -- Spool Of Gold Thread
        },

        {
            { itemid = 1110, droprate = 109 }, -- Vial Of Black Beetle Blood
            { itemid =  836, droprate =  89 }, -- Square Of Damascene Cloth
            { itemid =  658, droprate =  79 }, -- Damascus Ingot
            { itemid =  837, droprate =  99 }, -- Spool Of Malboro Fiber
            { itemid =  942, droprate = 188 }, -- Philosophers Stone
            { itemid =  844, droprate = 238 }, -- Phoenix Feather
            { itemid = 1132, droprate = 109 }, -- Square Of Raxa
        },

        {
            { itemid =  722, droprate =  79 }, -- Divine Log
            { itemid = 1446, droprate = 257 }, -- Lacquer Tree Log
            { itemid =  703, droprate = 337 }, -- Petrified Log
            { itemid =  831, droprate = 149 }, -- Square Of Shining Cloth
        },
    },

    -- BCNM The Final Bout
    [78] =
    {
        {
            { itemid = 1237, droprate = 1000 }, -- bag_of_tree_cuttings
        },

        {
            { itemid = 1237, droprate = 1000 }, -- bag_of_tree_cuttings
        },

        {
            { itemid = 919, droprate = 1000 }, -- clump_of_boyahda_moss
        },

        {
            { itemid = 4818, droprate = 100 }, -- scroll_of_quake
            { itemid = 1414, droprate = 100 }, -- piece_of_wisteria_lumber
            { itemid =  700, droprate = 100 }, -- mahogany_log
            { itemid =  702, droprate = 100 }, -- ebony_log
            { itemid = 4814, droprate = 100 }, -- scroll_of_freeze
            { itemid =  654, droprate = 100 }, -- darksteel_ingot
            { itemid = 4621, droprate = 100 }, -- scroll_of_raise_ii
            { itemid =  703, droprate = 100 }, -- petrified_log
            { itemid =  745, droprate = 100 }, -- gold_ingot
            { itemid =  887, droprate = 100 }, -- coral_fragment
        },

        {
            { itemid = 15150, droprate = 62 }, -- shock_mask
            { itemid = 15151, droprate = 62 }, -- super_ribbon
            { itemid = 15149, droprate = 62 }, -- rival_ribbon
            { itemid = 14842, droprate = 62 }, -- ivory_mitts
            { itemid = 14843, droprate = 70 }, -- spiked_finger_gauntlets
            { itemid = 14845, droprate = 62 }, -- sly_gauntlets
            { itemid = 14844, droprate = 62 }, -- rush_gloves
            { itemid = 15148, droprate = 62 }, -- mana_circlet
            { itemid = 13166, droprate = 62 }, -- hateful_collar
            { itemid = 13677, droprate = 62 }, -- esoteric_mantle
            { itemid = 13679, droprate = 62 }, -- templars_mantle
            { itemid = 13676, droprate = 62 }, -- heavy_mantle
            { itemid = 13168, droprate = 62 }, -- intellect_torque
            { itemid = 13167, droprate = 62 }, -- storm_gorget
            { itemid = 13169, droprate = 62 }, -- benign_necklace
            { itemid = 13678, droprate = 62 }, -- snipers_mantle
        },
    },

    -- BCNM Up In Arms
    [79] =
    {
        {
            { itemid = 65535, droprate = 1000, amount = 15000 }, -- Gil
        },

        {
            { itemid = 793, droprate = 1000 }, -- Black Pearl
        },

        {
            { itemid = 792, droprate = 1000 }, -- Pearl
        },

        {
            { itemid = 792, droprate = 1000 }, -- Pearl
        },

        {
            { itemid = 1311, droprate = 1000 }, -- Piece Of Oxblood
        },

        {
            { itemid = 1311, droprate = 1000 }, -- Piece Of Oxblood
        },

        {
            { itemid = 1311, droprate = 1000 }, -- Piece Of Oxblood
        },

        {
            { itemid = 14666, droprate = 447 }, -- Teleport Ring Altep
            { itemid = 14662, droprate = 487 }, -- Teleport Ring Dem
        },

        {
            { itemid = 13175, droprate = 494 }, -- Ajari Bead Necklace
            { itemid = 13176, droprate = 449 }, -- Philomath Stole
        },

        {
            { itemid =  791, droprate =  51 }, -- Aquamarine
            { itemid =  801, droprate =  32 }, -- Chrysoberyl
            { itemid =  654, droprate =  39 }, -- Darksteel Ingot
            { itemid =  702, droprate =  21 }, -- Ebony Log
            { itemid = 4173, droprate =  32 }, -- Hi-reraiser
            { itemid =  745, droprate =  55 }, -- Gold Ingot
            { itemid =  784, droprate =  62 }, -- Jadeite
            { itemid =  653, droprate =  81 }, -- Mythril Ingot
            { itemid =  802, droprate =  56 }, -- Moonstone
            { itemid =  797, droprate = 195 }, -- Painite
            { itemid =  652, droprate =  58 }, -- Steel Ingot
            { itemid =  803, droprate =  38 }, -- Sunstone
            { itemid =  773, droprate =  11 }, -- Translucent Rock
            { itemid = 4175, droprate =  21 }, -- Vile Elixir +1
            { itemid =  771, droprate =  15 }, -- Yellow Rock
            { itemid =  805, droprate =  26 }, -- Zircon
            { itemid =  769, droprate =  21 }, -- Red Rock
            { itemid =  700, droprate =  17 }, -- Mahogany Log
            { itemid =  770, droprate =   9 }, -- Blue Rock
            { itemid =  810, droprate =  62 }, -- Fluorite
            { itemid =  774, droprate =  11 }, -- Purple Rock
            { itemid =  775, droprate =  11 }, -- Black Rock
            { itemid =  772, droprate =  11 }, -- Green Rock
            { itemid =  776, droprate =   9 }, -- White Rock
        },

        {
            { itemid =     0, droprate =  932 }, -- Nothing
            { itemid = 17440, droprate =   13 }, -- Kraken Club
            { itemid = 15185, droprate =   55 }, -- Walkure Mask
        },
    },

    -- KSNM Operation Desert Swarm
    [81] =
    {
        {
            { itemid =  1473, droprate = 813 }, -- High-quality Scorpion Shell
            { itemid = 13552, droprate =  55 }, -- Serket Ring
            { itemid =   901, droprate = 123 }, -- Venomous Claw
        },

        {
            { itemid = 17207, droprate = 216 }, -- Expunger
            { itemid = 18005, droprate = 295 }, -- Heart Snatcher
            { itemid = 18217, droprate = 239 }, -- Rampager
            { itemid = 17793, droprate = 231 }, -- Senjuinrikio
        },

        {
            { itemid = 17624, droprate = 504 }, -- Anubiss Knife
            { itemid =   655, droprate =   4 }, -- Adaman Ingot
            { itemid = 19027, droprate =  86 }, -- Claymore Grip
            { itemid =   747, droprate =  22 }, -- Orichalcum Ingot
            { itemid = 19025, droprate = 146 }, -- Pole Grip
            { itemid = 19024, droprate =  22 }, -- Sword Strap
        },

        {
            { itemid = 15295, droprate = 287 }, -- Hierarch Belt
            { itemid = 12407, droprate = 216 }, -- Palmerins Shield
            { itemid = 14871, droprate = 198 }, -- Trainers Gloves
            { itemid = 15294, droprate = 287 }, -- Warwolf Belt
        },

        {
            { itemid =  887, droprate =  52 }, -- Coral Fragment
            { itemid =  645, droprate =  56 }, -- Chunk Of Darksteel Ore
            { itemid =  902, droprate =  41 }, -- Demon Horn
            { itemid =  702, droprate =  63 }, -- Ebony Log
            { itemid =  737, droprate =  52 }, -- Chunk Of Gold Ore
            { itemid =  823, droprate =  26 }, -- Spool Of Gold Thread
            { itemid = 1465, droprate =  11 }, -- Slab Of Granite
            { itemid = 4173, droprate =  37 }, -- Hi-reraiser
            { itemid =  700, droprate = 101 }, -- Mahogany Log
            { itemid =  653, droprate =   0 }, -- Mythril Ingot
            { itemid =  644, droprate =  52 }, -- Chunk Of Mythril Ore
            { itemid =  703, droprate = 116 }, -- Petrified Log
            { itemid =  844, droprate =  15 }, -- Phoenix Feather
            { itemid =  942, droprate =  56 }, -- Philosophers Stone
            { itemid =  738, droprate =  45 }, -- Chunk Of Platinum Ore
            { itemid =  830, droprate =  22 }, -- Square Of Rainbow Cloth
            { itemid =  895, droprate =  67 }, -- Ram Horn
            { itemid = 1132, droprate = 119 }, -- Square Of Raxa
            { itemid = 4172, droprate =  45 }, -- Reraiser
            { itemid = 4174, droprate =  19 }, -- Vile Elixir
            { itemid = 4175, droprate =  41 }, -- Vile Elixir +1
            { itemid =  866, droprate =  34 }, -- Handful Of Wyvern Scales
        },

        {
            { itemid = 1110, droprate =  78 }, -- Vial Of Black Beetle Blood
            { itemid =  836, droprate =  56 }, -- Square Of Damascene Cloth
            { itemid =  658, droprate =  93 }, -- Damascus Ingot
            { itemid =  837, droprate =  56 }, -- Spool Of Malboro Fiber
            { itemid =  942, droprate = 157 }, -- Philosophers Stone
            { itemid =  844, droprate = 276 }, -- Phoenix Feather
            { itemid = 1132, droprate = 209 }, -- Square Of Raxa
        },
    },

    -- KSNM Prehistoric Pigeons
    [82] =
    {
        {
            { itemid = 17827, droprate = 217 }, -- Michishiba-no-tsuyu
            { itemid = 17699, droprate = 174 }, -- Dissector
            { itemid = 17275, droprate = 333 }, -- Coffinmaker
            { itemid = 18053, droprate = 174 }, -- Gravedigger
        },

        {
            { itemid = 19027, droprate = 144 }, -- Claymore Grip
            { itemid =   658, droprate = 275 }, -- Damascus Ingot
            { itemid =   843, droprate = 275 }, -- Giant Bird Plume
            { itemid = 19025, droprate = 203 }, -- Pole Grip
            { itemid = 19026, droprate = 116 }, -- Spear Strap
        },

        {
            { itemid =   655, droprate = 159 }, -- Adaman Ingot
            { itemid =   747, droprate = 290 }, -- Orichalcum Ingot
            { itemid = 14765, droprate = 406 }, -- Titanis Earring
        },

        {
            { itemid = 15325, droprate = 159 }, -- Evokers Boots
            { itemid = 14872, droprate = 217 }, -- Ostreger Mitts
            { itemid = 15181, droprate = 145 }, -- Pineal Hat
            { itemid = 15387, droprate = 159 }, -- Trackers Kecks
        },

        {
            { itemid =  887, droprate = 101 }, -- Coral Fragment
            { itemid =  645, droprate =  29 }, -- Chunk Of Darksteel Ore
            { itemid =  902, droprate =  29 }, -- Demon Horn
            { itemid =  702, droprate =  29 }, -- Ebony Log
            { itemid =  745, droprate = 101 }, -- Gold Ingot
            { itemid =  823, droprate =  29 }, -- Spool Of Gold Thread
            { itemid =  644, droprate =  29 }, -- Chunk Of Mythril Ore
            { itemid =  703, droprate =  58 }, -- Petrified Log
            { itemid =  738, droprate =  14 }, -- Chunk Of Platinum Ore
            { itemid =  830, droprate =  58 }, -- Square Of Rainbow Cloth
            { itemid =  895, droprate =  14 }, -- Ram Horn
            { itemid = 1132, droprate = 159 }, -- Square Of Raxa
            { itemid =  837, droprate =  72 }, -- Spool Of Malboro Fiber
        },

        {
            { itemid = 1110, droprate =  87 }, -- Vial Of Black Beetle Blood
            { itemid =  658, droprate =  14 }, -- Damascus Ingot
            { itemid =  836, droprate =  29 }, -- Square Of Damascene Cloth
            { itemid =  942, droprate = 174 }, -- Philosophers Stone
            { itemid =  844, droprate = 246 }, -- Phoenix Feather
            { itemid = 1132, droprate = 159 }, -- Square Of Raxa
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
