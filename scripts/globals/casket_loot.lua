-----------------------------------------------------------
-- Caskets loot tables
-- Note: some zones are split into high and low teir,
-- this is because some zones have high mobs and low mobs,
-- and the drops are level dependant.
-----------------------------------------------------------

require("scripts/globals/zone")

tpz = tpz or {}
tpz.casket_loot = tpz.casket_loot or {}

tpz.casket_loot.casketItems =
{
    [tpz.zone.WEST_RONFAURE] =
    {
        regionalItems = {15834}, -- Blind Ring
        temps =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {1060, 4112}, -- Potion
            { 790, 4113}, -- Potion +1
            { 425, 4114}, -- Potion +2
            {1040, 4128}, -- Ether
            { 760, 4129}, -- Ether +1
            { 420, 4130}, -- Ether +2
            { 600, 4145}, -- Elixer
            { 820, 4148}, -- Antidote
            { 730, 4150}, -- Eye Drops
            { 750, 4151}, -- Echo Drops
            { 350, 4155}, -- Remedy
            {1020, 4164}, -- Prism Powder
            { 940, 4165}, -- Silent Oil
            { 420, 4202}, -- Daedalus Wing
            { 660, 4300}, -- Apple Au Lait
            { 250, 4423}, -- Apple Juice
        },
        items =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {1700,   505}, -- Sheepskin
            {4500,   640}, -- Copper Ore
            {2500,   641}, -- Tin Ore
            {3450,   642}, -- Zinc Ore
            {2000,   688}, -- Arrowwood Log
            {1020,   698}, -- Ash Log
            {4200,   656}, -- Beastcoin
            {5000,   768}, -- Flint Stone
            {1250,   818}, -- Cotton Thread
            {1300,   833}, -- Moko Grass
            { 800,   840}, -- Chocobo Feather
            {3600,   846}, -- Insect Wing
            {3000,   912}, -- Beehive Chip
            { 700,   943}, -- Poison Dust
            {2400,  1214}, -- Handful of Stone Arrowheads x33
            {4900,  4112}, -- Potion
            {3590,  4148}, -- Antidote
            {1150,  4150}, -- Eye Drops
            {1360,  4151}, -- Echo Drops
            {2900,  4370}, -- Honey
            { 600, 12290}, -- Maple Shield
            { 495, 12440}, -- Leather Bandana
            { 450, 12449}, -- Brass Cap
            { 190, 12456}, -- Hachimaki
            { 530, 12608}, -- Tunic
            { 460, 12696}, -- Leather Gloves
            { 340, 12705}, -- Brass Mittens
            { 168, 12712}, -- Tekko
            { 310, 12736}, -- Mitts
            { 475, 12824}, -- Leather Trousers
            { 280, 12833}, -- Brass Subligar
            { 235, 12840}, -- Sitabaki
            { 422, 12864}, -- Slacks
            { 250, 12961}, -- Brass Leggings
            { 287, 12992}, -- Solea
            { 500, 13081}, -- Leather Gorget
            { 300, 16407}, -- Brass Baghnakhs
            { 120, 16530}, -- Xiphos
            { 320, 17050}, -- Willow Wand
        }
    },
    [tpz.zone.EAST_RONFAURE] =
    {
        regionalItems = {19157}, -- Surviver
        temps =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
         ----------------------------------
            {1060, 4112}, -- Potion
            { 790, 4113}, -- Potion +1
            { 425, 4114}, -- Potion +2
            {1040, 4128}, -- Ether
            { 760, 4129}, -- Ether +1
            { 420, 4130}, -- Ether +2
            { 600, 4145}, -- Elixer
            { 820, 4148}, -- Antidote
            { 730, 4150}, -- Eye Drops
            { 750, 4151}, -- Echo Drops
            { 350, 4155}, -- Remedy
            {1020, 4164}, -- Prism Powder
            { 940, 4165}, -- Silent Oil
            { 420, 4202}, -- Daedalus Wing
            { 660, 4300}, -- Apple Au Lait
            { 250, 4423}, -- Apple Juice
        },
        items =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
         ----------------------------------
            {1700,   505}, -- Sheepskin
            {4500,   640}, -- Copper Ore
            {2500,   641}, -- Tin Ore
            {3450,   642}, -- Zinc Ore
            {2000,   688}, -- Arrowwood Log
            {1020,   698}, -- Ash Log
            {4200,   656}, -- Beastcoin
            {5000,   768}, -- Flint Stone
            {1250,   818}, -- Cotton Thread
            {1300,   833}, -- Moko Grass
            { 800,   840}, -- Chocobo Feather
            {3600,   846}, -- Insect Wing
            {3000,   912}, -- Beehive Chip
            { 700,   943}, -- Poison Dust
            {2400,  1214}, -- Handful of Stone Arrowheads x33
            {4900,  4112}, -- Potion
            {3590,  4148}, -- Antidote
            {1150,  4150}, -- Eye Drops
            {1360,  4151}, -- Echo Drops
            {2900,  4370}, -- Honey
            { 600, 12290}, -- Maple Shield
            { 495, 12440}, -- Leather Bandana
            { 450, 12449}, -- Brass Cap
            { 190, 12456}, -- Hachimaki
            { 530, 12608}, -- Tunic
            { 460, 12696}, -- Leather Gloves
            { 340, 12705}, -- Brass Mittens
            { 168, 12712}, -- Tekko
            { 310, 12736}, -- Mitts
            { 475, 12824}, -- Leather Trousers
            { 280, 12833}, -- Brass Subligar
            { 235, 12840}, -- Sitabaki
            { 422, 12864}, -- Slacks
            { 250, 12961}, -- Brass Leggings
            { 287, 12992}, -- Solea
            { 500, 13081}, -- Leather Gorget
            { 300, 16407}, -- Brass Baghnakhs
            { 120, 16530}, -- Xiphos
            { 320, 17050}, -- Willow Wand
        }
    },
    [tpz.zone.LA_THEINE_PLATEAU] =
    {
        regionalItems = {15835}, -- Desperado Ring
        temps =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {1060, 4112}, -- Potion
            { 790, 4113}, -- Potion +1
            { 425, 4114}, -- Potion +2
            {1040, 4128}, -- Ether
            { 760, 4129}, -- Ether +1
            { 420, 4130}, -- Ether +2
            { 600, 4145}, -- Elixer
            { 820, 4148}, -- Antidote
            { 730, 4150}, -- Eye Drops
            { 750, 4151}, -- Echo Drops
            { 350, 4155}, -- Remedy
            {1020, 4164}, -- Prism Powder
            { 940, 4165}, -- Silent Oil
            { 420, 4202}, -- Daedalus Wing
            { 240, 4300}, -- Apple Au Lait
            { 660, 4423}, -- Apple Juice
        },
        items =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {1700,   626}, -- Black Pepper
            {2500,   641}, -- Tin Ore
            {2000,   688}, -- Arrowwood Log
            {1020,   727}, -- Dogwood Log
            {4200,   750}, -- Silver Beastcoin
            {5000,   768}, -- Flint Stone
            {3600,   846}, -- Insect Wing
            {1300,   893}, -- Giant Femur
            {3000,   912}, -- Beehive Chip
            {1400,   925}, -- Giant Stinger
            {4300,   953}, -- Treant Bulb
            {2200,  1215}, -- Handful of Bone Arrowheads x33
            {4000,  1845}, -- Red Moko Grass
            {4900,  4112}, -- Potion
            {3750,  4128}, -- Ether
            { 595,  4148}, -- Antidote
            {1150,  4151}, -- Echo Drops
            {2100,  4227}, -- Bronze Bolt Quiver
            {2060,  4509}, -- Distilled Water
            { 425, 12432}, -- Faceguard
            { 760, 12449}, -- Brass Cap
            { 590, 12473}, -- Poet's Circlet
            { 630, 12601}, -- Linen Robe
            { 765, 12705}, -- Brass Mittens
            { 465, 12710}, -- Bone Mittens
            { 460, 12720}, -- Gloves
            { 430, 12729}, -- Linen Cuffs
            { 275, 12816}, -- Scale Cuisses
            { 730, 12834}, -- Bone Subligar
            { 600, 12848}, -- Brais
            { 535, 12688}, -- Scale Finger Gauntlets
            { 375, 12857}, -- Linen Slops
            { 410, 12966}, -- Bone Leggings
            { 655, 12976}, -- Gaiters
            { 425, 12985}, -- Holly Clogs
            { 390, 16466}, -- Knife
            { 370, 16531}, -- Brass Xiphos
            { 380, 17096}, -- Holly Pole
            {2320, 17316}, -- Bomb Arm
        }
    },
    [tpz.zone.VALKURM_DUNES] =
    {
        regionalItems = {16367}, -- Phlegethon's Trousers
        temps =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {1060, 4112}, -- Potion
            { 740, 4113}, -- Potion +1
            { 700, 4114}, -- Potion +2
            { 800, 4128}, -- Ether
            { 430, 4129}, -- Ether +1
            {  50, 4130}, -- Ether +2
            { 900, 4145}, -- Elixer
            { 820, 4148}, -- Antidote
            { 730, 4150}, -- Eye Drops
            { 850, 4151}, -- Echo Drops
            { 650, 4155}, -- Remedy
            {1020, 4164}, -- Prism Powder
            { 940, 4165}, -- Silent Oil
            { 450, 4202}, -- Daedalus Wing
            { 310, 4206}, -- Catholicon
            { 240, 4301}, -- Pear Au Lait
            { 660, 4425}, -- Tomato Juice
        },
        items =
        {
            ----------------------------------
            --| Weight | Item ID |   Name  |--
            ----------------------------------
            {4600,   642}, -- Zinc Ore
            {1250,   689}, -- Lauan Log
            { 600,   693}, -- Walnut Log
            {3250,   736}, -- Silver Ore
            {2900,   835}, -- Flax Flower
            {4800,   847}, -- Bird Feather
            {1600,   898}, -- Chicken Bone
            {2020,   914}, -- Mercury
            {5000,   936}, -- Rock Salt
            { 540,   947}, -- Firesand
            {3540,  1108}, -- Sulfur
            {4750,  1211}, -- Handful of Bronze Bolt Heads x33
            {2900,  4113}, -- Potion +1
            {2600,  4128}, -- Ether
            { 575,  4148}, -- Antidote
            {3150,  4151}, -- Echo Drops
            {1010,  4373}, -- Woozyshroom
            { 200, 16643}, -- Battleaxe
            { 520, 12455}, -- Beetle Mask
            { 240, 12583}, -- Beetle Harness
            { 680, 12711}, -- Beetle Mittens
            {1200, 12835}, -- Beetle Subligar
            { 990, 12967}, -- Beetle Leggings
            { 880, 12865}, -- Black Slacks
            {1530, 12966}, -- Bone Leggings
            {1760, 12454}, -- Bone Mask
            {1900, 12710}, -- Bone Mittens
            {1870, 12834}, -- Bone Subligar
            { 310, 13584}, -- Cotton Cape
            { 595, 13588}, -- Dhalmel Mantle
            {1580, 12985}, -- Holly Clogs
            { 275, 16473}, -- Kukri
            {1680, 12729}, -- Linen Cuffs
            {1460, 12857}, -- Linen Slops
            {2620, 12697}, -- Lizard Gloves
            { 645, 12441}, -- Lizard Helm
            { 835, 12953}, -- Lizard Ledelsens
            { 610, 12825}, -- Lizard Trousers
            { 455, 12473}, -- Poet's Circlet
            { 745, 12993}, -- Sandals
            {2165, 12737}, -- White Mitts
        }
    },
    [tpz.zone.JUGNER_FOREST] =
    {
        regionalItems = {15927}, -- Pinwheel Belt
        temps =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {1200, 4114}, -- Potion +2
            { 950, 4115}, -- Potion +3
            {1000, 4116}, -- Hi-Potion
            {1100, 4129}, -- Ether +1
            { 960, 4130}, -- Ether +2
            { 450, 4131}, -- Ether +3
            { 250, 4136}, -- Super Ether
            { 750, 4145}, -- Elixer
            { 820, 4148}, -- Antidote
            { 730, 4150}, -- Eye Drops
            { 850, 4151}, -- Echo Drops
            { 650, 4155}, -- Remedy
            {1020, 4164}, -- Prism Powder
            { 940, 4165}, -- Silent Oil
            { 450, 4202}, -- Daedalus Wing
            { 310, 4206}, -- Catholicon
            { 240, 4302}, -- Pamama Au Lait
            { 660, 4424}, -- Melon Juice
        },
        items =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {4600,   642}, -- Zinc Ore
            {1250,   689}, -- Lauan Log
            { 600,   693}, -- Walnut Log
            {3250,   736}, -- Silver Ore
            {2900,   835}, -- Flax Flower
            {4800,   847}, -- Bird Feather
            {1600,   898}, -- Chicken Bone
            {2020,   914}, -- Mercury
            {5000,   936}, -- Rock Salt
            { 540,   947}, -- Firesand
            {3540,  1108}, -- Sulfur
            {4750,  1211}, -- Handful of Bronze Bolt Heads x33
            {2900,  4113}, -- Potion +1
            {2600,  4128}, -- Ether
            { 575,  4148}, -- Antidote
            {3150,  4151}, -- Echo Drops
            {1010,  4373}, -- Woozyshroom
            { 200, 16643}, -- Battleaxe
            { 520, 12455}, -- Beetle Mask
            { 240, 12583}, -- Beetle Harness
            { 680, 12711}, -- Beetle Mittens
            {1200, 12835}, -- Beetle Subligar
            { 990, 12967}, -- Beetle Leggings
            { 880, 12865}, -- Black Slacks
            {1530, 12966}, -- Bone Leggings
            {1760, 12454}, -- Bone Mask
            {1900, 12710}, -- Bone Mittens
            {1870, 12834}, -- Bone Subligar
            { 310, 13584}, -- Cotton Cape
            { 595, 13588}, -- Dhalmel Mantle
            {1580, 12985}, -- Holly Clogs
            { 275, 16473}, -- Kukri
            {1680, 12729}, -- Linen Cuffs
            {1460, 12857}, -- Linen Slops
            {2620, 12697}, -- Lizard Gloves
            { 645, 12441}, -- Lizard Helm
            { 835, 12953}, -- Lizard Ledelsens
            { 610, 12825}, -- Lizard Trousers
            { 455, 12473}, -- Poet's Circlet
            { 745, 12993}, -- Sandals
            {2165, 12737}, -- White Mitts
        }
    },
    [tpz.zone.BATALLIA_DOWNS] =
    {
        regionalItems = {18451}, -- Mokusa
        temps =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {1200, 4114}, -- Potion +2
            { 950, 4115}, -- Potion +3
            {1000, 4116}, -- Hi-Potion
            {1100, 4129}, -- Ether +1
            { 960, 4130}, -- Ether +2
            { 450, 4131}, -- Ether +3
            { 250, 4136}, -- Super Ether
            { 750, 4145}, -- Elixer
            { 820, 4148}, -- Antidote
            { 730, 4150}, -- Eye Drops
            { 850, 4151}, -- Echo Drops
            { 650, 4155}, -- Remedy
            {1020, 4164}, -- Prism Powder
            { 940, 4165}, -- Silent Oil
            { 450, 4202}, -- Daedalus Wing
            { 310, 4206}, -- Catholicon
            { 240, 4302}, -- Pamama Au Lait
            { 660, 4424}, -- Melon Juice
        },
        items =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {5000,   573}, -- Vegetable Seeds
            { 475,   636}, -- Chamomile
            {2780,   643}, -- Iron Ore
            {1940,   644}, -- Mythril Ore
            {2700,   691}, -- Maple Log
            {1060,   694}, -- Chestnut Log
            {3500,   749}, -- Mythril Beastcoin
            {1900,   820}, -- Wool Thread
            {1150,   859}, -- Ram Skin
            {1090,   895}, -- Ram Horn
            {4600,   928}, -- Bomb Ash
            {2650,   943}, -- Poison Dust
            {3300,  1212}, -- Handful of Mythril Bolt Heads x33
            {4900,  4113}, -- Potion +1
            {3100,  4114}, -- Potion +2
            { 670,  4115}, -- Potion +3
            {4800,  4129}, -- Ether +1
            {3000,  4130}, -- Ether +2
            { 900,  4145}, -- Elixer
            { 120, 12300}, -- Targe
            { 320, 12433}, -- Brass Mask
            { 660, 12442}, -- Studded Bandana
            { 680, 12465}, -- Cotton Headgear
            { 520, 12474}, -- Wool Hat
            { 200, 12570}, -- Studded Vest
            { 450, 12689}, -- Brass Finger Gauntlets
            { 460, 12721}, -- Cotton Gloves
            { 390, 12817}, -- Brass Cuisses
            { 550, 12826}, -- Studded Trousers
            { 420, 12849}, -- Cotton Brais
            { 690, 12945}, -- Brass Greaves
            { 770, 12954}, -- Studded Boots
            { 510, 12977}, -- Cotton Gaiters
            { 625, 12986}, -- Chestnut Sabots
            { 310, 13085}, -- Hemp Gorget
            { 305, 13205}, -- Silver Obi
            { 430, 13328}, -- Mythril Earring
            { 235, 13446}, -- Mythril Ring
            { 525, 16467}, -- Mythril Knife
            { 505, 17097}, -- Elm Pole
            { 350, 17284}, -- Chakram
        }
    },
    [tpz.zone.NORTH_GUSTABERG] =
    {
        regionalItems = {11312}, -- Rambler's Cloak
        temps =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {1060, 4112}, -- Potion
            { 740, 4113}, -- Potion +1
            { 700, 4114}, -- Potion +2
            { 800, 4128}, -- Ether
            { 430, 4129}, -- Ether +1
            {  50, 4130}, -- Ether +2
            { 900, 4145}, -- Elixer
            { 820, 4148}, -- Antidote
            { 730, 4150}, -- Eye Drops
            { 850, 4151}, -- Echo Drops
            { 650, 4155}, -- Remedy
            {1020, 4164}, -- Prism Powder
            { 940, 4165}, -- Silent Oil
            { 420, 4202}, -- Daedalus Wing
            { 250, 4300}, -- Apple Au Lait
            { 660, 4423}, -- Apple Juice
        },
        items =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {1700,   505}, -- Sheepskin
            {4500,   640}, -- Copper Ore
            {2500,   641}, -- Tin Ore
            {3450,   642}, -- Zinc Ore
            {2000,   688}, -- Arrowwood Log
            {1020,   698}, -- Ash Log
            {4200,   656}, -- Beastcoin
            {5000,   768}, -- Flint Stone
            {1250,   818}, -- Cotton Thread
            {1300,   833}, -- Moko Grass
            { 800,   840}, -- Chocobo Feather
            {3600,   846}, -- Insect Wing
            {3000,   912}, -- Beehive Chip
            { 700,   943}, -- Poison Dust
            {2400,  1214}, -- Handful of Stone Arrowheads x33
            {4900,  4112}, -- Potion
            {3590,  4148}, -- Antidote
            {1150,  4150}, -- Eye Drops
            {1360,  4151}, -- Echo Drops
            {2900,  4370}, -- Honey
            { 600, 12290}, -- Maple Shield
            { 295, 12440}, -- Leather Bandana
            { 450, 12449}, -- Brass Cap
            { 290, 12456}, -- Hachimaki
            { 530, 12608}, -- Tunic
            { 460, 12696}, -- Leather Gloves
            { 340, 12705}, -- Brass Mittens
            { 168, 12712}, -- Tekko
            { 310, 12736}, -- Mitts
            { 475, 12824}, -- Leather Trousers
            {  80, 12833}, -- Brass Subligar
            { 235, 12840}, -- Sitabaki
            { 422, 12864}, -- Slacks
            { 135, 12952}, -- Leather Highboots
            { 250, 12961}, -- Brass Leggings
            { 255, 12968}, -- Kyahan
            { 287, 12992}, -- Solea
            { 500, 13081}, -- Leather Gorget
            { 300, 16407}, -- Brass Baghnakhs
            { 120, 16530}, -- Xiphos
            { 320, 17050}, -- Willow Wand
        }
    },
    [tpz.zone.SOUTH_GUSTABERG] =
    {
        regionalItems = {15926}, -- Bronze Bandolier
        temps =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {1060, 4112}, -- Potion
            { 740, 4113}, -- Potion +1
            { 700, 4114}, -- Potion +2
            { 800, 4128}, -- Ether
            { 430, 4129}, -- Ether +1
            {  50, 4130}, -- Ether +2
            { 900, 4145}, -- Elixer
            { 820, 4148}, -- Antidote
            { 730, 4150}, -- Eye Drops
            { 850, 4151}, -- Echo Drops
            { 650, 4155}, -- Remedy
            {1020, 4164}, -- Prism Powder
            { 940, 4165}, -- Silent Oil
            { 420, 4202}, -- Daedalus Wing
            { 250, 4300}, -- Apple Au Lait
            { 660, 4423}, -- Apple Juice
        },
        items =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {1700,   505}, -- Sheepskin
            {4500,   640}, -- Copper Ore
            {2500,   641}, -- Tin Ore
            {3450,   642}, -- Zinc Ore
            {2000,   688}, -- Arrowwood Log
            {1020,   698}, -- Ash Log
            {4200,   656}, -- Beastcoin
            {5000,   768}, -- Flint Stone
            {1250,   818}, -- Cotton Thread
            {1300,   833}, -- Moko Grass
            { 800,   840}, -- Chocobo Feather
            {3600,   846}, -- Insect Wing
            {3000,   912}, -- Beehive Chip
            { 700,   943}, -- Poison Dust
            {2400,  1214}, -- Handful of Stone Arrowheads x33
            {4900,  4112}, -- Potion
            {3590,  4148}, -- Antidote
            {1150,  4150}, -- Eye Drops
            {1360,  4151}, -- Echo Drops
            {2900,  4370}, -- Honey
            { 600, 12290}, -- Maple Shield
            { 295, 12440}, -- Leather Bandana
            { 450, 12449}, -- Brass Cap
            { 290, 12456}, -- Hachimaki
            { 530, 12608}, -- Tunic
            { 460, 12696}, -- Leather Gloves
            { 340, 12705}, -- Brass Mittens
            { 168, 12712}, -- Tekko
            { 310, 12736}, -- Mitts
            { 475, 12824}, -- Leather Trousers
            {  80, 12833}, -- Brass Subligar
            { 235, 12840}, -- Sitabaki
            { 422, 12864}, -- Slacks
            { 135, 12952}, -- Leather Highboots
            { 250, 12961}, -- Brass Leggings
            { 255, 12968}, -- Kyahan
            { 287, 12992}, -- Solea
            { 500, 13081}, -- Leather Gorget
            { 300, 16407}, -- Brass Baghnakhs
            { 120, 16530}, -- Xiphos
            { 320, 17050}, -- Willow Wand
        }
    },
    [tpz.zone.KONSCHTAT_HIGHLANDS] =
    {
        regionalItems = {19223}, -- Attar Of Roses
        temps =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {1060, 4112}, -- Potion
            { 740, 4113}, -- Potion +1
            { 700, 4114}, -- Potion +2
            { 800, 4128}, -- Ether
            { 430, 4129}, -- Ether +1
            {  50, 4130}, -- Ether +2
            { 900, 4145}, -- Elixer
            { 820, 4148}, -- Antidote
            { 730, 4150}, -- Eye Drops
            { 850, 4151}, -- Echo Drops
            { 650, 4155}, -- Remedy
            {1020, 4164}, -- Prism Powder
            { 940, 4165}, -- Silent Oil
            { 420, 4202}, -- Daedalus Wing
            { 240, 4301}, -- Pear Au Lait
            { 660, 4425}, -- Tomato Juice
        },
        items =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {2400,   626}, -- Black Pepper
            {3100,   641}, -- Tin Ore
            {3900,   688}, -- Arrowwood Log
            {1200,   727}, -- Dogwood Log
            {4200,   750}, -- Silver Beastcoin
            {4900,   768}, -- Flint Stone
            {4500,   846}, -- Insect Wing
            {2200,   893}, -- Giant Femur
            {2600,   912}, -- Beehive Chip
            {3250,   925}, -- Giant Stinger
            {5000,   953}, -- Treant Bulb
            {4450,  1215}, -- Handful of Bone Arrowheads x33
            {4650,  1845}, -- Red Moko Grass
            {4750,  4112}, -- Potion
            {4760,  4128}, -- Ether
            {1260,  4145}, -- Elixer
            { 460,  4148}, -- Antidote
            {1360,  4151}, -- Echo Drops
            {2120,  4227}, -- Bronze Bolt Quiver
            {1600,  4509}, -- Distilled Water
            { 650, 12432}, -- Faceguard
            { 620, 12449}, -- Brass Cap
            { 550, 12473}, -- Poet's Circlet
            { 630, 12601}, -- Linen Robe
            { 660, 12688}, -- Scale Finger Gauntlets
            { 540, 12705}, -- Brass Mittens
            { 340, 12710}, -- Bone Mittens
            { 730, 12720}, -- Gloves
            { 830, 12729}, -- Linen Cuffs
            { 715, 12816}, -- Scale Cuisses
            { 830, 12834}, -- Bone Subligar
            { 910, 12848}, -- Brais
            {1100, 12857}, -- Linen Slops
            {1250, 12966}, -- Bone Leggings
            { 530, 12976}, -- Gaiters
            { 345, 12985}, -- Holly Clogs
            { 210, 16466}, -- Knife
            { 455, 16531}, -- Brass Xiphos
            { 610, 17096}, -- Holly Pole
            {1465, 17316}, -- Bomb Arm
        }
    },
    [tpz.zone.PASHHOW_MARSHLANDS] =
    {
        regionalItems = {19222}, -- Wurger
        temps =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {1060, 4114}, -- Potion +2
            { 740, 4115}, -- Potion +3
            { 700, 4116}, -- Hi-Potion
            { 800, 4129}, -- Ether +1
            { 430, 4130}, -- Ether +2
            { 200, 4131}, -- Ether +3
            {  50, 4136}, -- Super Ether
            { 900, 4145}, -- Elixir
            { 820, 4148}, -- Antidote
            { 730, 4150}, -- Eye Drops
            { 850, 4151}, -- Echo Drops
            { 650, 4155}, -- Remedy
            {1020, 4164}, -- Prism Powder
            { 940, 4165}, -- Silent Oil
            { 420, 4202}, -- Daedalus Wing
            { 220, 4206}, -- Catholicon
            { 250, 4302}, -- Pamama Au Lait
            { 660, 4424}, -- Melon Juice
        },
        items =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {2400,   627}, -- Maple Sugar
            {1700,   637}, -- Slime Oil
            {3200,   643}, -- Iron Ore
            {4320,   690}, -- Elm Log
            {2050,   816}, -- Silk Thread
            {2450,   835}, -- Flax Flower
            {4050,   857}, -- Dhalmel Hide
            {5000,   880}, -- Bone Chip
            {3250,   897}, -- Scorpion Claw
            {1670,   900}, -- Fish Bones
            {3520,   913}, -- Beeswax
            {4300,   943}, -- Poison Dust
            {4690,  1211}, -- Brz. Bolt Heads x33
            {4900,  4112}, -- Potion
            {2400,  4114}, -- Potion +2
            {4890,  4128}, -- Ether
            {2350,  4129}, -- Ether +1
            {1700,  4145}, -- Elixir
            {2600,  4151}, -- Echo Drops
            {3170,  4225}, -- Iron Quiver
            {1540,  4447}, -- Scream Fungus
            { 670, 12424}, -- Iron Mask
            { 630, 12441}, -- Lizard Helm
            { 710, 12455}, -- Beetle Mask
            { 420, 12552}, -- Chainmail
            { 820, 12593}, -- Cotton Doublet
            { 310, 12680}, -- Chain Mittens
            { 520, 12697}, -- Lizard Gloves
            { 790, 12711}, -- Beetle Mittens
            { 900, 12721}, -- Cotton Gloves
            { 890, 12737}, -- White Mitts
            { 740, 12825}, -- Lizard Trousers
            { 650, 12849}, -- Cotton Brais
            { 760, 12865}, -- Black Slacks
            { 895, 12953}, -- Lizard Ledelsens
            {1020, 12967}, -- Beetle Leggings
            {1100, 12977}, -- Cotton Gaiters
            {1200, 12993}, -- Sandals
            { 330, 16406}, -- Baghnakhs
            { 320, 16835}, -- Spear
            { 350, 17090}, -- Elm Staff
        }
    },
    [tpz.zone.ROLANBERRY_FIELDS] =
    {
        regionalItems = {11401}, -- Rambler's Gaiters
        temps =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {1060, 4114}, -- Potion +2
            { 740, 4115}, -- Potion +3
            { 700, 4116}, -- Hi-Potion
            { 800, 4129}, -- Ether +1
            { 430, 4130}, -- Ether +2
            { 200, 4131}, -- Ether +3
            {  50, 4136}, -- Super Ether
            { 900, 4145}, -- Elixir
            { 820, 4148}, -- Antidote
            { 730, 4150}, -- Eye Drops
            { 850, 4151}, -- Echo Drops
            { 650, 4155}, -- Remedy
            {1020, 4164}, -- Prism Powder
            { 940, 4165}, -- Silent Oil
            { 420, 4202}, -- Daedalus Wing
            { 220, 4206}, -- Catholicon
            { 240, 4302}, -- Pamama Au Lait
            { 660, 4424}, -- Melon Juice

        },
        items =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {2400,   627}, -- Maple Sugar
            {1700,   637}, -- Slime Oil
            {3200,   643}, -- Iron Ore
            {4320,   690}, -- Elm Log
            {2050,   816}, -- Silk Thread
            {2450,   835}, -- Flax Flower
            {4050,   857}, -- Dhalmel Hide
            {5000,   880}, -- Bone Chip
            {3250,   897}, -- Scorpion Claw
            {1670,   900}, -- Fish Bones
            {3520,   913}, -- Beeswax
            {4300,   943}, -- Poison Dust
            {4690,  1211}, -- Brz. Bolt Heads x33
            {4900,  4112}, -- Potion
            {2400,  4114}, -- Potion +2
            {4890,  4128}, -- Ether
            {2350,  4129}, -- Ether +1
            {1700,  4145}, -- Elixir
            {2600,  4151}, -- Echo Drops
            {3170,  4225}, -- Iron Quiver
            {1540,  4447}, -- Scream Fungus
            { 670, 12424}, -- Iron Mask
            { 630, 12441}, -- Lizard Helm
            { 710, 12455}, -- Beetle Mask
            { 420, 12552}, -- Chainmail
            { 820, 12593}, -- Cotton Doublet
            { 310, 12680}, -- Chain Mittens
            { 520, 12697}, -- Lizard Gloves
            { 790, 12711}, -- Beetle Mittens
            { 900, 12721}, -- Cotton Gloves
            { 890, 12737}, -- White Mitts
            { 740, 12825}, -- Lizard Trousers
            { 650, 12849}, -- Cotton Brais
            { 760, 12865}, -- Black Slacks
            { 895, 12953}, -- Lizard Ledelsens
            {1020, 12967}, -- Beetle Leggings
            {1100, 12977}, -- Cotton Gaiters
            {1200, 12993}, -- Sandals
            { 330, 16406}, -- Baghnakhs
            { 320, 16835}, -- Spear
            { 350, 17090}, -- Elm Staff
        }
    },
    [tpz.zone.BEAUCEDINE_GLACIER] =
    {
        regionalItems = {16280}, -- Haraldr's Muffler
        temps =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {1060, 4118}, -- Hi-Potion +2
            { 740, 4119}, -- Hi-Potion +3
            { 600, 4120}, -- X-Potion
            {1020, 4134}, -- Hi-Ether +2
            { 730, 4135}, -- Hi-Ether +3
            { 500, 4136}, -- Super Ether
            { 900, 4145}, -- Elixir
            { 820, 4148}, -- Antidote
            { 730, 4150}, -- Eye Drops
            { 850, 4151}, -- Echo Drops
            { 650, 4155}, -- Remedy
            {1020, 4164}, -- Prism Powder
            { 940, 4165}, -- Silent Oil
            { 420, 4202}, -- Daedalus Wing
            { 220, 4206}, -- Catholicon
            { 240, 4302}, -- Pamama au Lait
            { 640, 4424}, -- Melon Juice
        },
        items =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {5000,   575}, -- Grain Seeds
            {1690,   612}, -- Kazham Peppers
            {2480,   644}, -- Mythril Ore
            {4150,   699}, -- Oak Log
            {3600,   819}, -- Linen Thread
            {1740,   845}, -- Black C. Feather
            {2350,   914}, -- Mercury
            {2600,  1217}, -- Slv. Arrowheads
            {4950,  4113}, -- Potion +1
            {1720,  4114}, -- Potion +2
            { 640,  4115}, -- Potion +3
            {4750,  4128}, -- Ether
            {1850,  4129}, -- Ether +1
            { 650,  4130}, -- Ether +2
            { 420,  4145}, -- Elixir
            { 660, 12450}, -- Padded Cap
            { 540, 12475}, -- Velvet Hat
            { 475, 12571}, -- Cuir Bouilli
            { 570, 12699}, -- Cuir Gloves
            { 690, 12706}, -- Iron Mittens
            {1100, 12731}, -- Velvet Cuffs
            { 860, 12827}, -- Cuir Trousers
            { 720, 12836}, -- Iron Subligar
            { 490, 12859}, -- Velvet Slops
            {1120, 12955}, -- Cuir Highboots
            { 390, 12987}, -- Ebony Sabots
        }
    },
    [tpz.zone.XARCABARD] =
    {
        regionalItems = {15042, 17267}, -- Gothic Gauntlets / Negoroshiki
        temps =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {1060, 4118}, -- Hi-Potion +2
            { 740, 4119}, -- Hi-Potion +3
            { 600, 4120}, -- X-Potion
            {1020, 4134}, -- Hi-Ether +2
            { 730, 4135}, -- Hi-Ether +3
            { 500, 4136}, -- Super Ether
            { 900, 4145}, -- Elixir
            { 820, 4148}, -- Antidote
            { 730, 4150}, -- Eye Drops
            { 850, 4151}, -- Echo Drops
            { 650, 4155}, -- Remedy
            {1020, 4164}, -- Prism Powder
            { 940, 4165}, -- Silent Oil
            { 420, 4202}, -- Daedalus Wing
            { 220, 4206}, -- Catholicon
            { 240, 4302}, -- Pamama au Lait
            { 660, 4424}, -- Melon Juice
        },
        items =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {5000,   575}, -- Grain Seeds
            {2600,   612}, -- Kazham Peppers
            {4200,   698}, -- Ash Log
            {3100,   816}, -- Silk Thread
            {2750,   923}, -- Dryad Root
            { 320,   932}, -- Carbon Fiber
            { 510,  1225}, -- Gold Nugget
            { 120,  1228}, -- Dst. Nugget
            {4500,  4113}, -- Potion +1
            {2300,  4114}, -- Potion +2
            {1450,  4115}, -- Potion +3
            {4100,  4128}, -- Ether
            {2100,  4129}, -- Ether +1
            {1420,  4130}, -- Ether +2
            { 640,  4145}, -- Elixir
            { 560, 12450}, -- Padded Cap
            { 790, 12837}, -- Carapace Subligar
            { 810, 13711}, -- Carapace Mask
            { 680, 13713}, -- Carapace Mittens
            { 725, 13715}, -- Cpc. Leggings
            { 120, 16412}, -- Mythril Claws
            {  95, 16558}, -- Falchion
            { 100, 16590}, -- Greatsword
            { 675, 16796}, -- Mythril Zaghnal
            { 450, 17062}, -- Bone Rod
            { 840, 17610}, -- Bone Knife
            {  80, 18207}, -- Kheten
        }
    },
    [tpz.zone.CAPE_TERIGGAN] =
    {
        regionalItems = {17965}, -- Sirocco Axe
        temps =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {1060, 4119}, -- Hi-Potion +3
            { 800, 4120}, -- X-Potion
            { 600, 4121}, -- X-Potion +1
            {1040, 4135}, -- Hi-Ether +3
            { 790, 4136}, -- Super Ether
            { 590, 4137}, -- Super Ether +1
            { 420, 4144}, -- Hi-Elixir
            { 655, 4145}, -- Elixir
            {  60, 4149}, -- Panacea
            { 460, 4155}, -- Remedy
            { 790, 4202}, -- Daedalus Wing
            { 490, 4206}, -- Catholicon
            { 320, 4210}, -- Lethe Water
            { 225, 4255}, -- Mana Powder
            { 360, 4302}, -- Pamama au Lait
            { 540, 4424}, -- Melon Juice
            { 210, 5322}, -- Healing Powder
        },
        items =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {2320,   645}, -- Darksteel Ore
            {1350,   702}, -- Ebony Log
            {1290,   737}, -- Gold Ore
            { 525,   823}, -- Gold Thread
            { 190,   844}, -- Phoenix Feather
            { 780,  1443}, -- Dried Mugwort
            {5000,  4116}, -- Hi-Potion
            {4500,  4117}, -- Hi-Potion +1
            {2500,  4120}, -- X-Potion
            { 500,  4121}, -- X-Potion +1
            {4200,  4133}, -- Hi-Ether +1
            {2100,  4141}, -- Pro-Ether +1
            {1230,  5164}, -- Ground Wasabi
            {1150, 12427}, -- Bascinet
            { 575, 12683}, -- Darksteel Mufflers
            { 680, 12740}, -- Silk Mitts
            { 740, 12811}, -- Dst. Breeches
            { 625, 12829}, -- Beak Trousers
            { 490, 12868}, -- Silk Slacks
            { 710, 12939}, -- Dst. Sollerets
            { 460, 12996}, -- Silk Pumps
            { 615, 13698}, -- Beak Helm
            { 540, 13700}, -- Beak Gloves
            { 470, 13702}, -- Beak Ledelsens
        }
    },
    [tpz.zone.EASTERN_ALTEPA_DESERT] =
    {
        regionalItems = {16251}, -- Casaba Melon Tank
        temps =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {1060, 4118}, -- Hi-Potion +2
            { 800, 4119}, -- Hi-Potion +3
            { 400, 4120}, -- X-Potion
            {1040, 4134}, -- Hi-Ether +2
            { 700, 4135}, -- Hi-Ether +3
            { 410, 4136}, -- Super Ether
            { 600, 4145}, -- Elixir
            {1450, 4148}, -- Antidote
            {1550, 4150}, -- Eye Drops
            {1650, 4151}, -- Echo Drops
            { 350, 4155}, -- Remedy
            { 820, 4164}, -- Prism Powder
            { 840, 4165}, -- Silent Oil
            { 600, 4202}, -- Daedalus Wing
            { 250, 4206}, -- Catholicon
            { 420, 4302}, -- Pamama au Lait
            { 720, 4424}, -- Melon Juice
        },
        items =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {5000,   575}, -- Grain Seeds
            {1690,   612}, -- Kazham Peppers
            {2480,   644}, -- Mythril Ore
            {4150,   699}, -- Oak Log
            {3600,   819}, -- Linen Thread
            {1740,   845}, -- Black C. Feather
            {2350,   914}, -- Mercury
            {2600,  1217}, -- Slv. Arrowheads
            {4950,  4113}, -- Potion +1
            {1720,  4114}, -- Potion +2
            { 640,  4115}, -- Potion +3
            {4750,  4128}, -- Ether
            {1850,  4129}, -- Ether +1
            { 650,  4130}, -- Ether +2
            { 420,  4145}, -- Elixir
            { 660, 12450}, -- Padded Cap
            { 540, 12475}, -- Velvet Hat
            { 475, 12571}, -- Cuir Bouilli
            { 570, 12699}, -- Cuir Gloves
            { 690, 12706}, -- Iron Mittens
            {1100, 12731}, -- Velvet Cuffs
            { 860, 12827}, -- Cuir Trousers
            { 720, 12836}, -- Iron Subligar
            { 490, 12859}, -- Velvet Slops
            {1120, 12955}, -- Cuir Highboots
            { 390, 12987}, -- Ebony Sabots
        }
    },
    [tpz.zone.QUICKSAND_CAVES] =
    {
        regionalItems = {10952}, -- Tanner's Torque
        temps =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {1100, 4118}, -- Hi-Potion +2
            {1000, 4119}, -- Hi-Potion +3
            { 800, 4120}, -- X-Potion
            { 600, 4121}, -- X-Potion +1
            {1040, 4135}, -- Hi-Ether +3
            { 790, 4136}, -- Super Ether
            { 590, 4137}, -- Super Ether +1
            { 420, 4144}, -- Hi-Elixir
            { 655, 4145}, -- Elixir
            {  60, 4149}, -- Panacea
            { 460, 4155}, -- Remedy
            { 790, 4202}, -- Daedalus Wing
            { 490, 4206}, -- Catholicon
            { 320, 4210}, -- Lethe Water
            { 225, 4255}, -- Mana Powder
            { 360, 4302}, -- Pamama au Lait
            { 540, 4424}, -- Melon Juice
            { 210, 5322}, -- Healing Powder
        },
        items =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {2320,   645}, -- Darksteel Ore
            {1350,   702}, -- Ebony Log
            {1290,   737}, -- Gold Ore
            { 525,   823}, -- Gold Thread
            { 190,   844}, -- Phoenix Feather
            { 780,  1443}, -- Dried Mugwort
            { 240,  3309}, -- Barrage Turbine
            {1500,  3450}, -- Voiddust
            {5000,  4116}, -- Hi-Potion
            {4500,  4117}, -- Hi-Potion +1
            {2500,  4120}, -- X-Potion
            { 500,  4121}, -- X-Potion +1
            {4200,  4133}, -- Hi-Ether +1
            {2100,  4141}, -- Pro-Ether +1
            {1230,  5164}, -- Ground Wasabi
            {1150, 12427}, -- Bascinet
            { 575, 12683}, -- Darksteel Mufflers
            { 680, 12740}, -- Silk Mitts
            { 740, 12811}, -- Dst. Breeches
            { 625, 12829}, -- Beak Trousers
            { 490, 12868}, -- Silk Slacks
            { 710, 12939}, -- Dst. Sollerets
            { 460, 12996}, -- Silk Pumps
            { 615, 13698}, -- Beak Helm
            { 540, 13700}, -- Beak Gloves
            { 470, 13702}, -- Beak Ledelsens
        }
    },
    [tpz.zone.WEST_SARUTABARUTA] =
    {
        regionalItems = {19221}, -- Firefly
        temps =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {1060, 4112}, -- Potion
            { 790, 4113}, -- Potion +1
            { 425, 4114}, -- Potion +2
            {1040, 4128}, -- Ether
            { 760, 4129}, -- Ether +1
            { 420, 4130}, -- Ether +2
            { 600, 4145}, -- Elixer
            { 820, 4148}, -- Antidote
            { 730, 4150}, -- Eye Drops
            { 750, 4151}, -- Echo Drops
            { 350, 4155}, -- Remedy
            {1020, 4164}, -- Prism Powder
            { 940, 4165}, -- Silent Oil
            { 420, 4202}, -- Daedalus Wing
            { 240, 4300}, -- Apple Au Lait
            { 660, 4423}, -- Apple Juice
        },
        items =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {1700,   505}, -- Sheepskin
            {4500,   640}, -- Copper Ore
            {2500,   641}, -- Tin Ore
            {3450,   642}, -- Zinc Ore
            {2000,   688}, -- Arrowwood Log
            {1020,   698}, -- Ash Log
            {4200,   656}, -- Beastcoin
            {5000,   768}, -- Flint Stone
            {1250,   818}, -- Cotton Thread
            {1300,   833}, -- Moko Grass
            { 800,   840}, -- Chocobo Feather
            {3600,   846}, -- Insect Wing
            {3000,   912}, -- Beehive Chip
            { 700,   943}, -- Poison Dust
            {2400,  1214}, -- Handful of Stone Arrowheads x33
            {4900,  4112}, -- Potion
            {3590,  4148}, -- Antidote
            {1150,  4150}, -- Eye Drops
            {1360,  4151}, -- Echo Drops
            {2900,  4370}, -- Honey
            { 600, 12290}, -- Maple Shield
            { 295, 12440}, -- Leather Bandana
            { 450, 12449}, -- Brass Cap
            { 720, 12456}, -- Hachimaki
            { 530, 12608}, -- Tunic
            { 460, 12696}, -- Leather Gloves
            { 340, 12705}, -- Brass Mittens
            { 640, 12712}, -- Tekko
            { 310, 12736}, -- Mitts
            { 475, 12824}, -- Leather Trousers
            {  80, 12833}, -- Brass Subligar
            { 890, 12840}, -- Sitabaki
            { 422, 12864}, -- Slacks
            { 135, 12952}, -- Leather Highboots
            { 250, 12961}, -- Brass Leggings
            { 700, 12968}, -- Kyahan
            { 287, 12992}, -- Solea
            { 500, 13081}, -- Leather Gorget
            { 300, 16407}, -- Brass Baghnakhs
            { 120, 16530}, -- Xiphos
            { 320, 17050}, -- Willow Wand
        }
    },
    [tpz.zone.EAST_SARUTABARUTA] =
    {
        regionalItems = {16279}, -- Pile Chain
        temps =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {1060, 4112}, -- Potion
            { 790, 4113}, -- Potion +1
            { 425, 4114}, -- Potion +2
            {1040, 4128}, -- Ether
            { 760, 4129}, -- Ether +1
            { 420, 4130}, -- Ether +2
            { 600, 4145}, -- Elixer
            { 820, 4148}, -- Antidote
            { 730, 4150}, -- Eye Drops
            { 750, 4151}, -- Echo Drops
            { 350, 4155}, -- Remedy
            {1020, 4164}, -- Prism Powder
            { 940, 4165}, -- Silent Oil
            { 420, 4202}, -- Daedalus Wing
            { 240, 4300}, -- Apple Au Lait
            { 660, 4423}, -- Apple Juice
        },
        items =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {1700,   505}, -- Sheepskin
            {4500,   640}, -- Copper Ore
            {2500,   641}, -- Tin Ore
            {3450,   642}, -- Zinc Ore
            {2000,   688}, -- Arrowwood Log
            {1020,   698}, -- Ash Log
            {4200,   656}, -- Beastcoin
            {5000,   768}, -- Flint Stone
            {1250,   818}, -- Cotton Thread
            {1300,   833}, -- Moko Grass
            { 800,   840}, -- Chocobo Feather
            {3600,   846}, -- Insect Wing
            {3000,   912}, -- Beehive Chip
            { 700,   943}, -- Poison Dust
            {2400,  1214}, -- Handful of Stone Arrowheads x33
            {4900,  4112}, -- Potion
            {3590,  4148}, -- Antidote
            {1150,  4150}, -- Eye Drops
            {1360,  4151}, -- Echo Drops
            {2900,  4370}, -- Honey
            { 600, 12290}, -- Maple Shield
            { 295, 12440}, -- Leather Bandana
            { 450, 12449}, -- Brass Cap
            { 720, 12456}, -- Hachimaki
            { 530, 12608}, -- Tunic
            { 460, 12696}, -- Leather Gloves
            { 340, 12705}, -- Brass Mittens
            { 640, 12712}, -- Tekko
            { 310, 12736}, -- Mitts
            { 475, 12824}, -- Leather Trousers
            {  80, 12833}, -- Brass Subligar
            { 890, 12840}, -- Sitabaki
            { 422, 12864}, -- Slacks
            { 135, 12952}, -- Leather Highboots
            { 250, 12961}, -- Brass Leggings
            { 700, 12968}, -- Kyahan
            { 287, 12992}, -- Solea
            { 500, 13081}, -- Leather Gorget
            { 300, 16407}, -- Brass Baghnakhs
            { 120, 16530}, -- Xiphos
            { 320, 17050}, -- Willow Wand
        }
    },
    [tpz.zone.TAHRONGI_CANYON] =
    {
        regionalItems = {16007}, -- Protect Earring
        temps =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {1060, 4112}, -- Potion
            { 790, 4113}, -- Potion +1
            { 425, 4114}, -- Potion +2
            {1040, 4128}, -- Ether
            { 760, 4129}, -- Ether +1
            { 420, 4130}, -- Ether +2
            { 600, 4145}, -- Elixer
            { 820, 4148}, -- Antidote
            { 730, 4150}, -- Eye Drops
            { 750, 4151}, -- Echo Drops
            { 350, 4155}, -- Remedy
            {1020, 4164}, -- Prism Powder
            { 940, 4165}, -- Silent Oil
            { 420, 4202}, -- Daedalus Wing
            { 240, 4301}, -- Pear au Lait
            { 660, 4425}, -- Tomato Juice
        },
        items =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {1700,   626}, -- Black Pepper
            {2500,   641}, -- Tin Ore
            {2000,   688}, -- Arrowwood Log
            {1020,   727}, -- Dogwood Log
            {4200,   750}, -- Silver Beastcoin
            {5000,   768}, -- Flint Stone
            {3600,   846}, -- Insect Wing
            {1300,   893}, -- Giant Femur
            {3000,   912}, -- Beehive Chip
            {1400,   925}, -- Giant Stinger
            {4300,   953}, -- Treant Bulb
            {2200,  1215}, -- Handful of Bone Arrowheads x33
            {4000,  1845}, -- Red Moko Grass
            {4900,  4112}, -- Potion
            {3600,  4113}, -- Potion +1
            {3750,  4128}, -- Ether
            { 595,  4148}, -- Antidote
            {1150,  4151}, -- Echo Drops
            {2100,  4227}, -- Bronze Bolt Quiver
            {2060,  4509}, -- Distilled Water
            { 425, 12432}, -- Faceguard
            { 760, 12449}, -- Brass Cap
            { 590, 12473}, -- Poet's Circlet
            { 630, 12601}, -- Linen Robe
            { 765, 12705}, -- Brass Mittens
            { 465, 12710}, -- Bone Mittens
            { 460, 12720}, -- Gloves
            { 430, 12729}, -- Linen Cuffs
            { 275, 12816}, -- Scale Cuisses
            { 730, 12834}, -- Bone Subligar
            { 600, 12848}, -- Brais
            { 535, 12688}, -- Scale Finger Gauntlets
            { 375, 12857}, -- Linen Slops
            { 410, 12966}, -- Bone Leggings
            { 655, 12976}, -- Gaiters
            { 425, 12985}, -- Holly Clogs
            { 390, 16466}, -- Knife
            { 370, 16531}, -- Brass Xiphos
            { 380, 17096}, -- Holly Pole
            {2320, 17316}, -- Bomb Arm
        }
    },
    [tpz.zone.BUBURIMU_PENINSULA] =
    {
        regionalItems = {18599}, -- Pestle
        temps =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {1060, 4112}, -- Potion
            { 790, 4113}, -- Potion +1
            { 425, 4114}, -- Potion +2
            {1040, 4128}, -- Ether
            { 760, 4129}, -- Ether +1
            { 420, 4130}, -- Ether +2
            { 600, 4145}, -- Elixer
            { 820, 4148}, -- Antidote
            { 730, 4150}, -- Eye Drops
            { 750, 4151}, -- Echo Drops
            { 350, 4155}, -- Remedy
            {1020, 4164}, -- Prism Powder
            { 940, 4165}, -- Silent Oil
            { 420, 4202}, -- Daedalus Wing
            { 240, 4301}, -- Pear au Lait
            { 660, 4425}, -- Tomato Juice
        },
        items =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {4600,   642}, -- Zinc Ore
            {1250,   689}, -- Lauan Log
            { 600,   693}, -- Walnut Log
            {3250,   736}, -- Silver Ore
            {2900,   835}, -- Flax Flower
            {4800,   847}, -- Bird Feather
            {1600,   898}, -- Chicken Bone
            {2020,   914}, -- Mercury
            {5000,   936}, -- Rock Salt
            { 540,   947}, -- Firesand
            {3540,  1108}, -- Sulfur
            {4750,  1211}, -- Handful of Bronze Bolt Heads x33
            {2900,  4113}, -- Potion +1
            {2600,  4128}, -- Ether
            { 575,  4148}, -- Antidote
            {3150,  4151}, -- Echo Drops
            {1010,  4373}, -- Woozyshroom
            { 645, 12441}, -- Lizard Helm
            {1760, 12454}, -- Bone Mask
            {1400, 12455}, -- Beetle Mask
            {1390, 12473}, -- Poet's Circlet
            {1900, 12697}, -- Lizard Gloves
            {1700, 12710}, -- Bone Mittens
            { 390, 12711}, -- Beetle Mittens
            {1200, 12729}, -- Linen Cuffs
            { 910, 12737}, -- White Mitts
            {1600, 12825}, -- Lizard Trousers
            {1430, 12834}, -- Bone Subligar
            { 790, 12835}, -- Beetle Subligar
            {1060, 12857}, -- Linen Slops
            { 920, 12865}, -- Black Slacks
            {1250, 12953}, -- Lizard Ledelsens
            {1010, 12966}, -- Bone Leggings
            { 475, 12967}, -- Beetle Leggings
            {1600, 12985}, -- Holly Clogs
            {1320, 12993}, -- Sandals
            { 610, 13584}, -- Cotton Cape
            { 405, 13588}, -- Dhalmel Mantle
            { 350, 16473}, -- Kukri
            { 345, 16643}, -- Battleaxe
        }
    },
    [tpz.zone.MERIPHATAUD_MOUNTAINS] =
    {
        regionalItems = {18503}, -- Mammut
        temps =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {1060, 4114}, -- Potion +2
            { 740, 4115}, -- Potion +3
            { 700, 4116}, -- Hi-Potion
            { 800, 4129}, -- Ether +1
            { 430, 4130}, -- Ether +2
            { 200, 4131}, -- Ether +3
            {  50, 4136}, -- Super Ether
            { 900, 4145}, -- Elixir
            { 820, 4148}, -- Antidote
            { 730, 4150}, -- Eye Drops
            { 850, 4151}, -- Echo Drops
            { 650, 4155}, -- Remedy
            {1020, 4164}, -- Prism Powder
            { 940, 4165}, -- Silent Oil
            { 420, 4202}, -- Daedalus Wing
            { 220, 4206}, -- Catholicon
            { 430, 4302}, -- Pamama au Lait
            { 660, 4424}, -- Melon Juice
        },
        items =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {2400,   627}, -- Maple Sugar
            {1700,   637}, -- Slime Oil
            {3200,   643}, -- Iron Ore
            {4320,   690}, -- Elm Log
            {2050,   816}, -- Silk Thread
            {2450,   835}, -- Flax Flower
            {4050,   857}, -- Dhalmel Hide
            {5000,   880}, -- Bone Chip
            {3250,   897}, -- Scorpion Claw
            {1670,   900}, -- Fish Bones
            {3520,   913}, -- Beeswax
            {4300,   943}, -- Poison Dust
            {4690,  1211}, -- Brz. Bolt Heads x33
            {4900,  4112}, -- Potion
            {2400,  4114}, -- Potion +2
            {4890,  4128}, -- Ether
            {2350,  4129}, -- Ether +1
            {1700,  4145}, -- Elixir
            {2600,  4151}, -- Echo Drops
            {3170,  4225}, -- Iron Quiver
            {1540,  4447}, -- Scream Fungus
            { 670, 12424}, -- Iron Mask
            { 630, 12441}, -- Lizard Helm
            { 710, 12455}, -- Beetle Mask
            { 420, 12552}, -- Chainmail
            { 820, 12593}, -- Cotton Doublet
            { 310, 12680}, -- Chain Mittens
            { 520, 12697}, -- Lizard Gloves
            { 790, 12711}, -- Beetle Mittens
            { 900, 12721}, -- Cotton Gloves
            { 890, 12737}, -- White Mitts
            { 740, 12825}, -- Lizard Trousers
            { 650, 12849}, -- Cotton Brais
            { 760, 12865}, -- Black Slacks
            { 895, 12953}, -- Lizard Ledelsens
            {1020, 12967}, -- Beetle Leggings
            {1100, 12977}, -- Cotton Gaiters
            {1200, 12993}, -- Sandals
            { 330, 16406}, -- Baghnakhs
            { 320, 16835}, -- Spear
            { 350, 17090}, -- Elm Staff
        }
    },
    [tpz.zone.SAUROMUGUE_CHAMPAIGN] =
    {
        regionalItems = {16368}, -- Herder's Subligar
        temps =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {1060, 4114}, -- Potion +2
            { 740, 4115}, -- Potion +3
            { 700, 4116}, -- Hi-Potion
            { 800, 4129}, -- Ether +1
            { 430, 4130}, -- Ether +2
            { 200, 4131}, -- Ether +3
            {  50, 4136}, -- Super Ether
            { 900, 4145}, -- Elixir
            { 820, 4148}, -- Antidote
            { 730, 4150}, -- Eye Drops
            { 850, 4151}, -- Echo Drops
            { 650, 4155}, -- Remedy
            {1020, 4164}, -- Prism Powder
            { 940, 4165}, -- Silent Oil
            { 420, 4202}, -- Daedalus Wing
            { 220, 4206}, -- Catholicon
            { 430, 4302}, -- Pamama au Lait
            { 660, 4424}, -- Melon Juice
        },
        items =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {5000,   573}, -- Vegetable Seeds
            { 475,   636}, -- Chamomile
            {2780,   643}, -- Iron Ore
            {1940,   644}, -- Mythril Ore
            {2700,   691}, -- Maple Log
            {1060,   694}, -- Chestnut Log
            {3500,   749}, -- Mythril Beastcoin
            {1900,   820}, -- Wool Thread
            {1150,   859}, -- Ram Skin
            {1090,   895}, -- Ram Horn
            {4600,   928}, -- Bomb Ash
            {2650,   943}, -- Poison Dust
            {3300,  1212}, -- Handful of Mythril Bolt Heads x33
            {4900,  4113}, -- Potion +1
            {3100,  4114}, -- Potion +2
            { 670,  4115}, -- Potion +3
            {4800,  4129}, -- Ether +1
            {3000,  4130}, -- Ether +2
            { 900,  4145}, -- Elixer
            { 120, 12300}, -- Targe
            { 320, 12433}, -- Brass Mask
            { 660, 12442}, -- Studded Bandana
            { 680, 12465}, -- Cotton Headgear
            { 520, 12474}, -- Wool Hat
            { 200, 12570}, -- Studded Vest
            { 450, 12689}, -- Brass Finger Gauntlets
            { 460, 12721}, -- Cotton Gloves
            { 390, 12817}, -- Brass Cuisses
            { 550, 12826}, -- Studded Trousers
            { 420, 12849}, -- Cotton Brais
            { 690, 12945}, -- Brass Greaves
            { 770, 12954}, -- Studded Boots
            { 510, 12977}, -- Cotton Gaiters
            { 625, 12986}, -- Chestnut Sabots
            { 310, 13085}, -- Hemp Gorget
            { 305, 13205}, -- Silver Obi
            { 430, 13328}, -- Mythril Earring
            { 235, 13446}, -- Mythril Ring
            { 525, 16467}, -- Mythril Knife
            { 505, 17097}, -- Elm Pole
            { 350, 17284}, -- Chakram
        }
    },
    [tpz.zone.THE_SANCTUARY_OF_ZITAH] =
    {
        regionalItems = {18075}, -- Rossignol
        temps =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {1060, 4118}, -- Hi-Potion +2
            { 800, 4119}, -- Hi-Potion +3
            { 400, 4120}, -- X-Potion
            {1040, 4134}, -- Hi-Ether +2
            { 700, 4135}, -- Hi-Ether +3
            { 410, 4136}, -- Super Ether
            { 600, 4145}, -- Elixir
            {1450, 4148}, -- Antidote
            {1550, 4150}, -- Eye Drops
            {1650, 4151}, -- Echo Drops
            { 350, 4155}, -- Remedy
            { 820, 4164}, -- Prism Powder
            { 840, 4165}, -- Silent Oil
            { 600, 4202}, -- Daedalus Wing
            { 250, 4206}, -- Catholicon
            { 420, 4302}, -- Pamama au Lait
            { 720, 4424}, -- Melon Juice
        },
        items =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {5000,   575}, -- Grain Seeds
            {1690,   612}, -- Kazham Peppers
            {2480,   644}, -- Mythril Ore
            {4150,   699}, -- Oak Log
            {3600,   819}, -- Linen Thread
            {1740,   845}, -- Black C. Feather
            {2350,   914}, -- Mercury
            {2600,  1217}, -- Slv. Arrowheads
            {4950,  4113}, -- Potion +1
            {1720,  4114}, -- Potion +2
            { 640,  4115}, -- Potion +3
            {4750,  4128}, -- Ether
            {1850,  4129}, -- Ether +1
            { 650,  4130}, -- Ether +2
            { 420,  4145}, -- Elixir
            { 660, 12450}, -- Padded Cap
            { 540, 12475}, -- Velvet Hat
            { 475, 12571}, -- Cuir Bouilli
            { 570, 12699}, -- Cuir Gloves
            { 690, 12706}, -- Iron Mittens
            {1100, 12731}, -- Velvet Cuffs
            { 860, 12827}, -- Cuir Trousers
            { 720, 12836}, -- Iron Subligar
            { 490, 12859}, -- Velvet Slops
            {1120, 12955}, -- Cuir Highboots
            { 390, 12987}, -- Ebony Sabots
        }
    },
    [tpz.zone.ROMAEVE] =
    {
        regionalItems = {11486}, -- Diana Corona
        temps =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {1060, 4119}, -- Hi-Potion +3
            { 800, 4120}, -- X-Potion
            { 600, 4121}, -- X-Potion +1
            {1040, 4135}, -- Hi-Ether +3
            { 790, 4136}, -- Super Ether
            { 590, 4137}, -- Super Ether +1
            { 420, 4144}, -- Hi-Elixir
            { 655, 4145}, -- Elixir
            {  60, 4149}, -- Panacea
            { 460, 4155}, -- Remedy
            { 790, 4202}, -- Daedalus Wing
            { 490, 4206}, -- Catholicon
            { 320, 4210}, -- Lethe Water
            { 225, 4255}, -- Mana Powder
            { 360, 4302}, -- Pamama au Lait
            { 540, 4424}, -- Melon Juice
            { 210, 5322}, -- Healing Powder
        },
        items =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {2320,   645}, -- Darksteel Ore
            {1350,   702}, -- Ebony Log
            {1290,   737}, -- Gold Ore
            { 525,   823}, -- Gold Thread
            { 190,   844}, -- Phoenix Feather
            { 780,  1443}, -- Dried Mugwort
            {5000,  4116}, -- Hi-Potion
            {4500,  4117}, -- Hi-Potion +1
            {2500,  4120}, -- X-Potion
            { 500,  4121}, -- X-Potion +1
            {4200,  4133}, -- Hi-Ether +1
            {2100,  4141}, -- Pro-Ether +1
            {1230,  5164}, -- Ground Wasabi
            {1150, 12427}, -- Bascinet
            { 575, 12683}, -- Darksteel Mufflers
            { 680, 12740}, -- Silk Mitts
            { 740, 12811}, -- Dst. Breeches
            { 625, 12829}, -- Beak Trousers
            { 490, 12868}, -- Silk Slacks
            { 710, 12939}, -- Dst. Sollerets
            { 460, 12996}, -- Silk Pumps
            { 615, 13698}, -- Beak Helm
            { 540, 13700}, -- Beak Gloves
            { 470, 13702}, -- Beak Ledelsens
        }
    },
    [tpz.zone.YUHTUNGA_JUNGLE] =
    {
        regionalItems = {17760}, -- Buccaneer's Scimitar
        temps =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {1060, 4114}, -- Potion +2
            { 740, 4115}, -- Potion +3
            { 700, 4116}, -- Hi-Potion
            { 800, 4129}, -- Ether +1
            { 430, 4130}, -- Ether +2
            { 200, 4131}, -- Ether +3
            {  50, 4136}, -- Super Ether
            { 900, 4145}, -- Elixir
            { 820, 4148}, -- Antidote
            { 730, 4150}, -- Eye Drops
            { 850, 4151}, -- Echo Drops
            { 650, 4155}, -- Remedy
            {1020, 4164}, -- Prism Powder
            { 940, 4165}, -- Silent Oil
            { 420, 4202}, -- Daedalus Wing
            { 220, 4206}, -- Catholicon
            { 430, 4302}, -- Pamama au Lait
            { 660, 4424}, -- Melon Juice
        },
        items =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {2750,   574}, -- Fruit Seeds
            {3600,   633}, -- Olive Oil
            {3250,   651}, -- Iron Ingot
            {1200,   653}, -- Mythril Ingot
            {1420,   691}, -- Maple Log
            { 760,   822}, -- Silver Thread
            {1350,   943}, -- Poison Dust
            {2700,  1212}, -- Mtl. Bolt Heads x33
            {4800,  4114}, -- Potion +2
            {3200,  4115}, -- Potion +3
            {5000,  4129}, -- Ether +1
            {3800,  4130}, -- Ether +2
            { 460, 12458}, -- Soil Hachimaki
            { 740, 12698}, -- Studded Gloves
            { 530, 12714}, -- Soil Tekko
            { 360, 12730}, -- Wool Cuffs
            { 290, 12826}, -- Studded Trousers
            {1200, 12842}, -- Soil Sitabaki
            { 400, 12858}, -- Wool Slops
            { 200, 12954}, -- Studded Boots
            { 190, 12970}, -- Soil Kyahan
            { 390, 12986}, -- Chestnut Sabots
        }
    },
    [tpz.zone.YHOATOR_JUNGLE] =
    {
        regionalItems = {18953}, -- Beluga
        temps =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {1060, 4117}, -- Hi-Potion +1
            { 700, 4118}, -- Hi-Potion +2
            { 230, 4119}, -- Hi-Potion +3
            {1020, 4133}, -- Hi-Ether +1
            { 800, 4134}, -- Hi-Ether +2
            { 240, 4135}, -- Hi-Ether +3
            { 900, 4145}, -- Elixir
            { 820, 4148}, -- Antidote
            { 730, 4150}, -- Eye Drops
            { 850, 4151}, -- Echo Drops
            { 650, 4155}, -- Remedy
            {1020, 4164}, -- Prism Powder
            { 940, 4165}, -- Silent Oil
            { 420, 4202}, -- Daedalus Wing
            { 220, 4206}, -- Catholicon
            { 430, 4302}, -- Pamama au Lait
            { 660, 4424}, -- Melon Juice
        },
        items =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {5000,   575}, -- Grain Seeds
            {2100,   612}, -- Kazham Peppers
            {2300,   644}, -- Mythril Ore
            {3800,   699}, -- Oak Log
            {1700,   819}, -- Linen Thread
            { 320,   845}, -- Black C. Feather
            {2750,   914}, -- Mercury
            {2200,  1217}, -- Slv. Arrowheads x33
            {4900,  4114}, -- Potion +2
            {1600,  4115}, -- Potion +3
            { 630,  4119}, -- Hi-Potion +3
            {4800,  4129}, -- Ether +1
            {3690,  4130}, -- Ether +2
            { 720, 12443}, -- Cuir Bandana
            { 610, 12450}, -- Padded Cap
            { 530, 12458}, -- Soil Hachimaki
            { 715, 12475}, -- Velvet Hat
            { 505, 12571}, -- Cuir Bouilli
            { 415, 12603}, -- Velvet Robe
            { 625, 12699}, -- Cuir Gloves
            { 735, 12706}, -- Iron Mittens
            { 410, 12731}, -- Velvet Cuffs
            { 710, 12827}, -- Cuir Trousers
            { 900, 12836}, -- Iron Subligar
            { 470, 12859}, -- Velvet Slops
            { 865, 12955}, -- Cuir Highboots
            { 645, 12962}, -- Leggings
            { 230, 12987}, -- Ebony Sabots
        }
    },
    [tpz.zone.WESTERN_ALTEPA_DESERT] =
    {
        regionalItems = {19114}, -- Galkan Dagger
        temps =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {1060, 4117}, -- Hi-Potion +1
            { 700, 4118}, -- Hi-Potion +2
            { 230, 4119}, -- Hi-Potion +3
            {1020, 4133}, -- Hi-Ether +1
            { 800, 4134}, -- Hi-Ether +2
            { 240, 4135}, -- Hi-Ether +3
            { 900, 4145}, -- Elixir
            { 820, 4148}, -- Antidote
            { 730, 4150}, -- Eye Drops
            { 850, 4151}, -- Echo Drops
            { 650, 4155}, -- Remedy
            {1020, 4164}, -- Prism Powder
            { 940, 4165}, -- Silent Oil
            { 420, 4202}, -- Daedalus Wing
            { 220, 4206}, -- Catholicon
            { 430, 4302}, -- Pamama au Lait
            { 660, 4424}, -- Melon Juice
        },
        items =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {5000,   575}, -- Grain Seeds
            {2600,   612}, -- Kazham Peppers
            {4200,   698}, -- Ash Log
            {3100,   816}, -- Silk Thread
            {2750,   923}, -- Dryad Root
            { 320,   932}, -- Carbon Fiber
            { 510,  1225}, -- Gold Nugget
            { 120,  1228}, -- Dst. Nugget
            {4500,  4113}, -- Potion +1
            {2300,  4114}, -- Potion +2
            {1450,  4115}, -- Potion +3
            {4100,  4128}, -- Ether
            {2100,  4129}, -- Ether +1
            {1420,  4130}, -- Ether +2
            { 640,  4145}, -- Elixir
            { 560, 12450}, -- Padded Cap
            { 790, 12837}, -- Carapace Subligar
            { 810, 13711}, -- Carapace Mask
            { 680, 13713}, -- Carapace Mittens
            { 725, 13715}, -- Cpc. Leggings
            { 120, 16412}, -- Mythril Claws
            {  95, 16558}, -- Falchion
            { 100, 16590}, -- Greatsword
            { 675, 16796}, -- Mythril Zaghnal
            { 450, 17062}, -- Bone Rod
            { 840, 17610}, -- Bone Knife
            {  80, 18207}, -- Kheten
        }
    },
    [tpz.zone.QUFIM_ISLAND] =
    {
        regionalItems = {18762}, -- Custodes
        temps =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {1060, 4117}, -- Hi-Potion +1
            { 700, 4118}, -- Hi-Potion +2
            { 230, 4119}, -- Hi-Potion +3
            {1020, 4133}, -- Hi-Ether +1
            { 800, 4134}, -- Hi-Ether +2
            { 240, 4135}, -- Hi-Ether +3
            { 900, 4145}, -- Elixir
            { 820, 4148}, -- Antidote
            { 730, 4150}, -- Eye Drops
            { 850, 4151}, -- Echo Drops
            { 650, 4155}, -- Remedy
            {1020, 4164}, -- Prism Powder
            { 940, 4165}, -- Silent Oil
            { 420, 4202}, -- Daedalus Wing
            { 220, 4206}, -- Catholicon
            { 430, 4302}, -- Pamama au Lait
            { 660, 4424}, -- Melon Juice
        },
        items =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {5000,   573}, -- Vegetable Seeds
            { 475,   636}, -- Chamomile
            {2780,   643}, -- Iron Ore
            {1940,   644}, -- Mythril Ore
            {2700,   691}, -- Maple Log
            {1060,   694}, -- Chestnut Log
            {3500,   749}, -- Mythril Beastcoin
            {1900,   820}, -- Wool Thread
            {1150,   859}, -- Ram Skin
            {1090,   895}, -- Ram Horn
            {4600,   928}, -- Bomb Ash
            {2650,   943}, -- Poison Dust
            {3300,  1212}, -- Handful of Mythril Bolt Heads x33
            {4900,  4113}, -- Potion +1
            {3100,  4114}, -- Potion +2
            { 670,  4115}, -- Potion +3
            {4800,  4129}, -- Ether +1
            {3000,  4130}, -- Ether +2
            { 900,  4145}, -- Elixer
            { 120, 12300}, -- Targe
            { 320, 12433}, -- Brass Mask
            { 660, 12442}, -- Studded Bandana
            { 680, 12465}, -- Cotton Headgear
            { 520, 12474}, -- Wool Hat
            { 200, 12570}, -- Studded Vest
            { 450, 12689}, -- Brass Finger Gauntlets
            { 460, 12721}, -- Cotton Gloves
            { 390, 12817}, -- Brass Cuisses
            { 550, 12826}, -- Studded Trousers
            { 420, 12849}, -- Cotton Brais
            { 690, 12945}, -- Brass Greaves
            { 770, 12954}, -- Studded Boots
            { 510, 12977}, -- Cotton Gaiters
            { 625, 12986}, -- Chestnut Sabots
            { 310, 13085}, -- Hemp Gorget
            { 305, 13205}, -- Silver Obi
            { 430, 13328}, -- Mythril Earring
            { 235, 13446}, -- Mythril Ring
            { 525, 16467}, -- Mythril Knife
            { 505, 17097}, -- Elm Pole
            { 350, 17284}, -- Chakram
        }
    },
    [tpz.zone.BEHEMOTHS_DOMINION] =
    {
        regionalItems = {11402}, -- Gothic Sabatons
        temps =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {1100, 4118}, -- Hi-Potion +2
            {1000, 4119}, -- Hi-Potion +3
            { 800, 4120}, -- X-Potion
            { 600, 4121}, -- X-Potion +1
            {1040, 4135}, -- Hi-Ether +3
            { 790, 4136}, -- Super Ether
            { 590, 4137}, -- Super Ether +1
            { 420, 4144}, -- Hi-Elixir
            { 655, 4145}, -- Elixir
            {  60, 4149}, -- Panacea
            { 460, 4155}, -- Remedy
            { 790, 4202}, -- Daedalus Wing
            { 490, 4206}, -- Catholicon
            { 320, 4210}, -- Lethe Water
            { 225, 4255}, -- Mana Powder
            { 360, 4302}, -- Pamama au Lait
            { 540, 4424}, -- Melon Juice
            { 210, 5322}, -- Healing Powder
        },
        items =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {5000,   575}, -- Grain Seeds
            {2100,   612}, -- Kazham Peppers
            {2300,   644}, -- Mythril Ore
            {3800,   699}, -- Oak Log
            {1700,   819}, -- Linen Thread
            { 320,   845}, -- Black C. Feather
            {2750,   914}, -- Mercury
            {2200,  1217}, -- Slv. Arrowheads x33
            {4900,  4114}, -- Potion +2
            {1600,  4115}, -- Potion +3
            { 630,  4119}, -- Hi-Potion +3
            {4800,  4129}, -- Ether +1
            {3690,  4130}, -- Ether +2
            { 720, 12443}, -- Cuir Bandana
            { 610, 12450}, -- Padded Cap
            { 530, 12458}, -- Soil Hachimaki
            { 715, 12475}, -- Velvet Hat
            { 505, 12571}, -- Cuir Bouilli
            { 415, 12603}, -- Velvet Robe
            { 625, 12699}, -- Cuir Gloves
            { 735, 12706}, -- Iron Mittens
            { 410, 12731}, -- Velvet Cuffs
            { 710, 12827}, -- Cuir Trousers
            { 900, 12836}, -- Iron Subligar
            { 470, 12859}, -- Velvet Slops
            { 865, 12955}, -- Cuir Highboots
            { 645, 12962}, -- Leggings
            { 230, 12987}, -- Ebony Sabots
        }
    },
    [tpz.zone.VALLEY_OF_SORROWS] =
    {
        regionalItems = {18867}, -- Daedalus Hammer
        temps =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {1100, 4118}, -- Hi-Potion +2
            {1000, 4119}, -- Hi-Potion +3
            { 800, 4120}, -- X-Potion
            { 600, 4121}, -- X-Potion +1
            {1040, 4135}, -- Hi-Ether +3
            { 790, 4136}, -- Super Ether
            { 590, 4137}, -- Super Ether +1
            { 420, 4144}, -- Hi-Elixir
            { 655, 4145}, -- Elixir
            {  60, 4149}, -- Panacea
            { 460, 4155}, -- Remedy
            { 790, 4202}, -- Daedalus Wing
            { 490, 4206}, -- Catholicon
            { 320, 4210}, -- Lethe Water
            { 225, 4255}, -- Mana Powder
            { 360, 4302}, -- Pamama au Lait
            { 540, 4424}, -- Melon Juice
            { 210, 5322}, -- Healing Powder
        },
        items =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {2320,   645}, -- Darksteel Ore
            {1350,   702}, -- Ebony Log
            {1290,   737}, -- Gold Ore
            { 525,   823}, -- Gold Thread
            { 190,   844}, -- Phoenix Feather
            { 780,  1443}, -- Dried Mugwort
            {5000,  4116}, -- Hi-Potion
            {4500,  4117}, -- Hi-Potion +1
            {2500,  4120}, -- X-Potion
            { 500,  4121}, -- X-Potion +1
            {4200,  4133}, -- Hi-Ether +1
            {2100,  4141}, -- Pro-Ether +1
            {1230,  5164}, -- Ground Wasabi
            {1150, 12427}, -- Bascinet
            { 575, 12683}, -- Darksteel Mufflers
            { 680, 12740}, -- Silk Mitts
            { 740, 12811}, -- Dst. Breeches
            { 625, 12829}, -- Beak Trousers
            { 490, 12868}, -- Silk Slacks
            { 710, 12939}, -- Dst. Sollerets
            { 460, 12996}, -- Silk Pumps
            { 615, 13698}, -- Beak Helm
            { 540, 13700}, -- Beak Gloves
            { 470, 13702}, -- Beak Ledelsens
        }
    },
    [tpz.zone.RUAUN_GARDENS] =
    {
        regionalItems = {16284}, -- Caract Choker
        temps =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {1100, 4118}, -- Hi-Potion +2
            {1000, 4119}, -- Hi-Potion +3
            { 800, 4120}, -- X-Potion
            { 600, 4121}, -- X-Potion +1
            {1040, 4135}, -- Hi-Ether +3
            { 790, 4136}, -- Super Ether
            { 590, 4137}, -- Super Ether +1
            { 420, 4144}, -- Hi-Elixir
            { 655, 4145}, -- Elixir
            {  60, 4149}, -- Panacea
            { 460, 4155}, -- Remedy
            { 790, 4202}, -- Daedalus Wing
            { 490, 4206}, -- Catholicon
            { 320, 4210}, -- Lethe Water
            { 225, 4255}, -- Mana Powder
            { 360, 4302}, -- Pamama au Lait
            { 540, 4424}, -- Melon Juice
            { 210, 5322}, -- Healing Powder
        },
        items =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {2700,   646}, -- Adaman Ore
            { 310,   739}, -- Orichalcum Ore
            { 580,   821}, -- Rainbow Thread
            {4700,  1222}, -- Yagudo Fltchg.
            {3100,  1962}, -- Plt. Arrowheads
            {1050,  2459}, -- Minium
            {2100,  2532}, -- Teak Log
            {5000,  4119}, -- Hi-Potion +3
            {2500,  4123}, -- X-Potion +3
            {4900,  4135}, -- Hi-Ether +3
            {2200,  4143}, -- Pro-Ether +3
            {2400,  5662}, -- Dragon Fruit
            {1250, 12309}, -- Ritter Shield
            { 645, 12324}, -- Tower Shield
            { 400, 13087}, -- Jeweled Collar
            { 655, 13185}, -- Muscle Belt
            { 320, 13212}, -- Tarutaru Sash
            { 680, 13587}, -- Rainbow Cape
            { 780, 13595}, -- Coeurl Mantle
            { 220, 15890}, -- Marid Belt
            { 695, 16128}, -- Wivre Hairpin
            { 725, 16265}, -- Wivre Gorget
        }
    },
    [tpz.zone.THE_BOYAHDA_TREE] =
    {
        regionalItems = {11038, 10948}, -- Dragonkin Earring | Carver's Torque
        temps =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            { 900, 4202}, -- Daedalus Wing
            { 500, 4206}, -- Catholicon
            { 300, 4255}, -- Mana Powder
            { 450, 5322}, -- Healing Powder
            { 320, 5393}, -- Monarch's Drink
            { 650, 5394}, -- Gnostic's Drink
            { 430, 5395}, -- Cleric's Drink
            {1000, 5433}, -- Dusty Elixir
            { 690, 5439}, -- Vicar's Drink
            { 250, 5440}, -- Dusty Wing
            {2000, 5824}, -- Lucid Potion I
            {1900, 5825}, -- Lucid Potion II
            {1200, 5826}, -- Lucid Potion III
            { 730, 5832}, -- Healing Mist
            { 420, 5833}, -- Mana Mist
            {  10, 5834}, -- Lucid Wings I
            { 875, 5835}, -- Healing Salve I
            { 210, 5836}, -- Healing Salve II
            { 920, 5837}, -- Clear Salve I
            { 190, 5838}, -- Clear Salve II
            { 310, 5839}, -- Stalwart's Tonic
            { 205, 5840}, -- Stalwart's Gambir
            { 410, 5841}, -- Ascetic's Tonic
            { 305, 5842}, -- Ascetic's Gambir
            { 200, 5845}, -- Fanatic's Tonic
        },
        items =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            { 390,   657}, -- Tama-Hagane
            { 745,   876}, -- Manta Skin
            { 250,   887}, -- Coral Fragment
            {3700,   919}, -- Boyahda Moss
            {4500,  1163}, -- Manticore Hair
            {1025,  1446}, -- Lacquer Tree Log
            { 450,  3313}, -- Vivi-Valve
            { 700,  3434}, -- Cobalt Cell
            {1600,  3435}, -- Rubicund Cell
            {2060,  3436}, -- Xanthous Cell
            {2050,  3437}, -- Jade Cell
            {1500,  3450}, -- Voiddust
            {5000,  4119}, -- Hi-Potion +3
            {4200,  4120}, -- X-Potion
            {3500,  4121}, -- X-Potion +1
            {3000,  4122}, -- X-Potion +2
            {4900,  4135}, -- Hi-Ether +3
            {2700,  4143}, -- Pro-Ether +3
            { 600,  4155}, -- Remedy
            {1200,  4173}, -- Hi-Reraiser
            { 900,  4174}, -- Vile Elixir
            {1200,  4291}, -- Sandfish
            {1700,  4447}, -- Scream Fungus
            { 650,  5866}, -- Toolbag (Moku)
            {1050,  5871}, -- Ruszor Quiver
            {2050, 17881}, -- Deepbed Soil
            {1020, 17884}, -- Sun Water
            { 500, 17898}, -- C. Grass. Broth
            { 400, 17899}, -- Svg. Mole Broth
        }
    },
    [tpz.zone.MIDDLE_DELKFUTTS_TOWER] =
    {
        regionalItems = {651}, -- Iron Ingot
        temps =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {1060, 4114}, -- Potion +2
            { 740, 4115}, -- Potion +3
            { 700, 4116}, -- Hi-Potion
            { 800, 4129}, -- Ether +1
            { 430, 4130}, -- Ether +2
            { 200, 4131}, -- Ether +3
            {  50, 4136}, -- Super Ether
            { 900, 4145}, -- Elixir
            { 820, 4148}, -- Antidote
            { 730, 4150}, -- Eye Drops
            { 850, 4151}, -- Echo Drops
            { 650, 4155}, -- Remedy
            {1020, 4164}, -- Prism Powder
            { 940, 4165}, -- Silent Oil
            { 420, 4202}, -- Daedalus Wing
            { 220, 4206}, -- Catholicon
            { 430, 4302}, -- Pamama au Lait
            { 660, 4424}, -- Melon Juice
        },
        items =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {2750,   574}, -- Fruit Seeds
            {3600,   633}, -- Olive Oil
            {3250,   651}, -- Iron Ingot
            {1200,   653}, -- Mythril Ingot
            {1420,   691}, -- Maple Log
            { 760,   822}, -- Silver Thread
            {1350,   943}, -- Poison Dust
            {2700,  1212}, -- Mtl. Bolt Heads x33
            { 500,  3435}, -- Rubicund Cell
            { 510,  3436}, -- Xanthous Cell
            {4800,  4114}, -- Potion +2
            {3200,  4115}, -- Potion +3
            {5000,  4129}, -- Ether +1
            {3800,  4130}, -- Ether +2
            { 460, 12458}, -- Soil Hachimaki
            { 740, 12698}, -- Studded Gloves
            { 530, 12714}, -- Soil Tekko
            { 360, 12730}, -- Wool Cuffs
            { 290, 12826}, -- Studded Trousers
            {1200, 12842}, -- Soil Sitabaki
            { 400, 12858}, -- Wool Slops
            { 200, 12954}, -- Studded Boots
            { 190, 12970}, -- Soil Kyahan
            { 390, 12986}, -- Chestnut Sabots
        }
    },
    [tpz.zone.UPPER_DELKFUTTS_TOWER] =
    {
        regionalItems = {19779}, -- Potestas Bomblet
        temps =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {1060, 4114}, -- Potion +2
            { 740, 4115}, -- Potion +3
            { 700, 4116}, -- Hi-Potion
            { 800, 4129}, -- Ether +1
            { 430, 4130}, -- Ether +2
            { 200, 4131}, -- Ether +3
            {  50, 4136}, -- Super Ether
            { 900, 4145}, -- Elixir
            { 820, 4148}, -- Antidote
            { 730, 4150}, -- Eye Drops
            { 850, 4151}, -- Echo Drops
            { 650, 4155}, -- Remedy
            {1020, 4164}, -- Prism Powder
            { 940, 4165}, -- Silent Oil
            { 420, 4202}, -- Daedalus Wing
            { 220, 4206}, -- Catholicon
            { 430, 4302}, -- Pamama au Lait
            { 660, 4424}, -- Melon Juice
        },
        items =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            { 700,   702}, -- Ebony Log
            { 100,   844}, -- Phoenix Feather
            { 320,  3308}, -- Power Cooler
            {1650,  3434}, -- Cobalt Cell
            {1600,  3436}, -- Xanthous Cell
            {1500,  3437}, -- Jade Cell
            { 800,  3450}, -- Voiddust
            {2000,  4117}, -- Hi-Potion +1
            {1900,  4133}, -- Hi-Ether +1
            { 600,  4141}, -- Pro-Ether +1
            { 440, 12996}, -- Silk Pumps
        }
    },
    [tpz.zone.TEMPLE_OF_UGGALEPIH] =
    {
        regionalItems = {10953}, -- Boneworker's Torque
        temps =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {1060, 4117}, -- Hi-Potion +1
            { 700, 4118}, -- Hi-Potion +2
            { 230, 4119}, -- Hi-Potion +3
            {1020, 4133}, -- Hi-Ether +1
            { 800, 4134}, -- Hi-Ether +2
            { 240, 4135}, -- Hi-Ether +3
            { 900, 4145}, -- Elixir
            { 820, 4148}, -- Antidote
            { 730, 4150}, -- Eye Drops
            { 850, 4151}, -- Echo Drops
            { 650, 4155}, -- Remedy
            {1020, 4164}, -- Prism Powder
            { 940, 4165}, -- Silent Oil
            { 420, 4202}, -- Daedalus Wing
            { 220, 4206}, -- Catholicon
            { 430, 4302}, -- Pamama au Lait
            { 660, 4424}, -- Melon Juice
        },
        items =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {1400,   645}, -- Darksteel Ore
            {2580,   702}, -- Ebony Log
            { 700,   737}, -- Gold Ore
            { 690,   823}, -- Gold Thread
            { 450,   844}, -- Phoenix Feather
            {3500,  1122}, -- Wyvern Skin
            {2700,  1213}, -- Dst. Bolt Heads x33
            { 740,  3308}, -- Power Cooler
            {3880,  3434}, -- Cobalt Cell
            { 440,  3435}, -- Rubicund Cell
            { 210,  3436}, -- Xanthous Cell
            {1425,  3450}, -- Voiddust
            {5000,  4117}, -- Hi-Potion +1
            {4200,  4121}, -- X-Potion +1
            {4900,  4133}, -- Hi-Ether +1
            {4000,  4141}, -- Pro-Ether +1
            { 900,  4449}, -- Reishi Mushroom
            {1200,  5164}, -- Ground Wasabi
            { 560, 12427}, -- Bascinet
            { 350, 12811}, -- Dst. Breeches
            { 540, 12939}, -- Dst. Sollerets
            { 610, 12996}, -- Silk Pumps
        }
    },
    [tpz.zone.DEN_OF_RANCOR] =
    {
        regionalItems = {10950, 10991}, -- Goldsm. Torque | Rancorous Mantle
        temps =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {1100, 4118}, -- Hi-Potion +2
            {1000, 4119}, -- Hi-Potion +3
            { 800, 4120}, -- X-Potion
            { 600, 4121}, -- X-Potion +1
            {1040, 4135}, -- Hi-Ether +3
            { 790, 4136}, -- Super Ether
            { 590, 4137}, -- Super Ether +1
            { 420, 4144}, -- Hi-Elixir
            { 655, 4145}, -- Elixir
            {  60, 4149}, -- Panacea
            { 460, 4155}, -- Remedy
            { 790, 4202}, -- Daedalus Wing
            { 490, 4206}, -- Catholicon
            { 320, 4210}, -- Lethe Water
            { 225, 4255}, -- Mana Powder
            { 360, 4302}, -- Pamama au Lait
            { 540, 4424}, -- Melon Juice
            { 210, 5322}, -- Healing Powder
        },
        items =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {2700,   646}, -- Adaman Ore
            { 310,   739}, -- Orichalcum Ore
            { 580,   821}, -- Rainbow Thread
            {4250,  1122}, -- Wyvern Skin
            {4700,  1222}, -- Yagudo Fltchg
            {3100,  1962}, -- Plt. Arrowheads
            {1050,  2459}, -- Minium
            {2100,  2532}, -- Teak Log
            { 510,  3312}, -- Percolator
            { 220,  3314}, -- Disruptor
            { 650,  3434}, -- Cobalt Cell
            { 980,  3435}, -- Rubicund Cell
            {1465,  3436}, -- Xanthous Cell
            {1050,  3437}, -- Jade Cell
            {1940,  3450}, -- Voiddust
            {5000,  4119}, -- Hi-Potion +3
            {2500,  4123}, -- X-Potion +3
            {4900,  4133}, -- Hi-Ether +1
            {3600,  4134}, -- Hi-Ether +2
            {2120,  4135}, -- Hi-Ether +3
            {1700,  4143}, -- Pro-Ether +3
            {2400,  5662}, -- Dragon Fruit
            { 320,  8555}, -- Barrier Module
            {1250, 12309}, -- Ritter Shield
            { 645, 12324}, -- Tower Shield
            { 400, 13087}, -- Jeweled Collar
            { 655, 13185}, -- Muscle Belt
            { 320, 13212}, -- Tarutaru Sash
            { 680, 13587}, -- Rainbow Cape
            { 780, 13595}, -- Coeurl Mantle
            { 220, 15890}, -- Marid Belt
            { 695, 16128}, -- Wivre Hairpin
        }
    },
    [tpz.zone.RANGUEMONT_PASS] =
    {
        regionalItems = {11575}, -- Grapevine Cape
        temps =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {1060, 4112}, -- Potion
            { 790, 4113}, -- Potion +1
            { 425, 4114}, -- Potion +2
            {1040, 4128}, -- Ether
            { 760, 4129}, -- Ether +1
            { 420, 4130}, -- Ether +2
            { 600, 4145}, -- Elixer
            { 820, 4148}, -- Antidote
            { 730, 4150}, -- Eye Drops
            { 750, 4151}, -- Echo Drops
            { 350, 4155}, -- Remedy
            {1020, 4164}, -- Prism Powder
            { 940, 4165}, -- Silent Oil
            { 420, 4202}, -- Daedalus Wing
            { 240, 4301}, -- Pear au Lait
            { 660, 4425}, -- Tomato Juice
        },
        items =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {2050,  3437}, -- Jade Cell
            {1500,  3450}, -- Voiddust
            {5000,  4119}, -- Hi-Potion +3
            {4200,  4120}, -- X-Potion
            {3500,  4121}, -- X-Potion +1
            {3000,  4122}, -- X-Potion +2
            {4900,  4135}, -- Hi-Ether +3
            {2700,  4143}, -- Pro-Ether +3
            { 600,  4155}, -- Remedy
            { 500, 17898}, -- C. Grass. Broth
        }
    },
    [tpz.zone.BOSTAUNIEUX_OUBLIETTE] =
    {
        regionalItems = {11920}, -- Melaco Mittens
        temps =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            { 900, 4202}, -- Daedalus Wing
            { 500, 4206}, -- Catholicon
            { 300, 4255}, -- Mana Powder
            { 450, 5322}, -- Healing Powder
            { 320, 5393}, -- Monarch's Drink
            { 650, 5394}, -- Gnostic's Drink
            { 430, 5395}, -- Cleric's Drink
            {1000, 5433}, -- Dusty Elixir
            { 690, 5439}, -- Vicar's Drink
            { 250, 5440}, -- Dusty Wing
            {2000, 5824}, -- Lucid Potion I
            {1900, 5825}, -- Lucid Potion II
            {1200, 5826}, -- Lucid Potion III
            { 730, 5832}, -- Healing Mist
            { 420, 5833}, -- Mana Mist
            {1010, 5834}, -- Lucid Wings I
            { 875, 5835}, -- Healing Salve I
            { 210, 5836}, -- Healing Salve II
            { 920, 5837}, -- Clear Salve I
            { 190, 5838}, -- Clear Salve II
            { 310, 5839}, -- Stalwart's Tonic
            { 205, 5840}, -- Stalwart's Gambir
            { 410, 5841}, -- Ascetic's Tonic
            { 305, 5842}, -- Ascetic's Gambir
            { 310, 5843}, -- Champion's Tonic
            { 200, 5845}, -- Fanatic's Tonic
        },
        items =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {1270,   737}, -- Gold Ore
            {1550,   739}, -- Orichalcum Ore
            { 745,   748}, -- Gold Beastcoin
            { 625,   769}, -- Red Rock
            { 325,   821}, -- Rainbow Thread
            { 425,   844}, -- Phoenix Feather
            { 720,  1213}, -- Dst. Bolt Heads
            { 830,  2459}, -- Minium
            { 240,  3309}, -- Barrage Turbine
            { 310,  3313}, -- Vivi-Valve
            { 290,  3314}, -- Disruptor
            {1400,  3434}, -- Cobalt Cell
            { 725,  3435}, -- Rubicund Cell
            {1020,  3436}, -- Xanthous Cell
            { 600,  3437}, -- Jade Cell
            {1750,  3450}, -- Voiddust
            {5000,  4119}, -- Hi-Potion +3
            {4900,  4135}, -- Hi-Ether +3
            {1700,  4144}, -- Hi-Elixir
            { 750,  4155}, -- Remedy
            {2100,  4173}, -- Hi-Reraiser
            { 630,  5662}, -- Dragon Fruit
            {1050,  5821}, -- Fsn. Bolt Quiver
            {  80, 13929}, -- Errant Hat
            {  75, 14078}, -- Errant Cuffs
            {  30, 14380}, -- Errant Hpl.
            { 110, 16520}, -- Verdun
        }
    },
    [tpz.zone.TORAIMARAI_CANAL] =
    {
        regionalItems = {11576}, -- Bond Cape
        temps =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            { 900, 4202}, -- Daedalus Wing
            { 500, 4206}, -- Catholicon
            { 300, 4255}, -- Mana Powder
            { 450, 5322}, -- Healing Powder
            { 320, 5393}, -- Monarch's Drink
            { 650, 5394}, -- Gnostic's Drink
            { 430, 5395}, -- Cleric's Drink
            {1000, 5433}, -- Dusty Elixir
            { 690, 5439}, -- Vicar's Drink
            { 250, 5440}, -- Dusty Wing
            {2000, 5824}, -- Lucid Potion I
            {1900, 5825}, -- Lucid Potion II
            {1200, 5826}, -- Lucid Potion III
            { 730, 5832}, -- Healing Mist
            { 420, 5833}, -- Mana Mist
            {1010, 5834}, -- Lucid Wings I
            { 875, 5835}, -- Healing Salve I
            { 210, 5836}, -- Healing Salve II
            { 920, 5837}, -- Clear Salve I
            { 190, 5838}, -- Clear Salve II
            { 310, 5839}, -- Stalwart's Tonic
            { 205, 5840}, -- Stalwart's Gambir
            { 410, 5841}, -- Ascetic's Tonic
            { 305, 5842}, -- Ascetic's Gambir
            { 310, 5843}, -- Champion's Tonic
            { 200, 5845}, -- Fanatic's Tonic
        },
        items =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {1270,   737}, -- Gold Ore
            {1550,   739}, -- Orichalcum Ore
            { 745,   748}, -- Gold Beastcoin
            { 625,   769}, -- Red Rock
            { 325,   821}, -- Rainbow Thread
            { 425,   844}, -- Phoenix Feather
            { 720,  1213}, -- Dst. Bolt Heads
            { 830,  2459}, -- Minium
            { 240,  3309}, -- Barrage Turbine
            { 310,  3313}, -- Vivi-Valve
            { 290,  3314}, -- Disruptor
            {1400,  3434}, -- Cobalt Cell
            { 725,  3435}, -- Rubicund Cell
            {1020,  3436}, -- Xanthous Cell
            { 600,  3437}, -- Jade Cell
            {1750,  3450}, -- Voiddust
            {5000,  4119}, -- Hi-Potion +3
            {4900,  4135}, -- Hi-Ether +3
            {1700,  4144}, -- Hi-Elixir
            { 750,  4155}, -- Remedy
            {2100,  4173}, -- Hi-Reraiser
            { 630,  5662}, -- Dragon Fruit
            {1050,  5821}, -- Fsn. Bolt Quiver
            {  80, 13929}, -- Errant Hat
            {  75, 14078}, -- Errant Cuffs
            {  30, 14380}, -- Errant Hpl.
            { 110, 16520}, -- Verdun
        }
    },
    [tpz.zone.ZERUHN_MINES] =
    {
        regionalItems = {11677}, -- Prouesse Ring
        tempsLow =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {1060, 4112}, -- Potion
            { 740, 4113}, -- Potion +1
            { 700, 4114}, -- Potion +2
            { 800, 4128}, -- Ether
            { 430, 4129}, -- Ether +1
            {  50, 4130}, -- Ether +2
            { 900, 4145}, -- Elixer
            { 820, 4148}, -- Antidote
            { 730, 4150}, -- Eye Drops
            { 850, 4151}, -- Echo Drops
            { 650, 4155}, -- Remedy
            {1020, 4164}, -- Prism Powder
            { 940, 4165}, -- Silent Oil
            { 420, 4202}, -- Daedalus Wing
            { 250, 4300}, -- Apple Au Lait
            { 660, 4423}, -- Apple Juice
        },
        tempsHi =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            { 900, 4202}, -- Daedalus Wing
            { 500, 4206}, -- Catholicon
            { 300, 4255}, -- Mana Powder
            { 450, 5322}, -- Healing Powder
            { 320, 5393}, -- Monarch's Drink
            { 650, 5394}, -- Gnostic's Drink
            { 430, 5395}, -- Cleric's Drink
            {1000, 5433}, -- Dusty Elixir
            { 690, 5439}, -- Vicar's Drink
            { 250, 5440}, -- Dusty Wing
            {2000, 5824}, -- Lucid Potion I
            {1900, 5825}, -- Lucid Potion II
            {1200, 5826}, -- Lucid Potion III
            { 730, 5832}, -- Healing Mist
            { 420, 5833}, -- Mana Mist
            {1010, 5834}, -- Lucid Wings I
            { 875, 5835}, -- Healing Salve I
            { 210, 5836}, -- Healing Salve II
            { 920, 5837}, -- Clear Salve I
            { 190, 5838}, -- Clear Salve II
            { 310, 5839}, -- Stalwart's Tonic
            { 205, 5840}, -- Stalwart's Gambir
            { 410, 5841}, -- Ascetic's Tonic
            { 305, 5842}, -- Ascetic's Gambir
            { 310, 5843}, -- Champion's Tonic
            { 200, 5845}, -- Fanatic's Tonic
        },
        itemsLow =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {3760,   505}, -- Sheepskin
            {3450,   626}, -- Black Pepper
            {4790,   656}, -- Beastcoin
            {4600,   818}, -- Cotton Thread
            {5000,   852}, -- Lizard Skin
            {4990,   880}, -- Bone Chip
            {2650,   893}, -- Giant Femur
            {1730,   912}, -- Beehive Chip
            {1450,   925}, -- Giant Stinger
            {1060,  1225}, -- Gold Nugget
            {3610,  1845}, -- Red Moko Grass
            {4820,  4114}, -- Potion +2
            {4650,  4115}, -- Potion +3
            {4840,  4129}, -- Ether +1
            {4320,  4130}, -- Ether +2
            { 510,  4145}, -- Elixir
            {2430,  4370}, -- Honey
        },
        itemsHi =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {3760,   505}, -- Sheepskin
            {3450,   626}, -- Black Pepper
            { 480,   679}, -- Aluminum Ingot
            {1560,   714}, -- Holly Lumber
            { 780,   727}, -- Dogwood Log
            {2750,   750}, -- Silver Beastcoin
            {4600,   818}, -- Cotton Thread
            {5000,   852}, -- Lizard Skin
            {4990,   880}, -- Bone Chip
            {2650,   893}, -- Giant Femur
            {1730,   912}, -- Beehive Chip
            {1450,   925}, -- Giant Stinger
            {1060,  1225}, -- Gold Nugget
            {3610,  1845}, -- Red Moko Grass
            {1290,  1981}, -- Skull Locust
            { 230,  3307}, -- Heat Capacitor
            { 120,  3308}, -- Power Cooler
            { 150,  3309}, -- Barrage Turbine
            { 110,  3311}, -- Galvanizer
            { 205,  3312}, -- Percolator
            { 235,  3313}, -- Vivi-Valve
            { 155,  3314}, -- Disruptor
            {1830,  3434}, -- Cobalt Cell
            {1020,  3435}, -- Rubicund Cell
            { 840,  3436}, -- Xanthous Cell
            { 610,  3437}, -- Jade Cell
            {1130,  3450}, -- Voiddust
            {4830,  4117}, -- Hi-Potion +1
            {4690,  4118}, -- Hi-Potion +2
            {3650,  4119}, -- Hi-Potion +3
            {2700,  4121}, -- X-Potion +1
            {1500,  4123}, -- X-Potion +3
            {3880,  4133}, -- Hi-Ether +1
            {3410,  4134}, -- Hi-Ether +2
            {2640,  4135}, -- Hi-Ether +3
            {1430,  4141}, -- Pro-Ether +1
            { 920,  4143}, -- Pro-Ether +3
            { 510,  4145}, -- Elixir
            {2430,  4370}, -- Honey
            { 680,  5819}, -- Antlion Quiver
            { 300,  8555}, -- Barrier Module
            { 105, 12469}, -- War Beret
            { 210, 12725}, -- War Gloves
            {  80, 12853}, -- War Brais
            {  55, 12981}, -- War Boots
            {  95, 13212}, -- Tarutaru Sash
            {  25, 13467}, -- Dragon Ring
            {3810, 17316}, -- Bomb Arm
            {1070, 17894}, -- Vermihumus
        }
    },
    [tpz.zone.KORROLOKA_TUNNEL] =
    {
        regionalItems = {11039}, -- Brachyura Earring
        tempsLow =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {1060, 4112}, -- Potion
            { 740, 4113}, -- Potion +1
            { 700, 4114}, -- Potion +2
            { 800, 4128}, -- Ether
            { 430, 4129}, -- Ether +1
            {  50, 4130}, -- Ether +2
            { 900, 4145}, -- Elixer
            { 820, 4148}, -- Antidote
            { 730, 4150}, -- Eye Drops
            { 850, 4151}, -- Echo Drops
            { 650, 4155}, -- Remedy
            {1020, 4164}, -- Prism Powder
            { 940, 4165}, -- Silent Oil
            { 420, 4202}, -- Daedalus Wing
            { 250, 4300}, -- Apple Au Lait
            { 660, 4423}, -- Apple Juice
        },
        tempsHi =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            { 900, 4202}, -- Daedalus Wing
            { 500, 4206}, -- Catholicon
            { 300, 4255}, -- Mana Powder
            { 450, 5322}, -- Healing Powder
            { 320, 5393}, -- Monarch's Drink
            { 650, 5394}, -- Gnostic's Drink
            { 430, 5395}, -- Cleric's Drink
            {1000, 5433}, -- Dusty Elixir
            { 690, 5439}, -- Vicar's Drink
            { 250, 5440}, -- Dusty Wing
            {2000, 5824}, -- Lucid Potion I
            {1900, 5825}, -- Lucid Potion II
            {1200, 5826}, -- Lucid Potion III
            { 730, 5832}, -- Healing Mist
            { 420, 5833}, -- Mana Mist
            {1010, 5834}, -- Lucid Wings I
            { 875, 5835}, -- Healing Salve I
            { 210, 5836}, -- Healing Salve II
            { 920, 5837}, -- Clear Salve I
            { 190, 5838}, -- Clear Salve II
            { 310, 5839}, -- Stalwart's Tonic
            { 205, 5840}, -- Stalwart's Gambir
            { 410, 5841}, -- Ascetic's Tonic
            { 305, 5842}, -- Ascetic's Gambir
            { 310, 5843}, -- Champion's Tonic
            { 200, 5845}, -- Fanatic's Tonic
        },
        itemsLow =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {1450,   835}, -- Flax Flower
            { 800,   898}, -- Chicken Bone
            {2630,  1155}, -- Iron Sand
            {4790,   656}, -- Beastcoin
            {4600,   818}, -- Cotton Thread
            {5000,   852}, -- Lizard Skin
            {4990,   880}, -- Bone Chip
            {2650,   893}, -- Giant Femur
            {1730,   912}, -- Beehive Chip
            {1450,   925}, -- Giant Stinger
            {1060,  1225}, -- Gold Nugget
            {3610,  1845}, -- Red Moko Grass
            {4820,  4114}, -- Potion +2
            {4650,  4115}, -- Potion +3
            {4840,  4129}, -- Ether +1
            {4320,  4130}, -- Ether +2
            { 510,  4145}, -- Elixir
            {2430,  4370}, -- Honey
        },
        itemsHi =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            { 870,   746}, -- Platinum Ingot
            { 430,   835}, -- Flax Flower
            { 790,   898}, -- Chicken Bone
            {2400,  1155}, -- Iron Sand
            {2750,   750}, -- Silver Beastcoin
            {4600,   818}, -- Cotton Thread
            { 390,   838}, -- Spider Web
            {3500,   852}, -- Lizard Skin
            {4990,   880}, -- Bone Chip
            {2650,   893}, -- Giant Femur
            {1730,   912}, -- Beehive Chip
            {1450,   925}, -- Giant Stinger
            {1060,  1225}, -- Gold Nugget
            {3610,  1845}, -- Red Moko Grass
            {2950,  3437}, -- Jade Cell
            {5000,  4119}, -- Hi-Potion +3
            {4700,  4121}, -- X-Potion +1
            { 600,  4123}, -- X-Potion +3
            {4900,  4141}, -- Pro-Ether +1
            {2700,  4145}, -- Elixir
            {1650,  4155}, -- Remedy
            {1450,  4449}, -- Reishi Mushroom
            { 120, 12880}, -- Ogre Trousers
            { 110, 13704}, -- Ogre Mask
        }
    },
    [tpz.zone.KUFTAL_TUNNEL] =
    {
        regionalItems = {18816}, -- Wizzan Grip
        temps =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            { 900, 4202}, -- Daedalus Wing
            { 500, 4206}, -- Catholicon
            { 300, 4255}, -- Mana Powder
            { 450, 5322}, -- Healing Powder
            { 320, 5393}, -- Monarch's Drink
            { 650, 5394}, -- Gnostic's Drink
            { 430, 5395}, -- Cleric's Drink
            {1000, 5433}, -- Dusty Elixir
            { 690, 5439}, -- Vicar's Drink
            { 250, 5440}, -- Dusty Wing
            {2000, 5824}, -- Lucid Potion I
            {1900, 5825}, -- Lucid Potion II
            {1200, 5826}, -- Lucid Potion III
            { 730, 5832}, -- Healing Mist
            { 420, 5833}, -- Mana Mist
            {1010, 5834}, -- Lucid Wings I
            { 875, 5835}, -- Healing Salve I
            { 210, 5836}, -- Healing Salve II
            { 920, 5837}, -- Clear Salve I
            { 190, 5838}, -- Clear Salve II
            { 310, 5839}, -- Stalwart's Tonic
            { 205, 5840}, -- Stalwart's Gambir
            { 410, 5841}, -- Ascetic's Tonic
            { 305, 5842}, -- Ascetic's Gambir
            { 310, 5843}, -- Champion's Tonic
            { 200, 5845}, -- Fanatic's Tonic
        },
        items =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            { 610,   657}, -- Tama-Hagane
            { 590,   685}, -- Khroma Ore
            { 730,   876}, -- Manta Skin
            {1640,   919}, -- Boyahda Moss
            {1390,   838}, -- Spider Web
            {4500,   852}, -- Lizard Skin
            {4990,   880}, -- Bone Chip
            {1490,  1446}, -- Lacquer Tree Log
            { 250,  3307}, -- Heat Capacitor
            { 320,  3308}, -- Power Cooler
            { 410,  3309}, -- Barrage Turbine
            {1620,  3434}, -- Cobalt Cell
            {2430,  3435}, -- Rubicund Cell
            {1720,  3436}, -- Xanthous Cell
            {1290,  3437}, -- Jade Cell
            {5000,  4119}, -- Hi-Potion +3
            {3700,  4123}, -- X-Potion +3
            {4900,  4134}, -- Hi-Ether +2
            {2900,  4143}, -- Pro-Ether +3
            {1900,  4155}, -- Remedy
            { 980,  4173}, -- Hi-Reraiser
            { 670,  4174}, -- Vile Elixir
            { 320,  4175}, -- Vile Elixir +1
            {1760,  4291}, -- Sandfish
            { 500,  4447}, -- Scream Fungus
            { 630,  5866}, -- Toolbag (Moku)
            { 420,  5872}, -- D.A. Bolt Quiver
        }
    },
    [tpz.zone.SEA_SERPENT_GROTTO] =
    {
        regionalItems = {19780}, -- Mana Ampulla
        temps =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {1060, 4117}, -- Hi-Potion +1
            { 700, 4118}, -- Hi-Potion +2
            { 230, 4119}, -- Hi-Potion +3
            {1020, 4133}, -- Hi-Ether +1
            { 800, 4134}, -- Hi-Ether +2
            { 240, 4135}, -- Hi-Ether +3
            { 900, 4145}, -- Elixir
            { 820, 4148}, -- Antidote
            { 730, 4150}, -- Eye Drops
            { 850, 4151}, -- Echo Drops
            { 650, 4155}, -- Remedy
            {1020, 4164}, -- Prism Powder
            { 940, 4165}, -- Silent Oil
            { 420, 4202}, -- Daedalus Wing
            { 220, 4206}, -- Catholicon
            { 430, 4302}, -- Pamama au Lait
            { 620, 4424}, -- Melon Juice
        },
        items =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            { 230,   645}, -- Darksteel Ore
            { 850,   702}, -- Ebony Log
            { 560,   737}, -- Gold Ore
            { 520,   823}, -- Gold Thread
            { 840,   843}, -- G. Bird Plume
            {1250,   844}, -- Phoenix Feather
            {2500,  1155}, -- Iron Sand
            {1900,  1213}, -- Dst. Bolt Heads
            {2100,  1443}, -- Dried Mugwort
            { 210,  3314}, -- Disruptor
            {1700,  3434}, -- Cobalt Cell
            { 650,  3435}, -- Rubicund Cell
            {1230,  3437}, -- Jade Cell
            {3100,  3450}, -- Voiddust
            {5000,  4117}, -- Hi-Potion +1
            {4400,  4120}, -- X-Potion
            { 600,  4121}, -- X-Potion +1
            {4800,  4133}, -- Hi-Ether +1
            { 790,  4141}, -- Pro-Ether +1
            { 310,  4449}, -- Reishi Mushroom
            { 430,  5164}, -- Ground Wasabi
            { 440, 12427}, -- Bascinet
            { 365, 12683}, -- Darksteel Mufflers
            { 295, 12811}, -- Dst. Breeches
            { 345, 12868}, -- Silk Slacks
            { 290, 12996}, -- Silk Pumps
            { 525, 13702}, -- Beak Ledelsens
        }
    },
    [tpz.zone.VELUGANNON_PALACE] =
    {
        regionalItems = {13467, 10954}, -- Dragon Ring | Alchemist's Torque
        temps =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {2000, 4119}, -- Hi-Potion +3
            {1500, 4120}, -- X-Potion
            { 800, 4121}, -- X-Potion +1
            {1900, 4135}, -- Hi-Ether +3
            { 600, 4136}, -- Super Ether
            { 420, 4137}, -- Super Ether +1
            { 540, 4144}, -- Hi-Elixir
            {1300, 4145}, -- Elixir
            {  60, 4149}, -- Panacea
            { 980, 4155}, -- Remedy
            {1670, 4202}, -- Daedalus Wing
            { 670, 4206}, -- Catholicon
            { 760, 4210}, -- Lethe Water
            { 680, 4255}, -- Mana Powder
            { 450, 4302}, -- Pamama au Lait
            { 765, 4424}, -- Melon Juice
            { 340, 5322}, -- Healing Powder
        },
        items =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {3760,   505}, -- Sheepskin
            {3450,   626}, -- Black Pepper
            { 480,   679}, -- Aluminum Ingot
            {1560,   714}, -- Holly Lumber
            { 780,   727}, -- Dogwood Log
            {2750,   750}, -- Silver Beastcoin
            {4600,   818}, -- Cotton Thread
            {5000,   852}, -- Lizard Skin
            {4990,   880}, -- Bone Chip
            {2650,   893}, -- Giant Femur
            {1730,   912}, -- Beehive Chip
            {1450,   925}, -- Giant Stinger
            {1060,  1225}, -- Gold Nugget
            {3610,  1845}, -- Red Moko Grass
            {1290,  1981}, -- Skull Locust
            { 230,  3307}, -- Heat Capacitor
            { 120,  3308}, -- Power Cooler
            { 150,  3309}, -- Barrage Turbine
            { 110,  3311}, -- Galvanizer
            { 205,  3312}, -- Percolator
            { 235,  3313}, -- Vivi-Valve
            { 155,  3314}, -- Disruptor
            {1830,  3434}, -- Cobalt Cell
            {1020,  3435}, -- Rubicund Cell
            { 840,  3436}, -- Xanthous Cell
            { 610,  3437}, -- Jade Cell
            {1130,  3450}, -- Voiddust
            {4830,  4117}, -- Hi-Potion +1
            {4690,  4118}, -- Hi-Potion +2
            {3650,  4119}, -- Hi-Potion +3
            {2700,  4121}, -- X-Potion +1
            {1500,  4123}, -- X-Potion +3
            {3880,  4133}, -- Hi-Ether +1
            {3410,  4134}, -- Hi-Ether +2
            {2640,  4135}, -- Hi-Ether +3
            {1430,  4141}, -- Pro-Ether +1
            { 920,  4143}, -- Pro-Ether +3
            { 510,  4145}, -- Elixir
            {2430,  4370}, -- Honey
            { 680,  5819}, -- Antlion Quiver
            { 300,  8555}, -- Barrier Module
            { 105, 12469}, -- War Beret
            { 210, 12725}, -- War Gloves
            {  80, 12853}, -- War Brais
            {  55, 12981}, -- War Boots
            {3810, 17316}, -- Bomb Arm
            {1070, 17894}, -- Vermihumus
        }
    },
    [tpz.zone.THE_SHRINE_OF_RUAVITAU] =
    {
        regionalItems = {11040, 10951}, -- Terminus Earring | Weaver's Torque
        temps =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            { 900, 4202}, -- Daedalus Wing
            { 500, 4206}, -- Catholicon
            { 300, 4255}, -- Mana Powder
            { 450, 5322}, -- Healing Powder
            { 320, 5393}, -- Monarch's Drink
            { 650, 5394}, -- Gnostic's Drink
            { 430, 5395}, -- Cleric's Drink
            {1000, 5433}, -- Dusty Elixir
            { 690, 5439}, -- Vicar's Drink
            { 250, 5440}, -- Dusty Wing
            {2000, 5824}, -- Lucid Potion I
            {1900, 5825}, -- Lucid Potion II
            {1200, 5826}, -- Lucid Potion III
            { 730, 5832}, -- Healing Mist
            { 420, 5833}, -- Mana Mist
            {1010, 5834}, -- Lucid Wings I
            { 875, 5835}, -- Healing Salve I
            { 210, 5836}, -- Healing Salve II
            { 920, 5837}, -- Clear Salve I
            { 190, 5838}, -- Clear Salve II
            { 310, 5839}, -- Stalwart's Tonic
            { 205, 5840}, -- Stalwart's Gambir
            { 410, 5841}, -- Ascetic's Tonic
            { 305, 5842}, -- Ascetic's Gambir
            { 310, 5843}, -- Champion's Tonic
            { 200, 5845}, -- Fanatic's Tonic
        },
        items =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            { 390,   657}, -- Tama-Hagane
            { 745,   876}, -- Manta Skin
            { 250,   887}, -- Coral Fragment
            {3700,   919}, -- Boyahda Moss
            {4500,  1163}, -- Manticore Hair
            {1025,  1446}, -- Lacquer Tree Log
            { 450,  3313}, -- Vivi-Valve
            { 700,  3434}, -- Cobalt Cell
            {1600,  3435}, -- Rubicund Cell
            {2060,  3436}, -- Xanthous Cell
            {2050,  3437}, -- Jade Cell
            {1500,  3450}, -- Voiddust
            {5000,  4119}, -- Hi-Potion +3
            {4200,  4120}, -- X-Potion
            {3500,  4121}, -- X-Potion +1
            {3000,  4122}, -- X-Potion +2
            {4900,  4135}, -- Hi-Ether +3
            {2700,  4143}, -- Pro-Ether +3
            { 600,  4155}, -- Remedy
            {1200,  4173}, -- Hi-Reraiser
            { 900,  4174}, -- Vile Elixir
            {1200,  4291}, -- Sandfish
            {1700,  4447}, -- Scream Fungus
            { 650,  5866}, -- Toolbag (Moku)
            {1050,  5871}, -- Ruszor Quiver
            {2050, 17881}, -- Deepbed Soil
            {1020, 17884}, -- Sun Water
            { 500, 17898}, -- C. Grass. Broth
            { 400, 17899}, -- Svg. Mole Broth
        }
    },
    [tpz.zone.LOWER_DELKFUTTS_TOWER] =
    {
        regionalItems = {11043}, -- Giant's Earring
        temps =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {1060, 4117}, -- Hi-Potion +1
            { 700, 4118}, -- Hi-Potion +2
            { 230, 4119}, -- Hi-Potion +3
            {1020, 4133}, -- Hi-Ether +1
            { 800, 4134}, -- Hi-Ether +2
            { 240, 4135}, -- Hi-Ether +3
            { 900, 4145}, -- Elixir
            { 820, 4148}, -- Antidote
            { 730, 4150}, -- Eye Drops
            { 850, 4151}, -- Echo Drops
            { 650, 4155}, -- Remedy
            {1020, 4164}, -- Prism Powder
            { 940, 4165}, -- Silent Oil
            { 420, 4202}, -- Daedalus Wing
            { 220, 4206}, -- Catholicon
            { 430, 4302}, -- Pamama au Lait
            { 620, 4424}, -- Melon Juice
        },
        items =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {2750,   574}, -- Fruit Seeds
            {3600,   633}, -- Olive Oil
            {3250,   651}, -- Iron Ingot
            {1200,   653}, -- Mythril Ingot
            {1420,   691}, -- Maple Log
            { 760,   822}, -- Silver Thread
            {1350,   943}, -- Poison Dust
            {2700,  1212}, -- Mtl. Bolt Heads x33
            { 500,  3435}, -- Rubicund Cell
            { 510,  3436}, -- Xanthous Cell
            {4800,  4114}, -- Potion +2
            {3200,  4115}, -- Potion +3
            {5000,  4129}, -- Ether +1
            {3800,  4130}, -- Ether +2
            { 245,  8555}, -- Barrier Module
            { 460, 12458}, -- Soil Hachimaki
            { 740, 12698}, -- Studded Gloves
            { 530, 12714}, -- Soil Tekko
            { 360, 12730}, -- Wool Cuffs
            { 290, 12826}, -- Studded Trousers
            {1200, 12842}, -- Soil Sitabaki
            { 400, 12858}, -- Wool Slops
            { 200, 12954}, -- Studded Boots
            { 190, 12970}, -- Soil Kyahan
            { 390, 12986}, -- Chestnut Sabots
        }
    },
    [tpz.zone.KING_RANPERRES_TOMB] =
    {
        regionalItems = {10924}, -- Chocobo Torque
        tempsLow =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {1060, 4112}, -- Potion
            { 740, 4113}, -- Potion +1
            { 700, 4114}, -- Potion +2
            { 800, 4128}, -- Ether
            { 430, 4129}, -- Ether +1
            {  50, 4130}, -- Ether +2
            { 900, 4145}, -- Elixer
            { 820, 4148}, -- Antidote
            { 730, 4150}, -- Eye Drops
            { 850, 4151}, -- Echo Drops
            { 650, 4155}, -- Remedy
            {1020, 4164}, -- Prism Powder
            { 940, 4165}, -- Silent Oil
            { 420, 4202}, -- Daedalus Wing
            { 250, 4300}, -- Apple Au Lait
            { 660, 4423}, -- Apple Juice
        },
        tempsHi =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            { 900, 4202}, -- Daedalus Wing
            { 500, 4206}, -- Catholicon
            { 300, 4255}, -- Mana Powder
            { 450, 5322}, -- Healing Powder
            { 320, 5393}, -- Monarch's Drink
            { 650, 5394}, -- Gnostic's Drink
            { 430, 5395}, -- Cleric's Drink
            {1000, 5433}, -- Dusty Elixir
            { 690, 5439}, -- Vicar's Drink
            { 250, 5440}, -- Dusty Wing
            {2000, 5824}, -- Lucid Potion I
            {1900, 5825}, -- Lucid Potion II
            {1200, 5826}, -- Lucid Potion III
            { 730, 5832}, -- Healing Mist
            { 420, 5833}, -- Mana Mist
            {1010, 5834}, -- Lucid Wings I
            { 875, 5835}, -- Healing Salve I
            { 210, 5836}, -- Healing Salve II
            { 920, 5837}, -- Clear Salve I
            { 190, 5838}, -- Clear Salve II
            { 310, 5839}, -- Stalwart's Tonic
            { 205, 5840}, -- Stalwart's Gambir
            { 410, 5841}, -- Ascetic's Tonic
            { 305, 5842}, -- Ascetic's Gambir
            { 310, 5843}, -- Champion's Tonic
            { 200, 5845}, -- Fanatic's Tonic
        },
        itemsLow =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {3760,   505}, -- Sheepskin
            {3450,   626}, -- Black Pepper
            { 800,   898}, -- Chicken Bone
            {1560,   714}, -- Holly Lumber
            {4790,   656}, -- Beastcoin
            {4600,   818}, -- Cotton Thread
            {5000,   852}, -- Lizard Skin
            {4990,   880}, -- Bone Chip
            {2650,   893}, -- Giant Femur
            {1730,   912}, -- Beehive Chip
            {1450,   925}, -- Giant Stinger
            {1060,  1225}, -- Gold Nugget
            {3610,  1845}, -- Red Moko Grass
            {4820,  4114}, -- Potion +2
            {4650,  4115}, -- Potion +3
            {4840,  4129}, -- Ether +1
            {4320,  4130}, -- Ether +2
            { 510,  4145}, -- Elixir
            {2430,  4370}, -- Honey
        },
        itemsHi =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {3760,   505}, -- Sheepskin
            {3450,   626}, -- Black Pepper
            { 480,   679}, -- Aluminum Ingot
            {1560,   714}, -- Holly Lumber
            { 780,   727}, -- Dogwood Log
            {2750,   750}, -- Silver Beastcoin
            {4600,   818}, -- Cotton Thread
            {5000,   852}, -- Lizard Skin
            {4990,   880}, -- Bone Chip
            {2650,   893}, -- Giant Femur
            {1730,   912}, -- Beehive Chip
            {1450,   925}, -- Giant Stinger
            {1060,  1225}, -- Gold Nugget
            {3610,  1845}, -- Red Moko Grass
            {1290,  1981}, -- Skull Locust
            {1830,  3434}, -- Cobalt Cell
            {1020,  3435}, -- Rubicund Cell
            { 840,  3436}, -- Xanthous Cell
            { 610,  3437}, -- Jade Cell
            {1130,  3450}, -- Voiddust
            {4830,  4117}, -- Hi-Potion +1
            {4690,  4118}, -- Hi-Potion +2
            {3650,  4119}, -- Hi-Potion +3
            {2700,  4121}, -- X-Potion +1
            {1500,  4123}, -- X-Potion +3
            {3880,  4133}, -- Hi-Ether +1
            {3410,  4134}, -- Hi-Ether +2
            {2640,  4135}, -- Hi-Ether +3
            {1430,  4141}, -- Pro-Ether +1
            { 920,  4143}, -- Pro-Ether +3
            { 510,  4145}, -- Elixir
            {2430,  4370}, -- Honey
            { 680,  5819}, -- Antlion Quiver
            { 300,  8555}, -- Barrier Module
            { 105, 12469}, -- War Beret
            { 210, 12725}, -- War Gloves
            {  80, 12853}, -- War Brais
            {  55, 12981}, -- War Boots
            {3810, 17316}, -- Bomb Arm
        }
    },
    [tpz.zone.DANGRUF_WADI] =
    {
        regionalItems = {11769}, -- Field Rope
        tempsLow =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {1060, 4112}, -- Potion
            { 740, 4113}, -- Potion +1
            { 700, 4114}, -- Potion +2
            { 800, 4128}, -- Ether
            { 430, 4129}, -- Ether +1
            {  50, 4130}, -- Ether +2
            { 900, 4145}, -- Elixer
            { 820, 4148}, -- Antidote
            { 730, 4150}, -- Eye Drops
            { 850, 4151}, -- Echo Drops
            { 650, 4155}, -- Remedy
            {1020, 4164}, -- Prism Powder
            { 940, 4165}, -- Silent Oil
            { 420, 4202}, -- Daedalus Wing
            { 250, 4300}, -- Apple Au Lait
            { 660, 4423}, -- Apple Juice
        },
        tempsHi =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            { 900, 4202}, -- Daedalus Wing
            { 500, 4206}, -- Catholicon
            { 300, 4255}, -- Mana Powder
            { 450, 5322}, -- Healing Powder
            { 320, 5393}, -- Monarch's Drink
            { 650, 5394}, -- Gnostic's Drink
            { 430, 5395}, -- Cleric's Drink
            {1000, 5433}, -- Dusty Elixir
            { 690, 5439}, -- Vicar's Drink
            { 250, 5440}, -- Dusty Wing
            {2000, 5824}, -- Lucid Potion I
            {1900, 5825}, -- Lucid Potion II
            {1200, 5826}, -- Lucid Potion III
            { 730, 5832}, -- Healing Mist
            { 420, 5833}, -- Mana Mist
            {1010, 5834}, -- Lucid Wings I
            { 875, 5835}, -- Healing Salve I
            { 210, 5836}, -- Healing Salve II
            { 920, 5837}, -- Clear Salve I
            { 190, 5838}, -- Clear Salve II
            { 310, 5839}, -- Stalwart's Tonic
            { 205, 5840}, -- Stalwart's Gambir
            { 410, 5841}, -- Ascetic's Tonic
            { 305, 5842}, -- Ascetic's Gambir
            { 310, 5843}, -- Champion's Tonic
            { 200, 5845}, -- Fanatic's Tonic
        },
        itemsLow =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {1450,   835}, -- Flax Flower
            { 800,   898}, -- Chicken Bone
            {2630,  1155}, -- Iron Sand
            {4790,   656}, -- Beastcoin
            {4600,   818}, -- Cotton Thread
            {5000,   852}, -- Lizard Skin
            {4990,   880}, -- Bone Chip
            {2650,   893}, -- Giant Femur
            {1730,   912}, -- Beehive Chip
            {1450,   925}, -- Giant Stinger
            {1060,  1225}, -- Gold Nugget
            {3610,  1845}, -- Red Moko Grass
            {4820,  4114}, -- Potion +2
            {4650,  4115}, -- Potion +3
            {4840,  4129}, -- Ether +1
            {4320,  4130}, -- Ether +2
            { 510,  4145}, -- Elixir
            {2430,  4370}, -- Honey
        },
        itemsHi =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {2700,   646}, -- Adaman Ore
            { 920,   653}, -- Mythril Ingot
            {2100,   690}, -- Elm Log
            {1540,   694}, -- Chestnut Log
            {2160,   749}, -- Mtl. Beastcoin
            {1760,   940}, -- Revival Root
            {2300,   943}, -- Poison Dust
            {1090,  3311}, -- Galvanizer
            { 650,  3434}, -- Cobalt Cell
            { 980,  3435}, -- Rubicund Cell
            {1465,  3436}, -- Xanthous Cell
            {1050,  3437}, -- Jade Cell
            {1940,  3450}, -- Voiddust
            {5000,  4119}, -- Hi-Potion +3
            {2500,  4123}, -- X-Potion +3
            {4900,  4133}, -- Hi-Ether +1
            {3600,  4134}, -- Hi-Ether +2
            {2120,  4135}, -- Hi-Ether +3
            { 795,  4155}, -- Remedy
            { 245, 12437}, -- Gavial Mask
        }
    },
    [tpz.zone.INNER_HORUTOTO_RUINS] =
    {
        regionalItems = {18624}, -- Numen Staff
        temps =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            { 900, 4202}, -- Daedalus Wing
            { 500, 4206}, -- Catholicon
            { 300, 4255}, -- Mana Powder
            { 450, 5322}, -- Healing Powder
            { 320, 5393}, -- Monarch's Drink
            { 650, 5394}, -- Gnostic's Drink
            { 430, 5395}, -- Cleric's Drink
            {1000, 5433}, -- Dusty Elixir
            { 690, 5439}, -- Vicar's Drink
            { 250, 5440}, -- Dusty Wing
            {2000, 5824}, -- Lucid Potion I
            {1900, 5825}, -- Lucid Potion II
            {1200, 5826}, -- Lucid Potion III
            { 730, 5832}, -- Healing Mist
            { 420, 5833}, -- Mana Mist
            {1010, 5834}, -- Lucid Wings I
            { 875, 5835}, -- Healing Salve I
            { 210, 5836}, -- Healing Salve II
            { 920, 5837}, -- Clear Salve I
            { 190, 5838}, -- Clear Salve II
            { 310, 5839}, -- Stalwart's Tonic
            { 205, 5840}, -- Stalwart's Gambir
            { 410, 5841}, -- Ascetic's Tonic
            { 305, 5842}, -- Ascetic's Gambir
            { 310, 5843}, -- Champion's Tonic
            { 200, 5845}, -- Fanatic's Tonic
        },
        items =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {3760,   505}, -- Sheepskin
            {3450,   626}, -- Black Pepper
            { 480,   679}, -- Aluminum Ingot
            {1560,   714}, -- Holly Lumber
            { 780,   727}, -- Dogwood Log
            {2750,   750}, -- Silver Beastcoin
            {4600,   818}, -- Cotton Thread
            {5000,   852}, -- Lizard Skin
            {4990,   880}, -- Bone Chip
            {2650,   893}, -- Giant Femur
            {1730,   912}, -- Beehive Chip
            {1450,   925}, -- Giant Stinger
            {1060,  1225}, -- Gold Nugget
            {3610,  1845}, -- Red Moko Grass
            {1290,  1981}, -- Skull Locust
            {1830,  3434}, -- Cobalt Cell
            {1020,  3435}, -- Rubicund Cell
            { 840,  3436}, -- Xanthous Cell
            { 610,  3437}, -- Jade Cell
            {1130,  3450}, -- Voiddust
            {4830,  4117}, -- Hi-Potion +1
            {4690,  4118}, -- Hi-Potion +2
            {3650,  4119}, -- Hi-Potion +3
            {2700,  4121}, -- X-Potion +1
            {1500,  4123}, -- X-Potion +3
            {3880,  4133}, -- Hi-Ether +1
            {3410,  4134}, -- Hi-Ether +2
            {2640,  4135}, -- Hi-Ether +3
            {1430,  4141}, -- Pro-Ether +1
            { 920,  4143}, -- Pro-Ether +3
            { 510,  4145}, -- Elixir
            {2430,  4370}, -- Honey
            { 680,  5819}, -- Antlion Quiver
            { 300,  8555}, -- Barrier Module
            { 105, 12469}, -- War Beret
            { 210, 12725}, -- War Gloves
            {  80, 12853}, -- War Brais
            {  55, 12981}, -- War Boots
            {3810, 17316}, -- Bomb Arm
        }
    },
    [tpz.zone.ORDELLES_CAVES] =
    {
        regionalItems = {11767}, -- Chocobo Rope
        tempsLow =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {1060, 4112}, -- Potion
            { 740, 4113}, -- Potion +1
            { 700, 4114}, -- Potion +2
            { 800, 4128}, -- Ether
            { 430, 4129}, -- Ether +1
            {  50, 4130}, -- Ether +2
            { 900, 4145}, -- Elixer
            { 820, 4148}, -- Antidote
            { 730, 4150}, -- Eye Drops
            { 850, 4151}, -- Echo Drops
            { 650, 4155}, -- Remedy
            {1020, 4164}, -- Prism Powder
            { 940, 4165}, -- Silent Oil
            { 420, 4202}, -- Daedalus Wing
            { 250, 4300}, -- Apple Au Lait
            { 660, 4423}, -- Apple Juice
        },
        tempsHi =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            { 900, 4202}, -- Daedalus Wing
            { 500, 4206}, -- Catholicon
            { 300, 4255}, -- Mana Powder
            { 450, 5322}, -- Healing Powder
            { 320, 5393}, -- Monarch's Drink
            { 650, 5394}, -- Gnostic's Drink
            { 430, 5395}, -- Cleric's Drink
            {1000, 5433}, -- Dusty Elixir
            { 690, 5439}, -- Vicar's Drink
            { 250, 5440}, -- Dusty Wing
            {2000, 5824}, -- Lucid Potion I
            {1900, 5825}, -- Lucid Potion II
            {1200, 5826}, -- Lucid Potion III
            { 730, 5832}, -- Healing Mist
            { 420, 5833}, -- Mana Mist
            {1010, 5834}, -- Lucid Wings I
            { 875, 5835}, -- Healing Salve I
            { 210, 5836}, -- Healing Salve II
            { 920, 5837}, -- Clear Salve I
            { 190, 5838}, -- Clear Salve II
            { 310, 5839}, -- Stalwart's Tonic
            { 205, 5840}, -- Stalwart's Gambir
            { 410, 5841}, -- Ascetic's Tonic
            { 305, 5842}, -- Ascetic's Gambir
            { 310, 5843}, -- Champion's Tonic
            { 200, 5845}, -- Fanatic's Tonic
        },
        itemsLow =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {1450,  835}, -- Flax Flower
            { 800,  898}, -- Chicken Bone
            {2630, 1155}, -- Iron Sand
            {4790,  656}, -- Beastcoin
            {4600,  818}, -- Cotton Thread
            {5000,  852}, -- Lizard Skin
            {4990,  880}, -- Bone Chip
            {2650,  893}, -- Giant Femur
            {1730,  912}, -- Beehive Chip
            {1450,  925}, -- Giant Stinger
            {1060, 1225}, -- Gold Nugget
            {3610, 1845}, -- Red Moko Grass
            {4820, 4114}, -- Potion +2
            {4650, 4115}, -- Potion +3
            {4840, 4129}, -- Ether +1
            {4320, 4130}, -- Ether +2
            { 510, 4145}, -- Elixir
            {2430, 4370}, -- Honey
        },
        itemsHi =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            { 425,   702}, -- Ebony Log
            { 870,   746}, -- Platinum Ingot
            { 430,   835}, -- Flax Flower
            { 790,   898}, -- Chicken Bone
            {2400,   857}, -- Dhalmel Hide
            {2750,   750}, -- Silver Beastcoin
            {4600,   818}, -- Cotton Thread
            { 390,   838}, -- Spider Web
            {3500,   852}, -- Lizard Skin
            {4990,   880}, -- Bone Chip
            {2650,   893}, -- Giant Femur
            {1730,   912}, -- Beehive Chip
            { 365,   913}, -- Beeswax
            {1450,   925}, -- Giant Stinger
            {1060,  1225}, -- Gold Nugget
            { 210,  1229}, -- Adaman Nugget
            {3610,  1845}, -- Red Moko Grass
            { 205,  3311}, -- Galvanizer
            { 725,  3313}, -- Vivi-Valve
            { 610,  3435}, -- Rubicund Cell
            { 930,  3436}, -- Xanthous Cell
            {2950,  3437}, -- Jade Cell
            {2105,  3450}, -- Voiddust
            {5000,  4119}, -- Hi-Potion +3
            {4700,  4121}, -- X-Potion +1
            { 600,  4123}, -- X-Potion +3
            {4900,  4141}, -- Pro-Ether +1
            {2700,  4145}, -- Elixir
            {1650,  4155}, -- Remedy
            {1450,  4449}, -- Reishi Mushroom
            { 795,  5416}, -- Stl. Bull. Pouch
            { 120, 12880}, -- Ogre Trousers
            { 425, 13587}, -- Rainbow Cape
            { 110, 13704}, -- Ogre Mask
            { 215, 13706}, -- Ogre Gloves
            { 150, 13708}, -- Ogre Ledelsens
        }
    },
    [tpz.zone.OUTER_HORUTOTO_RUINS] =
    {
        regionalItems = {10925}, -- Fisher's Torque
        tempsLow =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {1060, 4112}, -- Potion
            { 740, 4113}, -- Potion +1
            { 700, 4114}, -- Potion +2
            { 800, 4128}, -- Ether
            { 430, 4129}, -- Ether +1
            {  50, 4130}, -- Ether +2
            { 900, 4145}, -- Elixer
            { 820, 4148}, -- Antidote
            { 730, 4150}, -- Eye Drops
            { 850, 4151}, -- Echo Drops
            { 650, 4155}, -- Remedy
            {1020, 4164}, -- Prism Powder
            { 940, 4165}, -- Silent Oil
            { 420, 4202}, -- Daedalus Wing
            { 250, 4300}, -- Apple Au Lait
            { 660, 4423}, -- Apple Juice
        },
        tempsHi =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            { 900, 4202}, -- Daedalus Wing
            { 500, 4206}, -- Catholicon
            { 300, 4255}, -- Mana Powder
            { 450, 5322}, -- Healing Powder
            { 320, 5393}, -- Monarch's Drink
            { 650, 5394}, -- Gnostic's Drink
            { 430, 5395}, -- Cleric's Drink
            {1000, 5433}, -- Dusty Elixir
            { 690, 5439}, -- Vicar's Drink
            { 250, 5440}, -- Dusty Wing
            {2000, 5824}, -- Lucid Potion I
            {1900, 5825}, -- Lucid Potion II
            {1200, 5826}, -- Lucid Potion III
            { 730, 5832}, -- Healing Mist
            { 420, 5833}, -- Mana Mist
            {1010, 5834}, -- Lucid Wings I
            { 875, 5835}, -- Healing Salve I
            { 210, 5836}, -- Healing Salve II
            { 920, 5837}, -- Clear Salve I
            { 190, 5838}, -- Clear Salve II
            { 310, 5839}, -- Stalwart's Tonic
            { 205, 5840}, -- Stalwart's Gambir
            { 410, 5841}, -- Ascetic's Tonic
            { 305, 5842}, -- Ascetic's Gambir
            { 310, 5843}, -- Champion's Tonic
            { 200, 5845}, -- Fanatic's Tonic
        },
        itemsLow =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {3760,  505}, -- Sheepskin
            {3450,  626}, -- Black Pepper
            {4790,  656}, -- Beastcoin
            {4600,  818}, -- Cotton Thread
            {5000,  852}, -- Lizard Skin
            {4990,  880}, -- Bone Chip
            {2650,  893}, -- Giant Femur
            {1730,  912}, -- Beehive Chip
            {1450,  925}, -- Giant Stinger
            {1060, 1225}, -- Gold Nugget
            {3610, 1845}, -- Red Moko Grass
            {4820, 4114}, -- Potion +2
            {4650, 4115}, -- Potion +3
            {4840, 4129}, -- Ether +1
            {4320, 4130}, -- Ether +2
            { 510, 4145}, -- Elixir
            {2430, 4370}, -- Honey
        },
        itemsHi =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {3760,   505}, -- Sheepskin
            {3450,   626}, -- Black Pepper
            { 480,   679}, -- Aluminum Ingot
            {1560,   714}, -- Holly Lumber
            { 780,   727}, -- Dogwood Log
            {2750,   750}, -- Silver Beastcoin
            {4600,   818}, -- Cotton Thread
            {5000,   852}, -- Lizard Skin
            {4990,   880}, -- Bone Chip
            {2650,   893}, -- Giant Femur
            {1730,   912}, -- Beehive Chip
            {1450,   925}, -- Giant Stinger
            {1060,  1225}, -- Gold Nugget
            {3610,  1845}, -- Red Moko Grass
            {1290,  1981}, -- Skull Locust
            { 230,  3307}, -- Heat Capacitor
            { 120,  3308}, -- Power Cooler
            { 150,  3309}, -- Barrage Turbine
            { 110,  3311}, -- Galvanizer
            { 205,  3312}, -- Percolator
            { 235,  3313}, -- Vivi-Valve
            { 155,  3314}, -- Disruptor
            {1830,  3434}, -- Cobalt Cell
            {1020,  3435}, -- Rubicund Cell
            { 840,  3436}, -- Xanthous Cell
            { 610,  3437}, -- Jade Cell
            {1130,  3450}, -- Voiddust
            {4830,  4117}, -- Hi-Potion +1
            {4690,  4118}, -- Hi-Potion +2
            {3650,  4119}, -- Hi-Potion +3
            {2700,  4121}, -- X-Potion +1
            {1500,  4123}, -- X-Potion +3
            {3880,  4133}, -- Hi-Ether +1
            {3410,  4134}, -- Hi-Ether +2
            {2640,  4135}, -- Hi-Ether +3
            {1430,  4141}, -- Pro-Ether +1
            { 920,  4143}, -- Pro-Ether +3
            { 510,  4145}, -- Elixir
            {2430,  4370}, -- Honey
            { 680,  5819}, -- Antlion Quiver
            { 300,  8555}, -- Barrier Module
            { 105, 12469}, -- War Beret
            { 210, 12725}, -- War Gloves
            {  80, 12853}, -- War Brais
            {  55, 12981}, -- War Boots
            {  95, 13212}, -- Tarutaru Sash
            {  25, 13467}, -- Dragon Ring
            {3810, 17316}, -- Bomb Arm
            {1070, 17894}, -- Vermihumus
        }
    },
    [tpz.zone.THE_ELDIEME_NECROPOLIS] =
    {
        regionalItems = {18812}, -- Ossa Grip
        temps =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            { 900, 4202}, -- Daedalus Wing
            { 500, 4206}, -- Catholicon
            { 300, 4255}, -- Mana Powder
            { 450, 5322}, -- Healing Powder
            { 320, 5393}, -- Monarch's Drink
            { 650, 5394}, -- Gnostic's Drink
            { 430, 5395}, -- Cleric's Drink
            {1000, 5433}, -- Dusty Elixir
            { 690, 5439}, -- Vicar's Drink
            { 250, 5440}, -- Dusty Wing
            {2000, 5824}, -- Lucid Potion I
            {1900, 5825}, -- Lucid Potion II
            {1200, 5826}, -- Lucid Potion III
            { 730, 5832}, -- Healing Mist
            { 420, 5833}, -- Mana Mist
            {1010, 5834}, -- Lucid Wings I
            { 875, 5835}, -- Healing Salve I
            { 210, 5836}, -- Healing Salve II
            { 920, 5837}, -- Clear Salve I
            { 190, 5838}, -- Clear Salve II
            { 310, 5839}, -- Stalwart's Tonic
            { 205, 5840}, -- Stalwart's Gambir
            { 410, 5841}, -- Ascetic's Tonic
            { 305, 5842}, -- Ascetic's Gambir
            { 310, 5843}, -- Champion's Tonic
            { 200, 5845}, -- Fanatic's Tonic
        },
        items =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {3000,   574}, -- Fruit Seeds
            {1760,   633}, -- Olive Oil
            { 390,   646}, -- Adaman Ore
            {2650,   694}, -- Chestnut Log
            {3150,   749}, -- Mtl. Beastcoin
            {3200,   859}, -- Ram Skin
            {2570,   895}, -- Ram Horn
            { 765,   943}, -- Poison Dust
            { 235,  3309}, -- Barrage Turbine
            { 490,  3434}, -- Cobalt Cell
            { 655,  3436}, -- Xanthous Cell
            {1490,  3437}, -- Jade Cell
            {1760,  3450}, -- Voiddust
            {5000,  4117}, -- Hi-Potion +1
            {2700,  4119}, -- Hi-Potion +3
            {1050,  4121}, -- X-Potion +1
            { 450,  4123}, -- X-Potion +3
            {4900,  4143}, -- Pro-Ether +3
            { 650,  4144}, -- Hi-Elixir
            { 230, 12437}, -- Gavial Mask
            { 210, 12693}, -- Gavial Fng. Gnt.
            { 110, 16396}, -- Koenigs Knuckles
            {  90, 17364}, -- Cythara Anglica
            {2570, 17898}, -- C. Grass. Broth
            {3100, 18259}, -- Angon
        }
    },
    [tpz.zone.GUSGEN_MINES] =
    {
        regionalItems = {10926}, -- Field Torque
        tempsLow =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {1060, 4112}, -- Potion
            { 740, 4113}, -- Potion +1
            { 700, 4114}, -- Potion +2
            { 800, 4128}, -- Ether
            { 430, 4129}, -- Ether +1
            {  50, 4130}, -- Ether +2
            { 900, 4145}, -- Elixer
            { 820, 4148}, -- Antidote
            { 730, 4150}, -- Eye Drops
            { 850, 4151}, -- Echo Drops
            { 650, 4155}, -- Remedy
            {1020, 4164}, -- Prism Powder
            { 940, 4165}, -- Silent Oil
            { 420, 4202}, -- Daedalus Wing
            { 250, 4300}, -- Apple Au Lait
            { 660, 4423}, -- Apple Juice
        },
        tempsHi =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            { 900, 4202}, -- Daedalus Wing
            { 500, 4206}, -- Catholicon
            { 300, 4255}, -- Mana Powder
            { 450, 5322}, -- Healing Powder
            { 320, 5393}, -- Monarch's Drink
            { 650, 5394}, -- Gnostic's Drink
            { 430, 5395}, -- Cleric's Drink
            {1000, 5433}, -- Dusty Elixir
            { 690, 5439}, -- Vicar's Drink
            { 250, 5440}, -- Dusty Wing
            {2000, 5824}, -- Lucid Potion I
            {1900, 5825}, -- Lucid Potion II
            {1200, 5826}, -- Lucid Potion III
            { 730, 5832}, -- Healing Mist
            { 420, 5833}, -- Mana Mist
            {1010, 5834}, -- Lucid Wings I
            { 875, 5835}, -- Healing Salve I
            { 210, 5836}, -- Healing Salve II
            { 920, 5837}, -- Clear Salve I
            { 190, 5838}, -- Clear Salve II
            { 310, 5839}, -- Stalwart's Tonic
            { 205, 5840}, -- Stalwart's Gambir
            { 410, 5841}, -- Ascetic's Tonic
            { 305, 5842}, -- Ascetic's Gambir
            { 310, 5843}, -- Champion's Tonic
            { 200, 5845}, -- Fanatic's Tonic
        },
        itemsLow =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {1450,   835}, -- Flax Flower
            { 800,   898}, -- Chicken Bone
            {2630,  1155}, -- Iron Sand
            {4790,   656}, -- Beastcoin
            {4600,   818}, -- Cotton Thread
            {5000,   852}, -- Lizard Skin
            {4990,   880}, -- Bone Chip
            {2650,   893}, -- Giant Femur
            {1730,   912}, -- Beehive Chip
            {1450,   925}, -- Giant Stinger
            {1060,  1225}, -- Gold Nugget
            {3610,  1845}, -- Red Moko Grass
            {4820,  4114}, -- Potion +2
            {4650,  4115}, -- Potion +3
            {4840,  4129}, -- Ether +1
            {4320,  4130}, -- Ether +2
            { 510,  4145}, -- Elixir
            {2430,  4370}, -- Honey
        },
        itemsHi =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            { 425,   702}, -- Ebony Log
            { 870,   746}, -- Platinum Ingot
            { 430,   835}, -- Flax Flower
            { 790,   898}, -- Chicken Bone
            {2400,   857}, -- Dhalmel Hide
            {2750,   750}, -- Silver Beastcoin
            {4600,   818}, -- Cotton Thread
            { 390,   838}, -- Spider Web
            {3500,   852}, -- Lizard Skin
            {4990,   880}, -- Bone Chip
            {2650,   893}, -- Giant Femur
            {1730,   912}, -- Beehive Chip
            { 365,   913}, -- Beeswax
            {1450,   925}, -- Giant Stinger
            {1060,  1225}, -- Gold Nugget
            { 210,  1229}, -- Adaman Nugget
            {3610,  1845}, -- Red Moko Grass
            { 205,  3311}, -- Galvanizer
            { 725,  3313}, -- Vivi-Valve
            { 610,  3435}, -- Rubicund Cell
            { 930,  3436}, -- Xanthous Cell
            {2950,  3437}, -- Jade Cell
            {2105,  3450}, -- Voiddust
            {5000,  4119}, -- Hi-Potion +3
            {4700,  4121}, -- X-Potion +1
            { 600,  4123}, -- X-Potion +3
            {4900,  4141}, -- Pro-Ether +1
            {2700,  4145}, -- Elixir
            {1650,  4155}, -- Remedy
            {1450,  4449}, -- Reishi Mushroom
            { 795,  5416}, -- Stl. Bull. Pouch
            { 235, 12821}, -- Gavial Cuisses
            { 120, 12880}, -- Ogre Trousers
            { 425, 13587}, -- Rainbow Cape
            { 110, 13704}, -- Ogre Mask
            { 215, 13706}, -- Ogre Gloves
            { 150, 13708}, -- Ogre Ledelsens
        }
    },
    [tpz.zone.CRAWLERS_NEST] =
    {
        regionalItems = {11823}, -- Cocoon Band
        temps =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            { 900, 4202}, -- Daedalus Wing
            { 500, 4206}, -- Catholicon
            { 300, 4255}, -- Mana Powder
            { 450, 5322}, -- Healing Powder
            { 320, 5393}, -- Monarch's Drink
            { 650, 5394}, -- Gnostic's Drink
            { 430, 5395}, -- Cleric's Drink
            {1000, 5433}, -- Dusty Elixir
            { 690, 5439}, -- Vicar's Drink
            { 250, 5440}, -- Dusty Wing
            {2000, 5824}, -- Lucid Potion I
            {1900, 5825}, -- Lucid Potion II
            {1200, 5826}, -- Lucid Potion III
            { 730, 5832}, -- Healing Mist
            { 420, 5833}, -- Mana Mist
            {1010, 5834}, -- Lucid Wings I
            { 875, 5835}, -- Healing Salve I
            { 210, 5836}, -- Healing Salve II
            { 920, 5837}, -- Clear Salve I
            { 190, 5838}, -- Clear Salve II
            { 310, 5839}, -- Stalwart's Tonic
            { 205, 5840}, -- Stalwart's Gambir
            { 410, 5841}, -- Ascetic's Tonic
            { 305, 5842}, -- Ascetic's Gambir
            { 310, 5843}, -- Champion's Tonic
            { 200, 5845}, -- Fanatic's Tonic
        },
        items =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {3000,   574}, -- Fruit Seeds
            {1760,   633}, -- Olive Oil
            { 390,   646}, -- Adaman Ore
            {2650,   694}, -- Chestnut Log
            {3150,   749}, -- Mtl. Beastcoin
            {3200,   859}, -- Ram Skin
            {2570,   895}, -- Ram Horn
            { 765,   943}, -- Poison Dust
            { 235,  3309}, -- Barrage Turbine
            { 490,  3434}, -- Cobalt Cell
            { 655,  3436}, -- Xanthous Cell
            {1490,  3437}, -- Jade Cell
            {1760,  3450}, -- Voiddust
            {5000,  4117}, -- Hi-Potion +1
            {2700,  4119}, -- Hi-Potion +3
            {1050,  4121}, -- X-Potion +1
            { 450,  4123}, -- X-Potion +3
            {4900,  4143}, -- Pro-Ether +3
            { 650,  4144}, -- Hi-Elixir
            { 230, 12437}, -- Gavial Mask
            { 210, 12693}, -- Gavial Fng. Gnt.
            { 110, 16396}, -- Koenigs Knuckles
            {  90, 17364}, -- Cythara Anglica
            {2570, 17898}, -- C. Grass. Broth
            {3100, 18259}, -- Angon
        }
    },
    [tpz.zone.MAZE_OF_SHAKHRAMI] =
    {
        regionalItems = {11768}, -- Fisher's Rope
        tempsLow =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {1060, 4112}, -- Potion
            { 740, 4113}, -- Potion +1
            { 700, 4114}, -- Potion +2
            { 800, 4128}, -- Ether
            { 430, 4129}, -- Ether +1
            {  50, 4130}, -- Ether +2
            { 900, 4145}, -- Elixer
            { 820, 4148}, -- Antidote
            { 730, 4150}, -- Eye Drops
            { 850, 4151}, -- Echo Drops
            { 650, 4155}, -- Remedy
            {1020, 4164}, -- Prism Powder
            { 940, 4165}, -- Silent Oil
            { 420, 4202}, -- Daedalus Wing
            { 250, 4300}, -- Apple Au Lait
            { 660, 4423}, -- Apple Juice
        },
        tempsHi =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            { 900, 4202}, -- Daedalus Wing
            { 500, 4206}, -- Catholicon
            { 300, 4255}, -- Mana Powder
            { 450, 5322}, -- Healing Powder
            { 320, 5393}, -- Monarch's Drink
            { 650, 5394}, -- Gnostic's Drink
            { 430, 5395}, -- Cleric's Drink
            {1000, 5433}, -- Dusty Elixir
            { 690, 5439}, -- Vicar's Drink
            { 250, 5440}, -- Dusty Wing
            {2000, 5824}, -- Lucid Potion I
            {1900, 5825}, -- Lucid Potion II
            {1200, 5826}, -- Lucid Potion III
            { 730, 5832}, -- Healing Mist
            { 420, 5833}, -- Mana Mist
            {1010, 5834}, -- Lucid Wings I
            { 875, 5835}, -- Healing Salve I
            { 210, 5836}, -- Healing Salve II
            { 920, 5837}, -- Clear Salve I
            { 190, 5838}, -- Clear Salve II
            { 310, 5839}, -- Stalwart's Tonic
            { 205, 5840}, -- Stalwart's Gambir
            { 410, 5841}, -- Ascetic's Tonic
            { 305, 5842}, -- Ascetic's Gambir
            { 310, 5843}, -- Champion's Tonic
            { 200, 5845}, -- Fanatic's Tonic
        },
        itemsLow =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {1450,   835}, -- Flax Flower
            { 800,   898}, -- Chicken Bone
            {2630,  1155}, -- Iron Sand
            {4790,   656}, -- Beastcoin
            {4600,   818}, -- Cotton Thread
            {5000,   852}, -- Lizard Skin
            {4990,   880}, -- Bone Chip
            {2650,   893}, -- Giant Femur
            {1730,   912}, -- Beehive Chip
            {1450,   925}, -- Giant Stinger
            {1060,  1225}, -- Gold Nugget
            {3610,  1845}, -- Red Moko Grass
            {4820,  4114}, -- Potion +2
            {4650,  4115}, -- Potion +3
            {4840,  4129}, -- Ether +1
            {4320,  4130}, -- Ether +2
            { 510,  4145}, -- Elixir
            {2430,  4370}, -- Honey
        },
        itemsHi =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            { 425,   702}, -- Ebony Log
            { 870,   746}, -- Platinum Ingot
            { 430,   835}, -- Flax Flower
            { 790,   898}, -- Chicken Bone
            {2400,   857}, -- Dhalmel Hide
            {2750,   750}, -- Silver Beastcoin
            {4600,   818}, -- Cotton Thread
            { 390,   838}, -- Spider Web
            {3500,   852}, -- Lizard Skin
            {4990,   880}, -- Bone Chip
            {2650,   893}, -- Giant Femur
            {1730,   912}, -- Beehive Chip
            { 365,   913}, -- Beeswax
            {1450,   925}, -- Giant Stinger
            {1060,  1225}, -- Gold Nugget
            { 210,  1229}, -- Adaman Nugget
            {3610,  1845}, -- Red Moko Grass
            { 205,  3311}, -- Galvanizer
            { 725,  3313}, -- Vivi-Valve
            { 610,  3435}, -- Rubicund Cell
            { 930,  3436}, -- Xanthous Cell
            {2950,  3437}, -- Jade Cell
            {2105,  3450}, -- Voiddust
            {5000,  4119}, -- Hi-Potion +3
            {4700,  4121}, -- X-Potion +1
            { 600,  4123}, -- X-Potion +3
            {4900,  4141}, -- Pro-Ether +1
            {2700,  4145}, -- Elixir
            {1650,  4155}, -- Remedy
            {1450,  4449}, -- Reishi Mushroom
            { 795,  5416}, -- Stl. Bull. Pouch
            { 235, 12821}, -- Gavial Cuisses
            { 120, 12880}, -- Ogre Trousers
            { 425, 13587}, -- Rainbow Cape
            { 110, 13704}, -- Ogre Mask
            { 215, 13706}, -- Ogre Gloves
            { 150, 13708}, -- Ogre Ledelsens
        }
    },
    [tpz.zone.GARLAIGE_CITADEL] =
    {
        regionalItems = {18784}, -- Metasoma Katars
        temps =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            { 900, 4202}, -- Daedalus Wing
            { 500, 4206}, -- Catholicon
            { 300, 4255}, -- Mana Powder
            { 450, 5322}, -- Healing Powder
            { 320, 5393}, -- Monarch's Drink
            { 650, 5394}, -- Gnostic's Drink
            { 430, 5395}, -- Cleric's Drink
            {1000, 5433}, -- Dusty Elixir
            { 690, 5439}, -- Vicar's Drink
            { 250, 5440}, -- Dusty Wing
            {2000, 5824}, -- Lucid Potion I
            {1900, 5825}, -- Lucid Potion II
            {1200, 5826}, -- Lucid Potion III
            { 730, 5832}, -- Healing Mist
            { 420, 5833}, -- Mana Mist
            {1010, 5834}, -- Lucid Wings I
            { 875, 5835}, -- Healing Salve I
            { 210, 5836}, -- Healing Salve II
            { 920, 5837}, -- Clear Salve I
            { 190, 5838}, -- Clear Salve II
            { 310, 5839}, -- Stalwart's Tonic
            { 205, 5840}, -- Stalwart's Gambir
            { 410, 5841}, -- Ascetic's Tonic
            { 305, 5842}, -- Ascetic's Gambir
            { 310, 5843}, -- Champion's Tonic
            { 200, 5845}, -- Fanatic's Tonic
        },
        items =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            { 640,   633}, -- Olive Oil
            { 510,   646}, -- Adaman Ore
            { 410,   653}, -- Mythril Ingot
            { 670,   690}, -- Elm Log
            { 325,   691}, -- Maple Log
            {2980,   749}, -- Mtl. Beastcoin
            {3650,   750}, -- Silver Beastcoin
            {2430,   820}, -- Wool Thread
            {3200,   859}, -- Ram Skin
            {2570,   895}, -- Ram Horn
            { 765,   943}, -- Poison Dust
            { 325,  3312}, -- Percolator
            { 490,  3434}, -- Cobalt Cell
            { 655,  3436}, -- Xanthous Cell
            {1490,  3437}, -- Jade Cell
            {1760,  3450}, -- Voiddust
            {5000,  4117}, -- Hi-Potion +1
            {2700,  4119}, -- Hi-Potion +3
            {1050,  4121}, -- X-Potion +1
            { 450,  4123}, -- X-Potion +3
            {4900,  4143}, -- Pro-Ether +3
            { 650,  4144}, -- Hi-Elixir
            { 230, 12437}, -- Gavial Mask
            { 210, 12693}, -- Gavial Fng. Gnt.
            { 110, 16396}, -- Koenigs Knuckles
            {  90, 17364}, -- Cythara Anglica
            {2570, 17898}, -- C. Grass. Broth
            {3100, 18259}, -- Angon
        }
    },
    [tpz.zone.FEIYIN] =
    {
        regionalItems = {16202}, -- Dagda's Shield
        temps =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            { 900, 4202}, -- Daedalus Wing
            { 500, 4206}, -- Catholicon
            { 300, 4255}, -- Mana Powder
            { 450, 5322}, -- Healing Powder
            { 320, 5393}, -- Monarch's Drink
            { 650, 5394}, -- Gnostic's Drink
            { 430, 5395}, -- Cleric's Drink
            {1000, 5433}, -- Dusty Elixir
            { 690, 5439}, -- Vicar's Drink
            { 250, 5440}, -- Dusty Wing
            {2000, 5824}, -- Lucid Potion I
            {1900, 5825}, -- Lucid Potion II
            {1200, 5826}, -- Lucid Potion III
            { 730, 5832}, -- Healing Mist
            { 420, 5833}, -- Mana Mist
            {1010, 5834}, -- Lucid Wings I
            { 875, 5835}, -- Healing Salve I
            { 210, 5836}, -- Healing Salve II
            { 920, 5837}, -- Clear Salve I
            { 190, 5838}, -- Clear Salve II
            { 310, 5839}, -- Stalwart's Tonic
            { 205, 5840}, -- Stalwart's Gambir
            { 410, 5841}, -- Ascetic's Tonic
            { 305, 5842}, -- Ascetic's Gambir
            { 310, 5843}, -- Champion's Tonic
            { 200, 5845}, -- Fanatic's Tonic
        },
        items =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            { 760,   645}, -- Darksteel Ore
            { 365,   646}, -- Adaman Ore
            { 490,   739}, -- Orichalcum Ore
            {2680,   748}, -- Gold Beastcoin
            { 230,   773}, -- Translucent Rock
            { 570,   775}, -- Black Rock
            { 600,   776}, -- White Rock
            { 780,   821}, -- Rainbow Thread
            {1480,   823}, -- Gold Thread
            {3600,  1222}, -- Yagudo Fltchg.
            {1460,  1962}, -- Plt. Arrowheads
            { 430,  2459}, -- Minium
            {0000,  2761}, -- Feyweald Log
            { 360,  3312}, -- Percolator
            { 900,  3434}, -- Cobalt Cell
            {1050,  3435}, -- Rubicund Cell
            {1240,  3436}, -- Xanthous Cell
            {1465,  3437}, -- Jade Cell
            {2675,  3450}, -- Voiddust
            {5000,  4119}, -- Hi-Potion +3
            {4750,  4123}, -- X-Potion +3
            {4900,  4135}, -- Hi-Ether +3
            {4250,  4143}, -- Pro-Ether +3
            {2500,  4144}, -- Hi-Elixir
            {1500,  4155}, -- Remedy
            { 700,  4173}, -- Hi-Reraiser
            { 845,  5821}, -- Fsn. Bolt Quiver
            { 120, 13929}, -- Errant Hat
            {  90, 14078}, -- Errant Cuffs
            {  85, 14182}, -- Errant Pigaches
            {  75, 14301}, -- Errant Slops
            { 230, 16520}, -- Verdun
            {1000, 17896}, -- Gob. Bug Broth
            {2150, 18258}, -- Thr. Tomahawk
        }
    },
    [tpz.zone.IFRITS_CAULDRON] =
    {
        regionalItems = {10949}, -- Smithy's Torque
        temps =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            { 900, 4202}, -- Daedalus Wing
            { 500, 4206}, -- Catholicon
            { 300, 4255}, -- Mana Powder
            { 450, 5322}, -- Healing Powder
            { 320, 5393}, -- Monarch's Drink
            { 650, 5394}, -- Gnostic's Drink
            { 430, 5395}, -- Cleric's Drink
            {1000, 5433}, -- Dusty Elixir
            { 690, 5439}, -- Vicar's Drink
            { 250, 5440}, -- Dusty Wing
            {2000, 5824}, -- Lucid Potion I
            {1900, 5825}, -- Lucid Potion II
            {1200, 5826}, -- Lucid Potion III
            { 730, 5832}, -- Healing Mist
            { 420, 5833}, -- Mana Mist
            {1010, 5834}, -- Lucid Wings I
            { 875, 5835}, -- Healing Salve I
            { 210, 5836}, -- Healing Salve II
            { 920, 5837}, -- Clear Salve I
            { 190, 5838}, -- Clear Salve II
            { 310, 5839}, -- Stalwart's Tonic
            { 205, 5840}, -- Stalwart's Gambir
            { 410, 5841}, -- Ascetic's Tonic
            { 305, 5842}, -- Ascetic's Gambir
            { 310, 5843}, -- Champion's Tonic
            { 200, 5845}, -- Fanatic's Tonic
        },
        items =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            {2700,   646}, -- Adaman Ore
            { 310,   739}, -- Orichalcum Ore
            { 580,   821}, -- Rainbow Thread
            {4700,  1222}, -- Yagudo Fltchg.
            {1540,   838}, -- Spider Web
            {1700,   843}, -- G. Bird Plume
            {2050,  1155}, -- Iron Sand
            {3670,  1222}, -- Yagudo Fltchg.
            {3100,  1962}, -- Plt. Arrowheads
            {1050,  2459}, -- Minium
            {2100,  2532}, -- Teak Log
            { 340,  3309}, -- Barrage Turbine
            {1650,  3434}, -- Cobalt Cell
            {1430,  3435}, -- Rubicund Cell
            {1625,  3436}, -- Xanthous Cell
            {1725,  3437}, -- Jade Cell
            {2635,  3450}, -- Voiddust
            {5000,  4119}, -- Hi-Potion +3
            {2500,  4123}, -- X-Potion +3
            {4900,  4135}, -- Hi-Ether +3
            {2200,  4143}, -- Pro-Ether +3
            {2400,  5662}, -- Dragon Fruit
            { 410,  8555}, -- Barrier Module
            {1250, 12309}, -- Ritter Shield
            { 320, 13212}, -- Tarutaru Sash
            { 680, 13587}, -- Rainbow Cape
            { 780, 13595}, -- Coeurl Mantle
            { 220, 15890}, -- Marid Belt
            { 695, 16128}, -- Wivre Hairpin
            { 725, 16265}, -- Wivre Gorget
        }
    },
    [tpz.zone.GUSTAV_TUNNEL] =
    {
        regionalItems = {10955, 11041}, -- Culinarian's Torque | Liminus Earring
        temps =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            { 900, 4202}, -- Daedalus Wing
            { 500, 4206}, -- Catholicon
            { 300, 4255}, -- Mana Powder
            { 450, 5322}, -- Healing Powder
            { 320, 5393}, -- Monarch's Drink
            { 650, 5394}, -- Gnostic's Drink
            { 430, 5395}, -- Cleric's Drink
            {1000, 5433}, -- Dusty Elixir
            { 690, 5439}, -- Vicar's Drink
            { 250, 5440}, -- Dusty Wing
            {2000, 5824}, -- Lucid Potion I
            {1900, 5825}, -- Lucid Potion II
            {1200, 5826}, -- Lucid Potion III
            { 730, 5832}, -- Healing Mist
            { 420, 5833}, -- Mana Mist
            {1010, 5834}, -- Lucid Wings I
            { 875, 5835}, -- Healing Salve I
            { 210, 5836}, -- Healing Salve II
            { 920, 5837}, -- Clear Salve I
            { 190, 5838}, -- Clear Salve II
            { 310, 5839}, -- Stalwart's Tonic
            { 205, 5840}, -- Stalwart's Gambir
            { 410, 5841}, -- Ascetic's Tonic
            { 305, 5842}, -- Ascetic's Gambir
            { 310, 5843}, -- Champion's Tonic
            { 200, 5845}, -- Fanatic's Tonic
        },
        items =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            { 390,   657}, -- Tama-Hagane
            { 745,   876}, -- Manta Skin
            { 250,   887}, -- Coral Fragment
            {4500,  1163}, -- Manticore Hair
            {1025,  1446}, -- Lacquer Tree Log
            { 255,  3307}, -- Heat Capacitor
            { 245,  3312}, -- Percolator
            { 450,  3313}, -- Vivi-Valve
            { 700,  3434}, -- Cobalt Cell
            {1600,  3435}, -- Rubicund Cell
            {2060,  3436}, -- Xanthous Cell
            {2050,  3437}, -- Jade Cell
            {1500,  3450}, -- Voiddust
            {5000,  4119}, -- Hi-Potion +3
            {4200,  4120}, -- X-Potion
            {3500,  4121}, -- X-Potion +1
            {3000,  4122}, -- X-Potion +2
            {4900,  4135}, -- Hi-Ether +3
            {2700,  4143}, -- Pro-Ether +3
            { 600,  4155}, -- Remedy
            {1200,  4173}, -- Hi-Reraiser
            { 900,  4174}, -- Vile Elixir
            {1200,  4291}, -- Sandfish
            {1700,  4447}, -- Scream Fungus
            { 650,  5866}, -- Toolbag (Moku)
            {1050,  5871}, -- Ruszor Quiver
            {2050, 17881}, -- Deepbed Soil
            {1020, 17884}, -- Sun Water
            { 500, 17898}, -- C. Grass. Broth
            { 400, 17899}, -- Svg. Mole Broth
        }
    },
    [tpz.zone.LABYRINTH_OF_ONZOZO] =
    {
        regionalItems = {18817}, -- Furtive Grip
        temps =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            { 900, 4202}, -- Daedalus Wing
            { 500, 4206}, -- Catholicon
            { 300, 4255}, -- Mana Powder
            { 450, 5322}, -- Healing Powder
            { 320, 5393}, -- Monarch's Drink
            { 650, 5394}, -- Gnostic's Drink
            { 430, 5395}, -- Cleric's Drink
            {1000, 5433}, -- Dusty Elixir
            { 690, 5439}, -- Vicar's Drink
            { 250, 5440}, -- Dusty Wing
            {2000, 5824}, -- Lucid Potion I
            {1900, 5825}, -- Lucid Potion II
            {1200, 5826}, -- Lucid Potion III
            { 730, 5832}, -- Healing Mist
            { 420, 5833}, -- Mana Mist
            {1010, 5834}, -- Lucid Wings I
            { 875, 5835}, -- Healing Salve I
            { 210, 5836}, -- Healing Salve II
            { 920, 5837}, -- Clear Salve I
            { 190, 5838}, -- Clear Salve II
            { 310, 5839}, -- Stalwart's Tonic
            { 205, 5840}, -- Stalwart's Gambir
            { 410, 5841}, -- Ascetic's Tonic
            { 305, 5842}, -- Ascetic's Gambir
            { 310, 5843}, -- Champion's Tonic
            { 200, 5845}, -- Fanatic's Tonic
        },
        items =
        {
        ----------------------------------
        --| Weight | Item ID |   Name  |--
        ----------------------------------
            { 720,  1213}, -- Dst. Bolt Heads
            {1020,  1443}, -- Dried Mugwort
            { 430,  2459}, -- Minium
            {2200,  2761}, -- Feyweald Log
            { 360,  3312}, -- Percolator
            { 900,  3434}, -- Cobalt Cell
            {1050,  3435}, -- Rubicund Cell
            {1240,  3436}, -- Xanthous Cell
            {1465,  3437}, -- Jade Cell
            {2675,  3450}, -- Voiddust
            {5000,  4119}, -- Hi-Potion +3
            {4750,  4123}, -- X-Potion +3
            {4900,  4135}, -- Hi-Ether +3
            {4250,  4143}, -- Pro-Ether +3
            {2500,  4144}, -- Hi-Elixir
            {1500,  4155}, -- Remedy
            { 700,  4173}, -- Hi-Reraiser
            { 640,  4449}, -- Reishi Mushroom
            { 340,  9068}, -- Barrier Module
        },
    },
}
