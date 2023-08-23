-- This file is called by login_campaign.lua and require()'s no file, it should not be require()'d by any
-- other lua scripts, which should instead require() login_campaign.lua directly.

-- ONLY 19 ITEMS PER PRICE BRACKET POSSIBLE!! (20 will overwrite the ingame back button.)

-- Cycles: After 1 month the next items need to get cycled in. Comment out and uncomment items appropriately.
-- Seasonal event categories supersede cycles. Harvest Festival for October and Starlight Celebration for December
-- todo: add sesonal event categories for other events

local prizes =
{
    [1] =
    {
        ["price"] = 10,
        ["items"] =
        {
        -- CONSUMABLES I

            1449, -- Tukuku Whiteshell
            1452, -- Ordelle Bronzepiece
            1455, -- 1 Byne Bill
            4104, -- Fire Cluster
            4105, -- Ice Cluster
            4106, -- Wind Cluster
            4107, -- Earth Cluster
            4108, -- Lightning Cluster
            4109, -- Water Cluster
            4110, -- Light Cluster
            4111, -- Dark Cluster
        },
    },

    [5] =
    {
        ["price"] = 50,
        ["items"] =
        {
        -- CONSUMABLES II and furnishings(7 per cycle)

        --static items
            1875, -- Ancient Beastcoin
            3279, -- Neptunal Tatter
            3280, -- Martial Tatter
            3281, -- Earthen Tatter
            3282, -- Dryadic Tatter
            3283, -- Aquarian Tatter
            3284, -- Wyrmal Tatter
            3285, -- Phantasmal Tatter
            3286, -- Hadean Tatter

        -- Cycle #1
            -- 154,  -- Miniature Airship
            -- 192,  -- Hoary Spire
            -- 264,  -- Stuffed Chocobo
            -- 265,  -- Adamant Statue
            -- 266,  -- Behemoth Statue
            -- 282,  -- Yovra Replica
            -- 3706, -- Vanaclock

        -- Cycle #2
            -- 267, -- Fafnir Statue
            -- 268, -- N moogle Statue
            -- 269, -- S lord Statue
            -- 270, -- Odin Statue
            -- 271, -- Alexander Statue
            -- 277, -- Prishe Statue
            -- 278, -- Cardian Statue

        -- Cycle #3
           --  279, -- S Lord Statue II
           --  280, -- S Lord Statue III
           --  281, -- Atomos Statue
           --  284, -- Goobbue Statue
           --  286, -- Nanaa Mihgo Statue
           --  287, -- Nanaa Mihgo S II
           --  320, -- Harpsichord

        -- Cycle #4
        --    365,  -- Poele Classique
        --    366,  -- Kanonenofen
        --    367,  -- Pot Topper
        --    415,  -- Aldebaran Horn
        --    426,  -- Orchestrion
        --    3585, -- Galley Kitchen
        --    3652, -- Memorial Cake

        -- Cycle # 5
            88,   -- Timepiece
            3679, -- Beastman Gonfalon
            3681, -- Alzadaal Table
            3698, -- Cherry Tree
            3705, -- Far East Hearth
            3717, -- Birch Tree

        -- Cycle # 6
            -- 195,  -- The Big One
            -- 3641, -- Kabuto Kazari
            -- 3642, -- Katana Kazari
            -- 3654, -- Tender Bouquet
            -- 3739, -- Autumn Tree
            -- 3740, -- Model Synergy Furn
        },
    },

    [9] =
    {
        ["price"] = 100,
        ["items"] =
        {
        -- COSTUMES

        -- Cycle #1/#6
            10250, -- Moogle Suit
            10384, -- Cumulus Masque
            10429, -- Moogle Masque
            25632, -- Carbie Cap
            25711, -- Botulus Suit
            26705, -- Mandragora Masque
            26798, -- Behemoth Masque
            26889, -- Heart Apron
            26954, -- Behemoth Suit
            26956, -- Poroggo Coat
            27715, -- Goblin Masque
            27765, -- Chocobo Masque
            27854, -- Mandragora Suit
            27859, -- Kengyu Happi
            27866, -- Goblin Suit
            27911, -- Chocobo Suit

        -- Cycle #2
            -- 11491, -- Snow Bunny Hat +1
            -- 23730, -- Karakul Cap
            -- 25585, -- Bl. Chocobo Cap
            -- 25606, -- Agent Hood
            -- 25607, -- Starlet Flower
            -- 25756, -- Wyrmking Suit
            -- 25657, -- Wyrmking Masque
            -- 25776, -- Bl. Chocobo Suit
            -- 25850, -- Pink Subligar
            -- 26514, -- Poroggo Fleece
            -- 26974, -- Agent Coat
            -- 26975, -- Starlet Jabot
            -- 27111, -- Agent Cuffs
            -- 27112, -- Starlet Gloves
            -- 27296, -- Agent Pants
            -- 27297, -- Starlet Skirt
            -- 27467, -- Agent Boots
            -- 27468, -- Starlet Boots
            -- 27717, -- Worm Masque

        -- Cycle #3
            -- 11812, -- Charity Cap
            -- 25639, -- Korrigan Masque
            -- 25645, -- Kupo Masque
            -- 25715, -- Korrigan Suit
            -- 25726, -- Kupo Suit
            -- 25774, -- Fancy Gilet
            -- 25775, -- Fancy Top
            -- 25838, -- Fancy Trunks
            -- 25839, -- Fancy Shorts
            -- 26707, -- Flan Masque
            -- 26717, -- Cait Sith Cap
            -- 26719, -- Sheep Cap
            -- 26738, -- Leafkin Cap
            -- 26789, -- Shobuhouou Kabuto
            -- 26946, -- Pupil's Shirt
            -- 26964, -- Pupil's Camisa
            -- 27281, -- Pupil's Trousers
            -- 27455, -- Pupil's Shoes

        -- Cycle #4
            -- 25649, -- Gazer's Helmet
            -- 25713, -- Track Shirt
            -- 25722, -- Jubilee Shirt
            -- 25755, -- Crustacean Shirt
            -- 25758, -- Rhapsody Shirt
            -- 26516, -- Citrullus Shirt
            -- 26517, -- Shadow Lord Shirt
            -- 26518, -- Jody Shirt
            -- 26519, -- Mandragora Shirt
            -- 26524, -- Gil Nabber Shirt
            -- 26545, -- Mithkabob Shirt
            -- 26965, -- Ta Moko
            -- 26967, -- Cossie Top
            -- 27291, -- Swimming Togs
            -- 27293, -- Cossie Bottom
            -- 27325, -- Track Pants
            -- 27899, -- Alliance Shirt
            -- 28185, -- Alliance Pants
            -- 28324, -- Alliance Boots

        -- Cycle #5
            -- 10446, -- Ahriman Cap
            -- 10875, -- Snowman Cap
            -- 23731, -- Royal Chocobo Beret
            -- 23753, -- Sandogasa
            -- 23790, -- Adenium Masque
            -- 23791, -- Adenium Suit
            -- 25604, -- Buffalo Cap
            -- 25648, -- Curmudgeon's Helmet
            -- 25670, -- Rarab Cap
            -- 25672, -- Snoll Masque
            -- 25677, -- Arthro's Cap
            -- 25910, -- Cait Sith Subligar
            -- 26520, -- Akitu Shirt
            -- 26693, -- Morbol Cap
            -- 26703, -- Lycopodium Masque
            -- 26729, -- Corolla
            -- 27716, -- Green Moogle Masque
            -- 27757, -- Bomb Masque
            -- 27867, -- Green Moogle Suit

        -- Cycle #6 (Costumes)
            -- 5113,  -- Cracked Nut
            -- 5116,  -- Cavorting Worm
            -- 5203,  -- Hume Mochi
            -- 5204,  -- Elvaan Mochi
            -- 5206,  -- Galka Mochi
            -- 5294,  -- Hume rice cake
            -- 5295,  -- Elvaan Rice Cake
            -- 5724,  -- Pungent Powder
            -- 5733,  -- Miracle Milk
            -- 6008,  -- Copse Candy
            -- 6535,  -- Pinch of Pungent Powder II
            -- 6537,  -- Pinch of Pungent Powder III

        -- Seasonal event Harvest Festival. Uncomment for October campaign only
            -- 203,   -- Bomb Lantern
            -- 204,   -- Pumpkin Lantern
            -- 205,   -- Mandra Lantern
            -- 3622,  -- Jack O' Pricket
            -- 3623,  -- Djinn Pricket
            -- 3624,  -- Korrigan Pricket
            -- 3646,  -- Mandra Pricket
            -- 3651,  -- Harvest Pastry
            -- 10446, -- Ahriman Cap
            -- 11300, -- Eerie Cloak
            -- 13916, -- Pumpkin-head
            -- 16075, -- Witch Hat
            -- 17565, -- Trick Staff
            -- 18102, -- Pitchfork
            -- 25586, -- Kakai Cap
            -- 25711, -- Botulus Suit
            -- 25910, -- Cait Sith Subligar
            -- 26707, -- Flan Masque

        -- Seasonal event Starlight Celebration. Uncomment for December campaign only.
        --    86,    -- Sandorian Tree
        --    115,   -- Bastokan Tree
        --    116,   -- Windurstian Tree
        --    138,   -- Jeunoan Tree
        --    176,   -- Snowman Knight
        --    177,   -- Snowman Miner
        --    178,   -- Snowman Mage
        --    3619,  -- Cour Des Etoiles
        --    3620,  -- Silberkranz
        --    3621,  -- Leafberry Wreath
        --    10383, -- Dream Mittens +1
        --    10875, -- Snowman Cap
        --    11490, -- Snow Bunny Hat
        --    11966, -- Dream Trousers +1
        --    11968, -- Dream Pants +1
        --    14520, -- Dream Robe +1
        --    15179, -- Dream Hat +1
        --    15753, -- Dream Boots +1
        --    18863, -- Dream Bell
        --    21097, -- Leafkin Bopper
        },
    },

    [13] =
    {
        ["price"] = 200,
        ["items"] =
        {
        -- WEAPON COSTUMES and crafting latent items

        -- Cycle #1/#5
            -- 20514, -- Aphelion Knuckles
            -- 20578, -- Wind Knife
            -- 20665, -- Kam'lanaut's Sword
            -- 20694, -- Fermion Sword
            -- 21693, -- Irradiance Blade
            -- 21741, -- Demonic Axe
            -- 21745, -- Dullahan Axe
            -- 21820, -- Lost Sickle
            -- 21862, -- Mizukage Naginata
            -- 21977, -- Mutsonokami -- BROKEN
            -- 22005, -- Burrower's Wand
            -- 22019, -- Jingly Rod
            -- 22067, -- Levin
            -- 22124, -- Artemis's Bow
            -- 22153, -- Silver Gun
            -- 22282, -- Grudge
            -- 22283, -- Marvelous Cheer
            -- 26412, -- Kam'lanaut's Shield
            -- 28661, -- Glinting Shield

        -- Cycle #2/#6
        --    18102, -- Pitchfork
        --    18441, -- Shinai
        --    18864, -- Dream Bell +1
        --    20532, -- Worm Feelers
        --    20577, -- Chicken Knife II
        --    20713, -- Excalipoor
        --    20909, -- Hoe
        --    21107, -- Kyuka Uchiwa
        --    21658, -- Brave Blade II
        --    21770, -- Helgoland
        --    21863, -- Tzee Xicu's Blade
        --    21967, -- Melon Slicer
        --    22017, -- Seika Uchiwa
        --    22069, -- Hapy Staff
        --    22072, -- Lamia Staff
        --    27625, -- Morbol Shield
        --    27631, -- Cait Sith Guard
        --    28652, -- Hatchling Shield
        --    28655, -- Slime Shield

        -- Cycle #3
            10808, -- Janus Guard
            10811, -- Chocobo Shield
            18399, -- Charm Wand
            18464, -- Ark Tachi
            18545, -- Ark Tabar
            18563, -- Ark Scythe
            18912, -- Ark Saber
            18913, -- Ark Sword
            20573, -- Aern Dagger
            20674, -- Aern Sword
            20953, -- Escritorio
            21509, -- Premium Mogti
            21682, -- Lament
            21742, -- Aern Axe
            21759, -- Autarch's Axe
            21860, -- Aern Spear
            22004, -- Soulflayer's Wand
            22065, -- Aern Staff
            26489, -- Troth

        -- Cycle #4
            -- 10809, -- Moogle Guard
            -- 20569, -- Esikuva
            -- 20571, -- Infiltrator
            -- 20576, -- Qutrub Knife
            -- 20666, -- Blizzard Brand
            -- 20668, -- Firetongue
            -- 20933, -- Hotengeki
            -- 21074, -- Kupo Rod
            -- 21086, -- Heartstopper
            -- 21095, -- Heartbeater
            -- 21153, -- Malice Masher
            -- 21608, -- Onion Sword II
            -- 21609, -- Save The Queen II
            -- 21636, -- Nihility
            -- 21867, -- Sha Wujing's Lance
            -- 21965, -- Zanmato
            -- 22039, -- Floral Hagoita
            -- 22089, -- Sophistry
            -- 26410, -- Diamond Buckler

        -- Cycle #5
            -- 11499, -- Trainees Specs
            -- 15008, -- Trainee Gloves
            -- 17764, -- Trainee Sword
            -- 18502, -- Trainee Axe
            -- 18763, -- Trainee Scissors
            -- 18855, -- Trainee Hammer
            -- 19101, -- Trainee Knife
            -- 19110, -- Trainees Needle
            -- 19274, -- Trainee Burin

        -- Cycle #6 (Costumes)
            -- 10849, -- Yagudo Belt
            -- 10851, -- Slime Belt
            -- 15919, -- Drover's Belt
            -- 15921, -- Detonator Belt
            -- 16273, -- Pullus Torque
            -- 17031, -- Shell Scepter
            -- 27718, -- Worm Masque +1
        },
    },

    [17] =
    {
        ["price"] = 500,
        ["items"] =
        {
        -- MOUNTS

        -- TODO: Add mounts which only have a KeyItem.
        -- https://www.bg-wiki.com/ffxi/Levitus_key
        -- https://www.bg-wiki.com/ffxi/Omega_whistle
        -- https://www.bg-wiki.com/ffxi/Spectral_chair_companion
        -- https://www.bg-wiki.com/ffxi/Morbol_companion
        -- https://www.bg-wiki.com/ffxi/Moogle_companion
        -- https://www.bg-wiki.com/ffxi/Sheep_companion

            10050, -- ♪Tiger
            10051, -- ♪Crab
            -- 10052, -- ♪Red Crab
            10053, -- ♪Bomb
            10056, -- ♪Crawler
            10058, -- ♪Beetle
            10060, -- ♪Magic Pot
            10061, -- ♪Tulfaire
            10062, -- ♪Warmachine
            10063, -- ♪Xzomit
            10064, -- ♪Hippogryph
            10066, -- ♪Spheroid
            10068, -- ♪Coeurl
            10069, -- ♪Goobbue
            10070, -- ♪Raaz
            10072, -- ♪Adamantoise
            10073, -- ♪Dhalmel
            10074, -- ♪Doll
            -- 10075, -- ♪Red Raptor
            -- 10076, -- ♪Golden Bomb
            10077, -- ♪Buffalo
            10078, -- ♪Wivre
        },

    },

    [21] =
    {
        ["price"] = 1000,
        ["items"] =
        {
        -- Crafting items, leave these here until we can modify our skillup rates again

        -- static item
            11009, -- Shapers Shawl
            25637, -- Midrass Helm +1
            28585, -- Craftkeepers Ring
            28586, -- Craftmasters Ring
            28587, -- Artificers Ring

        -- Dyna currency
            -- static item
            1450, -- Lungo-Nango Jadeshell
            1453, -- Montiont Silverpiece
            1456, -- 100 Byne Bill

        -- HIGHLEVEL MATERIALS
            -- 658,  -- Damascus Ingot
            -- 686,  -- Imperial Wootz Ingot
            -- 720,  -- Ancient Lumber
            -- 723,  -- Divine Lumber
            -- 747,  -- Orichalcum Ingot
            -- 831,  -- Shining Cloth
            -- 862,  -- Behemoth Leather
            -- 1312, -- Angel Skin
            -- 1313, -- Siren's Hair
            -- 1409, -- Siren's Macrame
            -- 1714, -- Cashmere Cloth
            -- 2169, -- Cerberus Hide
            -- 2371, -- Khimaira Horn

        -- Cycle #2
            -- 655,  -- Adaman Ingot
            -- 836,  -- Damascene Cloth
            -- 837,  -- Malboro Fiber
            -- 1133, -- Dragon Blood
            -- 1289, -- Burning Hakutaku Eye
            -- 1446, -- Lacquer Tree Log
            -- 2001, -- Dark Adaman Sheet
            -- 2152, -- Marid Leather
            -- 2275, -- Scintillant Ingot
            -- 2289, -- Wamoura Cloth
            -- 2340, -- Imperial Silk Cloth
            -- 2535, -- Jacaranda Lumber
            -- 4272, -- Dragon Meat

        -- Cycle #3
            -- 730,  -- Bloodwood Lumber
            -- 866,  -- Wyvern Scales
            -- 867,  -- Dragon Scales
            -- 901,  -- Venomous Claw
            -- 903,  -- Dragon Talon
            -- 908,  -- Adamantoise Shell
            -- 1110, -- Beetle Blood
            -- 1311, -- Oxblood
            -- 1816, -- Wyrm Horn
            -- 2168, -- Cerberus Claw
            -- 2172, -- Hydra Scale
        },
    },

    [25] =
    {
        ["price"] = 1500,
        ["items"] =
        {
        -- NICE TO HAVE STUFF

        -- Cycle #1 -- Crafting/Nyzul sets <- These need to be highest login tier next time!
            -- 14568, -- Askar Korazin
            -- 14569, -- Denali Jacket
            -- 14570, -- Goliard Saio
            -- 14983, -- Askar Manopolas
            -- 14984, -- Denali Wristbands
            -- 14985, -- Goliard Cuffs
            -- 15647, -- Askar Dirs
            -- 15648, -- Denali Kecks
            -- 15649, -- Goliard Trews
            -- 15733, -- Askar Gambieras
            -- 15734, -- Denali Gamashes
            -- 15735, -- Goliard Clogs
            -- 16106, -- Askar Zucchetto
            -- 16107, -- Denali Bonnet
            -- 16108, -- Goliard Chapeau
            -- 28585, -- Craftkeeper's Ring
            -- 28587, -- Artificer's Ring

        -- Cycle #2 -- Nexus/ToAU rings/Odin Prime/Alexander Prime/CoP items
        --    11343, -- Thrakon Breastplate
        --    11538, -- Nexus Cape
        --    11546, -- Aesir Mantle
        --    11547, -- Colossus's Mantle
        --    11589, -- Aesir Torque
        --    11590, -- Colossus's Torque
        --    13177, -- Stone Gorget
        --    14889, -- Barbarian Mittens
        --    15457, -- Swift Belt
        --    16035, -- Altdorf's Earring
        --    16036, -- Wilhelm's Earring
        --    16057, -- Aesir Ear Pendant
        --    16058, -- Colossus's Earring
        --    17208, -- Hamayumi
        --    17466, -- Dia Wand
        --    18019, -- X's Knife
        --    18057, -- Y's Scythe
        --    18101, -- Z's Trident
        --    27556, -- Echad Ring

        -- Cycle #3 -- WOTG Nations
            14589, -- Fourth Brunne
            14590, -- Cobra Harness
            14591, -- Cobra Robe
            15010, -- Fourth Hentzes
            15011, -- Cobra Mittens
            15012, -- Cobra Gloves
            15756, -- Fourth Schuhs
            15757, -- Cobra Leggings
            15758, -- Cobra Crackows
            16147, -- Fourth Haube
            16148, -- Cobra Cap
            16149, -- Cobra Cloche
            16316, -- Fourth Schoss
            16317, -- Cobra Subligar
            16318, -- Cobra Trews

        -- Cycle #4 -- Assault gear
            -- 14525, -- Amir Korazin
            -- 14527, -- Yigit Gomlek
            -- 14530, -- Pln. Khazagand
            -- 14933, -- Amir Kolluks
            -- 14935, -- Yigit Gages
            -- 14940, -- Pln. Dastanas
            -- 15604, -- Amir Dirs
            -- 15606, -- Yigit Seraweels
            -- 15609, -- Pln. Seraweels
            -- 15688, -- Amir Boots
            -- 15690, -- Yigit Crackows
            -- 15695, -- Pln. Crackows
            -- 16062, -- Amir Puggaree
            -- 16064, -- Yigit Turban
            -- 16069, -- Pln. Qalansuwa
            -- 27556, -- Echad Ring

        -- Cycle #5 -- TOAU NM drops/Apollyon AF+1 items part 1
            -- 1931,  -- Argyro Rivet (WAR)
            -- 1933,  -- Ancient Brass (MNK)
            -- 1935,  -- Benedict Yarn (WHM)
            -- 1937,  -- Diabolic Yarn (BLM)
            -- 1939,  -- Cardinal Cloth (RDM)
            -- 1941,  -- Light Filament (THF)
            -- 1943,  -- White Rivet (PLD)
            -- 1945,  -- Black Rivet (DRK)
            -- 1947,  -- Fetid Lanolin (BST)
            -- 1949,  -- Brown Doeskin (BRD)
            -- 11496, -- Fenrir's Crown
            -- 16375, -- Surge Subligar
            -- 17971, -- Tartaglia
            -- 19235, -- Veuglaire

        -- Cycle #6 --Apollyon AF+1 items part 2
            -- 1951,  -- Charcoal Cotton (RNG)
            -- 1953,  -- Kurogane (SAM)
            -- 1955,  -- Ebony Lacquer (NIN)
            -- 1957,  -- Blue Rivet (DRG)
            -- 1959,  -- Astral Leather (SMN)
            -- 2657,  -- Flameshun Cloth (BLU)
            -- 2659,  -- Canvas Toile (COR)
            -- 2661,  -- Corduroy Cloth (PUP)
            -- 2715,  -- Gold Stud (DNC)
            -- 2717,  -- Electrum Stud (SCH)
            -- 27556, -- Echad Ring
        },
    },

    [29] =
    {
        ["price"] = 1500,
        ["items"] =
        {
        -- GAMECHANGERS

        -- Cycle #1 -- TH/Crafting/EXP/CoP rings
            -- 11009, -- Shaper's Shawl
            -- 15220, -- Rain hat
            -- 15543, -- Raja's Ring
            -- 15544, -- Sattva Ring
            -- 15545, -- Tamas Ring
            -- 25608, -- Tlahtlamah glasses
            -- 25679, -- White Rarab Cap +1
            -- 28586, -- Craftmaster's Ring

        -- Cycle #2 -- Divine Might/Apocalypse Nigh
        --    14740, -- Knight's Earring
        --    14741, -- Abyssal Earring
        --    14742, -- Beastly Earring
        --    14743, -- Bushinomimi
        --    15962, -- Static Earring
        --    15963, -- Magnetic Earring
        --    15964, -- Hollow Earring
        --    15965, -- Ethereal Earring

        -- Cycle #3 -- Useful NM drops/MMM
            13303, -- Jelly Ring
            13567, -- Bomb Queen Ring
            13915, -- Optical Hat
            14469, -- Reverend Mail
            14986, -- Ochimusha Kote
            15221, -- Patroclus's Helm
            15224, -- Empress Hairpin
            15351, -- Bounding Boots
            15515, -- Peacock Amulet
            15736, -- Trotter Boots
            15737, -- Sarutobi Kyahan
            17759, -- Koggelmander
            18714, -- Vali's Bow
            18752, -- Retaliators
            19236, -- Hightail Bullet

        -- Cycle #4 -- HQ Kings pop items/Carbuncle Prime/WOTG Nations/Naji's/TH+1 hat
            -- 3340,  -- Sweet Tea (Nidhogg pop)
            -- 3342,  -- Savory Shank (King Behemoth pop)
            -- 3344,  -- Red Pondweed (Aspidochelone pop)
            -- 14588, -- Iron Ram Hauberk
            -- 14931, -- Carbuncle's Cuffs
            -- 15009, -- Iron Ram Dastanas
            -- 15755, -- Iron Ram Greaves
            -- 16146, -- Iron Ram Sallet
            -- 16315, -- Iron Ram Hose
            -- 17192, -- Ifrit's Bow
            -- 17711, -- Shiva's Shotel
            -- 18021, -- Titan's Baselarde
            -- 18063, -- Garuda's Sickle
            -- 18109, -- Leviathan's Couse
            -- 18404, -- Ramuh's Mace
            -- 25679, -- White Rarab Cap +1 (TH+1)
            -- 26219, -- Naji's Loop

        -- Cycle #5 -- WOTG Nations
            -- 11545, -- Fourth Mantle
            -- 11588, -- Mrc.Mjr. Charm
            -- 11636, -- R.K. Sigil Ring
            -- 15844, -- Patronus Ring
            -- 15934, -- Crimson Belt
            -- 15935, -- Capricornian Rope
            -- 15936, -- Earthy Belt
            -- 15966, -- Silver Fox Earring
            -- 15967, -- Temple Earring
            -- 16258, -- Arrestor Mantle
            -- 16291, -- Shield Collar
            -- 16292, -- Bull Necklace
            -- 16293, -- Cougar Pendant
            -- 16294, -- Crocodile Collar
            -- 18734, -- Sturm's Report
            -- 18735, -- Sonia's Plectrum
            -- 19041, -- Rose Strap
            -- 19042, -- Ariesian Grip

        -- Cycle #6 -- Temenos AF+1 items (Change point cost to 1500 for this cycle only!)
            -- 1930, -- Ecarlate Cloth (WAR)
            -- 1932, -- Utopian Gold Thread (MNK)
            -- 1934, -- Benedict Silk (WHM)
            -- 1936, -- Diabolic Silk (BLM)
            -- 1938, -- Ruby Silk Thread (RDM)
            -- 1940, -- Supple Skin (THF)
            -- 1942, -- Snowy Cermet (PLD)
            -- 1944, -- Dark Orichalcum (DRK)
            -- 1946, -- Smalt Leather (BST)
            -- 1948, -- Coiled Yarn (BRD)
            -- 1950, -- Chameleon Yarn (RNG)
            -- 1952, -- Scarlet Odoshi (SAM)
            -- 1954, -- Plaited Cord (NIN)
            -- 1956, -- Cobalt Mythril Sheet (DRG)
            -- 1958, -- Glittering Yarn (SMN)
            -- 2656, -- Luminian Thread (BLU)
            -- 2658, -- Silkworm Thread (COR)
            -- 2660, -- Pantin Wire (PUP)
            -- 2714, -- Filet Lace (DNC)
            -- 2716, -- Brilliantine (SCH)
        },
    },
}
return prizes
