-----------------------------------
-- Area: Horlais Peak
--  NPC: Armoury Crate
-----------------------------------
local entity = {}

local loot =
{
    -- BCNM Tails of Woe
    [1] =
    {
        {
            { itemid = xi.item.BLITZ_RING, droprate = 150 }, -- blitz Ring
            { itemid = xi.item.NONE,       droprate = 850 }, -- Nothing
        },

        {
            { itemid = xi.item.AEGIS_RING,    droprate = 300 }, -- aegis Ring
            { itemid = xi.item.TUNDRA_MANTLE, droprate = 200 }, -- tundra mantle
            { itemid = xi.item.DRUIDS_ROPE,   droprate = 200 }, -- druids rope
            { itemid = xi.item.NONE,          droprate = 300 }, -- Nothing
        },

        {
            { itemid = xi.item.FIRE_SPIRIT_PACT,     droprate = 145 }, -- firespirit
            { itemid = xi.item.SCROLL_OF_ERASE,      droprate = 165 }, -- erase
            { itemid = xi.item.SCROLL_OF_PHALANX,    droprate = 140 }, -- phalanx
            { itemid = xi.item.SCROLL_OF_ABSORB_STR, droprate = 123 }, -- absorb-str
            { itemid = xi.item.PERIDOT,              droprate =  94 }, -- peridot
            { itemid = xi.item.PEARL,                droprate =  94 }, -- pearl
            { itemid = xi.item.GREEN_ROCK,           droprate =  13 }, -- green rock
            { itemid = xi.item.AMETRINE,             droprate =  53 }, -- ametrine
            { itemid = xi.item.GOLD_BEASTCOIN,       droprate =  70 }, -- gold beastcoin
            { itemid = xi.item.MYTHRIL_BEASTCOIN,    droprate =  50 }, -- mythril beastcoin
            { itemid = xi.item.YELLOW_ROCK,          droprate =  53 }, -- yellow rock
            { itemid = xi.item.NONE,                 droprate =   0 }, -- nothing
        },

        {
            { itemid = xi.item.SCROLL_OF_ERASE,      droprate = 125 }, -- erase
            { itemid = xi.item.SCROLL_OF_PHALANX,    droprate = 110 }, -- phalanx
            { itemid = xi.item.SCROLL_OF_ABSORB_STR, droprate = 104 }, -- absorb-str
            { itemid = xi.item.PERIDOT,              droprate =  94 }, -- peridot
            { itemid = xi.item.PEARL,                droprate =  94 }, -- pearl
            { itemid = xi.item.GREEN_ROCK,           droprate =  53 }, -- green rock
            { itemid = xi.item.AMETRINE,             droprate =  73 }, -- ametrine
            { itemid = xi.item.GOLD_BEASTCOIN,       droprate =  70 }, -- gold beastcoin
            { itemid = xi.item.MYTHRIL_BEASTCOIN,    droprate =  70 }, -- mythril beastcoin
            { itemid = xi.item.YELLOW_ROCK,          droprate =  73 }, -- yellow rock
            { itemid = xi.item.NONE,                 droprate =  94 }, -- nothing
        },

        {
            { itemid = xi.item.FIRE_SPIRIT_PACT,      droprate = 174 }, -- firespirit
            { itemid = xi.item.SCROLL_OF_ERASE,       droprate =  16 }, -- vile elixir
            { itemid = xi.item.SCROLL_OF_PHALANX,     droprate = 114 }, -- icespikes
            { itemid = xi.item.SCROLL_OF_ABSORB_STR,  droprate = 174 }, -- refresh
            { itemid = xi.item.SCROLL_OF_UTSUSEMI_NI, droprate = 138 }, -- utsusemi ni
            { itemid = xi.item.GREEN_ROCK,            droprate =  18 }, -- green rock
            { itemid = xi.item.BLACK_ROCK,            droprate =  18 }, -- black rock
            { itemid = xi.item.BLUE_ROCK,             droprate =  17 }, -- blue rock
            { itemid = xi.item.RED_ROCK,              droprate =  16 }, -- red rock
            { itemid = xi.item.PURPLE_ROCK,           droprate =  16 }, -- purple rock
            { itemid = xi.item.WHITE_ROCK,            droprate =  16 }, -- white rock
            { itemid = xi.item.YELLOW_ROCK,           droprate =  17 }, -- yellow rock
            { itemid = xi.item.TRANSLUCENT_ROCK,      droprate =  17 }, -- translucent rock
            { itemid = xi.item.RERAISER,              droprate =  21 }, -- reraiser
            { itemid = xi.item.OAK_LOG,               droprate =  22 }, -- oak log
            { itemid = xi.item.ROSEWOOD_LOG,          droprate =  18 }, -- rosewood log
            { itemid = xi.item.GOLD_BEASTCOIN,        droprate = 120 }, -- gold beastcoin
            { itemid = xi.item.MYTHRIL_BEASTCOIN,     droprate = 102 }, -- mythril beastcoin
            { itemid = xi.item.PEARL,                 droprate =  21 }, -- pearl
            { itemid = xi.item.TURQUOISE,             droprate =  23 }, -- Turquoise
            { itemid = xi.item.GOSHENITE,             droprate =  19 }, -- Goshenite
            { itemid = xi.item.BLACK_PEARL,           droprate =  18 }, -- Black pearl
            { itemid = xi.item.SPHENE,                droprate =  17 }, -- sphene
            { itemid = xi.item.GARNET,                droprate =  20 }, -- garnet
            { itemid = xi.item.AMETRINE,              droprate =  18 }, -- ametrine
            { itemid = xi.item.NONE,                  droprate =   0 }, -- nothing
        },

        {
            { itemid = xi.item.SCROLL_OF_PHALANX,     droprate = 87 }, -- icespikes
            { itemid = xi.item.SCROLL_OF_ABSORB_STR,  droprate = 75 }, -- refresh
            { itemid = xi.item.SCROLL_OF_UTSUSEMI_NI, droprate = 75 }, -- utsusemi ni
            { itemid = xi.item.OAK_LOG,               droprate = 80 }, -- oak log
            { itemid = xi.item.ROSEWOOD_LOG,          droprate = 97 }, -- rosewood log
            { itemid = xi.item.PEARL,                 droprate = 86 }, -- pearl
            { itemid = xi.item.TURQUOISE,             droprate = 88 }, -- Turquoise
            { itemid = xi.item.GOSHENITE,             droprate = 79 }, -- Goshenite
            { itemid = xi.item.BLACK_PEARL,           droprate = 93 }, -- Black pearl
            { itemid = xi.item.SPHENE,                droprate = 79 }, -- sphene
            { itemid = xi.item.GARNET,                droprate = 71 }, -- garnet
            { itemid = xi.item.AMETRINE,              droprate = 90 }, -- ametrine
            { itemid = xi.item.NONE,                  droprate =  0 }, -- nothing
        },
    },

    -- BCNM Dismemberment Brigade
    [2] =
    {
        {
            { itemid = xi.item.KABRAKANS_AXE, droprate = 250 }, -- kabrakans_axe
            { itemid = xi.item.SARNGA,        droprate = 250 }, -- sarnga
            { itemid = xi.item.DRAGVANDIL,    droprate = 250 }, -- dragvandil
            { itemid = xi.item.HAMELIN_FLUTE, droprate = 250 }, -- hamelin_flute
        },

        {
            { itemid = xi.item.NONE,            droprate = 400 }, -- nothing
            { itemid = xi.item.SPECTACLES,      droprate = 200 }, -- spectacles
            { itemid = xi.item.ASSAULT_EARRING, droprate = 200 }, -- assault_earring
            { itemid = xi.item.PEACE_RING,      droprate = 200 }, -- peace_ring
        },

        {
            { itemid = xi.item.NONE,             droprate = 200 }, -- nothing
            { itemid = xi.item.TRANSLUCENT_ROCK, droprate = 200 }, -- translucent_rock
            { itemid = xi.item.GREEN_ROCK,       droprate = 200 }, -- green_rock
            { itemid = xi.item.YELLOW_ROCK,      droprate = 200 }, -- yellow_rock
            { itemid = xi.item.PURPLE_ROCK,      droprate = 200 }, -- purple_rock
        },

        {
            { itemid = xi.item.PAINITE,         droprate = 100 }, -- painite
            { itemid = xi.item.JADEITE,         droprate = 100 }, -- jadeite
            { itemid = xi.item.MYTHRIL_INGOT,   droprate = 100 }, -- mythril_ingot
            { itemid = xi.item.STEEL_INGOT,     droprate = 100 }, -- steel_ingot
            { itemid = xi.item.FLUORITE,        droprate = 100 }, -- fluorite
            { itemid = xi.item.GOLD_INGOT,      droprate = 100 }, -- gold_ingot
            { itemid = xi.item.ZIRCON,          droprate = 100 }, -- zircon
            { itemid = xi.item.CHRYSOBERYL,     droprate = 100 }, -- chrysoberyl
            { itemid = xi.item.DARKSTEEL_INGOT, droprate = 100 }, -- darksteel_ingot
            { itemid = xi.item.MOONSTONE,       droprate = 100 }, -- moonstone
        },

        {
            { itemid = xi.item.NONE,           droprate =  900 }, -- nothing
            { itemid = xi.item.VILE_ELIXIR_P1, droprate =  100 }, -- vile_elixir_+1
        },
    },

    -- BCNM Hostile Herbivores
    [4] =
    {
        {
            { itemid = xi.item.NONE,         droprate = 50 }, -- Nothing
            { itemid = xi.item.OCEAN_BELT,   droprate = 95 }, -- Ocean Belt
            { itemid = xi.item.JUNGLE_BELT,  droprate = 95 }, -- Jungle Belt
            { itemid = xi.item.STEPPE_BELT,  droprate = 95 }, -- Steppe Belt
            { itemid = xi.item.DESERT_BELT,  droprate = 95 }, -- Desert Belt
            { itemid = xi.item.FOREST_BELT,  droprate = 95 }, -- Forest Belt
            { itemid = xi.item.OCEAN_STONE,  droprate = 95 }, -- Ocean Stone
            { itemid = xi.item.JUNGLE_STONE, droprate = 95 }, -- Jungle Stone
            { itemid = xi.item.STEPPE_STONE, droprate = 95 }, -- Steppe Stone
            { itemid = xi.item.DESERT_STONE, droprate = 95 }, -- Desert Stone
            { itemid = xi.item.FOREST_STONE, droprate = 95 }, -- Forest Stone
        },

        {
            { itemid = xi.item.GUARDIANS_RING, droprate = 64 }, -- Guardians Ring
            { itemid = xi.item.KAMPFER_RING,   droprate = 65 }, -- Kampfer Ring
            { itemid = xi.item.CONJURERS_RING, droprate = 65 }, -- Conjurers Ring
            { itemid = xi.item.SHINOBI_RING,   droprate = 65 }, -- Shinobi Ring
            { itemid = xi.item.SLAYERS_RING,   droprate = 65 }, -- Slayers Ring
            { itemid = xi.item.SORCERERS_RING, droprate = 65 }, -- Sorcerers Ring
            { itemid = xi.item.SOLDIERS_RING,  droprate = 64 }, -- Soldiers Ring
            { itemid = xi.item.TAMERS_RING,    droprate = 65 }, -- Tamers Ring
            { itemid = xi.item.TRACKERS_RING,  droprate = 64 }, -- Trackers Ring
            { itemid = xi.item.DRAKE_RING,     droprate = 65 }, -- Drake Ring
            { itemid = xi.item.FENCERS_RING,   droprate = 65 }, -- Fencers Ring
            { itemid = xi.item.MINSTRELS_RING, droprate = 65 }, -- Minstrels Ring
            { itemid = xi.item.MEDICINE_RING,  droprate = 64 }, -- Medicine Ring
            { itemid = xi.item.ROGUES_RING,    droprate = 65 }, -- Rogues Ring
            { itemid = xi.item.RONIN_RING,     droprate = 64 }, -- Ronin Ring
            { itemid = xi.item.PLATINUM_RING,  droprate = 30 }, -- Platinum Ring
        },

        {
            { itemid = xi.item.NONE,                droprate = 100 }, -- Nothing
            { itemid = xi.item.SCROLL_OF_QUAKE,     droprate = 176 }, -- Scroll Of Quake
            { itemid = xi.item.LIGHT_SPIRIT_PACT,   droprate =  10 }, -- Light Spirit Pact
            { itemid = xi.item.SCROLL_OF_FREEZE,    droprate = 176 }, -- Scroll Of Freeze
            { itemid = xi.item.SCROLL_OF_REGEN_III, droprate = 176 }, -- Scroll Of Regen Iii
            { itemid = xi.item.RERAISER,            droprate =  60 }, -- Reraiser
            { itemid = xi.item.VILE_ELIXIR,         droprate =  60 }, -- Vile Elixir
            { itemid = xi.item.SCROLL_OF_RAISE_II,  droprate = 176 }, -- Scroll Of Raise Ii
        },

        {
            { itemid = xi.item.NONE,                droprate = 100 }, -- Nothing
            { itemid = xi.item.SCROLL_OF_QUAKE,     droprate = 176 }, -- Scroll Of Quake
            { itemid = xi.item.LIGHT_SPIRIT_PACT,   droprate =  10 }, -- Light Spirit Pact
            { itemid = xi.item.SCROLL_OF_FREEZE,    droprate = 176 }, -- Scroll Of Freeze
            { itemid = xi.item.SCROLL_OF_REGEN_III, droprate = 176 }, -- Scroll Of Regen Iii
            { itemid = xi.item.RERAISER,            droprate =  60 }, -- Reraiser
            { itemid = xi.item.VILE_ELIXIR,         droprate =  60 }, -- Vile Elixir
            { itemid = xi.item.SCROLL_OF_RAISE_II,  droprate = 176 }, -- Scroll Of Raise Ii
        },

        {
            { itemid = xi.item.RAM_HORN,                 droprate =  59 }, -- Ram Horn
            { itemid = xi.item.MAHOGANY_LOG,             droprate =  59 }, -- Mahogany Log
            { itemid = xi.item.MYTHRIL_INGOT,            droprate = 200 }, -- Mythril Ingot
            { itemid = xi.item.MANTICORE_HIDE,           droprate =  59 }, -- Manticore Hide
            { itemid = xi.item.HANDFUL_OF_WYVERN_SCALES, droprate =  90 }, -- Handful Of Wyvern Scales
            { itemid = xi.item.WYVERN_SKIN,              droprate =  90 }, -- Wyvern Skin
            { itemid = xi.item.PETRIFIED_LOG,            droprate = 176 }, -- Petrified Log
            { itemid = xi.item.DARKSTEEL_INGOT,          droprate =  59 }, -- Darksteel Ingot
            { itemid = xi.item.RAM_SKIN,                 droprate =  59 }, -- Ram Skin
            { itemid = xi.item.PLATINUM_INGOT,           droprate =  90 }, -- Platinum Ingot
        },

        {
            { itemid = xi.item.NONE,                     droprate = 100 }, -- Nothing
            { itemid = xi.item.RAM_HORN,                 droprate =  59 }, -- Ram Horn
            { itemid = xi.item.MAHOGANY_LOG,             droprate =  59 }, -- Mahogany Log
            { itemid = xi.item.MYTHRIL_INGOT,            droprate = 200 }, -- Mythril Ingot
            { itemid = xi.item.MANTICORE_HIDE,           droprate =  59 }, -- Manticore Hide
            { itemid = xi.item.HANDFUL_OF_WYVERN_SCALES, droprate =  90 }, -- Handful Of Wyvern Scales
            { itemid = xi.item.WYVERN_SKIN,              droprate =  90 }, -- Wyvern Skin
            { itemid = xi.item.PETRIFIED_LOG,            droprate = 176 }, -- Petrified Log
            { itemid = xi.item.DARKSTEEL_INGOT,          droprate =  59 }, -- Darksteel Ingot
            { itemid = xi.item.RAM_SKIN,                 droprate =  59 }, -- Ram Skin
            { itemid = xi.item.PLATINUM_INGOT,           droprate =  90 }, -- Platinum Ingot
        },
    },

    -- BCNM Carapace Combatants
    [8] =
    {
        {
            { itemid = xi.item.BEETLE_JAW, droprate = 1000 }, -- beetle_jaw
        },

        {
            { itemid = xi.item.BEETLE_SHELL, droprate = 1000 }, -- beetle_shell
        },

        {
            { itemid = xi.item.NONE,        droprate = 250 }, -- nothing
            { itemid = xi.item.KATANA_OBI,  droprate = 150 }, -- katana_obi
            { itemid = xi.item.STAFF_BELT,  droprate = 150 }, -- staff_belt
            { itemid = xi.item.SONG_BELT,   droprate = 150 }, -- song_belt
            { itemid = xi.item.CESTUS_BELT, droprate = 150 }, -- cestus_belt
            { itemid = xi.item.PICK_BELT,   droprate = 150 }, -- pick_belt
        },

        {
            { itemid = xi.item.NONE,              droprate = 125 }, -- nothing
            { itemid = xi.item.GENIN_EARRING,     droprate = 125 }, -- genin_earring
            { itemid = xi.item.MAGICIANS_EARRING, droprate = 125 }, -- magicians_earring
            { itemid = xi.item.PILFERERS_EARRING, droprate = 125 }, -- pilferers_earring
            { itemid = xi.item.WARLOCKS_EARRING,  droprate = 125 }, -- warlocks_earring
            { itemid = xi.item.WRESTLERS_EARRING, droprate = 125 }, -- wrestlers_earring
            { itemid = xi.item.WYVERN_EARRING,    droprate = 125 }, -- wyvern_earring
            { itemid = xi.item.KILLER_EARRING,    droprate = 125 }, -- killer_earring
        },

        {
            { itemid = xi.item.NONE,                   droprate = 160 }, -- nothing
            { itemid = xi.item.CHUNK_OF_DARKSTEEL_ORE, droprate = 140 }, -- chunk_of_darksteel_ore
            { itemid = xi.item.MYTHRIL_INGOT,          droprate = 140 }, -- mythril_ingot
            { itemid = xi.item.SILVER_INGOT,           droprate = 140 }, -- silver_ingot
            { itemid = xi.item.STEEL_INGOT,            droprate = 140 }, -- steel_ingot
            { itemid = xi.item.CHUNK_OF_MYTHRIL_ORE,   droprate = 140 }, -- chunk_of_mythril_ore
            { itemid = xi.item.SARDONYX,               droprate = 140 }, -- sardonyx
        },

        {
            { itemid = xi.item.NONE,                   droprate = 250 }, -- nothing
            { itemid = xi.item.SCROLL_OF_DISPEL,       droprate = 125 }, -- scroll_of_dispel
            { itemid = xi.item.SCROLL_OF_UTSUSEMI_NI,  droprate = 125 }, -- scroll_of_utsusemi_ni
            { itemid = xi.item.SCROLL_OF_FIRE_II,      droprate = 125 }, -- scroll_of_fire_ii
            { itemid = xi.item.SCROLL_OF_MAGIC_FINALE, droprate = 125 }, -- scroll_of_magic_finale
            { itemid = xi.item.SCROLL_OF_ABSORB_AGI,   droprate = 125 }, -- scroll_of_absorb-agi
            { itemid = xi.item.SCROLL_OF_ABSORB_INT,   droprate = 125 }, -- scroll_of_absorb-int
        },

        {
            { itemid = xi.item.NONE,               droprate = 500 }, -- nothing
            { itemid = xi.item.JUG_OF_SCARLET_SAP, droprate = 500 }, -- jug_of_scarlet_sap
        },

        {
            { itemid = xi.item.NONE,               droprate = 750 }, -- nothing
            { itemid = xi.item.JUG_OF_SCARLET_SAP, droprate = 250 }, -- jug_of_scarlet_sap
        },

        {
            { itemid = xi.item.NONE,     droprate = 900 }, -- nothing
            { itemid = xi.item.HI_ETHER, droprate = 100 }, -- hi-ether
        },
    },

    -- BCNM Shooting Fish
    [9] =
    {
        {
            { itemid = xi.item.MANNEQUIN_HEAD, droprate = 1000 }, -- mannequin_head
        },

        {
            { itemid = xi.item.SHALL_SHELL, droprate = 1000 }, -- shall_shell
        },

        {
            { itemid = xi.item.MYTHRIL_BEASTCOIN, droprate = 300 }, -- mythril_beastcoin
            { itemid = xi.item.BLACK_ROCK,        droprate =  70 }, -- black_rock
            { itemid = xi.item.PURPLE_ROCK,       droprate =  30 }, -- purple_rock
            { itemid = xi.item.WHITE_ROCK,        droprate = 100 }, -- white_rock
            { itemid = xi.item.PLATOON_BOW,       droprate = 100 }, -- platoon_bow
            { itemid = xi.item.PLATOON_MACE,      droprate = 100 }, -- platoon_mace
            { itemid = xi.item.PLATOON_DISC,      droprate = 150 }, -- platoon_disc
            { itemid = xi.item.PLATOON_GUN,       droprate = 150 }, -- platoon_gun
        },

        {
            { itemid = xi.item.MYTHRIL_BEASTCOIN, droprate = 310 }, -- mythril_beastcoin
            { itemid = xi.item.GREEN_ROCK,        droprate =  50 }, -- green_rock
            { itemid = xi.item.YELLOW_ROCK,       droprate =  40 }, -- yellow_rock
            { itemid = xi.item.BLUE_ROCK,         droprate =  40 }, -- blue_rock
            { itemid = xi.item.RED_ROCK,          droprate =  40 }, -- red_rock
            { itemid = xi.item.TRANSLUCENT_ROCK,  droprate = 110 }, -- translucent_rock
            { itemid = xi.item.PLATOON_CESTI,     droprate = 130 }, -- platoon_cesti
            { itemid = xi.item.PLATOON_CUTTER,    droprate = 100 }, -- platoon_cutter
            { itemid = xi.item.PLATOON_SPATHA,    droprate =  80 }, -- platoon_spatha
            { itemid = xi.item.PLATOON_ZAGHNAL,   droprate = 100 }, -- platoon_zaghnal
        },

        {
            { itemid = xi.item.NONE,                    droprate = 670 }, -- nothing
            { itemid = xi.item.HANDFUL_OF_PUGIL_SCALES, droprate = 190 }, -- handful_of_pugil_scales
            { itemid = xi.item.SHALL_SHELL,             droprate = 140 }, -- shall_shell
        },

        {
            { itemid = xi.item.NONE,           droprate = 930 }, -- nothing
            { itemid = xi.item.MANNEQUIN_BODY, droprate =  70 }, -- mannequin_body
        },

        {
            { itemid = xi.item.SCROLL_OF_BLAZE_SPIKES,  droprate = 180 }, -- scroll_of_blaze_spikes
            { itemid = xi.item.SCROLL_OF_HORDE_LULLABY, droprate = 510 }, -- scroll_of_horde_lullaby
            { itemid = xi.item.THUNDER_SPIRIT_PACT,     droprate = 280 }, -- thunder_spirit_pact
            { itemid = xi.item.SCROLL_OF_WARP,          droprate =  30 }, -- scroll_of_warp
        },
    },

    -- BCNM Dropping Like Flies
    [10] =
    {
        {
            { itemid = xi.item.GIL, droprate = 1000, amount = 4000 }, -- Gil
        },

        {
            { itemid = xi.item.INSECT_WING, droprate = 1000 }, -- Insect Wing
        },

        {
            { itemid = xi.item.MANNEQUIN_HEAD, droprate = 1000 }, -- Mannequin Head
        },

        {
            { itemid = xi.item.NONE,            droprate = 636 }, -- Nothing
            { itemid = xi.item.EMPEROR_HAIRPIN, droprate = 364 }, -- Emperor Hairpin
        },

        {
            { itemid = xi.item.ASHIGARU_TARGE,  droprate = 175 }, -- Ashigaru Targe
            { itemid = xi.item.BEATERS_ASPIS,   droprate = 175 }, -- Beaters Aspis
            { itemid = xi.item.VARLETS_TARGE,   droprate = 175 }, -- Varlets Targe
            { itemid = xi.item.WRESTLERS_ASPIS, droprate = 175 }, -- Wrestlers Aspis
            { itemid = xi.item.CLEAR_TOPAZ,     droprate = 100 }, -- Clear Topaz
            { itemid = xi.item.LAPIS_LAZULI,    droprate = 100 }, -- Lapis Lazuli
            { itemid = xi.item.LIGHT_OPAL,      droprate = 100 }, -- Light Opal
        },

        {
            { itemid = xi.item.MERCENARY_MANTLE, droprate = 250 }, -- Mercenary Mantle
            { itemid = xi.item.SINGERS_MANTLE,   droprate = 250 }, -- Singers Mantle
            { itemid = xi.item.WIZARDS_MANTLE,   droprate = 250 }, -- Wizards Mantle
            { itemid = xi.item.WYVERN_MANTLE,    droprate = 250 }, -- Wyvern Mantle
        },

        {
            { itemid = xi.item.SCROLL_OF_UTSUSEMI_NI,   droprate =  70 }, -- Scroll Of Utsusemi Ni
            { itemid = xi.item.SCROLL_OF_MAGIC_FINALE,  droprate =  70 }, -- Scroll Of Magic Finale
            { itemid = xi.item.JUG_OF_QUADAV_BUG_BROTH, droprate = 150 }, -- Jug Of Quadav Bug Broth
            { itemid = xi.item.ONYX,                    droprate = 100 }, -- Onyx
            { itemid = xi.item.LAPIS_LAZULI,            droprate = 100 }, -- Lapis Lazuli
            { itemid = xi.item.LIGHT_OPAL,              droprate = 100 }, -- Light Opal
            { itemid = xi.item.SCROLL_OF_DISPEL,        droprate = 150 }, -- Scroll Of Dispel
            { itemid = xi.item.SCROLL_OF_ERASE,         droprate = 100 }, -- Scroll Of Erase
            { itemid = xi.item.ELM_LOG,                 droprate =  90 }, -- Elm Log
            { itemid = xi.item.MANNEQUIN_BODY,          droprate =  70 }, -- Mannequin Body
        },
    },

    -- KSNM Horns of War
    [11] =
    {
        {
            { itemid = xi.item.LIBATION_ABJURATION, droprate = 169 }, -- Libation Abjuration
            { itemid = xi.item.KRIEGSBEIL,          droprate = 268 }, -- Kriegsbeil
            { itemid = xi.item.SHINSOKU,            droprate =  99 }, -- Shinsoku
            { itemid = xi.item.NOKIZARU_SHURIKEN,   droprate =  85 }, -- Nokizaru Shuriken
            { itemid = xi.item.GUESPIERE,           droprate =  70 }, -- Guespiere
            { itemid = xi.item.PURGATORY_MACE,      droprate =  85 }, -- Purgatory Mace
            { itemid = xi.item.METEOR_CESTI,        droprate = 225 }, -- Meteor Cesti
        },

        {
            { itemid = xi.item.OBLATION_ABJURATION, droprate = 169 }, -- Oblation Abjuration
            { itemid = xi.item.UNSHO,               droprate =  14 }, -- Unsho
            { itemid = xi.item.HARLEQUINS_HORN,     droprate = 239 }, -- Harlequins Horn
            { itemid = xi.item.DREIZACK,            droprate =  85 }, -- Dreizack
            { itemid = xi.item.GAWAINS_AXE,         droprate = 254 }, -- Gawains Axe
            { itemid = xi.item.ZEN_POLE,            droprate = 183 }, -- Zen Pole
            { itemid = xi.item.BAYARDS_SWORD,       droprate  = 70 }, -- Bayards Sword
        },

        {
            { itemid = xi.item.PETRIFIED_LOG,           droprate = 563 }, -- Petrified Log
            { itemid = xi.item.LACQUER_TREE_LOG,        droprate = 296 }, -- Lacquer Tree Log
            { itemid = xi.item.SQUARE_OF_SHINING_CLOTH, droprate =  14 }, -- Square Of Shining Cloth
            { itemid = xi.item.DIVINE_LOG,              droprate = 141 }, -- Divine Log
        },

        {
            { itemid = xi.item.BEHEMOTH_HIDE, droprate = 535 }, -- Behemoth Hide
            { itemid = xi.item.BEHEMOTH_HORN, droprate = 366 }, -- Behemoth Horn
            { itemid = xi.item.HEALING_STAFF, droprate =  48 }, -- Healing Staff
        },

        {
            { itemid = xi.item.DEMON_HORN,               droprate =  99 }, -- Demon Horn
            { itemid = xi.item.PETRIFIED_LOG,            droprate =  70 }, -- Petrified Log
            { itemid = xi.item.SQUARE_OF_RAXA,           droprate =  70 }, -- Square Of Raxa
            { itemid = xi.item.SQUARE_OF_RAINBOW_CLOTH,  droprate =  28 }, -- Square Of Rainbow Cloth
            { itemid = xi.item.HI_RERAISER,              droprate = 113 }, -- Hi-reraiser
            { itemid = xi.item.PETRIFIED_LOG,            droprate = 211 }, -- Petrified Log
            { itemid = xi.item.PHILOSOPHERS_STONE,       droprate = 141 }, -- Philosophers Stone
            { itemid = xi.item.CHUNK_OF_GOLD_ORE,        droprate =  56 }, -- Chunk Of Gold Ore
            { itemid = xi.item.CHUNK_OF_MYTHRIL_ORE,     droprate =  85 }, -- Chunk Of Mythril Ore
            { itemid = xi.item.CORAL_FRAGMENT,           droprate =  70 }, -- Coral Fragment
            { itemid = xi.item.MAHOGANY_LOG,             droprate =  85 }, -- Mahogany Log
            { itemid = xi.item.HANDFUL_OF_WYVERN_SCALES, droprate =  42 }, -- Handful Of Wyvern Scales
            { itemid = xi.item.CHUNK_OF_DARKSTEEL_ORE,   droprate =  42 }, -- Chunk Of Darksteel Ore
            { itemid = xi.item.RAM_HORN,                 droprate =  70 }, -- Ram Horn
            { itemid = xi.item.EBONY_LOG,                droprate =  85 }, -- Ebony Log
            { itemid = xi.item.RERAISER,                 droprate =  28 }, -- Reraiser
            { itemid = xi.item.CHUNK_OF_PLATINUM_ORE,    droprate =  42 }, -- Chunk Of Platinum Ore
            { itemid = xi.item.VILE_ELIXIR,              droprate =  42 }, -- Vile Elixir
            { itemid = xi.item.VILE_ELIXIR_P1,           droprate =   7 }, -- Vile Elixir +1
        },

        {
            { itemid = xi.item.BEHEMOTH_TONGUE,  droprate = 208 }, -- Behemoth Tongue
            { itemid = xi.item.BEHEMOTH_HORN,    droprate = 296 }, -- Behemoth Horn
            { itemid = xi.item.STRENGTH_POTION,  droprate = 155 }, -- Strength Potion
            { itemid = xi.item.DEXTERITY_POTION, droprate =  70 }, -- Dexterity Potion
            { itemid = xi.item.AGILITY_POTION,   droprate = 141 }, -- Agility Potion
            { itemid = xi.item.VITALITY_POTION,  droprate = 113 }, -- Vitality Potion
        },

        {
            { itemid = xi.item.BEASTLY_SHANK, droprate = 1000 }, -- Beastly Shank
        },

        {
            { itemid = xi.item.MIND_POTION,         droprate = 169 }, -- Mind Potion
            { itemid = xi.item.INTELLIGENCE_POTION, droprate =  70 }, -- Intelligence Potion
            { itemid = xi.item.CHARISMA_POTION,     droprate = 113 }, -- Charisma Potion
            { itemid = xi.item.ICARUS_WING,         droprate = 155 }, -- Icarus Wing
            { itemid = xi.item.ANGEL_LYRE,          droprate = 254 }, -- Angel Lyre
            { itemid = xi.item.EMERALD,             droprate =  99 }, -- Emerald
            { itemid = xi.item.SPINEL,              droprate =  42 }, -- Spinel
            { itemid = xi.item.RUBY,                droprate =  56 }, -- Ruby
            { itemid = xi.item.DIAMOND,             droprate =  28 }, -- Diamond
        },

        {
            { itemid = xi.item.HI_ETHER_P3,    droprate = 296 }, -- Hi-ether +3
            { itemid = xi.item.HI_POTION_P3,   droprate = 225 }, -- Hi-potion +3
            { itemid = xi.item.HI_RERAISER,    droprate = 197 }, -- Hi-reraiser
            { itemid = xi.item.VILE_ELIXIR_P1, droprate = 282 }, -- Vile Elixir +1
        },

        {
            { itemid = xi.item.CORAL_FRAGMENT,           droprate = 141 }, -- Coral Fragment
            { itemid = xi.item.SQUARE_OF_RAXA,           droprate =  14 }, -- Square Of Raxa
            { itemid = xi.item.DEMON_HORN,               droprate = 113 }, -- Demon Horn
            { itemid = xi.item.CHUNK_OF_GOLD_ORE,        droprate =  28 }, -- Chunk Of Gold Ore
            { itemid = xi.item.CHUNK_OF_MYTHRIL_ORE,     droprate =  85 }, -- Chunk Of Mythril Ore
            { itemid = xi.item.VILE_ELIXIR,              droprate =  56 }, -- Vile Elixir
            { itemid = xi.item.RAM_HORN,                 droprate =  28 }, -- Ram Horn
            { itemid = xi.item.PETRIFIED_LOG,            droprate = 296 }, -- Petrified Log
            { itemid = xi.item.CHUNK_OF_PLATINUM_ORE,    droprate =  14 }, -- Chunk Of Platinum Ore
            { itemid = xi.item.MAHOGANY_LOG,             droprate =  56 }, -- Mahogany Log
            { itemid = xi.item.HANDFUL_OF_WYVERN_SCALES, droprate =  70 }, -- Handful Of Wyvern Scales
            { itemid = xi.item.SLAB_OF_GRANITE,          droprate =  42 }, -- Slab Of Granite
            { itemid = xi.item.CHUNK_OF_DARKSTEEL_ORE,   droprate =  42 }, -- Chunk Of Darksteel Ore
            { itemid = xi.item.EBONY_LOG,                droprate =  42 }, -- Ebony Log
            { itemid = xi.item.HI_RERAISER,              droprate =  42 }, -- Hi-reraiser
            { itemid = xi.item.SPOOL_OF_GOLD_THREAD,     droprate = 113 }, -- Spool Of Gold Thread
            { itemid = xi.item.SQUARE_OF_RAINBOW_CLOTH,  droprate =  28 }, -- Square Of Rainbow Cloth
        },

        {
            { itemid = xi.item.SQUARE_OF_RAXA,             droprate = 127 }, -- Square Of Raxa
            { itemid = xi.item.SPOOL_OF_MALBORO_FIBER,     droprate =  56 }, -- Spool Of Malboro Fiber
            { itemid = xi.item.PHILOSOPHERS_STONE,         droprate = 225 }, -- Philosophers Stone
            { itemid = xi.item.PHOENIX_FEATHER,            droprate = 423 }, -- Phoenix Feather
            { itemid = xi.item.SQUARE_OF_DAMASCENE_CLOTH,  droprate =  70 }, -- Square Of Damascene Cloth
            { itemid = xi.item.DAMASCUS_INGOT,             droprate =  42 }, -- Damascus Ingot
            { itemid = xi.item.VIAL_OF_BLACK_BEETLE_BLOOD, droprate =  85 }, -- Vial Of Black Beetle Blood
        },
    },

    -- BCNM Under Observation
    [12] =
    {
        {
            { itemid = xi.item.NONE,          droprate = 910 }, -- Nothing
            { itemid = xi.item.PEACOCK_CHARM, droprate =  90 }, -- Peacock Charm
        },

        {
            { itemid = xi.item.NONE,          droprate = 467 }, -- Nothing
            { itemid = xi.item.BEHOURD_LANCE, droprate =  48 }, -- Behourd Lance
            { itemid = xi.item.MUTILATOR,     droprate =  61 }, -- Mutilator
            { itemid = xi.item.RAIFU,         droprate =  46 }, -- Raifu
            { itemid = xi.item.TILT_BELT,     droprate = 302 }, -- Tilt Belt
            { itemid = xi.item.TOURNEY_PATAS, droprate =  76 }, -- Tourney Patas
        },

        {
            { itemid = xi.item.NONE,                  droprate = 413 }, -- Nothing
            { itemid = xi.item.BUZZARD_TUCK,          droprate =  42 }, -- Buzzard Tuck
            { itemid = xi.item.DE_SAINTRES_AXE,       droprate =  77 }, -- De Saintres Axe
            { itemid = xi.item.GRUDGE_SWORD,          droprate =  73 }, -- Grudge Sword
            { itemid = xi.item.MANTRA_BELT,           droprate = 258 }, -- Mantra Belt
            { itemid = xi.item.SCROLL_OF_REFRESH,     droprate =  68 }, -- Scroll Of Refresh
            { itemid = xi.item.SCROLL_OF_UTSUSEMI_NI, droprate =  55 }, -- Scroll Of Utsusemi Ni
            { itemid = xi.item.SCROLL_OF_ICE_SPIKES,  droprate =  14 }, -- Scroll Of Ice Spikes
        },

        {
            { itemid = xi.item.SCROLL_OF_ICE_SPIKES,  droprate = 114 }, -- Scroll Of Ice Spikes
            { itemid = xi.item.SCROLL_OF_REFRESH,     droprate = 174 }, -- Scroll Of Refresh
            { itemid = xi.item.SCROLL_OF_UTSUSEMI_NI, droprate = 138 }, -- Scroll Of Utsusemi Ni
            { itemid = xi.item.RED_ROCK,              droprate =  16 }, -- Red Rock
            { itemid = xi.item.BLUE_ROCK,             droprate =  17 }, -- Blue Rock
            { itemid = xi.item.YELLOW_ROCK,           droprate =  17 }, -- Yellow Rock
            { itemid = xi.item.GREEN_ROCK,            droprate =  18 }, -- Green Rock
            { itemid = xi.item.TRANSLUCENT_ROCK,      droprate =  17 }, -- Translucent Rock
            { itemid = xi.item.PURPLE_ROCK,           droprate =  16 }, -- Purple Rock
            { itemid = xi.item.BLACK_ROCK,            droprate =  18 }, -- Black Rock
            { itemid = xi.item.WHITE_ROCK,            droprate =  16 }, -- White Rock
            { itemid = xi.item.MYTHRIL_BEASTCOIN,     droprate = 102 }, -- Mythril Beastcoin
            { itemid = xi.item.GOLD_BEASTCOIN,        droprate = 120 }, -- Gold Beastcoin
            { itemid = xi.item.OAK_LOG,               droprate =  22 }, -- Oak Log
            { itemid = xi.item.AMETRINE,              droprate =  18 }, -- Ametrine
            { itemid = xi.item.BLACK_PEARL,           droprate =  18 }, -- Black Pearl
            { itemid = xi.item.GARNET,                droprate =  20 }, -- Garnet
            { itemid = xi.item.GOSHENITE,             droprate =  19 }, -- Goshenite
            { itemid = xi.item.PEARL,                 droprate =  21 }, -- Pearl
            { itemid = xi.item.PERIDOT,               droprate =  35 }, -- Peridot
            { itemid = xi.item.SPHENE,                droprate =  17 }, -- Sphene
            { itemid = xi.item.TURQUOISE,             droprate =  23 }, -- Turquoise
            { itemid = xi.item.RERAISER,              droprate =  21 }, -- Reraiser
            { itemid = xi.item.VILE_ELIXIR,           droprate =  16 }, -- Vile Elixir
        },

        {
            { itemid = xi.item.FIRE_SPIRIT_PACT,     droprate = 116 }, -- Fire Spirit Pact
            { itemid = xi.item.SCROLL_OF_ABSORB_STR, droprate = 113 }, -- Scroll Of Absorb-str
            { itemid = xi.item.SCROLL_OF_ERASE,      droprate = 137 }, -- Scroll Of Erase
            { itemid = xi.item.SCROLL_OF_ICE_SPIKES, droprate =  67 }, -- Scroll Of Ice Spikes
            { itemid = xi.item.SCROLL_OF_PHALANX,    droprate =  99 }, -- Scroll Of Phalanx
            { itemid = xi.item.AMETRINE,             droprate =  58 }, -- Ametrine
            { itemid = xi.item.BLACK_PEARL,          droprate =  52 }, -- Black Pearl
            { itemid = xi.item.GARNET,               droprate =  51 }, -- Garnet
            { itemid = xi.item.GOSHENITE,            droprate =  65 }, -- Goshenite
            { itemid = xi.item.PEARL,                droprate =  61 }, -- Pearl
            { itemid = xi.item.PERIDOT,              droprate =  63 }, -- Peridot
            { itemid = xi.item.SPHENE,               droprate =  55 }, -- Sphene
            { itemid = xi.item.TURQUOISE,            droprate =  62 }, -- Turquoise
        },

        {
            { itemid = xi.item.HECTEYES_EYE, droprate = 1000 }, -- Hecteyes Eye
        },

        {
            { itemid = xi.item.VIAL_OF_MERCURY, droprate = 1000 }, -- Vial Of Mercury
        },
    },

    -- BCNM Eye of the Tiger
    [13] =
    {
        {
            { itemid = xi.item.BLACK_TIGER_FANG, droprate = 1000 }, -- black_tiger_fang
        },

        {
            { itemid = xi.item.BLACK_TIGER_FANG, droprate = 1000 }, -- black_tiger_fang
        },

        {
            { itemid = xi.item.NONE,     droprate = 700 }, -- nothing
            { itemid = xi.item.NUE_FANG, droprate = 300 }, -- nue_fang
        },

        {
            { itemid = xi.item.NONE,                    droprate = 125 }, -- nothing
            { itemid = xi.item.IVORY_MITTS,             droprate = 125 }, -- ivory_mitts
            { itemid = xi.item.SUPER_RIBBON,            droprate = 125 }, -- super_ribbon
            { itemid = xi.item.MANA_CIRCLET,            droprate = 125 }, -- mana_circlet
            { itemid = xi.item.RIVAL_RIBBON,            droprate = 125 }, -- rival_ribbon
            { itemid = xi.item.SLY_GAUNTLETS,           droprate = 125 }, -- sly_gauntlets
            { itemid = xi.item.SHOCK_MASK,              droprate = 125 }, -- shock_mask
            { itemid = xi.item.SPIKED_FINGER_GAUNTLETS, droprate = 125 }, -- spiked_finger_gauntlets
        },

        {
            { itemid = xi.item.INTELLECT_TORQUE, droprate = 125 }, -- intellect_torque
            { itemid = xi.item.ESOTERIC_MANTLE,  droprate = 125 }, -- esoteric_mantle
            { itemid = xi.item.TEMPLARS_MANTLE,  droprate = 125 }, -- templars_mantle
            { itemid = xi.item.SNIPERS_MANTLE,   droprate = 125 }, -- snipers_mantle
            { itemid = xi.item.HATEFUL_COLLAR,   droprate = 125 }, -- hateful_collar
            { itemid = xi.item.STORM_GORGET,     droprate = 125 }, -- storm_gorget
            { itemid = xi.item.HEAVY_MANTLE,     droprate = 125 }, -- heavy_mantle
            { itemid = xi.item.BENIGN_NECKLACE,  droprate = 125 }, -- benign_necklace
        },

        {
            { itemid = xi.item.NONE,           droprate = 125 }, -- nothing
            { itemid = xi.item.GOLD_INGOT,     droprate = 125 }, -- gold_ingot
            { itemid = xi.item.RAM_HORN,       droprate = 125 }, -- ram_horn
            { itemid = xi.item.WYVERN_SKIN,    droprate = 125 }, -- wyvern_skin
            { itemid = xi.item.EBONY_LOG,      droprate = 125 }, -- ebony_log
            { itemid = xi.item.MYTHRIL_INGOT,  droprate = 125 }, -- mythril_ingot
            { itemid = xi.item.RAM_SKIN,       droprate = 125 }, -- ram_skin
            { itemid = xi.item.CORAL_FRAGMENT, droprate = 125 }, -- coral_fragment
        },

        {
            { itemid = xi.item.NONE,                  droprate = 400 }, -- nothing
            { itemid = xi.item.SLICE_OF_BUFFALO_MEAT, droprate = 200 }, -- slice_of_buffalo_meat
            { itemid = xi.item.SLICE_OF_DRAGON_MEAT,  droprate = 200 }, -- slice_of_dragon_meat
            { itemid = xi.item.SLICE_OF_COEURL_MEAT,  droprate = 200 }, -- slice_of_coeurl_meat
        },

        {
            { itemid = xi.item.NONE,               droprate = 625 }, -- nothing
            { itemid = xi.item.SCROLL_OF_FREEZE,   droprate = 125 }, -- scroll_of_freeze
            { itemid = xi.item.SCROLL_OF_RAISE_II, droprate = 125 }, -- scroll_of_raise_ii
            { itemid = xi.item.SCROLL_OF_QUAKE,    droprate = 125 }, -- scroll_of_quake
        },
    },

    -- BCNM Shots in the Dark
    [14] =
    {
        {
            { itemid = xi.item.GOLD_BEASTCOIN,    droprate = 500 }, -- gold_beastcoin
            { itemid = xi.item.MYTHRIL_BEASTCOIN, droprate = 500 }, -- mythril_beastcoin
        },

        {
            { itemid = xi.item.STEEL_INGOT, droprate = 500 }, -- steel_ingot
            { itemid = xi.item.AQUAMARINE,  droprate = 500 }, -- aquamarine
        },

        {
            { itemid = xi.item.NONE,         droprate = 500 }, -- nothing
            { itemid = xi.item.DEMON_QUIVER, droprate = 500 }, -- demon_quiver
        },

        {
            { itemid = xi.item.NONE,                droprate = 600 }, -- nothing
            { itemid = xi.item.TELEPORT_RING_HOLLA, droprate = 200 }, -- teleport_ring_holla
            { itemid = xi.item.TELEPORT_RING_VAHZL, droprate = 200 }, -- teleport_ring_vahzl
        },

        {
            { itemid = xi.item.NONE,                droprate = 600 }, -- nothing
            { itemid = xi.item.SAPIENT_CAPE,        droprate = 200 }, -- sapient_cape
            { itemid = xi.item.TRAINERS_WRISTBANDS, droprate = 200 }, -- trainers_wristbands
        },
    },

    -- KSNM Double Dragonian
    [15] =
    {
        {
            { itemid = xi.item.SUBDUER,        droprate = 222 }, -- Subduer
            { itemid = xi.item.DISSECTOR,      droprate = 302 }, -- Dissector
            { itemid = xi.item.DESTROYERS,     droprate = 245 }, -- Destroyers
            { itemid = xi.item.HEART_SNATCHER, droprate = 208 }, -- Heart Snatcher
        },

        {
            { itemid = xi.item.NONE,                 droprate = 638 }, -- Nothing
            { itemid = xi.item.VIAL_OF_DRAGON_BLOOD, droprate =  10 }, -- Vial Of Dragon Blood
            { itemid = xi.item.DRAGON_HEART,         droprate = 176 }, -- Dragon Heart
            { itemid = xi.item.SLICE_OF_DRAGON_MEAT, droprate = 176 }, -- Slice Of Dragon Meat
        },

        {
            { itemid = xi.item.NONE,                 droprate = 638 }, -- Nothing
            { itemid = xi.item.VIAL_OF_DRAGON_BLOOD, droprate =  10 }, -- Vial Of Dragon Blood
            { itemid = xi.item.DRAGON_HEART,         droprate = 176 }, -- Dragon Heart
            { itemid = xi.item.SLICE_OF_DRAGON_MEAT, droprate = 176 }, -- Slice Of Dragon Meat
        },

        {
            { itemid = xi.item.NONE,        droprate = 392 }, -- Nothing
            { itemid = xi.item.SPEAR_STRAP, droprate = 354 }, -- Spear Strap
            { itemid = xi.item.SWORD_STRAP, droprate = 165 }, -- Sword Strap
            { itemid = xi.item.POLE_GRIP,   droprate =  89 }, -- Pole Grip
        },

        {
            { itemid = xi.item.MINUET_EARRING,   droprate = 586 }, -- Minuet Earring
            { itemid = xi.item.ADAMAN_INGOT,     droprate = 184 }, -- Adaman Ingot
            { itemid = xi.item.ORICHALCUM_INGOT, droprate = 207 }, -- Orichalcum Ingot
        },

        {
            { itemid = xi.item.SORROWFUL_HARP,  droprate = 238 }, -- Sorrowful Harp
            { itemid = xi.item.ATTILAS_EARRING, droprate = 250 }, -- Attilas Earring
            { itemid = xi.item.DURANDAL,        droprate = 225 }, -- Durandal
            { itemid = xi.item.HOPLITES_HARPE,  droprate = 275 }, -- Hoplites Harpe
        },

        {
            { itemid = xi.item.CHUNK_OF_GOLD_ORE,        droprate = 122 }, -- Chunk Of Gold Ore
            { itemid = xi.item.RERAISER,                 droprate =  54 }, -- Reraiser
            { itemid = xi.item.CHUNK_OF_MYTHRIL_ORE,     droprate =  41 }, -- Chunk Of Mythril Ore
            { itemid = xi.item.DEMON_HORN,               droprate =  81 }, -- Demon Horn
            { itemid = xi.item.EBONY_LOG,                droprate = 149 }, -- Ebony Log
            { itemid = xi.item.HANDFUL_OF_WYVERN_SCALES, droprate =  54 }, -- Handful Of Wyvern Scales
            { itemid = xi.item.VILE_ELIXIR_P1,           droprate =  27 }, -- Vile Elixir +1
            { itemid = xi.item.MAHOGANY_LOG,             droprate =  41 }, -- Mahogany Log
            { itemid = xi.item.CORAL_FRAGMENT,           droprate =  95 }, -- Coral Fragment
            { itemid = xi.item.PETRIFIED_LOG,            droprate = 108 }, -- Petrified Log
            { itemid = xi.item.PHOENIX_FEATHER,          droprate = 135 }, -- Phoenix Feather
            { itemid = xi.item.CHUNK_OF_PLATINUM_ORE,    droprate =  54 }, -- Chunk Of Platinum Ore
            { itemid = xi.item.RAM_HORN,                 droprate =  14 }, -- Ram Horn
            { itemid = xi.item.SQUARE_OF_RAINBOW_CLOTH,  droprate =  14 }, -- Square Of Rainbow Cloth
            { itemid = xi.item.CHUNK_OF_DARKSTEEL_ORE,   droprate =  68 }, -- Chunk Of Darksteel Ore
            { itemid = xi.item.HI_RERAISER,              droprate =  14 }, -- Hi-reraiser
            { itemid = xi.item.SQUARE_OF_RAXA,           droprate = 135 }, -- Square Of Raxa
        },

        {
            { itemid = xi.item.SQUARE_OF_DAMASCENE_CLOTH,  droprate =  96 }, -- Square Of Damascene Cloth
            { itemid = xi.item.DAMASCUS_INGOT,             droprate =  27 }, -- Damascus Ingot
            { itemid = xi.item.PHILOSOPHERS_STONE,         droprate = 164 }, -- Philosophers Stone
            { itemid = xi.item.PHOENIX_FEATHER,            droprate = 260 }, -- Phoenix Feather
            { itemid = xi.item.SPOOL_OF_MALBORO_FIBER,     droprate =  96 }, -- Spool Of Malboro Fiber
            { itemid = xi.item.SQUARE_OF_RAXA,             droprate = 288 }, -- Square Of Raxa
            { itemid = xi.item.VIAL_OF_BLACK_BEETLE_BLOOD, droprate =  41 }, -- Vial Of Black Beetle Blood
        },
    },

    -- KSNM Contaminated Colosseum
    [17] =
    {
        {
            { itemid = xi.item.SPOOL_OF_MALBORO_FIBER, droprate = 1000 }, -- Spool Of Malboro Fiber
        },

        {
            { itemid = xi.item.MICHISHIBA_NO_TSUYU, droprate = 217 }, -- Michishiba-no-tsuyu
            { itemid = xi.item.MORGENSTERN,         droprate = 174 }, -- Morgenstern
            { itemid = xi.item.SENJUINRIKIO,        droprate = 333 }, -- Senjuinrikio
            { itemid = xi.item.THYRSUSSTAB,         droprate = 174 }, -- Thyrsusstab
        },

        {
            { itemid = xi.item.CASSIE_EARRING, droprate = 101 }, -- Cassie Earring
            { itemid = xi.item.CLAYMORE_GRIP,  droprate =  43 }, -- Claymore Grip
            { itemid = xi.item.MALBORO_VINE,   droprate = 275 }, -- Malboro Vine
            { itemid = xi.item.MORBOLGER_VINE, droprate = 275 }, -- Morbolger Vine
            { itemid = xi.item.POLE_GRIP,      droprate = 203 }, -- Pole Grip
            { itemid = xi.item.SPEAR_STRAP,    droprate = 116 }, -- Spear Strap
        },

        {
            { itemid = xi.item.ADAMAN_INGOT,     droprate = 159 }, -- Adaman Ingot
            { itemid = xi.item.ORICHALCUM_INGOT, droprate = 290 }, -- Orichalcum Ingot
            { itemid = xi.item.OSCAR_SCARF,      droprate = 406 }, -- Oscar Scarf
        },

        {
            { itemid = xi.item.EVOKERS_BOOTS,  droprate = 159 }, -- Evokers Boots
            { itemid = xi.item.OSTREGER_MITTS, droprate = 217 }, -- Ostreger Mitts
            { itemid = xi.item.PINEAL_HAT,     droprate = 145 }, -- Pineal Hat
            { itemid = xi.item.TRACKERS_KECKS, droprate = 159 }, -- Trackers Kecks
        },

        {
            { itemid = xi.item.CORAL_FRAGMENT,           droprate = 101 }, -- Coral Fragment
            { itemid = xi.item.CHUNK_OF_DARKSTEEL_ORE,   droprate =  29 }, -- Chunk Of Darksteel Ore
            { itemid = xi.item.DEMON_HORN,               droprate =  29 }, -- Demon Horn
            { itemid = xi.item.EBONY_LOG,                droprate =  29 }, -- Ebony Log
            { itemid = xi.item.CHUNK_OF_GOLD_ORE,        droprate = 101 }, -- Chunk Of Gold Ore
            { itemid = xi.item.SPOOL_OF_GOLD_THREAD,     droprate =  29 }, -- Spool Of Gold Thread
            { itemid = xi.item.SLAB_OF_GRANITE,          droprate =  29 }, -- Slab Of Granite
            { itemid = xi.item.MAHOGANY_LOG,             droprate =  43 }, -- Mahogany Log
            { itemid = xi.item.CHUNK_OF_MYTHRIL_ORE,     droprate =  29 }, -- Chunk Of Mythril Ore
            { itemid = xi.item.PETRIFIED_LOG,            droprate =  58 }, -- Petrified Log
            { itemid = xi.item.CHUNK_OF_PLATINUM_ORE,    droprate =  14 }, -- Chunk Of Platinum Ore
            { itemid = xi.item.SQUARE_OF_RAINBOW_CLOTH,  droprate =  58 }, -- Square Of Rainbow Cloth
            { itemid = xi.item.RAM_HORN,                 droprate =  14 }, -- Ram Horn
            { itemid = xi.item.VILE_ELIXIR,              droprate =  58 }, -- Vile Elixir
            { itemid = xi.item.VILE_ELIXIR_P1,           droprate =  29 }, -- Vile Elixir +1
            { itemid = xi.item.HANDFUL_OF_WYVERN_SCALES, droprate =  72 }, -- Handful Of Wyvern Scales
        },

        {
            { itemid = xi.item.VIAL_OF_BLACK_BEETLE_BLOOD, droprate =  87 }, -- Vial Of Black Beetle Blood
            { itemid = xi.item.DAMASCUS_INGOT,             droprate =  14 }, -- Damascus Ingot
            { itemid = xi.item.SQUARE_OF_DAMASCENE_CLOTH,  droprate =  29 }, -- Square Of Damascene Cloth
            { itemid = xi.item.SPOOL_OF_MALBORO_FIBER,     droprate =  43 }, -- Spool Of Malboro Fiber
            { itemid = xi.item.PHILOSOPHERS_STONE,         droprate = 174 }, -- Philosophers Stone
            { itemid = xi.item.PHOENIX_FEATHER,            droprate = 246 }, -- Phoenix Feather
            { itemid = xi.item.SQUARE_OF_RAXA,             droprate = 159 }, -- Square Of Raxa
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
