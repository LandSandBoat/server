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
            { itemid = xi.item.NONE,                  droprate = 125 }, -- nothing
            { itemid = xi.item.FIRE_SPIRIT_PACT,      droprate = 125 }, -- fire_spirit_pact
            { itemid = xi.item.SCROLL_OF_PHALANX,     droprate = 125 }, -- scroll_of_phalanx
            { itemid = xi.item.SCROLL_OF_UTSUSEMI_NI, droprate = 125 }, -- scroll_of_utsusemi_ni
            { itemid = xi.item.SCROLL_OF_ERASE,       droprate = 125 }, -- scroll_of_erase
            { itemid = xi.item.SCROLL_OF_ICE_SPIKES,  droprate = 125 }, -- scroll_of_ice_spikes
            { itemid = xi.item.SCROLL_OF_ABSORB_STR,  droprate = 125 }, -- scroll_of_absorb-str
            { itemid = xi.item.SCROLL_OF_REFRESH,     droprate = 125 }, -- scroll_of_refresh
        },

        {
            { itemid = xi.item.NONE,              droprate = 125 }, -- nothing
            { itemid = xi.item.ENHANCING_EARRING, droprate = 125 }, -- enhancing_earring
            { itemid = xi.item.SPIRIT_TORQUE,     droprate = 125 }, -- spirit_torque
            { itemid = xi.item.GUARDING_GORGET,   droprate = 125 }, -- guarding_gorget
            { itemid = xi.item.NEMESIS_EARRING,   droprate = 125 }, -- nemesis_earring
            { itemid = xi.item.EARTH_MANTLE,      droprate = 125 }, -- earth_mantle
            { itemid = xi.item.STRIKE_SHIELD,     droprate = 125 }, -- strike_shield
            { itemid = xi.item.SHIKAR_BOW,        droprate = 125 }, -- shikar_bow
        },

        {
            { itemid = xi.item.OAK_LOG,      droprate = 500 }, -- oak_log
            { itemid = xi.item.ROSEWOOD_LOG, droprate = 500 }, -- rosewood_log
        },

        {
            { itemid = xi.item.GOLD_BEASTCOIN,    droprate = 500 }, -- gold_beastcoin
            { itemid = xi.item.MYTHRIL_BEASTCOIN, droprate = 500 }, -- mythril_beastcoin
        },

        {
            { itemid = xi.item.BLACK_PEARL, droprate = 200 }, -- black_pearl
            { itemid = xi.item.AMETRINE,    droprate = 200 }, -- ametrine
            { itemid = xi.item.YELLOW_ROCK, droprate = 200 }, -- yellow_rock
            { itemid = xi.item.PERIDOT,     droprate = 200 }, -- peridot
            { itemid = xi.item.TURQUOISE,   droprate = 200 }, -- turquoise
        },

        {
            { itemid = xi.item.NONE,     droprate = 800 }, -- nothing
            { itemid = xi.item.RERAISER, droprate = 200 }, -- reraiser
        },
    },

    -- BCNM Grimshell Shocktroopers
    [66] =
    {
        {
            { itemid = xi.item.NONE,             droprate = 250 }, -- nothing
            { itemid = xi.item.ASSAULT_EARRING,  droprate = 125 }, -- assault_earring
            { itemid = xi.item.VASSAGOS_SCYTHE,  droprate = 125 }, -- vassagos_scythe
            { itemid = xi.item.CHICKEN_KNIFE,    droprate = 125 }, -- chicken_knife
            { itemid = xi.item.FEY_WAND,         droprate = 125 }, -- fey_wand
            { itemid = xi.item.ASTRAL_SHIELD,    droprate = 125 }, -- astral_shield
            { itemid = xi.item.ENHANCING_MANTLE, droprate = 125 }, -- enhancing_mantle
        },

        {
            { itemid = xi.item.MYTHRIL_INGOT,   droprate = 250 }, -- mythril_ingot
            { itemid = xi.item.STEEL_INGOT,     droprate = 250 }, -- steel_ingot
            { itemid = xi.item.GOLD_INGOT,      droprate = 250 }, -- gold_ingot
            { itemid = xi.item.DARKSTEEL_INGOT, droprate = 250 }, -- darksteel_ingot
        },

        {
            { itemid = xi.item.EBONY_LOG,     droprate = 250 }, -- ebony_log
            { itemid = xi.item.CHRYSOBERYL,   droprate = 250 }, -- chrysoberyl
            { itemid = xi.item.FLUORITE,      droprate = 250 }, -- fluorite
            { itemid = xi.item.DREAM_PLATTER, droprate = 250 }, -- jadeite
        },

        {
            { itemid = xi.item.NONE,               droprate = 875 }, -- nothing
            { itemid = xi.item.SCROLL_OF_RAISE_II, droprate = 125 }, -- scroll_of_raise_ii
        },

        {
            { itemid = xi.item.NONE,               droprate = 800 }, -- nothing
            { itemid = xi.item.SCROLL_OF_RAISE_II, droprate = 200 }, -- hi-reraiser
        },
    },

    -- BCNM 3, 2, 1...
    [69] =
    {
        {
            { itemid = xi.item.KAGEBOSHI, droprate = 500 }, -- kageboshi
            { itemid = xi.item.ODENTA,    droprate = 500 }, -- odenta
        },

        {
            { itemid = xi.item.OCEAN_BELT,  droprate = 200 }, -- ocean_belt
            { itemid = xi.item.FOREST_BELT, droprate = 200 }, -- forest_belt
            { itemid = xi.item.STEPPE_BELT, droprate = 200 }, -- steppe_belt
            { itemid = xi.item.JUNGLE_BELT, droprate = 200 }, -- jungle_belt
            { itemid = xi.item.DESERT_BELT, droprate = 200 }, -- desert_belt
        },

        {
            { itemid = xi.item.NONE,                droprate = 250 }, -- nothing
            { itemid = xi.item.SCROLL_OF_FREEZE,    droprate = 125 }, -- scroll_of_freeze
            { itemid = xi.item.SCROLL_OF_QUAKE,     droprate = 125 }, -- scroll_of_quake
            { itemid = xi.item.SCROLL_OF_RAISE_II,  droprate = 125 }, -- scroll_of_raise_ii
            { itemid = xi.item.SCROLL_OF_REGEN_III, droprate = 125 }, -- scroll_of_regen_iii
            { itemid = xi.item.FIRE_SPIRIT_PACT,    droprate = 125 }, -- fire_spirit_pact
            { itemid = xi.item.LIGHT_SPIRIT_PACT,   droprate = 125 }, -- light_spirit_pact
        },

        {
            { itemid = xi.item.NONE,          droprate = 800 }, -- nothing
            { itemid = xi.item.PETRIFIED_LOG, droprate = 200 }, -- petrified_log
        },
    },

    -- BCNM Birds of a Feather
    [73] =
    {
        {
            { itemid = xi.item.BIRD_FEATHER, droprate = 1000 }, -- Bird Feather
        },

        {
            { itemid = xi.item.ASHIGARU_EARRING,   droprate = 125 }, -- Ashigaru Earring
            { itemid = xi.item.TRIMMERS_EARRING,   droprate = 125 }, -- Trimmers Earring
            { itemid = xi.item.BEATERS_EARRING,    droprate = 125 }, -- Beaters Earring
            { itemid = xi.item.HEALERS_EARRING,    droprate = 125 }, -- Healers Earring
            { itemid = xi.item.MERCENARYS_EARRING, droprate = 125 }, -- Mercenarys Earring
            { itemid = xi.item.SINGERS_EARRING,    droprate = 125 }, -- Singers Earring
            { itemid = xi.item.WIZARDS_EARRING,    droprate = 125 }, -- Wizards Earring
            { itemid = xi.item.WRESTLERS_EARRING,  droprate = 125 }, -- Wrestlers Earring
        },

        {
            { itemid = xi.item.NONE,        droprate = 125 }, -- nothing
            { itemid = xi.item.AVATAR_BELT, droprate = 125 }, -- Avatar Belt
            { itemid = xi.item.DAGGER_BELT, droprate = 125 }, -- Dagger Belt
            { itemid = xi.item.LANCE_BELT,  droprate = 125 }, -- Lance Belt
            { itemid = xi.item.RAPIER_BELT, droprate = 125 }, -- Rapier Belt
            { itemid = xi.item.SARASHI,     droprate = 125 }, -- Sarashi
            { itemid = xi.item.SCYTHE_BELT, droprate = 125 }, -- Scythe Belt
            { itemid = xi.item.SHIELD_BELT, droprate = 125 }, -- Shield Belt
        },

        {
            { itemid = xi.item.NONE,                   droprate = 500 }, -- nothing
            { itemid = xi.item.SCROLL_OF_DISPEL,       droprate = 125 }, -- Scroll Of Dispel
            { itemid = xi.item.SCROLL_OF_ERASE,        droprate = 125 }, -- Scroll Of Erase
            { itemid = xi.item.SCROLL_OF_MAGIC_FINALE, droprate = 125 }, -- Scroll Of Magic Finale
            { itemid = xi.item.SCROLL_OF_UTSUSEMI_NI,  droprate = 125 }, -- Scroll Of Utsusemi Ni
        },

        {
            { itemid = xi.item.NONE,         droprate = 136 }, -- nothing
            { itemid = xi.item.BIRD_EGG,     droprate = 125 }, -- Bird Egg
            { itemid = xi.item.BIRD_FEATHER, droprate =  50 }, -- Bird Feather
            { itemid = xi.item.CHESTNUT_LOG, droprate = 125 }, -- Chestnut Log
            { itemid = xi.item.ELM_LOG,      droprate = 188 }, -- Elm Log
            { itemid = xi.item.HI_ETHER,     droprate =  63 }, -- Hi-ether
            { itemid = xi.item.HORN_QUIVER,  droprate = 313 }, -- Horn Quiver
        },

        {
            { itemid = xi.item.NONE,                 droprate = 123 }, -- nothing
            { itemid = xi.item.IRON_INGOT,           droprate =  63 }, -- Iron Ingot
            { itemid = xi.item.LAPIS_LAZULI,         droprate = 125 }, -- Lapis Lazuli
            { itemid = xi.item.LIGHT_OPAL,           droprate = 125 }, -- Light Opal
            { itemid = xi.item.MYTHRIL_INGOT,        droprate =  63 }, -- Mythril Ingot
            { itemid = xi.item.CHUNK_OF_MYTHRIL_ORE, droprate =  63 }, -- Chunk Of Mythril Ore
            { itemid = xi.item.ONYX,                 droprate = 250 }, -- Onyx
            { itemid = xi.item.CHUNK_OF_SILVER_ORE,  droprate =  63 }, -- Chunk Of Silver Ore
            { itemid = xi.item.SILVER_INGOT,         droprate = 125 }, -- Silver Ingot
        },

    },

    -- BCNM Crustacean Conundrum
    [74] =
    {
        {
            { itemid = xi.item.SLICE_OF_LAND_CRAB_MEAT, droprate = 1000 }, -- slice_of_land_crab_meat
        },

        {
            { itemid = xi.item.MANNEQUIN_BODY, droprate = 1000 }, -- mannequin_body
        },

        {
            { itemid = xi.item.NONE,       droprate = 334 }, -- nothing
            { itemid = xi.item.CRAB_SHELL, droprate = 666 }, -- crab_shell
        },

        {
            { itemid = xi.item.BEETLE_QUIVER,         droprate = 444 }, -- beetle_quiver
            { itemid = xi.item.JUG_OF_FISH_OIL_BROTH, droprate = 556 }, -- jug_of_fish_oil_broth
        },

        {
            { itemid = xi.item.NONE,         droprate = 450 }, -- nothing
            { itemid = xi.item.BRASS_INGOT,  droprate = 100 }, -- brass_ingot
            { itemid = xi.item.BRONZE_SHEET, droprate = 150 }, -- bronze_sheet
            { itemid = xi.item.BRONZE_INGOT, droprate = 300 }, -- bronze_ingot
        },

        {
            { itemid = xi.item.NONE,              droprate = 300 }, -- nothing
            { itemid = xi.item.MYTHRIL_BEASTCOIN, droprate = 500 }, -- mythril_beastcoin
            { itemid = xi.item.MANNEQUIN_HANDS,   droprate = 100 }, -- mannequin_hands
            { itemid = xi.item.MANNEQUIN_HEAD,    droprate = 100 }, -- mannequin_head
        },

        {
            { itemid = xi.item.NONE,            droprate = 200 }, -- nothing
            { itemid = xi.item.PLATOON_CESTI,   droprate = 100 }, -- platoon_cesti
            { itemid = xi.item.PLATOON_DAGGER,  droprate = 100 }, -- platoon_dagger
            { itemid = xi.item.PLATOON_AXE,     droprate = 100 }, -- platoon_axe
            { itemid = xi.item.PLATOON_BOW,     droprate = 100 }, -- platoon_bow
            { itemid = xi.item.PLATOON_LANCE,   droprate = 100 }, -- platoon_lance
            { itemid = xi.item.PLATOON_SWORD,   droprate = 100 }, -- platoon_sword
            { itemid = xi.item.PLATOON_MACE,    droprate = 100 }, -- platoon_mace
            { itemid = xi.item.PLATOON_ZAGHNAL, droprate = 100 }, -- platoon_zaghnal
        },
    },

    -- BCNM Grove Guardians
    [75] =
    {
        {
            { itemid = xi.item.MANNEQUIN_BODY, droprate = 1000 }, -- mannequin_body
        },

        {
            { itemid = xi.item.NONE,            droprate = 800 }, -- nothing
            { itemid = xi.item.MANNEQUIN_HANDS, droprate = 200 }, -- mannequin_hands
        },

        {
            { itemid = xi.item.NONE,             droprate = 250 }, -- nothing
            { itemid = xi.item.WRESTLERS_MANTLE, droprate = 250 }, -- wrestlers_mantle
            { itemid = xi.item.MAGICIANS_MANTLE, droprate = 250 }, -- magicians_mantle
            { itemid = xi.item.PILFERERS_MANTLE, droprate = 250 }, -- pilferers_mantle
        },

        {
            { itemid = xi.item.NONE,           droprate = 200 }, -- nothing
            { itemid = xi.item.HEALERS_SHIELD, droprate = 200 }, -- healers_shield
            { itemid = xi.item.GENIN_ASPIS,    droprate = 200 }, -- genin_aspis
            { itemid = xi.item.KILLER_TARGE,   droprate = 200 }, -- killer_targe
            { itemid = xi.item.STAFF_BELT,     droprate = 200 }, -- staff_belt
        },

        {
            { itemid = xi.item.NONE,                   droprate = 250 }, -- nothing
            { itemid = xi.item.BAG_OF_HERB_SEEDS,      droprate = 250 }, -- bag_of_herb_seeds
            { itemid = xi.item.BAG_OF_VEGETABLE_SEEDS, droprate = 250 }, -- bag_of_vegetable_seeds
            { itemid = xi.item.BAG_OF_GRAIN_SEEDS,     droprate = 250 }, -- bag_of_grain_seeds
        },

        {
            { itemid = xi.item.NONE,                   droprate = 500 }, -- nothing
            { itemid = xi.item.SCROLL_OF_DISPEL,       droprate = 125 }, -- scroll_of_dispel
            { itemid = xi.item.SCROLL_OF_UTSUSEMI_NI,  droprate = 125 }, -- scroll_of_utsusemi_ni
            { itemid = xi.item.SCROLL_OF_MAGIC_FINALE, droprate = 125 }, -- scroll_of_magic_finale
            { itemid = xi.item.SCROLL_OF_ERASE,        droprate = 125 }, -- scroll_of_erase
        },

        {
            { itemid = xi.item.NONE,            droprate = 800 }, -- nothing
            { itemid = xi.item.SCORPION_QUIVER, droprate = 200 }, -- scorpion_quiver
        },
    },

    -- KSNM The Hills are Alive
    [76] =
    {
        {
            { itemid = xi.item.CLUMP_OF_BLUE_PONDWEED, droprate = 1000 }, -- Blue Pondweed
        },

        {
            { itemid = xi.item.HAVOC_SCYTHE,        droprate = 188 }, -- Havoc Scythe
            { itemid = xi.item.KRIEGSBEIL,          droprate =  27 }, -- Kriegsbeil
            { itemid = xi.item.LEOPARD_AXE,         droprate = 170 }, -- Leopard Axe
            { itemid = xi.item.LIBATION_ABJURATION, droprate = 295 }, -- Libation Abjuration
            { itemid = xi.item.METEOR_CESTI,        droprate =  27 }, -- Meteor Cesti
            { itemid = xi.item.PURGATORY_MACE,      droprate =  71 }, -- Purgatory Mace
            { itemid = xi.item.SOMNUS_SIGNA,        droprate = 196 }, -- Somnus Signa
        },

        {
            { itemid = xi.item.GAWAINS_AXE,         droprate =  45 }, -- Gawains Axe
            { itemid = xi.item.GRIM_STAFF,          droprate = 259 }, -- Grim Staff
            { itemid = xi.item.GROSVENEURS_BOW,     droprate = 241 }, -- Grosveneurs Bow
            { itemid = xi.item.HARLEQUINS_HORN,     droprate = 143 }, -- Harlequins Horn
            { itemid = xi.item.OBLATION_ABJURATION, droprate = 161 }, -- Oblation Abjuration
            { itemid = xi.item.STYLET,              droprate = 143 }, -- Stylet
            { itemid = xi.item.ZEN_POLE,            droprate =  36 }, -- Zen Pole
        },

        {
            { itemid = xi.item.ADAMAN_CHAIN,        droprate = 446 }, -- Adaman Chain
            { itemid = xi.item.ADAMANTOISE_SHELL,   droprate = 420 }, -- Adamantoise Shell
            { itemid = xi.item.PIECE_OF_ANGEL_SKIN, droprate =  71 }, -- Piece Of Angel Skin
            { itemid = xi.item.STRIDER_BOOTS,       droprate =  26 }, -- Strider Boots
        },

        {
            { itemid = xi.item.CORAL_FRAGMENT,           droprate = 116 }, -- Coral Fragment
            { itemid = xi.item.CHUNK_OF_DARKSTEEL_ORE,   droprate =  89 }, -- Chunk Of Darksteel Ore
            { itemid = xi.item.DEMON_HORN,               droprate =  71 }, -- Demon Horn
            { itemid = xi.item.EBONY_LOG,                droprate = 152 }, -- Ebony Log
            { itemid = xi.item.CHUNK_OF_GOLD_ORE,        droprate = 107 }, -- Chunk Of Gold Ore
            { itemid = xi.item.SPOOL_OF_GOLD_THREAD,     droprate =  89 }, -- Spool Of Gold Thread
            { itemid = xi.item.SLAB_OF_GRANITE,          droprate =  45 }, -- Slab Of Granite
            { itemid = xi.item.HI_RERAISER,              droprate =  71 }, -- Hi-reraiser
            { itemid = xi.item.MAHOGANY_LOG,             droprate = 107 }, -- Mahogany Log
            { itemid = xi.item.PETRIFIED_LOG,            droprate = 223 }, -- Petrified Log
            { itemid = xi.item.CHUNK_OF_PLATINUM_ORE,    droprate = 116 }, -- Chunk Of Platinum Ore
            { itemid = xi.item.SQUARE_OF_RAINBOW_CLOTH,  droprate =  54 }, -- Square Of Rainbow Cloth
            { itemid = xi.item.RAM_HORN,                 droprate =  54 }, -- Ram Horn
            { itemid = xi.item.SQUARE_OF_RAXA,           droprate =  71 }, -- Square Of Raxa
            { itemid = xi.item.RERAISER,                 droprate =  45 }, -- Reraiser
            { itemid = xi.item.HANDFUL_OF_WYVERN_SCALES, droprate =  54 }, -- Handful Of Wyvern Scales
            { itemid = xi.item.VILE_ELIXIR,              droprate =  63 }, -- Vile Elixir
            { itemid = xi.item.VILE_ELIXIR_P1,           droprate =  45 }, -- Vile Elixir +1
        },

        {
            { itemid = xi.item.ADAMAN_CHAIN,     droprate = 268 }, -- Adaman Chain
            { itemid = xi.item.ADAMANTOISE_EGG,  droprate = 121 }, -- Adamantoise Egg
            { itemid = xi.item.AGILITY_POTION,   droprate =  80 }, -- Agility Potion
            { itemid = xi.item.DEXTERITY_POTION, droprate = 143 }, -- Dexterity Potion
            { itemid = xi.item.STRENGTH_POTION,  droprate = 214 }, -- Strength Potion
            { itemid = xi.item.VITALITY_POTION,  droprate = 196 }, -- Vitality Potion
        },

        {
            { itemid = xi.item.CHUNK_OF_ADAMAN_ORE,     droprate = 107 }, -- Chunk Of Adaman Ore
            { itemid = xi.item.CHARISMA_POTION,         droprate =  89 }, -- Charisma Potion
            { itemid = xi.item.CHUNK_OF_DARKSTEEL_ORE,  droprate = 179 }, -- Chunk Of Darksteel Ore
            { itemid = xi.item.ICARUS_WING,             droprate = 134 }, -- Icarus Wing
            { itemid = xi.item.INTELLIGENCE_POTION,     droprate = 152 }, -- Intelligence Potion
            { itemid = xi.item.MIND_POTION,             droprate =  80 }, -- Mind Potion
            { itemid = xi.item.CHUNK_OF_ORICHALCUM_ORE, droprate =  80 }, -- Chunk Of Orichalcum Ore
            { itemid = xi.item.CHUNK_OF_PLATINUM_ORE,   droprate = 107 }, -- Chunk Of Platinum Ore
            { itemid = xi.item.PRINCELY_SWORD,          droprate = 152 }, -- Princely Sword
        },

        {
            { itemid = xi.item.HI_ETHER_P3,    droprate = 295 },  -- Hi-ether +3
            { itemid = xi.item.HI_POTION_P3,   droprate = 250 },  -- Hi-potion +3
            { itemid = xi.item.HI_RERAISER,    droprate = 196 },  -- Hi-reraiser
            { itemid = xi.item.VILE_ELIXIR_P1, droprate = 214 },  -- Vile Elixir +1
        },

        {
            { itemid = xi.item.CORAL_FRAGMENT,           droprate = 139 }, -- Coral Fragment
            { itemid = xi.item.CHUNK_OF_DARKSTEEL_ORE,   droprate =  59 }, -- Chunk Of Darksteel Ore
            { itemid = xi.item.DEMON_HORN,               droprate =  50 }, -- Demon Horn
            { itemid = xi.item.EBONY_LOG,                droprate = 109 }, -- Ebony Log
            { itemid = xi.item.CHUNK_OF_GOLD_ORE,        droprate =  69 }, -- Chunk Of Gold Ore
            { itemid = xi.item.SLAB_OF_GRANITE,          droprate =  99 }, -- Slab Of Granite
            { itemid = xi.item.HI_RERAISER,              droprate =  79 }, -- Hi-reraiser
            { itemid = xi.item.MAHOGANY_LOG,             droprate = 129 }, -- Mahogany Log
            { itemid = xi.item.CHUNK_OF_MYTHRIL_ORE,     droprate = 119 }, -- Chunk Of Mythril Ore
            { itemid = xi.item.PHOENIX_FEATHER,          droprate =  69 }, -- Phoenix Feather
            { itemid = xi.item.PETRIFIED_LOG,            droprate = 168 }, -- Petrified Log
            { itemid = xi.item.CHUNK_OF_PLATINUM_ORE,    droprate = 129 }, -- Chunk Of Platinum Ore
            { itemid = xi.item.RAM_HORN,                 droprate = 109 }, -- Ram Horn
            { itemid = xi.item.SQUARE_OF_RAXA,           droprate =  79 }, -- Square Of Raxa
            { itemid = xi.item.VILE_ELIXIR,              droprate =  69 }, -- Vile Elixir
            { itemid = xi.item.HANDFUL_OF_WYVERN_SCALES, droprate =  79 }, -- Handful Of Wyvern Scales
            { itemid = xi.item.RERAISER,                 droprate =  50 }, -- Reraiser
            { itemid = xi.item.SPOOL_OF_GOLD_THREAD,     droprate =  89 }, -- Spool Of Gold Thread
        },

        {
            { itemid = xi.item.VIAL_OF_BLACK_BEETLE_BLOOD, droprate = 109 }, -- Vial Of Black Beetle Blood
            { itemid = xi.item.SQUARE_OF_DAMASCENE_CLOTH,  droprate =  89 }, -- Square Of Damascene Cloth
            { itemid = xi.item.DAMASCUS_INGOT,             droprate =  79 }, -- Damascus Ingot
            { itemid = xi.item.SPOOL_OF_MALBORO_FIBER,     droprate =  99 }, -- Spool Of Malboro Fiber
            { itemid = xi.item.PHILOSOPHERS_STONE,         droprate = 188 }, -- Philosophers Stone
            { itemid = xi.item.PHOENIX_FEATHER,            droprate = 238 }, -- Phoenix Feather
            { itemid = xi.item.SQUARE_OF_RAXA,             droprate = 109 }, -- Square Of Raxa
        },

        {
            { itemid = xi.item.DIVINE_LOG,              droprate =  79 }, -- Divine Log
            { itemid = xi.item.LACQUER_TREE_LOG,        droprate = 257 }, -- Lacquer Tree Log
            { itemid = xi.item.PETRIFIED_LOG,           droprate = 337 }, -- Petrified Log
            { itemid = xi.item.SQUARE_OF_SHINING_CLOTH, droprate = 149 }, -- Square Of Shining Cloth
        },
    },

    -- BCNM Royal Jelly
    [77] =
    {
        {
            { itemid = xi.item.VIAL_OF_SLIME_OIL, droprate = 1000 },
        },
        {
            { itemid = xi.item.VIAL_OF_SLIME_OIL, droprate = 1000 },
        },
        {
            { itemid = xi.item.ARCHERS_RING, droprate =  91 },
        },
        {
            { itemid = xi.item.MANA_RING,             droprate = 469 },
            { itemid = xi.item.GRUDGE_SWORD,          droprate = 152 },
            { itemid = xi.item.DE_SAINTRES_AXE,       droprate = 120 },
            { itemid = xi.item.BUZZARD_TUCK,          droprate = 118 },
            { itemid = xi.item.SCROLL_OF_UTSUSEMI_NI, droprate = 106 },
        },
        {
            { itemid = xi.item.MARKSMANS_RING, droprate = 258 },
            { itemid = xi.item.DUSKY_STAFF,    droprate = 152 },
            { itemid = xi.item.HIMMEL_STOCK,   droprate = 101 },
            { itemid = xi.item.SEALED_MACE,    droprate  = 98 },
            { itemid = xi.item.SHIKAR_BOW,     droprate  = 98 },
        },
        {
            { itemid = xi.item.SCROLL_OF_ABSORB_STR, droprate = 123 },
            { itemid = xi.item.SCROLL_OF_ERASE,      droprate = 165 },
            { itemid = xi.item.SCROLL_OF_PHALANX,    droprate = 140 },
            { itemid = xi.item.FIRE_SPIRIT_PACT,     droprate = 145 },
            { itemid = xi.item.STEEL_SHEET,          droprate = 229 },
            { itemid = xi.item.STEEL_INGOT,          droprate = 238 },
        },
        {
            { itemid = xi.item.SCROLL_OF_REFRESH,     droprate = 263 },
            { itemid = xi.item.SCROLL_OF_ICE_SPIKES,  droprate = 246 },
            { itemid = xi.item.SCROLL_OF_UTSUSEMI_NI, droprate = 177 },
            { itemid = xi.item.GOLD_BEASTCOIN,        droprate = 182 },
            { itemid = xi.item.MYTHRIL_BEASTCOIN,     droprate = 133 },
            { itemid = xi.item.PERIDOT,               droprate =  27 },
            { itemid = xi.item.TURQUOISE,             droprate =  20 },
            { itemid = xi.item.BLACK_PEARL,           droprate =  15 },
            { itemid = xi.item.GOSHENITE,             droprate =  15 },
            { itemid = xi.item.SPHENE,                droprate =  15 },
            { itemid = xi.item.AMETRINE,              droprate =  10 },
            { itemid = xi.item.GARNET,                droprate =   7 },
            { itemid = xi.item.BLACK_ROCK,            droprate =  12 },
            { itemid = xi.item.GREEN_ROCK,            droprate =   7 },
            { itemid = xi.item.WHITE_ROCK,            droprate =   7 },
            { itemid = xi.item.BLUE_ROCK,             droprate =   2 },
            { itemid = xi.item.TRANSLUCENT_ROCK,      droprate =   2 },
            { itemid = xi.item.OAK_LOG,               droprate =   5 },
            { itemid = xi.item.ROSEWOOD_LOG,          droprate =   5 },
            { itemid = xi.item.VILE_ELIXIR,           droprate =  10 },
            { itemid = xi.item.RERAISER,              droprate =   2 },
        },
    },

    -- BCNM The Final Bout
    [78] =
    {
        {
            { itemid = xi.item.BAG_OF_TREE_CUTTINGS, droprate = 1000 }, -- bag_of_tree_cuttings
        },

        {
            { itemid = xi.item.BAG_OF_TREE_CUTTINGS, droprate = 1000 }, -- bag_of_tree_cuttings
        },

        {
            { itemid = xi.item.CLUMP_OF_BOYAHDA_MOSS, droprate = 1000 }, -- clump_of_boyahda_moss
        },

        {
            { itemid = xi.item.SCROLL_OF_QUAKE,          droprate = 100 }, -- scroll_of_quake
            { itemid = xi.item.PIECE_OF_WISTERIA_LUMBER, droprate = 100 }, -- piece_of_wisteria_lumber
            { itemid = xi.item.MAHOGANY_LOG,             droprate = 100 }, -- mahogany_log
            { itemid = xi.item.EBONY_LOG,                droprate = 100 }, -- ebony_log
            { itemid = xi.item.SCROLL_OF_FREEZE,         droprate = 100 }, -- scroll_of_freeze
            { itemid = xi.item.DARKSTEEL_INGOT,          droprate = 100 }, -- darksteel_ingot
            { itemid = xi.item.SCROLL_OF_RAISE_II,       droprate = 100 }, -- scroll_of_raise_ii
            { itemid = xi.item.PETRIFIED_LOG,            droprate = 100 }, -- petrified_log
            { itemid = xi.item.GOLD_INGOT,               droprate = 100 }, -- gold_ingot
            { itemid = xi.item.CORAL_FRAGMENT,           droprate = 100 }, -- coral_fragment
        },

        {
            { itemid = xi.item.SHOCK_MASK,              droprate = 62 }, -- shock_mask
            { itemid = xi.item.SUPER_RIBBON,            droprate = 62 }, -- super_ribbon
            { itemid = xi.item.RIVAL_RIBBON,            droprate = 62 }, -- rival_ribbon
            { itemid = xi.item.IVORY_MITTS,             droprate = 62 }, -- ivory_mitts
            { itemid = xi.item.SPIKED_FINGER_GAUNTLETS, droprate = 70 }, -- spiked_finger_gauntlets
            { itemid = xi.item.SLY_GAUNTLETS,           droprate = 62 }, -- sly_gauntlets
            { itemid = xi.item.RUSH_GLOVES,             droprate = 62 }, -- rush_gloves
            { itemid = xi.item.MANA_CIRCLET,            droprate = 62 }, -- mana_circlet
            { itemid = xi.item.HATEFUL_COLLAR,          droprate = 62 }, -- hateful_collar
            { itemid = xi.item.ESOTERIC_MANTLE,         droprate = 62 }, -- esoteric_mantle
            { itemid = xi.item.TEMPLARS_MANTLE,         droprate = 62 }, -- templars_mantle
            { itemid = xi.item.HEAVY_MANTLE,            droprate = 62 }, -- heavy_mantle
            { itemid = xi.item.INTELLECT_TORQUE,        droprate = 62 }, -- intellect_torque
            { itemid = xi.item.STORM_GORGET,            droprate = 62 }, -- storm_gorget
            { itemid = xi.item.BENIGN_NECKLACE,         droprate = 62 }, -- benign_necklace
            { itemid = xi.item.SNIPERS_MANTLE,          droprate = 62 }, -- snipers_mantle
        },
    },

    -- BCNM Up In Arms
    [79] =
    {
        {
            { itemid = xi.item.GIL, droprate = 1000, amount = 15000 }, -- Gil
        },

        {
            { itemid = xi.item.BLACK_PEARL, droprate = 1000 }, -- Black Pearl
        },

        {
            { itemid = xi.item.PEARL, droprate = 1000 }, -- Pearl
        },

        {
            { itemid = xi.item.PEARL, droprate = 1000 }, -- Pearl
        },

        {
            { itemid = xi.item.PIECE_OF_OXBLOOD, droprate = 1000 }, -- Piece Of Oxblood
        },

        {
            { itemid = xi.item.PIECE_OF_OXBLOOD, droprate = 1000 }, -- Piece Of Oxblood
        },

        {
            { itemid = xi.item.PIECE_OF_OXBLOOD, droprate = 1000 }, -- Piece Of Oxblood
        },

        {
            { itemid = xi.item.TELEPORT_RING_ALTEP, droprate = 447 }, -- Teleport Ring Altep
            { itemid = xi.item.TELEPORT_RING_DEM,   droprate = 487 }, -- Teleport Ring Dem
        },

        {
            { itemid = xi.item.AJARI_BEAD_NECKLACE, droprate = 494 }, -- Ajari Bead Necklace
            { itemid = xi.item.PHILOMATH_STOLE,     droprate = 449 }, -- Philomath Stole
        },

        {
            { itemid = xi.item.AQUAMARINE,       droprate =  51 }, -- Aquamarine
            { itemid = xi.item.CHRYSOBERYL,      droprate =  32 }, -- Chrysoberyl
            { itemid = xi.item.DARKSTEEL_INGOT,  droprate =  39 }, -- Darksteel Ingot
            { itemid = xi.item.EBONY_LOG,        droprate =  21 }, -- Ebony Log
            { itemid = xi.item.HI_RERAISER,      droprate =  32 }, -- Hi-reraiser
            { itemid = xi.item.GOLD_INGOT,       droprate =  55 }, -- Gold Ingot
            { itemid = xi.item.JADEITE,          droprate =  62 }, -- Jadeite
            { itemid = xi.item.MYTHRIL_INGOT,    droprate =  81 }, -- Mythril Ingot
            { itemid = xi.item.MOONSTONE,        droprate =  56 }, -- Moonstone
            { itemid = xi.item.PAINITE,          droprate = 195 }, -- Painite
            { itemid = xi.item.STEEL_INGOT,      droprate =  58 }, -- Steel Ingot
            { itemid = xi.item.SUNSTONE,         droprate =  38 }, -- Sunstone
            { itemid = xi.item.TRANSLUCENT_ROCK, droprate =  11 }, -- Translucent Rock
            { itemid = xi.item.VILE_ELIXIR_P1,   droprate =  21 }, -- Vile Elixir +1
            { itemid = xi.item.YELLOW_ROCK,      droprate =  15 }, -- Yellow Rock
            { itemid = xi.item.ZIRCON,           droprate =  26 }, -- Zircon
            { itemid = xi.item.RED_ROCK,         droprate =  21 }, -- Red Rock
            { itemid = xi.item.MAHOGANY_LOG,     droprate =  17 }, -- Mahogany Log
            { itemid = xi.item.BLUE_ROCK,        droprate =   9 }, -- Blue Rock
            { itemid = xi.item.FLUORITE,         droprate =  62 }, -- Fluorite
            { itemid = xi.item.PURPLE_ROCK,      droprate =  11 }, -- Purple Rock
            { itemid = xi.item.BLACK_ROCK,       droprate =  11 }, -- Black Rock
            { itemid = xi.item.GREEN_ROCK,       droprate =  11 }, -- Green Rock
            { itemid = xi.item.WHITE_ROCK,       droprate =   9 }, -- White Rock
        },

        {
            { itemid = xi.item.NONE,         droprate =  932 }, -- Nothing
            { itemid = xi.item.KRAKEN_CLUB,  droprate =   13 }, -- Kraken Club
            { itemid = xi.item.WALKURE_MASK, droprate =   55 }, -- Walkure Mask
        },
    },

    -- KSNM Operation Desert Swarm
    [81] =
    {
        {
            { itemid = xi.item.HIGH_QUALITY_SCORPION_SHELL, droprate = 813 }, -- High-quality Scorpion Shell
            { itemid = xi.item.SERKET_RING,                 droprate =  55 }, -- Serket Ring
            { itemid = xi.item.VENOMOUS_CLAW,               droprate = 123 }, -- Venomous Claw
        },

        {
            { itemid = xi.item.EXPUNGER,       droprate = 216 }, -- Expunger
            { itemid = xi.item.HEART_SNATCHER, droprate = 295 }, -- Heart Snatcher
            { itemid = xi.item.RAMPAGER,       droprate = 239 }, -- Rampager
            { itemid = xi.item.SENJUINRIKIO,   droprate = 231 }, -- Senjuinrikio
        },

        {
            { itemid = xi.item.ANUBISS_KNIFE,    droprate = 504 }, -- Anubiss Knife
            { itemid = xi.item.ADAMAN_INGOT,     droprate =   4 }, -- Adaman Ingot
            { itemid = xi.item.CLAYMORE_GRIP,    droprate =  86 }, -- Claymore Grip
            { itemid = xi.item.ORICHALCUM_INGOT, droprate =  22 }, -- Orichalcum Ingot
            { itemid = xi.item.POLE_GRIP,        droprate = 146 }, -- Pole Grip
            { itemid = xi.item.SWORD_STRAP,      droprate =  22 }, -- Sword Strap
        },

        {
            { itemid = xi.item.HIERARCH_BELT,    droprate = 287 }, -- Hierarch Belt
            { itemid = xi.item.PALMERINS_SHIELD, droprate = 216 }, -- Palmerins Shield
            { itemid = xi.item.TRAINERS_GLOVES,  droprate = 198 }, -- Trainers Gloves
            { itemid = xi.item.WARWOLF_BELT,     droprate = 287 }, -- Warwolf Belt
        },

        {
            { itemid = xi.item.CORAL_FRAGMENT,           droprate =  52 }, -- Coral Fragment
            { itemid = xi.item.CHUNK_OF_DARKSTEEL_ORE,   droprate =  56 }, -- Chunk Of Darksteel Ore
            { itemid = xi.item.DEMON_HORN,               droprate =  41 }, -- Demon Horn
            { itemid = xi.item.EBONY_LOG,                droprate =  63 }, -- Ebony Log
            { itemid = xi.item.CHUNK_OF_GOLD_ORE,        droprate =  52 }, -- Chunk Of Gold Ore
            { itemid = xi.item.SPOOL_OF_GOLD_THREAD,     droprate =  26 }, -- Spool Of Gold Thread
            { itemid = xi.item.SLAB_OF_GRANITE,          droprate =  11 }, -- Slab Of Granite
            { itemid = xi.item.HI_RERAISER,              droprate =  37 }, -- Hi-reraiser
            { itemid = xi.item.MAHOGANY_LOG,             droprate = 101 }, -- Mahogany Log
            { itemid = xi.item.MYTHRIL_INGOT,            droprate =   0 }, -- Mythril Ingot
            { itemid = xi.item.CHUNK_OF_MYTHRIL_ORE,     droprate =  52 }, -- Chunk Of Mythril Ore
            { itemid = xi.item.PETRIFIED_LOG,            droprate = 116 }, -- Petrified Log
            { itemid = xi.item.PHOENIX_FEATHER,          droprate =  15 }, -- Phoenix Feather
            { itemid = xi.item.PHILOSOPHERS_STONE,       droprate =  56 }, -- Philosophers Stone
            { itemid = xi.item.CHUNK_OF_PLATINUM_ORE,    droprate =  45 }, -- Chunk Of Platinum Ore
            { itemid = xi.item.SQUARE_OF_RAINBOW_CLOTH,  droprate =  22 }, -- Square Of Rainbow Cloth
            { itemid = xi.item.RAM_HORN,                 droprate =  67 }, -- Ram Horn
            { itemid = xi.item.SQUARE_OF_RAXA,           droprate = 119 }, -- Square Of Raxa
            { itemid = xi.item.RERAISER,                 droprate =  45 }, -- Reraiser
            { itemid = xi.item.VILE_ELIXIR,              droprate =  19 }, -- Vile Elixir
            { itemid = xi.item.VILE_ELIXIR_P1,           droprate =  41 }, -- Vile Elixir +1
            { itemid = xi.item.HANDFUL_OF_WYVERN_SCALES, droprate =  34 }, -- Handful Of Wyvern Scales
        },

        {
            { itemid = xi.item.VIAL_OF_BLACK_BEETLE_BLOOD, droprate =  78 }, -- Vial Of Black Beetle Blood
            { itemid = xi.item.SQUARE_OF_DAMASCENE_CLOTH,  droprate =  56 }, -- Square Of Damascene Cloth
            { itemid = xi.item.DAMASCUS_INGOT,             droprate =  93 }, -- Damascus Ingot
            { itemid = xi.item.SPOOL_OF_MALBORO_FIBER,     droprate =  56 }, -- Spool Of Malboro Fiber
            { itemid = xi.item.PHILOSOPHERS_STONE,         droprate = 157 }, -- Philosophers Stone
            { itemid = xi.item.PHOENIX_FEATHER,            droprate = 276 }, -- Phoenix Feather
            { itemid = xi.item.SQUARE_OF_RAXA,             droprate = 209 }, -- Square Of Raxa
        },
    },

    -- KSNM Prehistoric Pigeons
    [82] =
    {
        {
            { itemid = xi.item.MICHISHIBA_NO_TSUYU, droprate = 217 }, -- Michishiba-no-tsuyu
            { itemid = xi.item.DISSECTOR,           droprate = 174 }, -- Dissector
            { itemid = xi.item.COFFINMAKER,         droprate = 333 }, -- Coffinmaker
            { itemid = xi.item.GRAVEDIGGER,         droprate = 174 }, -- Gravedigger
        },

        {
            { itemid = xi.item.CLAYMORE_GRIP,    droprate = 144 }, -- Claymore Grip
            { itemid = xi.item.DAMASCUS_INGOT,   droprate = 275 }, -- Damascus Ingot
            { itemid = xi.item.GIANT_BIRD_PLUME, droprate = 275 }, -- Giant Bird Plume
            { itemid = xi.item.POLE_GRIP,        droprate = 203 }, -- Pole Grip
            { itemid = xi.item.SPEAR_STRAP,      droprate = 116 }, -- Spear Strap
        },

        {
            { itemid = xi.item.ADAMAN_INGOT,     droprate = 159 }, -- Adaman Ingot
            { itemid = xi.item.ORICHALCUM_INGOT, droprate = 290 }, -- Orichalcum Ingot
            { itemid = xi.item.TITANIS_EARRING,  droprate = 406 }, -- Titanis Earring
        },

        {
            { itemid = xi.item.EVOKERS_BOOTS,  droprate = 159 }, -- Evokers Boots
            { itemid = xi.item.OSTREGER_MITTS, droprate = 217 }, -- Ostreger Mitts
            { itemid = xi.item.PINEAL_HAT,     droprate = 145 }, -- Pineal Hat
            { itemid = xi.item.TRACKERS_KECKS, droprate = 159 }, -- Trackers Kecks
        },

        {
            { itemid = xi.item.CORAL_FRAGMENT,          droprate = 101 }, -- Coral Fragment
            { itemid = xi.item.CHUNK_OF_DARKSTEEL_ORE,  droprate =  29 }, -- Chunk Of Darksteel Ore
            { itemid = xi.item.DEMON_HORN,              droprate =  29 }, -- Demon Horn
            { itemid = xi.item.EBONY_LOG,               droprate =  29 }, -- Ebony Log
            { itemid = xi.item.GOLD_INGOT,              droprate = 101 }, -- Gold Ingot
            { itemid = xi.item.SPOOL_OF_GOLD_THREAD,    droprate =  29 }, -- Spool Of Gold Thread
            { itemid = xi.item.CHUNK_OF_MYTHRIL_ORE,    droprate =  29 }, -- Chunk Of Mythril Ore
            { itemid = xi.item.PETRIFIED_LOG,           droprate =  58 }, -- Petrified Log
            { itemid = xi.item.CHUNK_OF_PLATINUM_ORE,   droprate =  14 }, -- Chunk Of Platinum Ore
            { itemid = xi.item.SQUARE_OF_RAINBOW_CLOTH, droprate =  58 }, -- Square Of Rainbow Cloth
            { itemid = xi.item.RAM_HORN,                droprate =  14 }, -- Ram Horn
            { itemid = xi.item.SQUARE_OF_RAXA,          droprate = 159 }, -- Square Of Raxa
            { itemid = xi.item.SPOOL_OF_MALBORO_FIBER,  droprate =  72 }, -- Spool Of Malboro Fiber
        },

        {
            { itemid = xi.item.VIAL_OF_BLACK_BEETLE_BLOOD, droprate =  87 }, -- Vial Of Black Beetle Blood
            { itemid = xi.item.DAMASCUS_INGOT,             droprate =  14 }, -- Damascus Ingot
            { itemid = xi.item.SQUARE_OF_DAMASCENE_CLOTH,  droprate =  29 }, -- Square Of Damascene Cloth
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
