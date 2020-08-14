-----------------------------------
-- Area: Lower Jeuno
--  NPC: Treasure Coffer
-- Type: Add-on NPC
-- !pos 41.169 3.899 -51.005 245
-----------------------------------
local ID = require("scripts/zones/Lower_Jeuno/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/settings")
-----------------------------------

local optionToKI =
{
    [ 1] = tpz.ki.CRIMSON_KEY,
    [ 2] = tpz.ki.VIRIDIAN_KEY,
    [ 3] = tpz.ki.AMBER_KEY,
    [ 4] = tpz.ki.AZURE_KEY,
    [ 5] = tpz.ki.IVORY_KEY,
    [ 6] = tpz.ki.EBON_KEY,
    [ 8] = tpz.ki.WHITE_CORAL_KEY,
    [ 9] = tpz.ki.BLUE_CORAL_KEY,
    [10] = tpz.ki.PEACH_CORAL_KEY,
    [11] = tpz.ki.BLACK_CORAL_KEY,
    [12] = tpz.ki.RED_CORAL_KEY,
    [13] = tpz.ki.ANGEL_SKIN_KEY,
    [15] = tpz.ki.MOOGLE_KEY,
    [16] = tpz.ki.BIRD_KEY,
    [17] = tpz.ki.CACTUAR_KEY,
    [18] = tpz.ki.BOMB_KEY,
    [19] = tpz.ki.CHOCOBO_KEY,
    [20] = tpz.ki.TONBERRY_KEY,
}

local prizes =
{
    [tpz.ki.CRIMSON_KEY] =
    {
        {cutoff =   70, itemId = 13206, augments = {{9, 0,  5}, {516, 0, 1}, {517, 0, 1}, {518, 0, 1}, { 32, 0, 1}, { 96, 0, 1}}}, -- Gold Obi
        {cutoff =   80, itemId = 13445, augments = {{9, 0,  8}, {516, 0, 1}, {517, 0, 1}, {518, 0, 2}, { 39, 0, 1}, { 35, 0, 2}}}, -- Gold Ring
        {cutoff =  186, itemId = 13446, augments = {{1, 0, 15}, { 13, 0, 2}, { 25, 0, 5}, { 31, 0, 2}, {195, 0, 1}, { 35, 0, 2}}}, -- Mythril Ring
        {cutoff =  276, itemId = 13643, augments = {{9, 0,  5}, {516, 0, 1}, {517, 0, 1}, {518, 0, 1}, {100, 0, 1}, { 39, 0, 1}}}, -- Sarcenet Cape
        {cutoff =  351, itemId = 13196, augments = {{1, 0,  5}, { 23, 0, 1}, { 27, 0, 1}, {512, 0, 1}, {520, 0, 1}, {515, 0, 1}}}, -- Silver Belt
        {cutoff =  460, itemId = 13571, augments = {{1, 0,  5}, { 25, 0, 3}, { 29, 0, 3}, {512, 0, 0}, {769, 0, 1}, { 32, 0, 1}}}, -- Wolf Mantle
        {cutoff =  468, itemId =   694}, -- Chestnut Log
        {cutoff =  471, itemId =   887}, -- Coral Fragment
        {cutoff =  476, itemId =  4903}, -- Dark Spirit Pact
        {cutoff =  479, itemId =   654}, -- Darksteel Ingot
        {cutoff =  500, itemId =   645}, -- Darksteel Ore
        {cutoff =  523, itemId =  4868}, -- Scroll of Dispel
        {cutoff =  619, itemId =  4145}, -- Elixir
        {cutoff =  668, itemId =   690}, -- Elm Log
        {cutoff =  699, itemId =  4751}, -- Scroll of Erase
        {cutoff =  702, itemId =  4116}, -- Hi-Potion
        {cutoff =  723, itemId =   651}, -- Iron Ingot
        {cutoff =  775, itemId =   643}, -- Iron Ore
        {cutoff =  785, itemId =  4902}, -- Light Spirit Pact
        {cutoff =  821, itemId =  5070}, -- Scroll of Magic Finale
        {cutoff =  824, itemId =   691}, -- Maple Log
        {cutoff =  858, itemId =   653}, -- Mythril Ingot
        {cutoff =  879, itemId =   644}, -- Mythril Ore
        {cutoff =  884, itemId =  4113}, -- Potion +1
        {cutoff =  923, itemId =   744}, -- Silver Ingot
        {cutoff =  949, itemId =   736}, -- Silver Ore
        {cutoff =  993, itemId =   652}, -- Steel Ingot
        {cutoff = 1003, itemId =  4947}, -- Scroll of Utsusemi: Ni
    },
    [tpz.ki.VIRIDIAN_KEY] =
    {
        {cutoff =   65, itemId = 13639}, -- Aurora Mantle
        {cutoff =  142, itemId = 13271}, -- Corsette
        {cutoff =  237, itemId = 12364}, -- Nymph Shield
        {cutoff =  356, itemId = 13570}, -- Ram Mantle
        {cutoff =  457, itemId = 13198}, -- Swordbelt
        {cutoff =  463, itemId = 13207}, -- Brocade Obi
        {cutoff =  469, itemId =   793}, -- Black Pearl
        {cutoff =  497, itemId =   775}, -- Black Rock
        {cutoff =  515, itemId =   770}, -- Blue Rock
        {cutoff =  616, itemId =  4145}, -- Elixir
        {cutoff =  670, itemId =  4129}, -- Ether +1
        {cutoff =  676, itemId =   790}, -- Garnet
        {cutoff =  672, itemId =   808}, -- Goshenite
        {cutoff =  684, itemId =   772}, -- Green Rock
        {cutoff =  775, itemId =   669}, -- Oak Log
        {cutoff =  811, itemId =   792}, -- Pearl
        {cutoff =  829, itemId =   788}, -- Peridot
        {cutoff =  835, itemId =   738}, -- Platinum Ore
        {cutoff =  871, itemId =  4113}, -- Potion +1
        {cutoff =  877, itemId =   774}, -- Purple Rock
        {cutoff =  901, itemId =   769}, -- Red Rock
        {cutoff =  984, itemId =   701}, -- Rosewood Log
        {cutoff = 1008, itemId =   815}, -- Sphene
        {cutoff = 1020, itemId =   773}, -- Translucent Rock
        {cutoff = 1032, itemId =   776}, -- White Rock
        {cutoff = 1044, itemId =   771}, -- Yellow Rock
        {cutoff = 1056, itemId =   798}, -- Turquoise
    },
    [tpz.ki.AMBER_KEY] =
    {
        {cutoff = 111, itemId = 16263}, -- Beak Necklace
        {cutoff = 219, itemId = 13207}, -- Brocade Obi
        {cutoff = 334, itemId = 13091}, -- Carapace Gorget
        {cutoff = 436, itemId = 13445}, -- Gold Ring
        {cutoff = 561, itemId = 13593}, -- Raptor Mantle
        {cutoff = 564, itemId =   887}, -- Coral Fragment
        {cutoff = 576, itemId =   645}, -- Darksteel Ore
        {cutoff = 599, itemId =   902}, -- Demon Horn
        {cutoff = 616, itemId =   702}, -- Ebony Log
        {cutoff = 625, itemId =   737}, -- Gold Ore
        {cutoff = 683, itemId =  4144}, -- Hi-Elixer
        {cutoff = 730, itemId =  4132}, -- Hi-Ether
        {cutoff = 771, itemId =  4116}, -- Hi-Potion
        {cutoff = 788, itemId =   700}, -- Mahogany Log
        {cutoff = 805, itemId =  1116}, -- Manticore Hide
        {cutoff = 807, itemId =   703}, -- Petrified Log
        {cutoff = 809, itemId =   738}, -- Platinum Ore
        {cutoff = 818, itemId =   644}, -- Mythril Ore
        {cutoff = 835, itemId =   895}, -- Ram Horn
        {cutoff = 876, itemId =   859}, -- Ram Skin
        {cutoff = 885, itemId =  4621}, -- Scroll of Raise II
        {cutoff = 920, itemId =  4719}, -- Scroll of Regen III
        {cutoff = 946, itemId =   866}, -- Wyvern Scales
        {cutoff = 961, itemId =  1122}, -- Wyvern Skin
    },
    [tpz.ki.AZURE_KEY] =
    {
        {cutoff = 106, itemId = 13597}, -- Beak Mantle
        {cutoff = 203, itemId = 13092}, -- Coeurl Gorget
        {cutoff = 305, itemId = 13447}, -- Platinum Ring
        {cutoff = 386, itemId = 13208}, -- Rainbow Obi
        {cutoff = 490, itemId = 13125}, -- Torque
        {cutoff = 498, itemId =   791}, -- Aquamarine
        {cutoff = 502, itemId =   801}, -- Chrysoberyl
        {cutoff = 536, itemId =   654}, -- Darksteel Ingot
        {cutoff = 612, itemId =   645}, -- Darksteel Ore
        {cutoff = 659, itemId =   702}, -- Ebony Log
        {cutoff = 693, itemId =   745}, -- Gold Ingot
        {cutoff = 786, itemId =  4144}, -- Hi-Elixir
        {cutoff = 789, itemId =  4133}, -- Hi-Ether +1
        {cutoff = 831, itemId =  4117}, -- Hi-Potion +1
        {cutoff = 835, itemId =   784}, -- Jadeite
        {cutoff = 856, itemId =   700}, -- Mahogany Log
        {cutoff = 907, itemId =   653}, -- Mythril Ingot
        {cutoff = 911, itemId =   895}, -- Ram Horn
        {cutoff = 915, itemId =  4719}, -- Scroll of Regen III
        {cutoff = 948, itemId =   652}, -- Steel Ingot
        {cutoff = 956, itemId =   803}, -- Sunstone
        {cutoff = 960, itemId =   866}, -- Wyvern Scales
    },
    [tpz.ki.IVORY_KEY] =
    {
        {cutoff =   62, itemId = 13357}, -- Angels Earring
        {cutoff =   70, itemId = 13356}, -- Death Earring
        {cutoff =  113, itemId = 13353}, -- Diamond Earring
        {cutoff =  196, itemId = 13351}, -- Emerald Earring
        {cutoff =  301, itemId = 13352}, -- Ruby Earring
        {cutoff =  392, itemId = 13355}, -- Sapphire Earring
        {cutoff =  478, itemId = 13354}, -- Spinel Earring
        {cutoff =  497, itemId = 13318}, -- Topaz Earring
        {cutoff =  546, itemId =  1110}, -- Beetle Blood
        {cutoff =  602, itemId =   823}, -- Gold Thread
        {cutoff =  627, itemId =  1465}, -- Granite
        {cutoff =  658, itemId =  4134}, -- Hi-Ether +2
        {cutoff =  901, itemId =  4118}, -- Hi-Potion +2
        {cutoff =  963, itemId =   837}, -- Malboro Fiber
        {cutoff =  982, itemId =   924}, -- Philosophers Stone
        {cutoff = 1019, itemId =   844}, -- Phoenix Feather
        {cutoff = 1062, itemId =   830}, -- Rainbow Cloth
        {cutoff = 1124, itemId =  1132}, -- Raxa
        {cutoff = 1172, itemId =  4174}, -- Vile Elixir
    },
    [tpz.ki.EBON_KEY] =
    {
        {cutoff =  31, itemId = 13463}, -- Angels Ring
        {cutoff =  82, itemId = 13462}, -- Death Ring
        {cutoff = 174, itemId = 13450}, -- Diamond Ring
        {cutoff = 225, itemId = 13448}, -- Emerald Ring
        {cutoff = 296, itemId = 13449}, -- Ruby Ring
        {cutoff = 357, itemId = 13452}, -- Sapphire Ring
        {cutoff = 459, itemId = 13451}, -- Spinel Ring
        {cutoff = 500, itemId = 13453}, -- Topaz Ring
        {cutoff = 510, itemId =   655}, -- Adaman Ingot
        {cutoff = 541, itemId =   813}, -- Angelstone
        {cutoff = 561, itemId =   645}, -- Darksteel Ore
        {cutoff = 592, itemId =   812}, -- Deathstone
        {cutoff = 633, itemId =   787}, -- Diamond
        {cutoff = 643, itemId =   785}, -- Emerald
        {cutoff = 714, itemId =  4135}, -- Hi-Ether +3
        {cutoff = 785, itemId =  4119}, -- Hi-Potion +3
        {cutoff = 805, itemId =   739}, -- Orichalcum Ore
        {cutoff = 815, itemId =   738}, -- Platinum Ore
        {cutoff = 835, itemId =   786}, -- Ruby
        {cutoff = 855, itemId =   794}, -- Sapphire
        {cutoff = 896, itemId =  4613}, -- Scroll of Cure V
        {cutoff = 916, itemId =  4659}, -- Scroll of Shell IV
        {cutoff = 936, itemId =  4774}, -- Scroll of Thunder III
        {cutoff = 987, itemId =  4174}, -- Vile Elixir
        {cutoff = 997, itemId =  4748}, -- Scroll of Raise III
    },
    [tpz.ki.WHITE_CORAL_KEY] =
    {
        {cutoff =   31, itemId = 12433}, -- Brass Mask
        {cutoff =  109, itemId = 12986}, -- Chestnut Sabots
        {cutoff =  218, itemId = 12721}, -- Cotton Gloves
        {cutoff =  296, itemId = 12826}, -- Studded Trousers
        {cutoff =  437, itemId = 12602}, -- Wool Robe
        {cutoff =  468, itemId =   694}, -- Chestnut Log
        {cutoff =  499, itemId =   645}, -- Darksteel Ore
        {cutoff =  624, itemId =  4145}, -- Elixir
        {cutoff =  655, itemId =   690}, -- Elm Log
        {cutoff =  686, itemId =   643}, -- Iron Ore
        {cutoff =  717, itemId =   651}, -- Iron Ingot
        {cutoff =  764, itemId =   653}, -- Mythril Ingot
        {cutoff =  780, itemId =   644}, -- Mythril Ore
        {cutoff =  843, itemId =   744}, -- Silver Ingot
        {cutoff =  874, itemId =   736}, -- Silver Ore
        {cutoff =  937, itemId =   652}, -- Steel Ingot
        {cutoff =  968, itemId =  4868}, -- Scroll of Dispel
        {cutoff =  999, itemId =  5070}, -- Scroll of Magic Finale
        {cutoff = 1015, itemId =  4947}, -- Scroll of Utsusemi: Ni
        {cutoff = 1031, itemId =  4751}, -- Scroll of Erase
    },
    [tpz.ki.BLUE_CORAL_KEY] =
    {
        {cutoff =   42, itemId = 12571}, -- Cuir Bouilli
        {cutoff =  250, itemId = 14118}, -- Iron Greaves
        {cutoff =  292, itemId = 12866}, -- Linen Slacks
        {cutoff =  375, itemId = 12450}, -- Padded Cap
        {cutoff =  458, itemId = 12731}, -- Velvet Cuffs
        {cutoff =  500, itemId =   793}, -- Black Pearl
        {cutoff =  583, itemId =  4145}, -- Elixir
        {cutoff =  625, itemId =  4129}, -- Ether +1
        {cutoff =  667, itemId =   790}, -- Garnet
        {cutoff =  709, itemId =   788}, -- Peridot
        {cutoff =  751, itemId =  4113}, -- Potion +1
        {cutoff =  876, itemId =   669}, -- Oak Log
        {cutoff =  918, itemId =   830}, -- Rainbow Cloth
        {cutoff =  960, itemId =   769}, -- Red Rock
        {cutoff = 1002, itemId =   798}, -- Turquoise
    },
    [tpz.ki.PEACH_CORAL_KEY] =
    {
        {cutoff =   66, itemId = 13712}, -- Carapace Harness
        {cutoff =  198, itemId = 12956}, -- Raptor Ledelsens
        {cutoff =  303, itemId = 12476}, -- Silk Hat
        {cutoff =  395, itemId = 14003}, -- Steel Finger Gauntlets
        {cutoff =  487, itemId = 12867}, -- White Slacks
        {cutoff =  500, itemId =   645}, -- Darksteel Ore
        {cutoff =  526, itemId =   902}, -- Demon Horn
        {cutoff =  565, itemId =   702}, -- Ebony Log
        {cutoff =  591, itemId =   737}, -- Gold Ore
        {cutoff =  696, itemId =  4144}, -- Hi-Elixer
        {cutoff =  747, itemId =  4132}, -- Hi-Ether
        {cutoff =  773, itemId =  4116}, -- Hi-Potion
        {cutoff =  786, itemId =   700}, -- Mahogany Log
        {cutoff =  839, itemId =  1116}, -- Manticore Hide
        {cutoff =  852, itemId =   644}, -- Mythril Ore
        {cutoff =  891, itemId =   703}, -- Petrified Log
        {cutoff =  930, itemId =  4621}, -- Scroll of Raise II
        {cutoff =  969, itemId =   738}, -- Platinum Ore
        {cutoff = 1008, itemId =   895}, -- Ram Horn
        {cutoff = 1021, itemId =   859}, -- Ram Skin
        {cutoff = 1074, itemId =  4719}, -- Scroll of Regen III
        {cutoff = 1087, itemId =   866}, -- Wyvern Scales
        {cutoff = 1103, itemId =  1122}, -- Wyvern Skin
    },
    [tpz.ki.BLACK_CORAL_KEY] =
    {
        {cutoff =   90, itemId = 13698}, -- Beak Helm
        {cutoff =  194, itemId = 12988}, -- Pigaches
        {cutoff =  224, itemId = 12811}, -- Darksteel Breeches
        {cutoff =  433, itemId = 12707}, -- Scorpion Mitts
        {cutoff =  552, itemId = 12604}, -- Silk Coat
        {cutoff =  597, itemId =   645}, -- Darksteel Ore
        {cutoff =  612, itemId =   654}, -- Darksteel Ingot
        {cutoff =  642, itemId =   745}, -- Gold Ingot
        {cutoff =  776, itemId =  4144}, -- Hi-Elixer
        {cutoff =  821, itemId =  4133}, -- Hi-Ether +1
        {cutoff =  851, itemId =  4117}, -- Hi-Potion +1
        {cutoff =  866, itemId =   700}, -- Mahogany Log
        {cutoff =  881, itemId =   653}, -- Mythril Ingot
        {cutoff =  896, itemId =   797}, -- Painite
        {cutoff = 1000, itemId =   652}, -- Steel Ingot
        {cutoff = 1015, itemId =   805}, -- Zircon
    },
    [tpz.ki.RED_CORAL_KEY] =
    {
        {cutoff =  109, itemId = 16289}, -- Alloy Torque
        {cutoff =  200, itemId = 16288}, -- Aureate Necklace
        {cutoff =  273, itemId = 16290}, -- Burly Gorget
        {cutoff =  382, itemId = 16286}, -- Nitid Choker
        {cutoff =  473, itemId = 16287}, -- Pneuma Collar
        {cutoff =  528, itemId =  1110}, -- Beetle Blood
        {cutoff =  619, itemId =   823}, -- Gold Thread
        {cutoff =  692, itemId =  1465}, -- Granite
        {cutoff =  728, itemId =  4134}, -- Hi-Ether +2
        {cutoff =  764, itemId =   837}, -- Malboro Fiber
        {cutoff =  782, itemId =   924}, -- Philosophers Stone
        {cutoff =  800, itemId =   844}, -- Phoenix Feather
        {cutoff =  836, itemId =   830}, -- Rainbow Cloth
        {cutoff =  872, itemId =  1132}, -- Raxa
        {cutoff =  999, itemId =  4174}, -- Vile Elixir
        {cutoff = 1017, itemId =  4517}, -- Yellow Curry
    },
    [tpz.ki.ANGEL_SKIN_KEY] =
    {
        {cutoff =   65, itemId = 16254}, -- Altius Mantle
        {cutoff =  162, itemId = 16253}, -- Chiffon Cape
        {cutoff =  243, itemId = 16255}, -- Cortege Cape
        {cutoff =  356, itemId = 16252}, -- Resilient Mantle
        {cutoff =  437, itemId = 16256}, -- Rugged Mantle
        {cutoff =  469, itemId =   646}, -- Adaman Ore
        {cutoff =  501, itemId =   813}, -- Angelstone
        {cutoff =  517, itemId =   645}, -- Darksteel Ore
        {cutoff =  582, itemId =   812}, -- Deathstone
        {cutoff =  614, itemId =   787}, -- Diamond
        {cutoff =  646, itemId =   785}, -- Emerald
        {cutoff =  662, itemId =  4135}, -- Hi-Ether +3
        {cutoff =  694, itemId =  4119}, -- Hi-Potion +3
        {cutoff =  742, itemId =   739}, -- Orichalcum Ore
        {cutoff =  790, itemId =   786}, -- Ruby
        {cutoff =  822, itemId =  4613}, -- Scroll of Cure V
        {cutoff =  855, itemId =  4659}, -- Scroll of Shell IV
        {cutoff =  888, itemId =   804}, -- Spinel
        {cutoff = 1021, itemId =  4174}, -- Vile Elixir
        {cutoff = 1037, itemId =  4774}, -- Scroll of Thunder III
        {cutoff = 1047, itemId =  4748}, -- Scroll of Raise III
    },
    [tpz.ki.MOOGLE_KEY] =
    {
        {cutoff =  167, itemId = 12442}, -- Studded Bandana
        {cutoff =  374, itemId = 13209}, -- Chain Belt
        {cutoff =  707, itemId = 13083}, -- Chain Choker
        {cutoff =  874, itemId =  4751}, -- Scroll of Erase
        {cutoff = 1041, itemId =   653}, -- Mythril Ingot
        {cutoff = 1100, itemId =   744}, -- Silver Ingot
    },
    [tpz.ki.BIRD_KEY] =
    {
        {cutoff = 143, itemId = 12987}, -- Ebony Sabots
        {cutoff = 393, itemId = 13783}, -- Iron Scale Mail
        {cutoff = 536, itemId = 12293}, -- Oak Shield
        {cutoff = 653, itemId = 13200}, -- Waistbelt
        {cutoff = 663, itemId =   793}, -- Black Pearl
        {cutoff = 678, itemId =   770}, -- Blue Rock
        {cutoff = 770, itemId =  4145}, -- Elixir
        {cutoff = 801, itemId =  4129}, -- Ether +1
        {cutoff = 816, itemId =   808}, -- Goshenite
        {cutoff = 847, itemId =   669}, -- Oak Log
        {cutoff = 852, itemId =   792}, -- Pearl
        {cutoff = 862, itemId =   788}, -- Peridot
        {cutoff = 871, itemId =  4113}, -- Potion +1
        {cutoff = 922, itemId =   701}, -- Rosewood Log
        {cutoff = 927, itemId =   815}, -- Sphene
        {cutoff = 947, itemId =   773}, -- Translucent Rock
        {cutoff = 957, itemId =   776}, -- White Rock
        {cutoff = 967, itemId =   771}, -- Yellow Rock
        {cutoff = 972, itemId =   774}, -- Purple Rock
    },
    [tpz.ki.CACTUAR_KEY] =
    {
        {cutoff = 109, itemId = 13111}, -- Nodowa
        {cutoff = 196, itemId = 12604}, -- Silk Coat
        {cutoff = 305, itemId = 13981}, -- Turtle Bangles
        {cutoff = 370, itemId = 13711}, -- Carapace Mask
        {cutoff = 435, itemId =  4132}, -- Hi-Ether
        {cutoff = 544, itemId =  4144}, -- Hi-Elixer
        {cutoff = 609, itemId =   645}, -- Darksteel Ore
        {cutoff = 631, itemId =   737}, -- Gold Ore
        {cutoff = 674, itemId =  4719}, -- Scroll of Regen III
        {cutoff = 696, itemId =  4621}, -- Scroll of Raise II
        {cutoff = 718, itemId =   738}, -- Platinum Ore
        {cutoff = 761, itemId =   866}, -- Wyvern Scales
        {cutoff = 804, itemId =   702}, -- Ebony Log
        {cutoff = 847, itemId =   902}, -- Demon Horn
        {cutoff = 869, itemId =   703}, -- Petrified Log
        {cutoff = 891, itemId =  1116}, -- Manticore Hide
        {cutoff = 913, itemId =   895}, -- Ram Horn
        {cutoff = 935, itemId =   859}, -- Ram Skin
    },
    [tpz.ki.BOMB_KEY] =
    {
        {cutoff = 308, itemId = 12980}, -- Battle Boots
        {cutoff = 462, itemId = 12860}, -- Silk Slops
        {cutoff = 616, itemId = 13589}, -- Tiger Mantle
        {cutoff = 693, itemId = 12427}, -- Bascinet
        {cutoff = 747, itemId =  4144}, -- Hi-Elixer
        {cutoff = 824, itemId =   654}, -- Darksteel Ingot
        {cutoff = 901, itemId =   645}, -- Darksteel Ore
    },
    [tpz.ki.CHOCOBO_KEY] =
    {
        {cutoff =  190, itemId = 16008}, -- Aptus Earring
        {cutoff =  285, itemId = 16372}, -- Stearc Subligar
        {cutoff =  571, itemId = 16295}, -- Varius Torque
        {cutoff =  595, itemId =   823}, -- Gold Thread
        {cutoff =  643, itemId =  4134}, -- Hi-Ether +2
        {cutoff =  714, itemId =  4118}, -- Hi-Potion +2
        {cutoff =  785, itemId =   837}, -- Malboro Fiber
        {cutoff =  856, itemId =  1110}, -- Beetle Blood
        {cutoff =  927, itemId =   924}, -- Philosophers Stone
        {cutoff =  995, itemId =   830}, -- Rainbow Cloth
        {cutoff = 1043, itemId =  1132}, -- Raxa
        {cutoff = 1067, itemId =  1465}, -- Granite
        {cutoff = 1115, itemId =  4174}, -- Vile Elixir
        {cutoff = 1186, itemId =   844}, -- Phoenix Feather
    },
    [tpz.ki.TONBERRY_KEY] =
    {
        {cutoff =  291, itemId = 15938}, -- Esprit Belt
        {cutoff =  600, itemId = 15937}, -- Fettle Belt
        {cutoff =  636, itemId =   813}, -- Angelstone
        {cutoff =  654, itemId =   812}, -- Deathstone
        {cutoff =  690, itemId =   645}, -- Darksteel Ore
        {cutoff =  708, itemId =   787}, -- Diamond
        {cutoff =  744, itemId =   785}, -- Emerald
        {cutoff =  780, itemId =   823}, -- Gold Thread
        {cutoff =  798, itemId =  4119}, -- Hi-Potion +3
        {cutoff =  816, itemId =   738}, -- Platinum Ore
        {cutoff =  834, itemId =   739}, -- Orichalcum Ore
        {cutoff =  870, itemId =   786}, -- Ruby
        {cutoff =  883, itemId =   794}, -- Sapphire
        {cutoff =  901, itemId =  4613}, -- Scroll of Cure V
        {cutoff =  919, itemId =  4748}, -- Scroll of Raise III
        {cutoff =  937, itemId =  4774}, -- Scroll of Thunder III
        {cutoff =  955, itemId =   804}, -- Spinel
        {cutoff =  973, itemId =   789}, -- Topaz
        {cutoff = 1082, itemId =  4174}, -- Vile Elixir
    },
}

local function givePrize(player, ki)
    if not player:hasKeyItem(ki) then
        player:showText(player, ID.text.NO_KEY)
    else
        local p = prizes[ki]
        if p ~= nil then
            -- determine prize
            local prize = nil
            local roll = math.random(p[#p].cutoff)
            for i = 1, #p do
                if roll <= p[i].cutoff then
                    prize = p[i]
                    break
                end
            end

            -- determine augments
            local addAug = {}
            if prize.augments ~= nil then
                local pAug = prize.augments
                local alreadyRolled = {}
                for i = 1, 4 do
                    roll = math.random(0, #pAug)
                    local a = pAug[roll]
                    if a ~= nil and alreadyRolled[a[1]] == nil then
                        alreadyRolled[a[1]] = true
                        table.insert(addAug, a[1])
                        table.insert(addAug, math.random(a[2], a[3]))
                    end
                end
            end
            for i = #addAug, 7 do
                table.insert(addAug, 0)
            end

            -- give prize
            if player:getFreeSlotsCount() == 0 then
                player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, prize.itemId)
            else
                player:addItem(prize.itemId, 1, unpack(addAug))
                player:messageSpecial(ID.text.ITEM_OBTAINED, prize.itemId)
                player:delKeyItem(ki)
            end
        end
    end
end

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local receivedNexusCape = player:getCharVar("receivedNexusCape")

    local arg1 =
        (not player:hasKeyItem(tpz.ki.CRIMSON_KEY)   and   2 or 0) +
        (not player:hasKeyItem(tpz.ki.VIRIDIAN_KEY)  and   4 or 0) +
        (not player:hasKeyItem(tpz.ki.AMBER_KEY)     and   8 or 0) +
        (not player:hasKeyItem(tpz.ki.AZURE_KEY)     and  16 or 0) +
        (not player:hasKeyItem(tpz.ki.IVORY_KEY)     and  32 or 0) +
        (not player:hasKeyItem(tpz.ki.EBON_KEY)      and  64 or 0) +
        (not player:hasKeyItem(tpz.ki.PRISMATIC_KEY) and 128 or 0)

    local arg2 =
        (not player:hasKeyItem(tpz.ki.WHITE_CORAL_KEY) and   2 or 0) +
        (not player:hasKeyItem(tpz.ki.BLUE_CORAL_KEY)  and   4 or 0) +
        (not player:hasKeyItem(tpz.ki.PEACH_CORAL_KEY) and   8 or 0) +
        (not player:hasKeyItem(tpz.ki.BLACK_CORAL_KEY) and  16 or 0) +
        (not player:hasKeyItem(tpz.ki.RED_CORAL_KEY)   and  32 or 0) +
        (not player:hasKeyItem(tpz.ki.ANGEL_SKIN_KEY)  and  64 or 0) +
        (not player:hasKeyItem(tpz.ki.OXBLOOD_KEY)     and 128 or 0)

    local arg3 =
        (not player:hasKeyItem(tpz.ki.MOOGLE_KEY)   and   2 or 0) +
        (not player:hasKeyItem(tpz.ki.BIRD_KEY)     and   4 or 0) +
        (not player:hasKeyItem(tpz.ki.CACTUAR_KEY)  and   8 or 0) +
        (not player:hasKeyItem(tpz.ki.BOMB_KEY)     and  16 or 0) +
        (not player:hasKeyItem(tpz.ki.CHOCOBO_KEY)  and  32 or 0) +
        (not player:hasKeyItem(tpz.ki.TONBERRY_KEY) and  64 or 0) +
        (not player:hasKeyItem(tpz.ki.BEHEMOTH_KEY) and 128 or 0)

    local arg4 =
        ((ENABLE_ACP == 0 or arg1 == 254) and 2 or 0) +
        ((ENABLE_AMK == 0 or arg2 == 254) and 4 or 0) +
        ((ENABLE_ASA == 0 or arg3 == 254) and 8 or 0) +
        ((ENABLE_ACP * ENABLE_AMK * ENABLE_ASA == 0 or receivedNexusCape == 1) and 16 or 0) +
        ((ENABLE_ACP * ENABLE_AMK * ENABLE_ASA == 0 or receivedNexusCape == 0) and 32 or 0)

    player:startEvent(10099, arg1, arg2, arg3, arg4, 0, 0, 0, 0)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 10099 then
        if option == 16777216 and player:getCharVar("receivedNexusCape") == 0 and npcUtil.giveItem(player, 11538) then
            player:setCharVar("receivedNexusCape", 1)
        elseif option == 33554432 or (option == 16777216 and player:getCharVar("receivedNexusCape") == 0) then
            player:addUsedItem(11538)
        elseif option >= 1 and option <= 20 then
            local ki = optionToKI[option]
            if ki ~= nil then
                givePrize(player, ki)
            end
        end
    end
end
