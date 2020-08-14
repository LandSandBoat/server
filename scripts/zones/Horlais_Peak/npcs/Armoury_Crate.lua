-----------------------------------
-- Area: Horlais Peak
-- NPC:  Armoury Crate
-------------------------------------
require("scripts/globals/battlefield")
require("scripts/globals/bcnm")
-------------------------------------

local loot =
{
    -- BCNM Tails of Woe
    [1] =
    {
        {
            {itemid = 13553, droprate = 150}, -- blitz Ring
            {itemid = 0,     droprate = 850}, -- Nothing
        },
        {
            {itemid = 13554, droprate = 300}, -- aegis Ring
            {itemid = 13625, droprate = 200}, -- tundra mantle
            {itemid = 13238, droprate = 200}, -- druids rope
            {itemid = 0,     droprate = 300}, -- Nothing
        },
        {
            {itemid = 4896, droprate = 145}, -- firespirit
            {itemid = 4751, droprate = 165}, -- erase
            {itemid = 4714, droprate = 140}, -- phalanx
            {itemid = 4874, droprate = 123}, -- absorb-str
            {itemid = 788,  droprate =  94}, -- peridot
            {itemid = 792,  droprate =  94}, -- pearl
            {itemid = 772,  droprate =  13}, -- green rock
            {itemid = 811,  droprate =  53}, -- ametrine
            {itemid = 748,  droprate =  70}, -- gold beastcoin
            {itemid = 749,  droprate =  50}, -- mythril beastcoin
            {itemid = 771,  droprate =  53}, -- yellow rock
            {itemid = 0,    droprate =   0}, -- nothing
        },
        {
            {itemid = 4751, droprate = 125}, -- erase
            {itemid = 4714, droprate = 110}, -- phalanx
            {itemid = 4874, droprate = 104}, -- absorb-str
            {itemid = 788,  droprate =  94}, -- peridot
            {itemid = 792,  droprate =  94}, -- pearl
            {itemid = 772,  droprate =  53}, -- green rock
            {itemid = 811,  droprate =  73}, -- ametrine
            {itemid = 748,  droprate =  70}, -- gold beastcoin
            {itemid = 749,  droprate =  70}, -- mythril beastcoin
            {itemid = 771,  droprate =  73}, -- yellow rock
            {itemid = 0,    droprate =  94}, -- nothing
        },
        {
            {itemid = 4896, droprate = 174}, -- firespirit
            {itemid = 4751, droprate =  16}, -- vile elixir
            {itemid = 4714, droprate = 114}, -- icespikes
            {itemid = 4874, droprate = 174}, -- refresh
            {itemid = 4947, droprate = 138}, -- utsusemi ni
            {itemid = 772,  droprate =  18}, -- green rock
            {itemid = 775,  droprate =  18}, -- black rock
            {itemid = 770,  droprate =  17}, -- blue rock
            {itemid = 769,  droprate =  16}, -- red rock
            {itemid = 774,  droprate =  16}, -- purple rock
            {itemid = 776,  droprate =  16}, -- white rock
            {itemid = 771,  droprate =  17}, -- yellow rock
            {itemid = 773,  droprate =  17}, -- translucent rock
            {itemid = 4172, droprate =  21}, -- reraiser
            {itemid = 699,  droprate =  22}, -- oak log
            {itemid = 701,  droprate =  18}, -- rosewood log
            {itemid = 748,  droprate = 120}, -- gold beastcoin
            {itemid = 749,  droprate = 102}, -- mythril beastcoin
            {itemid = 792,  droprate =  21}, -- pearl
            {itemid = 798,  droprate =  23}, -- Turquoise
            {itemid = 808,  droprate =  19}, -- Goshenite
            {itemid = 793,  droprate =  18}, -- Black pearl
            {itemid = 815,  droprate =  17}, -- sphene
            {itemid = 790,  droprate =  20}, -- garnet
            {itemid = 811,  droprate =  18}, -- ametrine
            {itemid = 0,    droprate =   0}, -- nothing
        },
        {
            {itemid = 4714, droprate = 87}, -- icespikes
            {itemid = 4874, droprate = 75}, -- refresh
            {itemid = 4947, droprate = 75}, -- utsusemi ni
            {itemid =  699, droprate = 80}, -- oak log
            {itemid =  701, droprate = 97}, -- rosewood log
            {itemid =  792, droprate = 86}, -- pearl
            {itemid =  798, droprate = 88}, -- Turquoise
            {itemid =  808, droprate = 79}, -- Goshenite
            {itemid =  793, droprate = 93}, -- Black pearl
            {itemid =  815, droprate = 79}, -- sphene
            {itemid =  790, droprate = 71}, -- garnet
            {itemid =  811, droprate = 90}, -- ametrine
            {itemid =    0, droprate =  0}, -- nothing
        },
    },

    -- BCNM Dismemberment Brigade
    [2] =
    {
        {
            {itemid = 16684, droprate =  250}, -- kabrakans_axe
            {itemid = 17190, droprate =  250}, -- sarnga
            {itemid = 17648, droprate =  250}, -- dragvandil
            {itemid = 17379, droprate =  250}, -- hamelin_flute
        },
        {
            {itemid =     0, droprate =  400}, -- nothing
            {itemid = 13128, droprate =  200}, -- spectacles
            {itemid = 13403, droprate =  200}, -- assault_earring
            {itemid = 13555, droprate =  200}, -- peace_ring
        },
        {
            {itemid =     0, droprate =  200}, -- nothing
            {itemid =   773, droprate =  200}, -- translucent_rock
            {itemid =   772, droprate =  200}, -- green_rock
            {itemid =   771, droprate =  200}, -- yellow_rock
            {itemid =   774, droprate =  200}, -- purple_rock
        },
        {
            {itemid =   797, droprate =  100}, -- painite
            {itemid =   784, droprate =  100}, -- jadeite
            {itemid =   653, droprate =  100}, -- mythril_ingot
            {itemid =   652, droprate =  100}, -- steel_ingot
            {itemid =   810, droprate =  100}, -- fluorite
            {itemid =   745, droprate =  100}, -- gold_ingot
            {itemid =   805, droprate =  100}, -- zircon
            {itemid =   801, droprate =  100}, -- chrysoberyl
            {itemid =   654, droprate =  100}, -- darksteel_ingot
            {itemid =   802, droprate =  100}, -- moonstone
        },
        {
            {itemid =     0, droprate =  900}, -- nothing
            {itemid =  4175, droprate =  100}, -- vile_elixir_+1
        },
    },

    -- BCNM Hostile Herbivores
    [4] =
    {
        {
            {itemid = 0, droprate = 50},     -- Nothing
            {itemid = 13251, droprate = 95}, -- Ocean Belt
            {itemid = 13254, droprate = 95}, -- Jungle Belt
            {itemid = 13253, droprate = 95}, -- Steppe Belt
            {itemid = 13255, droprate = 95}, -- Desert Belt
            {itemid = 13252, droprate = 95}, -- Forest Belt
            {itemid = 13256, droprate = 95}, -- Ocean Stone
            {itemid = 13259, droprate = 95}, -- Jungle Stone
            {itemid = 13258, droprate = 95}, -- Steppe Stone
            {itemid = 13260, droprate = 95}, -- Desert Stone
            {itemid = 13257, droprate = 95}, -- Forest Stone
        },
        {
            {itemid = 13292, droprate = 64}, -- Guardians Ring
            {itemid = 13287, droprate = 65}, -- Kampfer Ring
            {itemid = 13300, droprate = 65}, -- Conjurers Ring
            {itemid = 13298, droprate = 65}, -- Shinobi Ring
            {itemid = 13293, droprate = 65}, -- Slayers Ring
            {itemid = 13289, droprate = 65}, -- Sorcerers Ring
            {itemid = 13286, droprate = 64}, -- Soldiers Ring
            {itemid = 13294, droprate = 65}, -- Tamers Ring
            {itemid = 13296, droprate = 64}, -- Trackers Ring
            {itemid = 13299, droprate = 65}, -- Drake Ring
            {itemid = 13290, droprate = 65}, -- Fencers Ring
            {itemid = 13295, droprate = 65}, -- Minstrels Ring
            {itemid = 13288, droprate = 64}, -- Medicine Ring
            {itemid = 13291, droprate = 65}, -- Rogues Ring
            {itemid = 13297, droprate = 64}, -- Ronin Ring
            {itemid = 13447, droprate = 30}, -- Platinum Ring
        },
        {
            {itemid = 0, droprate = 100},    -- Nothing
            {itemid = 4818, droprate = 176}, -- Scroll Of Quake
            {itemid = 4902, droprate = 10},  -- Light Spirit Pact
            {itemid = 4814, droprate = 176}, -- Scroll Of Freeze
            {itemid = 4719, droprate = 176}, -- Scroll Of Regen Iii
            {itemid = 4172, droprate = 60},  -- Reraiser
            {itemid = 4174, droprate = 60},  -- Vile Elixir
            {itemid = 4621, droprate = 176}, -- Scroll Of Raise Ii
        },
        {
            {itemid = 0, droprate = 100},    -- Nothing
            {itemid = 4818, droprate = 176}, -- Scroll Of Quake
            {itemid = 4902, droprate = 10},  -- Light Spirit Pact
            {itemid = 4814, droprate = 176}, -- Scroll Of Freeze
            {itemid = 4719, droprate = 176}, -- Scroll Of Regen Iii
            {itemid = 4172, droprate = 60},  -- Reraiser
            {itemid = 4174, droprate = 60},  -- Vile Elixir
            {itemid = 4621, droprate = 176}, -- Scroll Of Raise Ii
        },
        {
            {itemid = 895, droprate = 59},   -- Ram Horn
            {itemid = 700, droprate = 59},   -- Mahogany Log
            {itemid = 653, droprate = 200},  -- Mythril Ingot
            {itemid = 1116, droprate = 59},  -- Manticore Hide
            {itemid = 866, droprate = 90},   -- Handful Of Wyvern Scales
            {itemid = 1122, droprate = 90},  -- Wyvern Skin
            {itemid = 703, droprate = 176},  -- Petrified Log
            {itemid = 654, droprate = 59},   -- Darksteel Ingot
            {itemid = 859, droprate = 59},   -- Ram Skin
            {itemid = 746, droprate = 90},   -- Platinum Ingot
        },
        {
            {itemid = 0, droprate = 100},    -- Nothing
            {itemid = 895, droprate = 59},   -- Ram Horn
            {itemid = 700, droprate = 59},   -- Mahogany Log
            {itemid = 653, droprate = 200},  -- Mythril Ingot
            {itemid = 1116, droprate = 59},  -- Manticore Hide
            {itemid = 866, droprate = 90},   -- Handful Of Wyvern Scales
            {itemid = 1122, droprate = 90},  -- Wyvern Skin
            {itemid = 703, droprate = 176},  -- Petrified Log
            {itemid = 654, droprate = 59},   -- Darksteel Ingot
            {itemid = 859, droprate = 59},   -- Ram Skin
            {itemid = 746, droprate = 90},   -- Platinum Ingot
        },
    },

    -- BCNM Carapace Combatants
    [8] =
    {
        {
            {itemid =   894, droprate = 1000}, -- beetle_jaw
        },
        {
            {itemid =   889, droprate = 1000}, -- beetle_shell
        },
        {
            {itemid =     0, droprate =  250}, -- nothing
            {itemid = 15282, droprate =  150}, -- katana_obi
            {itemid = 15274, droprate =  150}, -- staff_belt
            {itemid = 15280, droprate =  150}, -- song_belt
            {itemid = 15272, droprate =  150}, -- cestus_belt
            {itemid = 15279, droprate =  150}, -- pick_belt
        },
        {
            {itemid =     0, droprate =  125}, -- nothing
            {itemid = 14736, droprate =  125}, -- genin_earring
            {itemid = 14738, droprate =  125}, -- magicians_earring
            {itemid = 14729, droprate =  125}, -- pilferers_earring
            {itemid = 13439, droprate =  125}, -- warlocks_earring
            {itemid = 13436, droprate =  125}, -- wrestlers_earring
            {itemid = 14737, droprate =  125}, -- wyvern_earring
            {itemid = 14731, droprate =  125}, -- killer_earring
        },
        {
            {itemid =     0, droprate =  160}, -- nothing
            {itemid =   645, droprate =  140}, -- chunk_of_darksteel_ore
            {itemid =   653, droprate =  140}, -- mythril_ingot
            {itemid =   744, droprate =  140}, -- silver_ingot
            {itemid =   652, droprate =  140}, -- steel_ingot
            {itemid =   644, droprate =  140}, -- chunk_of_mythril_ore
            {itemid =   807, droprate =  140}, -- sardonyx
        },
        {
            {itemid =     0, droprate =  250}, -- nothing
            {itemid =  4868, droprate =  125}, -- scroll_of_dispel
            {itemid =  4947, droprate =  125}, -- scroll_of_utsusemi_ni
            {itemid =  4753, droprate =  125}, -- scroll_of_fire_ii
            {itemid =  5070, droprate =  125}, -- scroll_of_magic_finale
            {itemid =  4877, droprate =  125}, -- scroll_of_absorb-agi
            {itemid =  4878, droprate =  125}, -- scroll_of_absorb-int
        },
        {
            {itemid =     0, droprate =  500}, -- nothing
            {itemid = 17873, droprate =  500}, -- jug_of_scarlet_sap
        },
        {
            {itemid =     0, droprate =  750}, -- nothing
            {itemid = 17873, droprate =  250}, -- jug_of_scarlet_sap
        },
        {
            {itemid =     0, droprate =  900}, -- nothing
            {itemid =  4132, droprate =  100}, -- hi-ether
        },
    },

    -- BCNM Shooting Fish
    [9] =
    {
        {
            {itemid =  1601, droprate = 1000}, -- mannequin_head
        },
        {
            {itemid =  4484, droprate = 1000}, -- shall_shell
        },
        {
            {itemid =   749, droprate =  300}, -- mythril_beastcoin
            {itemid =   775, droprate =   70}, -- black_rock
            {itemid =   774, droprate =   30}, -- purple_rock
            {itemid =   776, droprate =  100}, -- white_rock
            {itemid = 17202, droprate =  100}, -- platoon_bow
            {itemid = 17462, droprate =  100}, -- platoon_mace
            {itemid = 18171, droprate =  150}, -- platoon_disc
            {itemid = 17271, droprate =  150}, -- platoon_gun
        },
        {
            {itemid =   749, droprate =  310}, -- mythril_beastcoin
            {itemid =   772, droprate =   50}, -- green_rock
            {itemid =   771, droprate =   40}, -- yellow_rock
            {itemid =   770, droprate =   40}, -- blue_rock
            {itemid =   769, droprate =   40}, -- red_rock
            {itemid =   773, droprate =  110}, -- translucent_rock
            {itemid = 17519, droprate =  130}, -- platoon_cesti
            {itemid = 18209, droprate =  100}, -- platoon_cutter
            {itemid = 17692, droprate =   80}, -- platoon_spatha
            {itemid = 18045, droprate =  100}, -- platoon_zaghnal
        },
        {
            {itemid =     0, droprate =  670}, -- nothing
            {itemid =   868, droprate =  190}, -- handful_of_pugil_scales
            {itemid =  4484, droprate =  140}, -- shall_shell
        },
        {
            {itemid =     0, droprate =  930}, -- nothing
            {itemid =  1602, droprate =   70}, -- mannequin_body
        },
        {
            {itemid =  4857, droprate =  180}, -- scroll_of_blaze_spikes
            {itemid =  4984, droprate =  510}, -- scroll_of_horde_lullaby
            {itemid =  4900, droprate =  280}, -- thunder_spirit_pact
            {itemid =  4869, droprate =   30}, -- scroll_of_warp
        },
    },

    -- BCNM Dropping Like Flies
    [10] =
    {
        {
            {itemid = 65535, droprate = 1000, amount = 4000}, -- Gil
        },
        {
            {itemid = 846, droprate = 1000}, -- Insect Wing
        },
        {
            {itemid = 1601, droprate = 1000}, -- Mannequin Head
        },
        {
            {itemid = 0, droprate = 636},    -- Nothing
            {itemid = 12486, droprate = 364}, -- Emperor Hairpin
        },
        {
            {itemid = 12400, droprate = 175}, -- Ashigaru Targe
            {itemid = 12399, droprate = 175}, -- Beaters Aspis
            {itemid = 12395, droprate = 175}, -- Varlets Targe
            {itemid = 12390, droprate = 175}, -- Wrestlers Aspis
            {itemid = 809, droprate = 100},  -- Clear Topaz
            {itemid = 795, droprate = 100},  -- Lapis Lazuli
            {itemid = 796, droprate = 100},  -- Light Opal
        },
        {
            {itemid = 13659, droprate = 250}, -- Mercenary Mantle
            {itemid = 13668, droprate = 250}, -- Singers Mantle
            {itemid = 13662, droprate = 250}, -- Wizards Mantle
            {itemid = 13672, droprate = 250}, -- Wyvern Mantle
        },
        {
            {itemid = 4947, droprate = 70},  -- Scroll Of Utsusemi Ni
            {itemid = 5070, droprate = 70},  -- Scroll Of Magic Finale
            {itemid = 17863, droprate = 150}, -- Jug Of Quadav Bug Broth
            {itemid = 799, droprate = 100},  -- Onyx
            {itemid = 795, droprate = 100},  -- Lapis Lazuli
            {itemid = 796, droprate = 100},  -- Light Opal
            {itemid = 4868, droprate = 150}, -- Scroll Of Dispel
            {itemid = 4751, droprate = 100}, -- Scroll Of Erase
            {itemid = 690, droprate = 90},   -- Elm Log
            {itemid = 1602, droprate = 70},  -- Mannequin Body
        },
    },

    -- KSNM Horns of War
    [11] =
    {
        {
            {itemid = 1441, droprate = 169},  -- Libation Abjuration
            {itemid = 17939, droprate = 268}, -- Kriegsbeil
            {itemid = 17823, droprate = 99},  -- Shinsoku
            {itemid = 18173, droprate = 85},  -- Nokizaru Shuriken
            {itemid = 17694, droprate = 70},  -- Guespiere
            {itemid = 17464, droprate = 85},  -- Purgatory Mace
            {itemid = 18351, droprate = 225}, -- Meteor Cesti
        },
        {
            {itemid = 1442, droprate = 169},  -- Oblation Abjuration
            {itemid = 17789, droprate = 14},  -- Unsho
            {itemid = 17838, droprate = 239}, -- Harlequins Horn
            {itemid = 18088, droprate = 85},  -- Dreizack
            {itemid = 18211, droprate = 254}, -- Gawains Axe
            {itemid = 17578, droprate = 183}, -- Zen Pole
            {itemid = 17695, droprate = 70},  -- Bayards Sword
        },
        {
            {itemid = 703, droprate = 563},   -- Petrified Log
            {itemid = 1446, droprate = 296},  -- Lacquer Tree Log
            {itemid = 831, droprate = 14},    -- Square Of Shining Cloth
            {itemid = 722, droprate = 141},   -- Divine Log
        },
        {
            {itemid = 860, droprate = 535},   -- Behemoth Hide
            {itemid = 883, droprate = 366},   -- Behemoth Horn
            {itemid = 17108, droprate = 48},  -- Healing Staff
        },
        {
            {itemid = 902, droprate = 99},    -- Demon Horn
            {itemid = 703, droprate = 70},    -- Petrified Log
            {itemid = 1132, droprate = 70},   -- Square Of Raxa
            {itemid = 830, droprate = 28},    -- Square Of Rainbow Cloth
            {itemid = 4173, droprate = 113},  -- Hi-reraiser
            {itemid = 703, droprate = 211},   -- Petrified Log
            {itemid = 942, droprate = 141},   -- Philosophers Stone
            {itemid = 737, droprate = 56},    -- Chunk Of Gold Ore
            {itemid = 644, droprate = 85},    -- Chunk Of Mythril Ore
            {itemid = 887, droprate = 70},    -- Coral Fragment
            {itemid = 700, droprate = 85},    -- Mahogany Log
            {itemid = 866, droprate = 42},    -- Handful Of Wyvern Scales
            {itemid = 645, droprate = 42},    -- Chunk Of Darksteel Ore
            {itemid = 895, droprate = 70},    -- Ram Horn
            {itemid = 702, droprate = 85},    -- Ebony Log
            {itemid = 4172, droprate = 28},   -- Reraiser
            {itemid = 738, droprate = 42},    -- Chunk Of Platinum Ore
            {itemid = 4174, droprate = 42},   -- Vile Elixir
            {itemid = 4175, droprate = 7},    -- Vile Elixir +1
        },
        {
            {itemid = 1527, droprate = 208},  -- Behemoth Tongue
            {itemid = 883, droprate = 296},   -- Behemoth Horn
            {itemid = 4199, droprate = 155},  -- Strength Potion
            {itemid = 4201, droprate = 70},   -- Dexterity Potion
            {itemid = 4205, droprate = 141},  -- Agility Potion
            {itemid = 4203, droprate = 113},  -- Vitality Potion
        },
        {
            {itemid = 3341, droprate = 1000}, -- Beastly Shank
        },
        {
            {itemid = 4209, droprate = 169},  -- Mind Potion
            {itemid = 4207, droprate = 70},   -- Intelligence Potion
            {itemid = 4211, droprate = 113},  -- Charisma Potion
            {itemid = 4213, droprate = 155},  -- Icarus Wing
            {itemid = 17840, droprate = 254}, -- Angel Lyre
            {itemid = 785, droprate = 99},    -- Emerald
            {itemid = 804, droprate = 42},    -- Spinel
            {itemid = 786, droprate = 56},    -- Ruby
            {itemid = 787, droprate = 28},    -- Diamond
        },
        {
            {itemid = 4135, droprate = 296},  -- Hi-ether +3
            {itemid = 4119, droprate = 225},  -- Hi-potion +3
            {itemid = 4173, droprate = 197},  -- Hi-reraiser
            {itemid = 4175, droprate = 282},  -- Vile Elixir +1
        },
        {
            {itemid = 887, droprate = 141},   -- Coral Fragment
            {itemid = 1132, droprate = 14},   -- Square Of Raxa
            {itemid = 902, droprate = 113},   -- Demon Horn
            {itemid = 737, droprate = 28},    -- Chunk Of Gold Ore
            {itemid = 644, droprate = 85},    -- Chunk Of Mythril Ore
            {itemid = 4174, droprate = 56},   -- Vile Elixir
            {itemid = 895, droprate = 28},    -- Ram Horn
            {itemid = 703, droprate = 296},   -- Petrified Log
            {itemid = 738, droprate = 14},    -- Chunk Of Platinum Ore
            {itemid = 700, droprate = 56},    -- Mahogany Log
            {itemid = 866, droprate = 70},    -- Handful Of Wyvern Scales
            {itemid = 1465, droprate = 42},   -- Slab Of Granite
            {itemid = 645, droprate = 42},    -- Chunk Of Darksteel Ore
            {itemid = 702, droprate = 42},    -- Ebony Log
            {itemid = 4173, droprate = 42},   -- Hi-reraiser
            {itemid = 823, droprate = 113},   -- Spool Of Gold Thread
            {itemid = 830, droprate = 28},    -- Square Of Rainbow Cloth
        },
        {
            {itemid = 1132, droprate = 127},  -- Square Of Raxa
            {itemid = 837, droprate = 56},    -- Spool Of Malboro Fiber
            {itemid = 942, droprate = 225},   -- Philosophers Stone
            {itemid = 844, droprate = 423},   -- Phoenix Feather
            {itemid = 836, droprate = 70},    -- Square Of Damascene Cloth
            {itemid = 658, droprate = 42},    -- Damascus Ingot
            {itemid = 1110, droprate = 85},   -- Vial Of Black Beetle Blood
        },
    },

    -- BCNM Under Observation
    [12] =
    {
        {
            {itemid = 0, droprate = 910},    -- Nothing
            {itemid = 13056, droprate = 90}, -- Peacock Charm
        },
        {
            {itemid = 0, droprate = 467},    -- Nothing
            {itemid = 18086, droprate = 48}, -- Behourd Lance
            {itemid = 18046, droprate = 61}, -- Mutilator
            {itemid = 18210, droprate = 46}, -- Raifu
            {itemid = 15286, droprate = 302}, -- Tilt Belt
            {itemid = 18350, droprate = 76}, -- Tourney Patas
        },
        {
            {itemid = 0, droprate = 413},    -- Nothing
            {itemid = 17696, droprate = 42}, -- Buzzard Tuck
            {itemid = 17936, droprate = 77}, -- De Saintres Axe
            {itemid = 17693, droprate = 73}, -- Grudge Sword
            {itemid = 15287, droprate = 258}, -- Mantra Belt
            {itemid = 4717, droprate = 68},  -- Scroll Of Refresh
            {itemid = 4947, droprate = 55},  -- Scroll Of Utsusemi Ni
            {itemid = 4858, droprate = 14},  -- Scroll Of Ice Spikes
        },
        {
            {itemid = 4858, droprate = 114}, -- Scroll Of Ice Spikes
            {itemid = 4717, droprate = 174}, -- Scroll Of Refresh
            {itemid = 4947, droprate = 138}, -- Scroll Of Utsusemi Ni
            {itemid = 769, droprate = 16},   -- Red Rock
            {itemid = 770, droprate = 17},   -- Blue Rock
            {itemid = 771, droprate = 17},   -- Yellow Rock
            {itemid = 772, droprate = 18},   -- Green Rock
            {itemid = 773, droprate = 17},   -- Translucent Rock
            {itemid = 774, droprate = 16},   -- Purple Rock
            {itemid = 775, droprate = 18},   -- Black Rock
            {itemid = 776, droprate = 16},   -- White Rock
            {itemid = 749, droprate = 102},  -- Mythril Beastcoin
            {itemid = 748, droprate = 120},  -- Gold Beastcoin
            {itemid = 699, droprate = 22},   -- Oak Log
            {itemid = 811, droprate = 18},   -- Ametrine
            {itemid = 793, droprate = 18},   -- Black Pearl
            {itemid = 790, droprate = 20},   -- Garnet
            {itemid = 808, droprate = 19},   -- Goshenite
            {itemid = 792, droprate = 21},   -- Pearl
            {itemid = 788, droprate = 35},   -- Peridot
            {itemid = 815, droprate = 17},   -- Sphene
            {itemid = 798, droprate = 23},   -- Turquoise
            {itemid = 4172, droprate = 21},  -- Reraiser
            {itemid = 4174, droprate = 16},  -- Vile Elixir
        },
        {
            {itemid = 4896, droprate = 116}, -- Fire Spirit Pact
            {itemid = 4874, droprate = 113}, -- Scroll Of Absorb-str
            {itemid = 4751, droprate = 137}, -- Scroll Of Erase
            {itemid = 4858, droprate = 67},  -- Scroll Of Ice Spikes
            {itemid = 4714, droprate = 99},  -- Scroll Of Phalanx
            {itemid = 811, droprate = 58},   -- Ametrine
            {itemid = 793, droprate = 52},   -- Black Pearl
            {itemid = 790, droprate = 51},   -- Garnet
            {itemid = 808, droprate = 65},   -- Goshenite
            {itemid = 792, droprate = 61},   -- Pearl
            {itemid = 788, droprate = 63},   -- Peridot
            {itemid = 815, droprate = 55},   -- Sphene
            {itemid = 798, droprate = 62},   -- Turquoise
        },
        {
            {itemid = 939, droprate = 1000}, -- Hecteyes Eye
        },
        {
            {itemid = 914, droprate = 1000}, -- Vial Of Mercury
        },
    },

    -- BCNM Eye of the Tiger
    [13] =
    {
        {
            {itemid =   884, droprate = 1000}, -- black_tiger_fang
        },
        {
            {itemid =   884, droprate = 1000}, -- black_tiger_fang
        },
        {
            {itemid =     0, droprate =  700}, -- nothing
            {itemid =  1012, droprate =  300}, -- nue_fang
        },
        {
            {itemid =     0, droprate =  125}, -- nothing
            {itemid = 14842, droprate =  125}, -- ivory_mitts
            {itemid = 15151, droprate =  125}, -- super_ribbon
            {itemid = 15148, droprate =  125}, -- mana_circlet
            {itemid = 15149, droprate =  125}, -- rival_ribbon
            {itemid = 14845, droprate =  125}, -- sly_gauntlets
            {itemid = 15150, droprate =  125}, -- shock_mask
            {itemid = 14843, droprate =  125}, -- spiked_finger_gauntlets
        },
        {
            {itemid = 13168, droprate =  125}, -- intellect_torque
            {itemid = 13677, droprate =  125}, -- esoteric_mantle
            {itemid = 13679, droprate =  125}, -- templars_mantle
            {itemid = 13678, droprate =  125}, -- snipers_mantle
            {itemid = 13166, droprate =  125}, -- hateful_collar
            {itemid = 13167, droprate =  125}, -- storm_gorget
            {itemid = 13676, droprate =  125}, -- heavy_mantle
            {itemid = 13169, droprate =  125}, -- benign_necklace
        },
        {
            {itemid =     0, droprate =  125}, -- nothing
            {itemid =   745, droprate =  125}, -- gold_ingot
            {itemid =   895, droprate =  125}, -- ram_horn
            {itemid =  1122, droprate =  125}, -- wyvern_skin
            {itemid =   702, droprate =  125}, -- ebony_log
            {itemid =   653, droprate =  125}, -- mythril_ingot
            {itemid =   859, droprate =  125}, -- ram_skin
            {itemid =   887, droprate =  125}, -- coral_fragment
        },
        {
            {itemid =     0, droprate =  400}, -- nothing
            {itemid =  5152, droprate =  200}, -- slice_of_buffalo_meat
            {itemid =  4272, droprate =  200}, -- slice_of_dragon_meat
            {itemid =  4377, droprate =  200}, -- slice_of_coeurl_meat
        },
        {
            {itemid =     0, droprate =  625}, -- nothing
            {itemid =  4814, droprate =  125}, -- scroll_of_freeze
            {itemid =  4621, droprate =  125}, -- scroll_of_raise_ii
            {itemid =  4818, droprate =  125}, -- scroll_of_quake
        },
    },

    -- BCNM Shots in the Dark
    [14] =
    {
        {
            {itemid =   748, droprate =  500}, -- gold_beastcoin
            {itemid =   749, droprate =  500}, -- mythril_beastcoin
        },
        {
            {itemid =   652, droprate =  500}, -- steel_ingot
            {itemid =   791, droprate =  500}, -- aquamarine
        },
        {
            {itemid =     0, droprate =  500}, -- nothing
            {itemid =  4224, droprate =  500}, -- demon_quiver
        },
        {
            {itemid =     0, droprate =  600}, -- nothing
            {itemid = 14661, droprate =  200}, -- teleport_ring_holla
            {itemid = 14664, droprate =  200}, -- teleport_ring_vahzl
        },
        {
            {itemid =     0, droprate =  600}, -- nothing
            {itemid = 13687, droprate =  200}, -- sapient_cape
            {itemid = 14870, droprate =  200}, -- trainers_wristbands
        },
    },

    -- KSNM Double Dragonian
    [15] =
    {
        {
            {itemid = 18378, droprate = 222}, -- Subduer
            {itemid = 17699, droprate = 302}, -- Dissector
            {itemid = 17509, droprate = 245}, -- Destroyers
            {itemid = 18005, droprate = 208}, -- Heart Snatcher
        },
        {
            {itemid = 0, droprate = 638},     -- Nothing
            {itemid = 1133, droprate = 10},   -- Vial Of Dragon Blood
            {itemid = 4486, droprate = 176},  -- Dragon Heart
            {itemid = 4272, droprate = 176},  -- Slice Of Dragon Meat
        },
        {
            {itemid = 0, droprate = 638},     -- Nothing
            {itemid = 1133, droprate = 10},   -- Vial Of Dragon Blood
            {itemid = 4486, droprate = 176},  -- Dragon Heart
            {itemid = 4272, droprate = 176},  -- Slice Of Dragon Meat
        },
        {
            {itemid = 0, droprate = 392},     -- Nothing
            {itemid = 19026, droprate = 354}, -- Spear Strap
            {itemid = 19024, droprate = 165}, -- Sword Strap
            {itemid = 19025, droprate = 89},  -- Pole Grip
        },
        {
            {itemid = 14764, droprate = 586}, -- Minuet Earring
            {itemid = 655, droprate = 184},   -- Adaman Ingot
            {itemid = 747, droprate = 207},   -- Orichalcum Ingot
        },
        {
            {itemid = 17842, droprate = 238}, -- Sorrowful Harp
            {itemid = 14762, droprate = 250}, -- Attilas Earring
            {itemid = 17700, droprate = 225}, -- Durandal
            {itemid = 18006, droprate = 275}, -- Hoplites Harpe
        },
        {
            {itemid = 737, droprate = 122},   -- Chunk Of Gold Ore
            {itemid = 4172, droprate = 54},   -- Reraiser
            {itemid = 644, droprate = 41},    -- Chunk Of Mythril Ore
            {itemid = 902, droprate = 81},    -- Demon Horn
            {itemid = 702, droprate = 149},   -- Ebony Log
            {itemid = 866, droprate = 54},    -- Handful Of Wyvern Scales
            {itemid = 4175, droprate = 27},   -- Vile Elixir +1
            {itemid = 700, droprate = 41},    -- Mahogany Log
            {itemid = 887, droprate = 95},    -- Coral Fragment
            {itemid = 703, droprate = 108},   -- Petrified Log
            {itemid = 844, droprate = 135},   -- Phoenix Feather
            {itemid = 738, droprate = 54},    -- Chunk Of Platinum Ore
            {itemid = 895, droprate = 14},    -- Ram Horn
            {itemid = 830, droprate = 14},    -- Square Of Rainbow Cloth
            {itemid = 645, droprate = 68},    -- Chunk Of Darksteel Ore
            {itemid = 4173, droprate = 14},   -- Hi-reraiser
            {itemid = 1132, droprate = 135},  -- Square Of Raxa
        },
        {
            {itemid = 836, droprate = 96},    -- Square Of Damascene Cloth
            {itemid = 658, droprate = 27},    -- Damascus Ingot
            {itemid = 942, droprate = 164},   -- Philosophers Stone
            {itemid = 844, droprate = 260},   -- Phoenix Feather
            {itemid = 837, droprate = 96},    -- Spool Of Malboro Fiber
            {itemid = 1132, droprate = 288},  -- Square Of Raxa
            {itemid = 1110, droprate = 41},   -- Vial Of Black Beetle Blood
        },
    },

    -- KSNM Contaminated Colosseum
    [17] =
    {
        {
            {itemid = 837, droprate = 1000}, -- Spool Of Malboro Fiber
        },
        {
            {itemid = 17827, droprate = 217}, -- Michishiba-no-tsuyu
            {itemid = 17451, droprate = 174}, -- Morgenstern
            {itemid = 17793, droprate = 333}, -- Senjuinrikio
            {itemid = 17589, droprate = 174}, -- Thyrsusstab
        },
        {
            {itemid = 13402, droprate = 101}, -- Cassie Earring
            {itemid = 19027, droprate = 43}, -- Claymore Grip
            {itemid = 920, droprate = 275},  -- Malboro Vine
            {itemid = 1013, droprate = 275}, -- Morbolger Vine
            {itemid = 19025, droprate = 203}, -- Pole Grip
            {itemid = 19026, droprate = 116}, -- Spear Strap
        },
        {
            {itemid = 655, droprate = 159},  -- Adaman Ingot
            {itemid = 747, droprate = 290},  -- Orichalcum Ingot
            {itemid = 13182, droprate = 406}, -- Oscar Scarf
        },
        {
            {itemid = 15325, droprate = 159}, -- Evokers Boots
            {itemid = 14872, droprate = 217}, -- Ostreger Mitts
            {itemid = 15181, droprate = 145}, -- Pineal Hat
            {itemid = 15387, droprate = 159}, -- Trackers Kecks
        },
        {
            {itemid = 887, droprate = 101},  -- Coral Fragment
            {itemid = 645, droprate = 29},   -- Chunk Of Darksteel Ore
            {itemid = 902, droprate = 29},   -- Demon Horn
            {itemid = 702, droprate = 29},   -- Ebony Log
            {itemid = 737, droprate = 101},  -- Chunk Of Gold Ore
            {itemid = 823, droprate = 29},   -- Spool Of Gold Thread
            {itemid = 1465, droprate = 29},  -- Slab Of Granite
            {itemid = 700, droprate = 43},   -- Mahogany Log
            {itemid = 644, droprate = 29},   -- Chunk Of Mythril Ore
            {itemid = 703, droprate = 58},   -- Petrified Log
            {itemid = 738, droprate = 14},   -- Chunk Of Platinum Ore
            {itemid = 830, droprate = 58},   -- Square Of Rainbow Cloth
            {itemid = 895, droprate = 14},   -- Ram Horn
            {itemid = 4174, droprate = 58},  -- Vile Elixir
            {itemid = 4175, droprate = 29},  -- Vile Elixir +1
            {itemid = 866, droprate = 72},   -- Handful Of Wyvern Scales
        },
        {
            {itemid = 1110, droprate = 87},  -- Vial Of Black Beetle Blood
            {itemid = 658, droprate = 14},   -- Damascus Ingot
            {itemid = 836, droprate = 29},   -- Square Of Damascene Cloth
            {itemid = 837, droprate = 43},   -- Spool Of Malboro Fiber
            {itemid = 942, droprate = 174},  -- Philosophers Stone
            {itemid = 844, droprate = 246},  -- Phoenix Feather
            {itemid = 1132, droprate = 159}, -- Square Of Raxa
        },
    },
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
