-----------------------------------
-- Appraisal Utilities
-- desc: Common functionality for Appraisals
-----------------------------------
require("scripts/globals/assault")
require("scripts/globals/items")
require("scripts/globals/npc_util")
require("scripts/globals/status")
-----------------------------------
xi = xi or {}
xi.appraisalUtil = xi.appraisalUtil or {}
-----------------------------------

xi.appraisalUtil.Origin =
{
    NYZUL_BASIC                 = 100,
    NYZUL_BAT_EYE               = 101,
    NYZUL_SHADOW_EYE            = 102,
    NYZUL_BOMB_KING             = 103,
    NYZUL_JUGGLER_HECATOMB      = 104,
    NYZUL_SMOTHERING_SCHMIDT    = 105,
    NYZUL_HELLION               = 106,
    NYZUL_LEAPING_LIZZY         = 107,
    NYZUL_TOM_TIT_TAT           = 108,
    NYZUL_JAGGEDY_EARED_JACK    = 109,
    NYZUL_CACTUAR_CANTAUTOR     = 110,
    NYZUL_GARGANTUA             = 111,
    NYZUL_GYRE_CARLIN           = 112,
    NYZUL_ASPHYXIATED_AMSEL     = 113,
    NYZUL_FROSTMANE             = 114,
    NYZUL_PEALLAIDH             = 115,
    NYZUL_CARNERO               = 116,
    NYZUL_FALCATUS_ARANEI       = 117,
    NYZUL_EMERGENT_ELM          = 118,
    NYZUL_OLD_TWO_WINGS         = 119,
    NYZUL_AIATAR                = 120,
    NYZUL_INTULO                = 121,
    NYZUL_ORCTRAP               = 122,
    NYZUL_VALKURM_EMPEROR       = 123,
    NYZUL_CRUSHED_KRAUSE        = 124,
    NYZUL_STINGING_SOPHIE       = 125,
    NYZUL_SERPOPARD_ISHTAR      = 126,
    NYZUL_WESTERN_SHADOW        = 127,
    NYZUL_BLOODTEAR_BALDURF     = 128,
    NYZUL_ZIZZY_ZILLAH          = 129,
    NYZUL_ELLYLLON              = 130,
    NYZUL_MISCHIEVOUS_MICHOLAS  = 131,
    NYZUL_LEECH_KING            = 132,
    NYZUL_EASTERN_SHADOW        = 133,
    NYZUL_NUNYENUNC             = 134,
    NYZUL_HELLDIVER             = 135,
    NYZUL_TAISAIJIN             = 136,
    NYZUL_FUNGUS_BEETLE         = 137,
    NYZUL_FRIAR_RUSH            = 138,
    NYZUL_PULVERIZED_PFEFFER    = 139,
    NYZUL_ARGUS                 = 140,
    NYZUL_BLOODPOOL_VORAX       = 141,
    NYZUL_NIGHTMARE_VASE        = 142,
    NYZUL_DAGGERCLAW_DRACOS     = 143,
    NYZUL_NORTHERN_SHADOW       = 144,
    NYZUL_FRAELISSA             = 145,
    NYZUL_ROC                   = 146,
    NYZUL_SABOTENDER_BAILARIN   = 147,
    NYZUL_AQUARIUS              = 148,
    NYZUL_ENERGETIC_ERUCA       = 149,
    NYZUL_SPINY_SPIPI           = 150,
    NYZUL_TRICKSTER_KINETIX     = 151,
    NYZUL_DROOLING_DAISY        = 152,
    NYZUL_BONNACON              = 153,

    NYZUL_GOLDEN_BAT            = 155,
    NYZUL_STEELFLEECE_BALDARICH = 156,
    NYZUL_SABOTENDER_MARIACHI   = 157,
    NYZUL_UNGUR                 = 158,
    NYZUL_SWAMFISK              = 159,
    NYZUL_BUBURIMBOO            = 160,
    NYZUL_KEEPER_OF_HALIDOM     = 161,
    NYZUL_SERKET                = 162,
    NYZUL_DUNE_WIDOW            = 163,
    NYZUL_ODQAN                 = 164,
    NYZUL_BURNED_BERGMANN       = 165,

    NYZUL_TYRANNIC_TUNNOK       = 167,
    NYZUL_BLOODSUCKER           = 168,
    NYZUL_TOTTERING_TOBY        = 169,
    NYZUL_SOUTHERN_SHADOW       = 170,
    NYZUL_SHARP_EARED_ROPIPI    = 171,

    NYZUL_PANZER_PERCIVAL       = 173,
    NYZUL_VOUIVRE               = 174,
    NYZUL_JOLLY_GREEN           = 175,
    NYZUL_TUMBLING_TRUFFLE      = 176,
    NYZUL_CAPRICIOUS_CASSIE     = 177,
    NYZUL_AMIKIRI               = 178,
    NYZUL_STRAY_MARY            = 179,
    NYZUL_SEWER_SYRUP           = 180,
    NYZUL_UNUT                  = 181,
    NYZUL_SIMURGH               = 182,
    NYZUL_PELICAN               = 183,
    NYZUL_CARGO_CRAB_COLIN      = 184,
    NYZUL_WOUNDED_WURFEL        = 185,
    NYZUL_PEG_POWLER            = 186,

    NYZUL_JADED_JODY            = 188,
    NYZUL_MAIGHDEAN_UAINE       = 189,

}

xi.appraisalUtil.unappraisedItems =
{
    xi.items.UNAPPRAISED_SWORD,
    xi.items.UNAPPRAISED_DAGGER,
    xi.items.UNAPPRAISED_POLEARM,
    xi.items.UNAPPRAISED_AXE,
    xi.items.UNAPPRAISED_BOW,
    xi.items.UNAPPRAISED_GLOVES,
    xi.items.UNAPPRAISED_FOOTWEAR,
    xi.items.UNAPPRAISED_HEADPIECE,
    xi.items.UNAPPRAISED_EARRING,
    xi.items.UNAPPRAISED_RING,
    xi.items.UNAPPRAISED_CAPE,
    xi.items.UNAPPRAISED_SASH,
    xi.items.UNAPPRAISED_SHIELD,
    xi.items.UNAPPRAISED_NECKLACE,
    xi.items.UNAPPRAISED_INGOT,
    xi.items.UNAPPRAISED_POTION,
    xi.items.UNAPPRAISED_CLOTH,
    xi.items.UNAPPRAISED_BOX,
}

xi.appraisalUtil.appraisalItems =
{
    [xi.items.UNAPPRAISED_SWORD] =
    {
        [xi.assaultUtil.mission.SEAGULL_GROUNDED] =
        {
            items =
            {
                {65, 18366}, -- Gust Claymore
                {30, 16978}, -- Uchigatana+1
                { 5, 18434}, -- Kosetsusamonji
            },
        },
        [xi.assaultUtil.mission.SAGELORD_ELIMINATION] =
        {
            items =
            {
                {55,18366}, -- Gust Claymore
                {40,16978}, -- Uchigatana+1
                { 5,18387}, -- Djinnbringer
            },
        },
        [xi.assaultUtil.mission.BREAKING_MORALE] =
        {
            items =
            {
                {45, 18366}, -- Gust Claymore
                {30, 16978}, -- Uchigatana+1
                {20, 17703}, -- Pealing Anelace
                {10, 18433}, -- Kagiroi
                { 5, 17661}, -- Storm Schimitar
            },
        },
        [xi.assaultUtil.mission.THE_DOUBLE_AGENT] =
        {
            items =
            {
                {45, 18336}, -- Gust Claymore
                {10, 18387}, -- Djinnbringer
                {38, 16978}, -- Uchigatana+1
                { 4, 17703}, -- Pealing Anelace
                { 3, 18433}, -- Kagiroi
            },
        },
        [xi.assaultUtil.mission.AZURE_EXPERIMENTS] =
        {
            items =
            {
                {100,17716}, -- Macuahuitl-1
            },
        },
        [xi.assaultUtil.mission.BLITZKRIEG] =
        {
            items =
            {
                {45, 18366}, -- Gust Claymore
                {30, 16978}, -- Uchigatana+1
                {20, 17700}, -- Durandal
                { 5, 17721}, -- Sanguine Sword
            },
        },
        [xi.assaultUtil.mission.WAMOURA_FARM_RAID] =
        {
            items =
            {
                {45, 18366}, -- Gust Claymore
                {30 ,16978}, -- Uchigatana+1
                {20, 18435}, -- Hotarumaru
                { 5, 18438}, -- Kumokirimaru
            },
        },
        [xi.assaultUtil.mission.RED_VERSUS_BLUE] =
        {
            items =
            {
                {100,17660}, -- Kilij
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_FROSTMANE] =
        {
            items =
            {
                {60, 16583}, -- Claymore
                {35, 18366}, -- Gust Claymore
                { 5, 16944}, -- Lockheart
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_CARNERO] =
        {
            items =
            {
                {75, 16535}, -- Bronze Sword
                {25, 17811}, -- Katayama
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_EMERGENT_ELM] =
        {
            items =
            {
                {60, 16535}, -- Bronze Sword
                {35, 16530}, -- Xiphos
                { 5, 18386}, -- Gloom Claymore
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_ZIZZY_ZILLAH] =
        {
            items =
            {
                {60, 16535}, -- Bronze Sword
                {35, 16978}, -- Uchigatana+1
                { 5, 18437}, -- Namikirimaru
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_KEEPER_OF_HALIDOM] =
        {
            items =
            {
                {65, 16535}, -- Bronze Sword
                {32, 16978}, -- Uchigatana+1
                { 3, 16990}, -- Daihannya
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_AMIKIRI] =
        {
            items =
            {
                {75, 16535}, -- Bronze Sword
                {25, 16968}, -- Kamewari
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_CARGO_CRAB_COLIN] =
        {
            items =
            {
                {85, 16535}, -- Bronze Sword
                {15, 17650}, -- Nadris
            },
        },
    },
    [xi.items.UNAPPRAISED_DAGGER] =
    {
        [xi.appraisalUtil.Origin.NYZUL_TOM_TIT_TAT] =
        {
            items =
            {
                {70, 16465}, -- Bronze Knife
                {25, 16896}, -- Kunai
                { 5, 16443}, -- Fruit Punches
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_ORCTRAP] =
        {
            items =
            {
                {95, 16465}, -- Bronze Knife
                { 5, 17792}, -- Nikkariaoe
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_STINGING_SOPHIE] =
        {
            items =
            {
                {95, 16465}, -- Bronze Knife
                { 5, 16486}, -- Beestinger
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_WESTERN_SHADOW] =
        {
            items =
            {
                {95, 16896}, -- Kunai
                { 5, 18752}, -- Retaliators
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_MISCHIEVOUS_MICHOLAS] =
        {
            items =
            {
                {95, 16465}, -- Bronze Knife
                { 5, 17610}, -- Kidney Dagger
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_NIGHTMARE_VASE] =
        {
            items =
            {
                {90, 16896}, -- Kunai
                {10, 16913}, -- Shinogi
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_DAGGERCLAW_DRACOS] =
        {
            items =
            {
                {90, 16390}, -- Bronze Knuckels
                {10, 16434}, -- Sonic Knuckles
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_SABOTENDER_MARIACHI] =
        {
            items =
            {
                {90, 16465}, -- Bonze Knife
                {10, 17981}, -- Bano Del Sol
            },
        },
    },
    [xi.items.UNAPPRAISED_POLEARM] =
    {
        [xi.assaultUtil.mission.SEAGULL_GROUNDED] =
        {
            items =
            {
                {100, xi.items.SPARK_SPEAR},
            },
        },
        [xi.assaultUtil.mission.REQUIEM] =
        {
            items =
            {
                {20, xi.items.HOLLY_STAFF_HQ},
                {40, xi.items.BRASS_ZAGHNAL},
                {20, xi.items.WILLOW_WAND_HQ},
                { 5, xi.items.PUK_LANCE},
                {15, xi.items.SPARK_SPEAR},
            },
        },
        [xi.assaultUtil.mission.EXTERMINATION] =
        {
            items =
            {
                {20, xi.items.SPARK_SPEAR},
                {20, xi.items.WILLOW_WAND_HQ},
                {15, xi.items.HOLLY_STAFF_HQ},
                {35, xi.items.BRASS_ZAGHNAL},
                {10, xi.items.VOLUNTEERS_SCYTHE},
            },
        },
        [xi.assaultUtil.mission.TROLL_FUGITIVES] =
        {
            items =
            {
                {100, xi.items.SICKLE}
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_JUGGLER_HECATOMB] =
        {
            items =
            {
                {90, 17024}, -- Ash Club
                {10, 16868}, -- Heavy Halberd
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_HELLION] =
        {
            items =
            {
                {70, 17049}, -- Maple Wand
                {30, 16868}, -- A I'Outrance
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_FALCATUS_ARANEI] =
        {
            items =
            {
                {70, 17049}, -- Maple Wand
                {20, 16768}, -- Bronze Zaghnal
                {10, 18040}, -- Webcutter
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_NUNYENUNC] =
        {
            items =
            {
                {90, 17024}, -- Ash Club
                {10, 18394}, -- Pilgrams Wand
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_ROC] =
        {
            items =
            {
                {90, 17049}, -- Maple Wand
                {10, 18587}, -- Dryad Staff
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_SWAMFISK] =
        {
            items =
            {
                {90, 17049}, -- Maple Wand
                {10, 17594}, -- Gelong Staff
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_VOUIVRE] =
        {
            items =
            {
                {90, 17024}, -- Ash Club
                {10, 16885}, -- Gae Blog
            },
        },
    },
    [xi.items.UNAPPRAISED_AXE] =
    {
        [xi.assaultUtil.mission.REQUIEM] =
        {
            items =
            {
                {100, xi.items.PICKAXE},
            },
        },
        [xi.assaultUtil.mission.EXTERMINATION] =
        {
            items =
            {
                {100, xi.items.PICKAXE},
            },
        },
        [xi.assaultUtil.mission.TROLL_FUGITIVES] =
        {
            items =
            {
                {60, xi.items.HATCHET},
                {10, xi.items.TOMAHAWK_HQ},
                {15, xi.items.WAMOURA_AXE},
                {15, xi.items.PROMINENCE_AXE},
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_BAT_EYE] =
        {
            items =
            {
                {95, 16642}, -- Bone Axe
                { 5, 16675}, -- Storm Axe
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_NORTHERN_SHADOW] =
        {
            items =
            {
                {90, 16704}, -- Butterfly Axe
                {10, 16723}, -- Executioner
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_AQUARIUS] =
        {
            items =
            {
                {90, 16642}, -- Bone Axe
                {10, 17925}, -- Fransisca
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_TRICKSTER_KINETIX] =
        {
            items =
            {
                {90, 16642}, -- Bone Axe
                {10, 16657}, -- Tabar
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_TYRANNIC_TUNNOK] =
        {
            items =
            {
                {90, 16642}, -- Bone Axe
                {10, 17927}, -- Lohar
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_PANZER_PERCIVAL] =
        {
            items =
            {
                {90, 16704}, -- Butterfly Axe
                {10, 16714}, -- Neckchopper
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_PEG_POWLER] =
        {
            items =
            {
                {90, 16704}, -- Butterfly Axe
                {10, 16728}, -- Schwarz Axe
            },
        },
    },
    [xi.items.UNAPPRAISED_BOW] =
    {
        [xi.assaultUtil.mission.LAMIA_NO_13] =
        {
            items =
            {
                {43, 17177}, -- Longbow +1
                {43, 17225}, -- Crossbow +1
                {14, 18683}, -- Imperial Bow
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_GYRE_CARLIN] =
        {
            items =
            {
                {90, 17152}, -- Shortbow
                {10, 17247}, -- Rikonodo
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_EASTERN_SHADOW] =
        {
            items =
            {
                {90, 17160}, -- Longbow
                {10, 18714}, -- Valis Bow
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_HELLDIVER] =
        {
            items =
            {
                {90, 17153}, -- Self Bow
                {10, 17281}, -- Wingedge
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_UNGUR] =
        {
            items =
            {
                {90, 17217}, -- Crossbow
                {10, 18141}, -- Ungar Boomerang
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_FRAELISSA] =
        {
            items =
            {
                {90, xi.items.CROSSBOW},
                {10, xi.items.ALMOGAVAR_BOW},
            },
        },
    },
    [xi.items.UNAPPRAISED_GLOVES] =
    {
        [xi.assaultUtil.mission.ORICHALCUM_SURVEY] =
        {
            items =
            {
                {100, xi.items.STORM_GAGES},
            },
        },
        [xi.assaultUtil.mission.SEAGULL_GROUNDED] =
        {
            items =
            {
                {28, 12695}, -- Bronze Mittens + 1
                {30, 12696}, -- Leather Gloves
                {20, 12721}, -- Cotton Gloves
                {18, 12728}, -- Cuffs
                { 5, 14936}, -- Storm Manopolas
            },
        },
        [xi.assaultUtil.mission.REQUIEM] =
        {
            items =
            {
                {30, 12696}, -- Leather Gloves
                {28, 12695}, -- Bronze Mittens + 1
                {20, 12721}, -- Cotton Gloves
                {18, 12728}, -- Cuffs
                { 5, 14937}, -- Storm Gages
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_PEALLAIDH] =
        {
            items =
            {
                {90, 12696}, -- Leather Gloves
                {10, 14946}, -- Nightmare Gloves
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_ENERGETIC_ERUCA] =
        {
            items =
            {
                {90, 12721}, -- Cotton Cloves
                {10, 14947}, -- Hanzo Tekko
            },
        },
    },
    [xi.items.UNAPPRAISED_FOOTWEAR] =
    {
        [xi.assaultUtil.mission.LAMIA_NO_13] =
        {
            items =
            {
                {20, 12984}, -- Ash Clogs
                {38, 12951}, -- Bronze Leggings +1
                {18, 12952}, -- Leather Highboots
                {6,  12992}, -- Solea
                {18, 15691}, -- Storm Gambieras
            },
        },
        [xi.assaultUtil.mission.EXTERMINATION] =
        {
            items =
            {
                {5,  xi.items.STORM_CRACKOWS},
                {35, xi.items.ASH_CLOGS},
                {25, xi.items.BRONZE_LEGGINGS_HQ},
                {35, xi.items.LEATHER_HIGHBOOTS},
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_LEAPING_LIZZY] =
        {
            items =
            {
                {95, 12952}, -- Leather Highboots
                { 5, 13014}, -- Leaping boots
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_CACTUAR_CANTAUTOR] =
        {
            items =
            {
                {90, 12952}, -- Leather Highboots
                {10, 14128}, -- Kung Fu Shoes
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_BONNACON] =
        {
            items =
            {
                {90, 12984}, -- Ash Clogs
                {10, 18052}, -- Tredecim Scythe or Cure Clogs
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_TOTTERING_TOBY] =
        {
            items =
            {
                {90, 12984}, -- Ash Clogs
                {10, 13013}, -- Stumbling Sandles
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_SIMURGH] =
        {
            items =
            {
                {90, 12952}, -- Leather Highboots
                {10, 15736}, -- Trotter Boots
            },
        },
    },
    [xi.items.UNAPPRAISED_HEADPIECE] =
    {
        [xi.assaultUtil.mission.TROLL_FUGITIVES] =
        {
            items =
            {
                {5, xi.items.STORM_TURBAN},
                {20, xi.items.COTTON_HEADGEAR},
                {15, xi.items.BRONZE_CAP_HQ},
                {30, xi.items.LEATHER_BANDANA},
                {30, xi.items.CIRCLET},
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_VALKURM_EMPEROR] =
        {
            items =
            {
                {90, 12496}, -- Copper Hairpin
                {10, 15224}, -- Empress Hairpin
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_ELLYLLON] =
        {
            items =
            {
                {90, 12440}, -- Leather Bandana
                {10, 13913}, -- Mushroom Helm
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_TAISAIJIN] =
        {
            items =
            {
                {90, 12440}, -- Leather Bandana
                {10, 15222}, -- Spelunker's Hat
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_DROOLING_DAISY] =
        {
            items =
            {
                {90, 12505}, -- Bone Hairpin
                {10, 13838}, -- Dodge Headband
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_SHARP_EARED_ROPIPI] =
        {
            items =
            {
                {90, 12496}, -- Copper Hairpin
                {10, 15218}, -- Entrancing Ribbon
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_TUMBLING_TRUFFLE] =
        {
            items =
            {
                {90, 12440}, -- Leather Bandana
                {10, 12485}, -- Fungus Hat
            },
        },
    },
    [xi.items.UNAPPRAISED_EARRING] =
    {
        [xi.assaultUtil.mission.EXCAVATION_DUTY] =
        {
            items =
            {
                {25, 13313}, -- Shell Earring
                {21, 13321}, -- Bone Earring
                {25, 13323}, -- Beetle Earring
                {20, 13327}, -- Silver Earring
                { 6, 14790}, -- Reraise Earring
                { 3, 15968}, -- Storm Loop
            },
        },
        [xi.assaultUtil.mission.GOLDEN_SALVAGE] =
        {
            items =
            {
                {22, 13313}, -- Shell Earring
                {20, 13321}, -- Bone Earring
                {21, 13323}, -- Beetle Earring
                {27, 13327}, -- Silver Earring
                { 6, 14805}, -- Heims Earring
                { 4, 15969}, -- Storm Earring
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_LEECH_KING] =
        {
            items =
            {
                {90, 13313}, -- Shell Earring
                {10, 13359}, -- Bloodbead Earring
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_CAPRICIOUS_CASSIE] =
        {
            items =
            {
                {90, 13321}, -- Bone Earring
                {10, 13402}, -- Cassie Earring
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_MAIGHDEAN_UAINE] =
        {
            items =
            {
                {90, 13323}, -- Beetle Earring
                {10, 14803}, -- Optical Earring
            },
        },
    },
    [xi.items.UNAPPRAISED_RING] =
    {
        [xi.assaultUtil.mission.LEUJAOAM_CLEANSING] =
        {
            items =
            {
                {50, 13454}, -- Copper Ring
                {30, 13465}, -- Brass Ring
                {15, 13514}, -- Archer Ring
                { 5, 15773}, -- Imperial Ring
            },
        },
        [xi.assaultUtil.mission.IMPERIAL_AGENT_RESCUE] =
        {
            items =
            {
                {50, 13454}, -- Copper Ring
                {30, 13465}, -- Brass Ring
                {15, 13549}, -- Ether Ring
                { 5, 15774}, -- Storm Ring
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_BOMB_KING] =
        {
            items =
            {
                {60, 13454}, -- Copper Ring
                {30, 13465}, -- Brass Ring
                {10, 13506}, -- Bomb Ring
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_SMOTHERING_SCHMIDT] =
        {
            items =
            {
                {60, 13454}, -- Copper Ring
                {30, 13465}, -- Brass Ring
                {10, 13507}, -- Malflood Ring
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_ASPHYXIATED_AMSEL] =
        {
            items =
            {
                {90, 13465}, -- Brass Ring
                {10, 13512}, -- Malgust Ring
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_CRUSHED_KRAUSE] =
        {
            items =
            {
                {90, 13454}, -- Copper Ring
                {10, 13508}, -- Maldust Ring
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_PULVERIZED_PFEFFER] =
        {
            items =
            {
                {90, 13454}, -- Copper Ring
                {10, 13509}, -- Malfrost Ring
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_SERKET] =
        {
            items =
            {
                {90, 13465}, -- Brass Ring
                {10, 13552}, -- Serket Ring
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_BURNED_BERGMANN] =
        {
            items =
            {
                {90, 13454}, -- Copper Ring
                {10, 13510}, -- Malflame Ring
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_BLOODSUCKER] =
        {
            items =
            {
                {90, 13454}, -- Copper Ring
                {10, 13302}, -- Bloodbead Ring
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_SEWER_SYRUP] =
        {
            items =
            {
                {90, 13465}, -- Brass Ring
                {10, 13303}, -- Jelly Ring
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_WOUNDED_WURFEL] =
        {
            items =
            {
                {90, 13454}, -- Copper Ring
                {10, 13511}, -- Malflash Ring
            },
        },
    },
    [xi.items.UNAPPRAISED_CAPE] =
    {
        [xi.assaultUtil.mission.LEBROS_SUPPLIES] =
        {
            items =
            {
                {30, 13600}, -- dhmamal mantle +1
                {25, 13601}, -- cotton cape +1
                {25, 13608}, -- lizard mantle +1
                { 5, xi.items.STORM_CAPE},
                {15, xi.items.ENHANCING_MANTLE},
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_OLD_TWO_WINGS] =
        {
            items =
            {
                {90, 13608}, -- Lizard Mantle +1
                {10, 13598}, -- Bat Cape
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_FRAELISSA] =
        {
            items =
            {
                {90, 13601}, -- Cotton Cape +1
                {10, 15469}, -- Bellicose Cape
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_SPINY_SPIPI] =
        {
            items =
            {
                {90, 13594}, -- Rabbit Mantle
                {10, 13607}, -- Mist Silk Cape
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_GOLDEN_BAT] =
        {
            items =
            {
                {90, 13601}, -- Cotton Cape +1
                {10, 13576}, -- Night Cape
            },
        },
    },
    [xi.items.UNAPPRAISED_SASH] =
    {

    },
    [xi.items.UNAPPRAISED_SHIELD] =
    {
        [xi.appraisalUtil.Origin.NYZUL_BLOODTEAR_BALDURF] =
        {
            items =
            {
                {90, 12293}, -- Oak Shield
                {10, 12356}, -- Viking Shield
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_FUNGUS_BEETLE] =
        {
            items =
            {
                {90, 12289}, -- Lauan Shield
                {10, 12371}, -- Clipeus
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_STEELFLEECE_BALDARICH] =
        {
            items =
            {
                {90, 12293}, -- Oak Shield
                {10, 12356}, -- Viking Shield
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_SOUTHERN_SHADOW] =
        {
            items =
            {
                {90, 12291}, -- Elm Shield
                {10, 12344}, -- Master Shield
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_PELICAN] =
        {
            items =
            {
                {90, 12299}, -- Aspis
                {10, 12382}, -- Astral Aspis
            },
        },
    },
    [xi.items.UNAPPRAISED_NECKLACE] =
    {
        [xi.assaultUtil.mission.ORICHALCUM_SURVEY] =
        {
            items =
            {
                {55, xi.items.FEATHER_COLLAR},
                {30, xi.items.GORGET_1},
                {10, xi.items.JAGD_GORGET},
                { 5, xi.items.STORM_MUFFLER},
            },
        },
        [xi.assaultUtil.mission.PREEMPTIVE_STRIKE] =
        {
            items =
            {
                {55, 13075}, -- Feather Collar
                {30, 13065}, -- Gorget +1
                {10, 13128}, -- Spectacles
                { 5, 15520}, -- Storm Torqe
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_SHADOW_EYE] =
        {
            items =
            {
                {95, 15526}, -- Regen Collar
                { 5, 13114}, -- Moon Amulet
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_JAGGEDY_EARED_JACK] =
        {
            items =
            {
                {90, 13081}, -- Leather Gorget
                {10, 13112}, -- Rabbit Charm
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_GARGANTUA] =
        {
            items =
            {
                {90, 13075}, -- Feather Collar
                {10, 13115}, -- Elementl Charm
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_SERPOPARD_ISHTAR] =
        {
            items =
            {
                {90, 13075}, -- Feather Collar
                {10, 13086}, -- Cerulean Pendant
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_ARGUS] =
        {
            items =
            {
                {90, 15526}, -- Regen Collar
                {10, 13056}, -- Peacok Charm
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_BLOODPOOL_VORAX] =
        {
            items =
            {
                {90, 13065}, -- Gorget +1
                {10, 13058}, -- Bloodbead Amulet
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_BUBURIMBOO] =
        {
            items =
            {
                {90, 13065}, -- Gorget +1
                {10, 13057}, -- Buburimu Gorget
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_DUNE_WIDOW] =
        {
            items =
            {
                {90, 15526}, -- Regen Collar
                {10, 13137}, -- Spider Torque
            },
        },
    },
    [xi.items.UNAPPRAISED_INGOT] =
    {

    },
    [xi.items.UNAPPRAISED_POTION] =
    {

    },
    [xi.items.UNAPPRAISED_CLOTH] =
    {

    },
    [xi.items.UNAPPRAISED_BOX] =
    {
        [xi.assaultUtil.mission.LEUJAOAM_CLEANSING] =
        {
            items =
            {
                {10,  776}, -- White Rock
                {20, 1164}, -- Tsurara
                { 2, 1411}, -- Phalaenopsis
                { 5, 1472}, -- Gardenia Seed
                { 8, 1887}, -- Glass Sheet
                {20, 2146}, -- Merrow Scale
                {15, 2336}, -- Soulflayer Staff
                {10, 4097}, -- Ice Crystal
                { 1, 5315}, -- Toolbag: Jusa
                { 3, 5353}, -- Iron Bullet Pouch
                { 6, 5450}, -- Lakerda
            },
        },
        [xi.assaultUtil.mission.ORICHALCUM_SURVEY] =
        {
            items =
            {
                {10, xi.items.EGGPLANT},
                { 9, xi.items.GARDENIA_SEED},
                {10, xi.items.ICE_CRYSTAL},
                { 7, xi.items.KABURA_QUIVER},
                {13, xi.items.SQUARE_OF_LINEN_CLOTH},
                { 8, xi.items.MERROW_SCALE},
                { 5, xi.items.PHALAENOPSIS},
                {10, xi.items.POROGGO_HAT},
                { 6, xi.items.SOULFLAYER_STAFF},
                {15, xi.items.TSURARA},
                { 7, xi.items.WHITE_ROCK},
            },
        },
        [xi.assaultUtil.mission.IMPERIAL_AGENT_RESCUE] =
        {
            items =
            {
                { 7, 5566}, -- Date
                { 5, 4388}, -- Eggplant
                {10, 2156}, -- Imperial Tea Leaves
                { 4, 2475}, -- Kaolin
                {20, 2227}, -- Mamool Ja Collar
                {15, 2334}, -- Poroggo Hat
                { 6,  638}, -- Sage
                { 5,  829}, -- Silk Cloth
                { 1, 5310}, -- Tollbag Kawa
                { 1, 5314}, -- Tollbag Shihei
                { 1, 5309}, -- Toolbag Tsura
                {10, 4387}, -- Wild Onion
                { 1, 5308}, -- Tollbag Uchi
                {14, 5453}, -- Istakoz
            },
        },
        [xi.assaultUtil.mission.LEBROS_SUPPLIES] =
        {
            items =
            {
                {20, xi.items.PINCH_OF_SULFUR},
                {20, xi.items.CHUNK_OF_FLAN_MEAT},
                { 5, xi.items.BULLET_POUCH},
                {20, xi.items.TROLL_PAULDRON},
                {10, xi.items.SPARTAN_BULLET},
                {25, xi.items.SPRIG_OF_HOLY_BASIL},
            },
        },
        [xi.assaultUtil.mission.PREEMPTIVE_STRIKE] =
        {
            items =
            {
                {17, 4388}, -- Eggplant
                {15,  638}, -- Sage
                {15, 2156}, -- Imp. Tea Leaves
                { 7, 4387}, -- Wild Onion
                {10, 1828}, -- Red Grass Thread
                { 7, 2227}, -- Mamool Ja Collar
                { 4, 5317}, -- Toolbag (Sairui-ran)
                { 3, 5314}, -- Toolbag (Shihei)
                { 4, 5315}, -- Toolbag (Jusa)
                {10, 2475}, -- Kaolin
                { 8, 2334}, -- Poroggo Hat
            },
        },
        [xi.assaultUtil.mission.REQUIEM] =
        {
            items =
            {
                { 4,  1654}, -- Igneous Rock
                { 5,  4196}, -- Rotten Quiver
                { 5,  5336}, -- Holy Bolt Quiver
                {20,   880}, -- Bone Chip
                { 5,   113}, -- Cleaning Tool Set
                { 2,   867}, -- Dragon Scales
                { 9,  2153}, -- Qiqirn Sandbag
                {15,  2163}, -- Imp Wing
                {20, 17339}, -- Bronze Bolt
                {15,  1523}, -- Apple Mint
            },
        },
        [xi.assaultUtil.mission.EXCAVATION_DUTY] =
        {
            items =
            {
                {15,  640}, -- Copper Ore
                {10,  769}, -- Red Rock
                { 5,  828}, -- Velvet Cloth
                { 8,  928}, -- Bomb Ash
                { 8, 1108}, -- Sulfur
                { 5, 1590}, -- Holy Basil
                {20, 2160}, -- Troll Pauldron
                {15, 2175}, -- Flan Meat
                { 1, 2302}, -- Troll Bronze Ingot
                { 2, 5340}, -- Silver Bullet Pouch
                { 1, 5341}, -- Spartan Bullet Pouch
                { 2, 5353}, -- Iron Bullet Pouch
                { 4, 5359}, -- Bronze Bullet Pouch
                { 3, 5363}, -- Bullet Pouch
            },
        },
        [xi.assaultUtil.mission.SEAGULL_GROUNDED] =
        {
            items =
            {
                { 1,  113}, -- Cleaning Tool Set
                { 2,  821}, -- Rainbow Thread
                {25,  880}, -- Bone Chip
                { 5, 1523}, -- Apple Mint
                { 3, 1654}, -- Igneous Rock
                {20, 2153}, -- Qiqirn Sandbag
                { 5, 2163}, -- Imp Wing
                {10, 4196}, -- Rotton Quiver
                { 6, 4227}, -- Bronze Bolt Quiver
                {10, 4387}, -- Wild Onion
                { 5, 5336}, -- Holy Bolt Quiver
                { 3, 5337}, -- Sleep Bolt Quiver
            },
        },
        [xi.assaultUtil.mission.GOLDEN_SALVAGE] =
        {
            items =
            {
                { 1,    90}, -- Rusty Bucket
                {24,  2165}, -- Qutrub Gorget
                {20,  2167}, -- Lamian Armlet
                { 6,  2418}, -- Aht Urhgan Brass Ingot
                { 2,  4129}, -- Stone Quiver
                { 6,  4220}, -- Bone Quiver
                { 2,  4221}, -- Beetle Quiver
                { 1,  4222}, -- Horn Quiver
                { 5,  4223}, -- Scorpion Quiver
                { 5,  4224}, -- Demon Quiver
                { 3,  4225}, -- Iron Quiver
                { 4,  4226}, -- Silver Quiver
                { 1,  4509}, -- Distilled Water
                { 5,  5018}, -- Puppet's Operetta
                { 5,  5332}, -- Kabura Quiver
                { 1,  5333}, -- Sleep Quiver
                {14,  5453}, -- Istakoz
                { 1, 17391}, -- Willow Fishing Rod
                { 1, 17396}, -- Little Worm
            },
        },
        [xi.assaultUtil.mission.LAMIA_NO_13] =
        {
            items =
            {
                { 2, xi.items.SPRIG_OF_APPLE_MINT},
                {25, xi.items.QUTRUB_GORGET},
                {25, xi.items.LAMIAN_ARMLET},
                { 2, xi.items.AHT_URHGAN_BRASS_INGOT},
                { 2, xi.items.STONE_QUIVER},
                { 6, xi.items.BONE_QUIVER},
                { 2, xi.items.BEETLE_QUIVER},
                { 2, xi.items.DEMON_QUIVER},
                { 4, xi.items.SILVER_QUIVER},
                { 6, xi.items.LIGHT_SPIRIT_PACT},
                { 2, xi.items.KABURA_QUIVER},
                { 2, xi.items.SLEEP_QUIVER},
                {19, xi.items.ISTAKOZ},
                { 1, xi.items.RUSTY_BUCKET},
            },
        },
        [xi.assaultUtil.mission.EXTERMINATION] =
        {
            items =
            {
                {15, xi.items.RUSTY_BUCKET},
                {25, xi.items.LITTLE_WORM},
                {25, xi.items.FLASK_OF_DISTILLED_WATER},
                {10, xi.items.LAMIAN_ARMLET},
                { 5, xi.items.KING_TRUFFLE},
                { 5, xi.items.QUTRUB_GORGET},
                { 2, xi.items.SILVER_QUIVER},
                { 2, xi.items.SLEEP_QUIVER},
                { 4, xi.items.STONE_QUIVER},
                { 3, xi.items.BONE_QUIVER},
                { 4, xi.items.BEETLE_QUIVER},
            },
        },
        [xi.assaultUtil.mission.TROLL_FUGITIVES] =
        {
            items =
            {
                {10, xi.items.PINCH_OF_BOMB_ASH},
                {15, xi.items.CHUNK_OF_COPPER_ORE},
                {8, xi.items.CHUNK_OF_FLAN_MEAT},
                {6, xi.items.SPRIG_OF_HOLY_BASIL},
                {2, xi.items.IRON_BULLET_POUCH},
                {1, xi.items.SILVER_BULLET_POUCH},
                {5, xi.items.PETRIFIED_LOG},
                {10, xi.items.RED_ROCK},
                {25, xi.items.PINCH_OF_SULFUR},
                {8, xi.items.TROLL_BRONZE_INGOT},
                {10, xi.items.TROLL_PAULDRON},
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_AIATAR] =
        {
            items =
            {
                {80, 12824}, -- Leather Trousers
                {10, 15367}, -- Falconer's Hose
                {10, 15370}, -- Sable Cuisses
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_INTULO] =
        {
            items =
            {
                {90, 12864}, -- Slacks
                {10, 15372}, -- Magic Slacks
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_FRIAR_RUSH] =
        {
            items =
            {
                {90, 17316}, -- Bomb Arm
                {10, 18139}, -- Bomb Core
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_SABOTENDER_BAILARIN] =
        {
            items =
            {
                {90, 17307}, -- Dart
                {10, 18138}, -- Bailathorn
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_ODQAN] =
        {
            items =
            {
                {90, 12824}, -- Leather Trousers
                {10, 15373}, -- Bravo's Subligar
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_STRAY_MARY] =
        {
            items =
            {
                {90, 17344}, -- Cornette
                {10, 17366}, -- Mary's Horn
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_UNUT] =
        {
            items =
            {
                {90, 12857}, -- Linen Slops
                {10, 14287}, -- Luna Subligar
            },
        },
        [xi.appraisalUtil.Origin.NYZUL_JADED_JODY] =
        {
            items =
            {
                {90, 12864}, -- Slacks
                {10, 15613}, -- Jet Seraweels
            },
        },
    },
}

xi.appraisalUtil.appraiseItem = function(player, npc, trade, gil, appraisalCsid)
    if player:getGil() >= gil then
        for _, tradedItem in pairs(xi.appraisalUtil.unappraisedItems) do
            if npcUtil.tradeHasExactly(trade, tradedItem) then
                local tradeID = trade:getItemId()
                local info = xi.appraisalUtil.appraisalItems[tradeID]
                local appraisalID = trade:getItem():getAppraisalID()
                local appraisedItem  = xi.appraisalUtil.itemPick(player, info, appraisalID)

                if appraisedItem ~= 0 then
                    player:startEvent(appraisalCsid, 1, appraisedItem)
                    player:setLocalVar("Appraisal", appraisedItem) -- anticheat
                end
                break
            end
        end
    end
end

xi.appraisalUtil.itemPick = function(player, info, appraisalID)
    -- possible drops
    local items = info[appraisalID].items

    -- sum weights
    local sum = 0
    for i = 1, #items do
        sum = sum + items[i][1]
    end

    -- pick weighted result
    local item = 0
    local pick = math.random(sum)
    sum = 0
    for i = 1, #items do
        sum = sum + items[i][1]
        if sum >= pick then
            item = items[i][2]
            break
        end
    end

    return item
end

xi.appraisalUtil.appraisalOnEventFinish = function(player, csid, option, gil, appraisalCsid, npc)
    if csid == appraisalCsid then
        local appraisedItem = player:getLocalVar("Appraisal")
        player:confirmTrade()
        player:addTreasure(appraisedItem, npc)
        player:delGil(gil)
        player:setLocalVar("Appraisal", 0)
    end
end

xi.appraisalUtil.canGetUnappraisedItem = function(player, area)
    local instance = player:getInstance()
    local result = false
    local cap = instance:getLevelCap()
    if cap == 0 or cap >= xi.assaultUtil.missionInfo[area].suggestedLevel then
        result = true
    end
    return result
end

xi.appraisalUtil.pickUnappraisedItem = function(player, npc, qItemTable)
    if npc:getLocalVar("UnappraisedItem") == 0 then
        for i = 1, #qItemTable, 1 do
            local lootGroup = qItemTable[i]
            if lootGroup then
                local max = 0
                for _, entry in pairs(lootGroup) do
                    max = max + entry.droprate
                end
                local roll = math.random(max)
                for _, entry in pairs(lootGroup) do
                    max = max - entry.droprate
                    if roll > max then
                        if entry.itemid > 0 then
                            npc:setLocalVar("UnappraisedItem",entry.itemid)
                        end
                        break
                    end
                end
            end
        end
    end
end

xi.appraisalUtil.assaultChestTrigger = function(player, npc, qItemTable, regItemTable)
    local instance = player:getInstance()
    local chars = instance:getChars()
    local area = player:getCurrentAssault()

    if instance:completed() and npc:getLocalVar("open") == 0 then
        if xi.appraisalUtil.canGetUnappraisedItem(player, area) then
            xi.appraisalUtil.pickUnappraisedItem(player, npc, qItemTable)
            local UnappraisedItem = npc:getLocalVar("UnappraisedItem")
            if player:getFreeSlotsCount() == 0 then
                player:messageSpecial(zones[player:getZoneID()].text.ITEM_CANNOT_BE_OBTAINED, UnappraisedItem)
                return
            else
                player:addItem({id = UnappraisedItem, appraisal = area})
                for _, players in pairs(chars) do
                    players:messageName(zones[player:getZoneID()].text.PLAYER_OBTAINS_ITEM, player, UnappraisedItem)
                end
            end
        end
        npc:entityAnimationPacket("open")
        npc:setLocalVar("open", 1)
        npc:setUntargetable(true)
        npc:timer(15000, function(npcArg) npcArg:entityAnimationPacket("kesu") end)
        npc:timer(16000, function(npcArg) npcArg:setStatus(xi.status.DISAPPEAR) end)
        for i = 1, #regItemTable, 1 do
            local lootGroup = regItemTable[i]
            if lootGroup then
                local max = 0
                for _, entry in pairs(lootGroup) do
                    max = max + entry.droprate
                end
                local roll = math.random(max)
                for _, entry in pairs(lootGroup) do
                    max = max - entry.droprate
                    if roll > max then
                        if entry.itemid ~= 0 then
                            player:addTreasure(entry.itemid, npc)
                        end
                        break
                    end
                end
            end
        end
    end
end
