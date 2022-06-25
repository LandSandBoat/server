-- This file is called by login_campaign.lua and require()'s no file, it should not be require()'d by any
-- other lua scripts, which should instead require() login_campaign.lua directly.

-- ONLY 19 ITEMS PER PRICE BRACKET POSSIBLE!! (20 will overwrite the ingame back button.)

-- Cycles: After 1 month the next items need to get cycled in. Comment out and uncomment items appropriately.

local prizes =
{
    [1] =
    {
        ["price"] = 10,
        ["items"] =
        {
        -- CONSUMABLES I
			
			1126, -- Beastmen's Seal
			1455, -- 1 Byne Bill
			1449, -- Tukuku Whiteshell
			1452, -- Ordelle Bronzepiece
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
		-- CONSUMABLES II
			
			1875, -- Ancient Beastcoin
			3283, -- Aquarian Tatter
			3282, -- Dryadic Tatter
			3281, -- Earthen Tatter
			3280, -- Martial Tatter
			3279, -- Neptunal Tatter
			3284, -- Wyrmal Tatter
			3286, -- Hadean Tatter
			3285, -- Phantasmal Tatter
			3278, -- Byakko Scrap
			3275, -- Genbu Scrap
			3277, -- Seiryu Scrap
			3276, -- Suzaku Scrap

        },
    },

    [9] =
    {
        ["price"] = 100,
        ["items"] =
        {
        -- COSTUMES
			
			-- Cycle #1/#6
			-- 10429, -- Moogle Masque
			-- 10250, -- Moogle Suit
			-- 27765, -- Chocobo Masque
			-- 27911, -- Chocobo Suit
			-- 26798, -- Behemoth Masque
			-- 26954, -- Behemoth Suit
			-- 27715, -- Goblin Masque
			-- 27866, -- Goblin Suit
			-- 26705, -- Mandragora Masque
			-- 27854, -- Mandragora Suit
			-- 26956, -- Poroggo Coat
			-- 25711, -- Botulus Suit
			-- 25632, -- Carbie Cap
			-- 10384, -- Cumulus Masque
			-- 27859, -- Kengyu Happi 
			-- 28149, -- Kengyu Hanmomohiki 	-- BROKEN
			-- 27860, -- Shokujo Happi 			-- BROKEN
			-- 28150, -- Shokujo Hanmomohiki	-- BROKEN
			-- 26889, -- Heart Apron
			
			-- Cycle #2
            25606, -- Agent Hood
			26974, -- Agent Coat
			27111, -- Agent Cuffs
			27296, -- Agent Pants
			27467, -- Agent Boots
			25607, -- Starlet Flower
			26975, -- Starlet Jabot
			27112, -- Starlet Gloves
			27297, -- Starlet Skirt
			27468, -- Starlet Boots
			25657, -- Wyrmking Masque
			25756, -- Wyrmking Suit
			25585, -- Bl. Chocobo Cap
			25776, -- Bl. Chocobo Suit
			26514, -- Poroggo Fleece
			27717, -- Worm Masque
			11491, -- Snow Bunny Hat +1
			23730, -- Karakul Cap
			25850, -- Pink Subligar
			
			-- Cycle #3
			-- 25774, -- Fancy Gilet
			-- 25838, -- Fancy Trunks
			-- 25775, -- Fancy Top
			-- 25839, -- Fancy Shorts
			-- 26964, -- Pupil's Camisa 
			-- 26946, -- Pupil's Shirt
			-- 27281, -- Pupil's Trousers
			-- 27455, -- Pupil's Shoes 
			-- 25639, -- Korrigan Masque
			-- 25715, -- Korrigan Suit
			-- 25645, -- Kupo Masque
			-- 25726, -- Kupo Suit
			-- 11812, -- Charity Cap
			-- 26719, -- Sheep Cap
			-- 26717, -- Cait Sith Cap
			-- 26738, -- Leafkin Cap
			-- 26707, -- Flan Masque
			-- 23737, -- Byakko Masque
			-- 26789, -- Shobuhouou Kabuto
			
			-- Cycle #4
			-- 27899, -- Alliance Shirt
			-- 28185, -- Alliance Pants
			-- 28324, -- Alliance Boots 
			-- 26967, -- Cossie Top
			-- 27293, -- Cossie Bottom
			-- 26965, -- Ta Moko
			-- 27291, -- Swimming Togs
			-- 25713, -- Track Shirt
			-- 27325, -- Track Pants 
			-- 25649, -- Gazer's Helmet
			-- 26519, -- Mandragora Shirt
			-- 26516, -- Citrullus Shirt
			-- 25755, -- Crustacean Shirt
			-- 26524, -- Gil Nabber Shirt
			-- 26518, -- Jody Shirt
			-- 25722, -- Jubilee Shirt
			-- 26545, -- Mithkabob Shirt
			-- 25758, -- Rhapsody Shirt
			-- 26517, -- Shadow Lord Shirt
            
			-- Cycle #5
			-- 26520, -- Akitu Shirt
			-- 23753, -- Sandogasa
			-- 23790, -- Adenium Masque
			-- 23791, -- Adenium Suit
			-- 27716, -- Green Moogle Masque
			-- 27867, -- Green Moogle Suit
			-- 25910, -- Cait Sith Subligar
			-- 25648, -- Curmudgeon's Helmet
			-- 26729, -- Corolla
			-- 25677, -- Arthro's Cap
			-- 25670, -- Rarab Cap
			-- 23731, -- Royal Chocobo Beret
			-- 25672, -- Snoll Masque
			-- 25604, -- Buffalo Cap
			-- 26693, -- Morbol Cap
			-- 10875, -- Snowman Cap
			-- 26703, -- Lycopodium Masque
			-- 10446, -- Ahriman Cap
			-- 27757, -- Bomb Masque
			
			-- Cycle #?
			-- TODO: Add rest of Storage Slip 11
			-- 25638, -- Pachypodium Masque
			-- 25586, -- Kakai Cap

        },
    },

    [13] =
    {
        ["price"] = 200,
        ["items"] =
        {
        -- WEAPON COSTUMES
		   
		   -- Cycle #1/#5
		   -- 20514, -- Aphelion Knuckles
		   -- 20578, -- Wind Knife
		   -- 20694, -- Fermion Sword
		   -- 20665, -- Kam'lanaut's Sword
		   -- 26412, -- Kam'lanaut's Shield
		   -- 28661, -- Glinting Shield
		   -- 21741, -- Demonic Axe
		   -- 21693, -- Irradiance Blade
		   -- 21745, -- Dullahan Axe
		   -- 21977, -- Mutsonokami		-- BROKEN
		   -- 21862, -- Mizukage Naginata
		   -- 22005, -- Burrower's Wand
		   -- 22019, -- Jingly Rod
		   -- 22067, -- Levin
		   -- 21820, -- Lost Sickle
		   -- 22283, -- Marvelous Cheer
		   -- 22124, -- Artemis's Bow
		   -- 22282, -- Grudge
		   -- 22153, -- Silver Gun
		   
		   -- Cycle #2/#6
		   -- 20532, -- Worm Feelers
		   -- 20577, -- Chicken Knife II
		   -- 20713, -- Excalipoor
		   -- 28652, -- Hatchling Shield
		   -- 27631, -- Cait Sith Guard
		   -- 27625, -- Morbol Shield
		   -- 28655, -- Slime Shield
		   -- 21770, -- Helgoland
		   -- 21658, -- Brave Blade II
		   -- 18441, -- Shinai
		   -- 21967, -- Melon Slicer
		   -- 21863, -- Tzee Xicu's Blade
		   -- 18102, -- Pitchfork
		   -- 22017, -- Seika Uchiwa
		   -- 21107, -- Kyuka Uchiwa
		   -- 18864, -- Dream Bell +1
		   -- 22072, -- Lamia Staff
		   -- 22069, -- Hapy Staff
		   -- 20909, -- Hoe

		   
		   -- Cycle #3
		   21509, -- Premium Mogti
		   20573, -- Aern Dagger
		   20674, -- Aern Sword
		   18912, -- Ark Saber
		   18913, -- Ark Sword
		   26489, -- Troth
		   10808, -- Janus Guard
		   10811, -- Chocobo Shield
		   21759, -- Autarch's Axe
		   21682, -- Lament
		   21742, -- Aern Axe
		   18545, -- Ark Tabar
		   18464, -- Ark Tachi
		   21860, -- Aern Spear
		   20953, -- Escritorio
		   22004, -- Soulflayer's Wand
		   18399, -- Charm Wand
		   22065, -- Aern Staff
		   18563, -- Ark Scythe
		   
		   -- Cycle #4
		   -- 20571, -- Infiltrator
		   -- 20569, -- Esikuva
		   -- 20576, -- Qutrub Knife
		   -- 21608, -- Onion Sword II
		   -- 21609, -- Save The Queen II
		   -- 21636, -- Nihility
		   -- 20668, -- Firetongue
		   -- 20666, -- Blizzard Brand
		   -- 26410, -- Diamond Buckler
		   -- 10809, -- Moogle Guard
		   -- 21965, -- Zanmato
		   -- 21867, -- Sha Wujing's Lance
		   -- 20933, -- Hotengeki
		   -- 21086, -- Heartstopper
		   -- 21095, -- Heartbeater
		   -- 22039, -- Floral Hagoita
		   -- 21074, -- Kupo Rod
		   -- 21153, -- Malice Masher
		   -- 22089, -- Sophistry

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
			
            10073, -- ♪Dhalmel
			10069, -- ♪Goobbue
            10051, -- ♪Crab
            10058, -- ♪Beetle
			10050, -- ♪Tiger
			10053, -- ♪Bomb
			10056, -- ♪Crawler
			10060, -- ♪Magic Pot
			10061, -- ♪Tulfaire
			10062, -- ♪Warmachine
			10063, -- ♪Xzomit
			10064, -- ♪Hippogryph
			10066, -- ♪Spheroid
			10068, -- ♪Coeurl
			10070, -- ♪Raaz
			10072, -- ♪Adamantoise
			10074, -- ♪Doll
			10077, -- ♪Buffalo
			10078, -- ♪Wivre
			-- 10052, -- ♪Red Crab
			-- 10075, -- ♪Red Raptor
			-- 10076, -- ♪Golden Bomb
        },

    },

    [21] =
    {
        ["price"] = 1000,
        ["items"] =
        {
        -- HIGHLEVEL MATERIALS
			
			1456, -- 100 Byne Bill
			1450, -- Lungo-Nango Jadeshell
			1453, -- Montiont Silverpiece
			
			658, -- Damascus Ingot
			747, -- Orichalcum Ingot
			686, -- Imperial Wootz Ingot
			1714, -- Cashmere Cloth
			1313, -- Siren's Hair
			1409, -- Siren's Macrame
			831, -- Shining Cloth
			862, -- Behemoth Leather
			2170, -- Cerberus Leather
			1312, -- Angel Skin
			723, -- Divine Lumber
			720, -- Ancient Lumber
			2535, -- Jacaranda Lumber
			1446, -- Lacquer Tree Log
			1133, -- Dragon Blood
			4272, -- Dragon Meat
			
			-- Other interesting Materials:
			-- 655, -- Adaman Ingot
			-- 2275, -- Scintillant Ingot
			-- 2001, -- Dark Adaman Sheet
			-- 836, -- Damascene Cloth
			-- 2289, -- Wamoura Cloth
			-- 2340, -- Imperial Silk Cloth
			-- 837, -- Malboro Fiber
			-- 2152, -- Marid Leather
			-- 730, -- Bloodwood Lumber
			-- 901, -- Venomous Claw
			-- 903, -- Dragon Talon
			-- 1311, -- Oxblood
			-- 908, -- Adamantoise Shell
			-- 867, -- Dragon Scales
			-- 866, -- Wyvern Scales
			-- 1816, -- Wyrm Horn
			-- 1110, -- Beetle Blood
			
			
        },
    },

    [25] =
    {
        ["price"] = 1500,
        ["items"] =
        {
		-- NICE TO HAVE STUFF

			-- Cycle #1 -- Crafting/Nyzul sets <- These need to be highest login tier next time!
			28587, -- Artificer's Ring
			28585, -- Craftkeeper's Ring
			16106, -- Askar Zucchetto
			14568, -- Askar Korazin
			14983, -- Askar Manopolas
			15647, -- Askar Dirs
			15733, -- Askar Gambieras
			16107, -- Denali Bonnet
			14569, -- Denali Jacket 
			14984, -- Denali Wristbands 
			15648, -- Denali Kecks
			15734, -- Denali Gamashes
			16108, -- Goliard Chapeau 
			14570, -- Goliard Saio 
			14985, -- Goliard Cuffs
			15649, -- Goliard Trews
			15735, -- Goliard Clogs
			
			-- Cycle #2 -- Nexus/ToAU rings/Odin Prime/Alexander Prime/CoP items
			-- 11538, -- Nexus Cape
			-- 11589, -- Aesir Torque
			-- 11546, -- Aesir Mantle
			-- 16057, -- Aesir Ear Pendant
			-- 11590, -- Colossus's Torque
			-- 11547, -- Colossus's Mantle
			-- 16058, -- Colossus's Earring
			-- 17208, -- Hamayumi
			-- 17466, -- Dia Wand
			-- 13177, -- Stone Gorget
			-- 18019, -- X's Knife
			-- 18057, -- Y's Scythe
			-- 18101, -- Z's Trident
			-- 15457, -- Swift Belt
			-- 14889, -- Barbarian Mittens
			-- 16036, -- Wilhelm's Earring
			-- 16035, -- Altdorf's Earring
			-- 11343, -- Thrakon Breastplate
			
			-- Cycle #3 -- WOTG Nations
			-- 16149, -- Cobra Cloche
			-- 14591, -- Cobra Robe
			-- 15012, -- Cobra Gloves
			-- 16318, -- Cobra Trews
			-- 15758, -- Cobra Crackows
			-- 16148, -- Cobra Cap
			-- 14590, -- Cobra Harness
			-- 15011, -- Cobra Mittens
			-- 16317, -- Cobra Subligar
			-- 15757, -- Cobra Leggings
			-- 16147, -- Fourth Haube
			-- 14589, -- Fourth Brunne
			-- 15010, -- Fourth Hentzes
			-- 16316, -- Fourth Schoss
			-- 15756, -- Fourth Schuhs
			
			-- Cycle #4 -- TOAU NM drops/Assault gear
			-- 11496, -- Fenrir's Crown
			-- 19235, -- Veuglaire
			-- 16375, -- Surge Subligar
			-- 17971, -- Tartaglia
			-- 16062, -- Amir Puggaree
			-- 14525, -- Amir Korazin
			-- 14933, -- Amir Kolluks
			-- 15604, -- Amir Dirs
			-- 15688, -- Amir Boots 
			-- 16069, -- Pln. Qalansuwa
			-- 14530, -- Pln. Khazagand
			-- 14940, -- Pln. Dastanas
			-- 15609, -- Pln. Seraweels
			-- 15695, -- Pln. Crackows 
			-- 16064, -- Yigit Turban
			-- 14527, -- Yigit Gomlek
			-- 14935, -- Yigit Gages
			-- 15606, -- Yigit Seraweels
			-- 15690, -- Yigit Crackows
			
			-- Cycle #5 -- Apollyon AF+1 items
			-- 1931, -- Argyro Rivet (WAR)
			-- 1933, -- Ancient Brass (MNK)
			-- 1935, -- Benedict Yarn (WHM)
			-- 1937, -- Diabolic Yarn (BLM)
			-- 1939, -- Cardinal Cloth (RDM)
			-- 1941, -- Light Filament (THF)
			-- 1943, -- White Rivet (PLD)
			-- 1945, -- Black Rivet (DRK)
			-- 1947, -- Fetid Lanolin (BST)
			-- 1949, -- Brown Doeskin (BRD)
			-- 1951, -- Charcoal Cotton (RNG)
			-- 1953, -- Kurogane (SAM)
			-- 1955, -- Ebony Lacquer (NIN)
			-- 1957, -- Blue Rivet (DRG)
			-- 1959, -- Astral Leather (SMN)
			-- 2657, -- Flameshun Cloth (BLU)
			-- 2659, -- Canvas Toile (COR)
			-- 2661, -- Corduroy Cloth (PUP)
			-- 2715, -- Gold Stud (DNC)
			-- 2717, -- Electrum Stud (SCH)
			
			-- Cycle #? -- Treasure Casket gear
			
			-- Cycle #? -- CoP subligars
        },
    },

    [29] =
    {
        ["price"] = 1500,
        ["items"] =
        {
        -- GAMECHANGERS
			
			-- Cycle #1 -- TH/Crafting/EXP/CoP rings
			25679, -- White Rarab Cap +1
			28586, -- Craftmaster's Ring
			11009, -- Shaper's Shawl
			27556, -- Echad Ring
			15543, -- Raja's Ring
			15544, -- Sattva Ring
			15545, -- Tamas Ring
			
			-- Cycle #2 -- Divine Might/Apocalypse Nigh/Sea capes/Sea torques
			-- 15962, -- Static Earring
			-- 15963, -- Magnetic Earring
			-- 15964, -- Hollow Earring
			-- 15965, -- Ethereal Earring
			-- 14740, -- Knight's Earring
			-- 14741, -- Abyssal Earring
			-- 14742, -- Beastly Earring
			-- 14743, -- Bushinomimi	
			
			-- Cycle #3 -- Useful NM drops/MMM
			-- 15351, -- Bounding Boots
			-- 15224, -- Empress Hairpin
			-- 14986, -- Ochimusha Kote
			-- 15737, -- Sarutobi Kyahan
			-- 15736, -- Trotter Boots
			-- 15515, -- Peacock Amulet
			-- 18752, -- Retaliators
			-- 18714, -- Vali's Bow
			-- 18852, -- Octave Club
			-- 14469, -- Reverend Mail
			-- 13915, -- Optical Hat
			-- 15221, -- Patroclus's Helm
			-- 13567, -- Bomb Queen Ring
			-- 13303, -- Jelly Ring
			-- 17759, -- Koggelmander
			
			-- Cycle #4 -- HQ Kings pop items/Carbuncle Prime/WOTG Nations/Naji's/TH+1 hat
			-- 3340,  -- Sweet Tea (Nidhogg pop)
			-- 3342,  -- Savory Shank (King Behemoth pop)
			-- 3344,  -- Red Pondweed (Aspidochelone pop)
			-- 14931, -- Carbuncle's Cuffs
			-- 18063, -- Garuda's Sickle
			-- 17192, -- Ifrit's Bow
			-- 18109, -- Leviathan's Couse
			-- 18404, -- Ramuh's Mace
			-- 17711, -- Shiva's Shotel
			-- 18021, -- Titan's Baselarde
			-- 26219, -- Naji's Loop
			-- 16146, -- Iron Ram Sallet
			-- 14588, -- Iron Ram Hauberk
			-- 15009, -- Iron Ram Dastanas
			-- 16315, -- Iron Ram Hose
			-- 15755, -- Iron Ram Greaves
			-- 25679, -- White Rarab Cap +1 (TH+1)
			
			-- Cycle #5 -- WOTG Nations
			-- 11636, -- R.K. Sigil Ring
			-- 15844, -- Patronus Ring
			-- 15966, -- Silver Fox Earring
			-- 15967, -- Temple Earring
			-- 15934, -- Crimson Belt
			-- 19041, -- Rose Strap
			-- 11545, -- Fourth Mantle
			-- 16291, -- Shield Collar
			-- 18734, -- Sturm's Report
			-- 18735, -- Sonia's Plectrum
			-- 16292, -- Bull Necklace
			-- 16258, -- Arrestor Mantle
			-- 11588, -- Mrc.Mjr. Charm
			-- 15935, -- Capricornian Rope
			-- 15936, -- Earthy Belt 
			-- 16293, -- Cougar Pendant
			-- 16294, -- Crocodile Collar
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
