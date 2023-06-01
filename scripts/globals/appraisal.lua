-----------------------------------
-- Appraisal Utilities
-- desc: Common functionality for Appraisals
-----------------------------------
require("scripts/globals/assault")
require("scripts/globals/items")
require("scripts/globals/npc_util")
-----------------------------------
xi = xi or {}
xi.appraisal = xi.appraisal or {}
-----------------------------------

xi.appraisal.origin =
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

xi.appraisal.unappraisedItems =
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

xi.appraisal.appraisalItems =
{
    [xi.items.UNAPPRAISED_SWORD] =
    {
        [xi.assault.mission.SEAGULL_GROUNDED] =
        {
            items =
            {
                { 65, xi.items.GUST_CLAYMORE  },
                { 30, xi.items.UCHIGATANA_P1  },
                {  5, xi.items.KOSETSUSAMONJI },
            },
        },

        [xi.assault.mission.SAGELORD_ELIMINATION] =
        {
            items =
            {
                { 55, xi.items.GUST_CLAYMORE },
                { 40, xi.items.UCHIGATANA_P1 },
                {  5, xi.items.DJINNBRINGER  },
            },
        },

        [xi.assault.mission.BREAKING_MORALE] =
        {
            items =
            {
                { 45, xi.items.GUST_CLAYMORE   },
                { 30, xi.items.UCHIGATANA_P1   },
                { 20, xi.items.PEALING_ANELACE },
                { 10, xi.items.KAGIROI         },
                {  5, xi.items.STORM_SCIMITAR  },
            },
        },

        [xi.assault.mission.THE_DOUBLE_AGENT] =
        {
            items =
            {
                { 45, xi.items.GUST_CLAYMORE   },
                { 10, xi.items.DJINNBRINGER    },
                { 38, xi.items.UCHIGATANA_P1   },
                {  4, xi.items.PEALING_ANELACE },
                {  3, xi.items.KAGIROI         },
            },
        },
        [xi.assault.mission.AZURE_EXPERIMENTS] =
        {
            items =
            {
                { 100, xi.items.MACUAHUITL_M1 },
            },
        },

        [xi.assault.mission.BLITZKRIEG] =
        {
            items =
            {
                { 45, xi.items.GUST_CLAYMORE  },
                { 30, xi.items.UCHIGATANA_P1  },
                { 20, xi.items.DURANDAL       },
                {  5, xi.items.SANGUINE_SWORD },
            },
        },

        [xi.assault.mission.WAMOURA_FARM_RAID] =
        {
            items =
            {
                { 45, xi.items.GUST_CLAYMORE },
                { 30, xi.items.UCHIGATANA_P1 },
                { 20, xi.items.HOTARUMARU    },
                {  5, xi.items.KUMOKIRIMARU  },
            },
        },

        [xi.assault.mission.RED_VERSUS_BLUE] =
        {
            items =
            {
                { 100, xi.items.KILIJ },
            },
        },

        [xi.appraisal.origin.NYZUL_FROSTMANE] =
        {
            items =
            {
                { 60, xi.items.CLAYMORE      },
                { 35, xi.items.GUST_CLAYMORE },
                {  5, xi.items.LOCKHEART     },
            },
        },

        [xi.appraisal.origin.NYZUL_CARNERO] =
        {
            items =
            {
                { 75, xi.items.BRONZE_SWORD       },
                { 25, xi.items.KATAYAMA_ICHIMONJI },
            },
        },

        [xi.appraisal.origin.NYZUL_EMERGENT_ELM] =
        {
            items =
            {
                { 60, xi.items.BRONZE_SWORD   },
                { 35, xi.items.XIPHOS         },
                {  5, xi.items.GLOOM_CLAYMORE },
            },
        },

        [xi.appraisal.origin.NYZUL_ZIZZY_ZILLAH] =
        {
            items =
            {
                { 60, xi.items.BRONZE_SWORD  },
                { 35, xi.items.UCHIGATANA_P1 },
                {  5, xi.items.NAMIKIRIMARU  },
            },
        },

        [xi.appraisal.origin.NYZUL_KEEPER_OF_HALIDOM] =
        {
            items =
            {
                { 65, xi.items.BRONZE_SWORD  },
                { 32, xi.items.UCHIGATANA_P1 },
                {  3, xi.items.DAIHANNYA     },
            },
        },

        [xi.appraisal.origin.NYZUL_AMIKIRI] =
        {
            items =
            {
                { 75, xi.items.BRONZE_SWORD },
                { 25, xi.items.KAMEWARI     },
            },
        },

        [xi.appraisal.origin.NYZUL_CARGO_CRAB_COLIN] =
        {
            items =
            {
                { 85, xi.items.BRONZE_SWORD },
                { 15, xi.items.NADRS        },
            },
        },
    },

    [xi.items.UNAPPRAISED_DAGGER] =
    {
        [xi.appraisal.origin.NYZUL_TOM_TIT_TAT] =
        {
            items =
            {
                { 70, xi.items.BRONZE_KNIFE  },
                { 25, xi.items.KUNAI         },
                {  5, xi.items.FRUIT_PUNCHES },
            },
        },

        [xi.appraisal.origin.NYZUL_ORCTRAP] =
        {
            items =
            {
                { 95, xi.items.BRONZE_KNIFE },
                {  5, xi.items.NIKKARIAOE   },
            },
        },

        [xi.appraisal.origin.NYZUL_STINGING_SOPHIE] =
        {
            items =
            {
                { 95, xi.items.BRONZE_KNIFE },
                {  5, xi.items.BEESTINGER   },
            },
        },

        [xi.appraisal.origin.NYZUL_WESTERN_SHADOW] =
        {
            items =
            {
                { 95, xi.items.KUNAI       },
                {  5, xi.items.RETALIATORS },
            },
        },

        [xi.appraisal.origin.NYZUL_MISCHIEVOUS_MICHOLAS] =
        {
            items =
            {
                { 95, xi.items.BRONZE_KNIFE  },
                {  5, xi.items.KIDNEY_DAGGER },
            },
        },

        [xi.appraisal.origin.NYZUL_NIGHTMARE_VASE] =
        {
            items =
            {
                { 90, xi.items.KUNAI   },
                { 10, xi.items.SHINOGI },
            },
        },

        [xi.appraisal.origin.NYZUL_DAGGERCLAW_DRACOS] =
        {
            items =
            {
                { 90, xi.items.BRONZE_KNUCKLES },
                { 10, xi.items.SONIC_KNUCKLES  },
            },
        },

        [xi.appraisal.origin.NYZUL_SABOTENDER_MARIACHI] =
        {
            items =
            {
                { 90, xi.items.BRONZE_KNIFE },
                { 10, xi.items.BANO_DEL_SOL },
            },
        },
    },

    [xi.items.UNAPPRAISED_POLEARM] =
    {
        [xi.assault.mission.SEAGULL_GROUNDED] =
        {
            items =
            {
                { 100, xi.items.SPARK_SPEAR },
            },
        },

        [xi.assault.mission.REQUIEM] =
        {
            items =
            {
                { 20, xi.items.HOLLY_STAFF_HQ },
                { 40, xi.items.BRASS_ZAGHNAL  },
                { 20, xi.items.WILLOW_WAND_HQ },
                {  5, xi.items.PUK_LANCE      },
                { 15, xi.items.SPARK_SPEAR    },
            },
        },

        [xi.assault.mission.EXTERMINATION] =
        {
            items =
            {
                { 20, xi.items.SPARK_SPEAR       },
                { 20, xi.items.WILLOW_WAND_HQ    },
                { 15, xi.items.HOLLY_STAFF_HQ    },
                { 35, xi.items.BRASS_ZAGHNAL     },
                { 10, xi.items.VOLUNTEERS_SCYTHE },
            },
        },

        [xi.assault.mission.TROLL_FUGITIVES] =
        {
            items =
            {
                { 100, xi.items.SICKLE }
            },
        },

        [xi.appraisal.origin.NYZUL_JUGGLER_HECATOMB] =
        {
            items =
            {
                { 90, xi.items.ASH_CLUB      },
                { 10, xi.items.HEAVY_HALBERD },
            },
        },

        [xi.appraisal.origin.NYZUL_HELLION] =
        {
            items =
            {
                { 70, xi.items.MAPLE_WAND  },
                { 30, xi.items.A_LOUTRANCE },
            },
        },

        [xi.appraisal.origin.NYZUL_FALCATUS_ARANEI] =
        {
            items =
            {
                { 70, xi.items.MAPLE_WAND     },
                { 20, xi.items.BRONZE_ZAGHNAL },
                { 10, xi.items.WEBCUTTER      },
            },
        },

        [xi.appraisal.origin.NYZUL_NUNYENUNC] =
        {
            items =
            {
                { 90, xi.items.ASH_CLUB      },
                { 10, xi.items.PILGRIMS_WAND },
            },
        },

        [xi.appraisal.origin.NYZUL_ROC] =
        {
            items =
            {
                { 90, xi.items.MAPLE_WAND  },
                { 10, xi.items.DRYAD_STAFF },
            },
        },

        [xi.appraisal.origin.NYZUL_SWAMFISK] =
        {
            items =
            {
                { 90, xi.items.MAPLE_WAND   },
                { 10, xi.items.GELONG_STAFF },
            },
        },

        [xi.appraisal.origin.NYZUL_VOUIVRE] =
        {
            items =
            {
                { 90, xi.items.ASH_CLUB },
                { 10, xi.items.GAE_BOLG },
            },
        },
    },

    [xi.items.UNAPPRAISED_AXE] =
    {
        [xi.assault.mission.REQUIEM] =
        {
            items =
            {
                { 100, xi.items.PICKAXE },
            },
        },

        [xi.assault.mission.EXTERMINATION] =
        {
            items =
            {
                { 100, xi.items.PICKAXE },
            },
        },

        [xi.assault.mission.TROLL_FUGITIVES] =
        {
            items =
            {
                { 60, xi.items.HATCHET        },
                { 10, xi.items.TOMAHAWK_HQ    },
                { 15, xi.items.WAMOURA_AXE    },
                { 15, xi.items.PROMINENCE_AXE },
            },
        },

        [xi.appraisal.origin.NYZUL_BAT_EYE] =
        {
            items =
            {
                { 95, xi.items.BONE_AXE  },
                {  5, xi.items.STORM_AXE },
            },
        },

        [xi.appraisal.origin.NYZUL_NORTHERN_SHADOW] =
        {
            items =
            {
                { 90, xi.items.BUTTERFLY_AXE },
                { 10, xi.items.EXECUTIONER   },
            },
        },

        [xi.appraisal.origin.NYZUL_AQUARIUS] =
        {
            items =
            {
                { 90, xi.items.BONE_AXE  },
                { 10, xi.items.FRANSISCA },
            },
        },

        [xi.appraisal.origin.NYZUL_TRICKSTER_KINETIX] =
        {
            items =
            {
                { 90, xi.items.BONE_AXE },
                { 10, xi.items.TABAR    },
            },
        },

        [xi.appraisal.origin.NYZUL_TYRANNIC_TUNNOK] =
        {
            items =
            {
                { 90, xi.items.BONE_AXE },
                { 10, xi.items.LOHAR    },
            },
        },

        [xi.appraisal.origin.NYZUL_PANZER_PERCIVAL] =
        {
            items =
            {
                { 90, xi.items.BUTTERFLY_AXE },
                { 10, xi.items.NECKCHOPPER   },
            },
        },

        [xi.appraisal.origin.NYZUL_PEG_POWLER] =
        {
            items =
            {
                { 90, xi.items.BUTTERFLY_AXE },
                { 10, xi.items.SCHWARZ_AXT   },
            },
        },
    },

    [xi.items.UNAPPRAISED_BOW] =
    {
        [xi.assault.mission.LAMIA_NO_13] =
        {
            items =
            {
                { 43, xi.items.LONGBOW_P1   },
                { 43, xi.items.CROSSBOW_P1  },
                { 14, xi.items.IMPERIAL_BOW },
            },
        },

        [xi.appraisal.origin.NYZUL_GYRE_CARLIN] =
        {
            items =
            {
                { 90, xi.items.SHORTBOW },
                { 10, xi.items.RIKONODO },
            },
        },

        [xi.appraisal.origin.NYZUL_EASTERN_SHADOW] =
        {
            items =
            {
                { 90, xi.items.LONGBOW   },
                { 10, xi.items.VALIS_BOW },
            },
        },

        [xi.appraisal.origin.NYZUL_HELLDIVER] =
        {
            items =
            {
                { 90, xi.items.SELF_BOW },
                { 10, xi.items.WINGEDGE },
            },
        },

        [xi.appraisal.origin.NYZUL_UNGUR] =
        {
            items =
            {
                { 90, xi.items.CROSSBOW        },
                { 10, xi.items.UNGUR_BOOMERANG },
            },
        },

        [xi.appraisal.origin.NYZUL_FRAELISSA] =
        {
            items =
            {
                { 90, xi.items.CROSSBOW      },
                { 10, xi.items.ALMOGAVAR_BOW },
            },
        },
    },

    [xi.items.UNAPPRAISED_GLOVES] =
    {
        [xi.assault.mission.ORICHALCUM_SURVEY] =
        {
            items =
            {
                { 100, xi.items.STORM_GAGES },
            },
        },

        [xi.assault.mission.SEAGULL_GROUNDED] =
        {
            items =
            {
                { 28, xi.items.BRONZE_MITTENS_P1 },
                { 30, xi.items.LEATHER_GLOVES    },
                { 20, xi.items.COTTON_GLOVES     },
                { 18, xi.items.CUFFS             },
                {  5, xi.items.STORM_MANOPOLAS   },
            },
        },

        [xi.assault.mission.REQUIEM] =
        {
            items =
            {
                { 30, xi.items.LEATHER_GLOVES    },
                { 28, xi.items.BRONZE_MITTENS_P1 },
                { 20, xi.items.COTTON_GLOVES     },
                { 18, xi.items.CUFFS             },
                {  5, xi.items.STORM_GAGES       },
            },
        },

        [xi.appraisal.origin.NYZUL_PEALLAIDH] =
        {
            items =
            {
                { 90, xi.items.LEATHER_GLOVES   },
                { 10, xi.items.NIGHTMARE_GLOVES },
            },
        },

        [xi.appraisal.origin.NYZUL_ENERGETIC_ERUCA] =
        {
            items =
            {
                { 90, xi.items.COTTON_GLOVES },
                { 10, xi.items.HANZO_TEKKO   },
            },
        },
    },

    [xi.items.UNAPPRAISED_FOOTWEAR] =
    {
        [xi.assault.mission.LAMIA_NO_13] =
        {
            items =
            {
                { 20, xi.items.ASH_CLOGS          },
                { 38, xi.items.BRONZE_LEGGINGS_P1 },
                { 18, xi.items.LEATHER_HIGHBOOTS  },
                {  6, xi.items.SOLEA              },
                { 18, xi.items.STORM_GAMBIERAS    },
            },
        },

        [xi.assault.mission.EXTERMINATION] =
        {
            items =
            {
                {  5, xi.items.STORM_CRACKOWS     },
                { 35, xi.items.ASH_CLOGS          },
                { 25, xi.items.BRONZE_LEGGINGS_HQ },
                { 35, xi.items.LEATHER_HIGHBOOTS  },
            },
        },

        [xi.appraisal.origin.NYZUL_LEAPING_LIZZY] =
        {
            items =
            {
                { 95, xi.items.LEATHER_HIGHBOOTS },
                {  5, xi.items.LEAPING_BOOTS     },
            },
        },

        [xi.appraisal.origin.NYZUL_CACTUAR_CANTAUTOR] =
        {
            items =
            {
                { 90, xi.items.LEATHER_HIGHBOOTS },
                { 10, xi.items.KUNG_FU_SHOES     },
            },
        },

        [xi.appraisal.origin.NYZUL_BONNACON] =
        {
            items =
            {
                { 90, xi.items.ASH_CLOGS       },
                { 10, xi.items.TREDECIM_SCYTHE }, -- Tredecim Scythe or Cure Clogs
            },
        },

        [xi.appraisal.origin.NYZUL_TOTTERING_TOBY] =
        {
            items =
            {
                { 90, xi.items.ASH_CLOGS         },
                { 10, xi.items.STUMBLING_SANDALS },
            },
        },

        [xi.appraisal.origin.NYZUL_SIMURGH] =
        {
            items =
            {
                { 90, xi.items.LEATHER_HIGHBOOTS },
                { 10, xi.items.TROTTER_BOOTS     },
            },
        },
    },

    [xi.items.UNAPPRAISED_HEADPIECE] =
    {
        [xi.assault.mission.TROLL_FUGITIVES] =
        {
            items =
            {
                {  5, xi.items.STORM_TURBAN    },
                { 20, xi.items.COTTON_HEADGEAR },
                { 15, xi.items.BRONZE_CAP_HQ   },
                { 30, xi.items.LEATHER_BANDANA },
                { 30, xi.items.CIRCLET         },
            },
        },

        [xi.appraisal.origin.NYZUL_VALKURM_EMPEROR] =
        {
            items =
            {
                { 90, xi.items.COPPER_HAIRPIN  },
                { 10, xi.items.EMPRESS_HAIRPIN },
            },
        },

        [xi.appraisal.origin.NYZUL_ELLYLLON] =
        {
            items =
            {
                { 90, xi.items.LEATHER_BANDANA },
                { 10, xi.items.MUSHROOM_HELM   },
            },
        },

        [xi.appraisal.origin.NYZUL_TAISAIJIN] =
        {
            items =
            {
                { 90, xi.items.LEATHER_BANDANA },
                { 10, xi.items.SPELUNKERS_HAT  },
            },
        },

        [xi.appraisal.origin.NYZUL_DROOLING_DAISY] =
        {
            items =
            {
                { 90, xi.items.BONE_HAIRPIN   },
                { 10, xi.items.DODGE_HEADBAND },
            },
        },

        [xi.appraisal.origin.NYZUL_SHARP_EARED_ROPIPI] =
        {
            items =
            {
                { 90, xi.items.COPPER_HAIRPIN    },
                { 10, xi.items.ENTRANCING_RIBBON },
            },
        },

        [xi.appraisal.origin.NYZUL_TUMBLING_TRUFFLE] =
        {
            items =
            {
                { 90, xi.items.LEATHER_BANDANA },
                { 10, xi.items.FUNGUS_HAT      },
            },
        },
    },

    [xi.items.UNAPPRAISED_EARRING] =
    {
        [xi.assault.mission.EXCAVATION_DUTY] =
        {
            items =
            {
                { 25, xi.items.SHELL_EARRING   },
                { 21, xi.items.BONE_EARRING    },
                { 25, xi.items.BEETLE_EARRING  },
                { 20, xi.items.SILVER_EARRING  },
                {  6, xi.items.RERAISE_EARRING },
                {  3, xi.items.STORM_LOOP      },
            },
        },

        [xi.assault.mission.GOLDEN_SALVAGE] =
        {
            items =
            {
                { 22, xi.items.SHELL_EARRING  },
                { 20, xi.items.BONE_EARRING   },
                { 21, xi.items.BEETLE_EARRING },
                { 27, xi.items.SILVER_EARRING },
                {  6, xi.items.HEIMS_EARRING  },
                {  4, xi.items.STORM_EARRING  },
            },
        },

        [xi.appraisal.origin.NYZUL_LEECH_KING] =
        {
            items =
            {
                { 90, xi.items.SHELL_EARRING     },
                { 10, xi.items.BLOODBEAD_EARRING },
            },
        },

        [xi.appraisal.origin.NYZUL_CAPRICIOUS_CASSIE] =
        {
            items =
            {
                { 90, xi.items.BONE_EARRING   },
                { 10, xi.items.CASSIE_EARRING },
            },
        },

        [xi.appraisal.origin.NYZUL_MAIGHDEAN_UAINE] =
        {
            items =
            {
                { 90, xi.items.BEETLE_EARRING  },
                { 10, xi.items.OPTICAL_EARRING },
            },
        },
    },

    [xi.items.UNAPPRAISED_RING] =
    {
        [xi.assault.mission.LEUJAOAM_CLEANSING] =
        {
            items =
            {
                { 50, xi.items.COPPER_RING   },
                { 30, xi.items.BRASS_RING    },
                { 15, xi.items.ARCHERS_RING  },
                {  5, xi.items.IMPERIAL_RING },
            },
        },

        [xi.assault.mission.IMPERIAL_AGENT_RESCUE] =
        {
            items =
            {
                { 50, xi.items.COPPER_RING },
                { 30, xi.items.BRASS_RING  },
                { 15, xi.items.ETHER_RING  },
                {  5, xi.items.STORM_RING  },
            },
        },

        [xi.appraisal.origin.NYZUL_BOMB_KING] =
        {
            items =
            {
                { 60, xi.items.COPPER_RING },
                { 30, xi.items.BRASS_RING  },
                { 10, xi.items.BOMB_RING   },
            },
        },

        [xi.appraisal.origin.NYZUL_SMOTHERING_SCHMIDT] =
        {
            items =
            {
                { 60, xi.items.COPPER_RING   },
                { 30, xi.items.BRASS_RING    },
                { 10, xi.items.MALFLOOD_RING },
            },
        },

        [xi.appraisal.origin.NYZUL_ASPHYXIATED_AMSEL] =
        {
            items =
            {
                { 90, xi.items.BRASS_RING   },
                { 10, xi.items.MALGUST_RING },
            },
        },

        [xi.appraisal.origin.NYZUL_CRUSHED_KRAUSE] =
        {
            items =
            {
                { 90, xi.items.COPPER_RING  },
                { 10, xi.items.MALDUST_RING },
            },
        },

        [xi.appraisal.origin.NYZUL_PULVERIZED_PFEFFER] =
        {
            items =
            {
                { 90, xi.items.COPPER_RING   },
                { 10, xi.items.MALFROST_RING },
            },
        },

        [xi.appraisal.origin.NYZUL_SERKET] =
        {
            items =
            {
                { 90, xi.items.BRASS_RING  },
                { 10, xi.items.SERKET_RING },
            },
        },

        [xi.appraisal.origin.NYZUL_BURNED_BERGMANN] =
        {
            items =
            {
                { 90, xi.items.COPPER_RING   },
                { 10, xi.items.MALFLAME_RING },
            },
        },

        [xi.appraisal.origin.NYZUL_BLOODSUCKER] =
        {
            items =
            {
                { 90, xi.items.COPPER_RING    },
                { 10, xi.items.BLOODBEAD_RING },
            },
        },

        [xi.appraisal.origin.NYZUL_SEWER_SYRUP] =
        {
            items =
            {
                { 90, xi.items.BRASS_RING },
                { 10, xi.items.JELLY_RING },
            },
        },

        [xi.appraisal.origin.NYZUL_WOUNDED_WURFEL] =
        {
            items =
            {
                { 90, xi.items.COPPER_RING   },
                { 10, xi.items.MALFLASH_RING },
            },
        },
    },

    [xi.items.UNAPPRAISED_CAPE] =
    {
        [xi.assault.mission.LEBROS_SUPPLIES] =
        {
            items =
            {
                { 30, xi.items.DHALMEL_MANTLE_P1 },
                { 25, xi.items.COTTON_CAPE_P1    },
                { 25, xi.items.LIZARD_MANTLE_P1  },
                {  5, xi.items.STORM_CAPE        },
                { 15, xi.items.ENHANCING_MANTLE  },
            },
        },

        [xi.appraisal.origin.NYZUL_OLD_TWO_WINGS] =
        {
            items =
            {
                { 90, xi.items.LIZARD_MANTLE_P1 },
                { 10, xi.items.BAT_CAPE         },
            },
        },

        [xi.appraisal.origin.NYZUL_FRAELISSA] =
        {
            items =
            {
                { 90, xi.items.COTTON_CAPE_P1   },
                { 10, xi.items.BELLICOSE_MANTLE },
            },
        },

        [xi.appraisal.origin.NYZUL_SPINY_SPIPI] =
        {
            items =
            {
                { 90, xi.items.RABBIT_MANTLE  },
                { 10, xi.items.MIST_SILK_CAPE },
            },
        },

        [xi.appraisal.origin.NYZUL_GOLDEN_BAT] =
        {
            items =
            {
                { 90, xi.items.COTTON_CAPE_P1 },
                { 10, xi.items.NIGHT_CAPE     },
            },
        },
    },

    [xi.items.UNAPPRAISED_SASH] =
    {

    },

    [xi.items.UNAPPRAISED_SHIELD] =
    {
        [xi.appraisal.origin.NYZUL_BLOODTEAR_BALDURF] =
        {
            items =
            {
                { 90, xi.items.OAK_SHIELD    },
                { 10, xi.items.VIKING_SHIELD },
            },
        },

        [xi.appraisal.origin.NYZUL_FUNGUS_BEETLE] =
        {
            items =
            {
                { 90, xi.items.LAUAN_SHIELD },
                { 10, xi.items.CLIPEUS      },
            },
        },

        [xi.appraisal.origin.NYZUL_STEELFLEECE_BALDARICH] =
        {
            items =
            {
                { 90, xi.items.OAK_SHIELD    },
                { 10, xi.items.VIKING_SHIELD },
            },
        },

        [xi.appraisal.origin.NYZUL_SOUTHERN_SHADOW] =
        {
            items =
            {
                { 90, xi.items.ELM_SHIELD    },
                { 10, xi.items.MASTER_SHIELD },
            },
        },

        [xi.appraisal.origin.NYZUL_PELICAN] =
        {
            items =
            {
                { 90, xi.items.ASPIS        },
                { 10, xi.items.ASTRAL_ASPIS },
            },
        },
    },

    [xi.items.UNAPPRAISED_NECKLACE] =
    {
        [xi.assault.mission.ORICHALCUM_SURVEY] =
        {
            items =
            {
                { 55, xi.items.FEATHER_COLLAR },
                { 30, xi.items.GORGET_P1      },
                { 10, xi.items.JAGD_GORGET    },
                {  5, xi.items.STORM_MUFFLER  },
            },
        },

        [xi.assault.mission.PREEMPTIVE_STRIKE] =
        {
            items =
            {
                { 55, xi.items.FEATHER_COLLAR },
                { 30, xi.items.GORGET_P1      },
                { 10, xi.items.SPECTACLES     },
                {  5, xi.items.STORM_TORQUE   },
            },
        },

        [xi.appraisal.origin.NYZUL_SHADOW_EYE] =
        {
            items =
            {
                { 95, xi.items.REGEN_COLLAR },
                {  5, xi.items.MOON_AMULET  },
            },
        },

        [xi.appraisal.origin.NYZUL_JAGGEDY_EARED_JACK] =
        {
            items =
            {
                { 90, xi.items.LEATHER_GORGET },
                { 10, xi.items.RABBIT_CHARM   },
            },
        },

        [xi.appraisal.origin.NYZUL_GARGANTUA] =
        {
            items =
            {
                { 90, xi.items.FEATHER_COLLAR  },
                { 10, xi.items.ELEMENTAL_CHARM },
            },
        },

        [xi.appraisal.origin.NYZUL_SERPOPARD_ISHTAR] =
        {
            items =
            {
                { 90, xi.items.FEATHER_COLLAR   },
                { 10, xi.items.CERULEAN_PENDANT },
            },
        },

        [xi.appraisal.origin.NYZUL_ARGUS] =
        {
            items =
            {
                { 90, xi.items.REGEN_COLLAR  },
                { 10, xi.items.PEACOCK_CHARM },
            },
        },

        [xi.appraisal.origin.NYZUL_BLOODPOOL_VORAX] =
        {
            items =
            {
                { 90, xi.items.GORGET_P1        },
                { 10, xi.items.BLOODBEAD_AMULET },
            },
        },

        [xi.appraisal.origin.NYZUL_BUBURIMBOO] =
        {
            items =
            {
                { 90, xi.items.GORGET_P1       },
                { 10, xi.items.BUBURIMU_GORGET },
            },
        },

        [xi.appraisal.origin.NYZUL_DUNE_WIDOW] =
        {
            items =
            {
                { 90, xi.items.REGEN_COLLAR  },
                { 10, xi.items.SPIDER_TORQUE },
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
        [xi.assault.mission.LEUJAOAM_CLEANSING] =
        {
            items =
            {
                { 10, xi.items.WHITE_ROCK        },
                { 20, xi.items.TSURARA           },
                {  2, xi.items.PHALAENOPSIS      },
                {  5, xi.items.GARDENIA_SEED     },
                {  8, xi.items.GLASS_SHEET       },
                { 20, xi.items.MERROW_SCALE      },
                { 15, xi.items.SOULFLAYER_STAFF  },
                { 10, xi.items.ICE_CRYSTAL       },
                {  1, xi.items.TOOLBAG_JUSATSU   },
                {  3, xi.items.IRON_BULLET_POUCH },
                {  6, xi.items.LAKERDA           },
            },
        },

        [xi.assault.mission.ORICHALCUM_SURVEY] =
        {
            items =
            {
                { 10, xi.items.EGGPLANT              },
                {  9, xi.items.GARDENIA_SEED         },
                { 10, xi.items.ICE_CRYSTAL           },
                {  7, xi.items.KABURA_QUIVER         },
                { 13, xi.items.SQUARE_OF_LINEN_CLOTH },
                {  8, xi.items.MERROW_SCALE          },
                {  5, xi.items.PHALAENOPSIS          },
                { 10, xi.items.POROGGO_HAT           },
                {  6, xi.items.SOULFLAYER_STAFF      },
                { 15, xi.items.TSURARA               },
                {  7, xi.items.WHITE_ROCK            },
            },
        },

        [xi.assault.mission.IMPERIAL_AGENT_RESCUE] =
        {
            items =
            {
                {  7, xi.items.DATE                         },
                {  5, xi.items.EGGPLANT                     },
                { 10, xi.items.CLUMP_OF_IMPERIAL_TEA_LEAVES },
                {  4, xi.items.CHUNK_OF_KAOLIN              },
                { 20, xi.items.MAMOOL_JA_COLLAR             },
                { 15, xi.items.POROGGO_HAT                  },
                {  6, xi.items.SPRIG_OF_SAGE                },
                {  5, xi.items.SQUARE_OF_SILK_CLOTH         },
                {  1, xi.items.TOOLBAG_KAWAHORI_OGI         },
                {  1, xi.items.TOOLBAG_SHIHEI               },
                {  1, xi.items.TOOLBAG_TSURARA              },
                { 10, xi.items.WILD_ONION                   },
                {  1, xi.items.TOOLBAG_UCHITAKE             },
                { 14, xi.items.ISTAKOZ                      },
            },
        },

        [xi.assault.mission.LEBROS_SUPPLIES] =
        {
            items =
            {
                { 20, xi.items.PINCH_OF_SULFUR     },
                { 20, xi.items.CHUNK_OF_FLAN_MEAT  },
                {  5, xi.items.BULLET_POUCH        },
                { 20, xi.items.TROLL_PAULDRON      },
                { 10, xi.items.SPARTAN_BULLET      },
                { 25, xi.items.SPRIG_OF_HOLY_BASIL },
            },
        },

        [xi.assault.mission.PREEMPTIVE_STRIKE] =
        {
            items =
            {
                { 17, xi.items.EGGPLANT                     },
                { 15, xi.items.SPRIG_OF_SAGE                },
                { 15, xi.items.CLUMP_OF_IMPERIAL_TEA_LEAVES },
                {  7, xi.items.WILD_ONION                   },
                { 10, xi.items.SPOOL_OF_RED_GRASS_THREAD    },
                {  7, xi.items.MAMOOL_JA_COLLAR             },
                {  4, xi.items.TOOLBAG_SAIRUI_RAN           },
                {  3, xi.items.TOOLBAG_SHIHEI               },
                {  4, xi.items.TOOLBAG_JUSATSU              },
                { 10, xi.items.CHUNK_OF_KAOLIN              },
                {  8, xi.items.POROGGO_HAT                  },
            },
        },

        [xi.assault.mission.REQUIEM] =
        {
            items =
            {
                {  4, xi.items.IGNEOUS_ROCK             },
                {  5, xi.items.ROTTEN_QUIVER            },
                {  5, xi.items.HOLY_BOLT_QUIVER         },
                { 20, xi.items.BONE_CHIP                },
                {  5, xi.items.CLEANING_TOOL_SET        },
                {  2, xi.items.HANDFUL_OF_DRAGON_SCALES },
                {  9, xi.items.QIQIRN_SANDBAG           },
                { 15, xi.items.IMP_WING                 },
                { 20, xi.items.BRONZE_BOLT              },
                { 15, xi.items.SPRIG_OF_APPLE_MINT      },
            },
        },

        [xi.assault.mission.EXCAVATION_DUTY] =
        {
            items =
            {
                { 15, xi.items.CHUNK_OF_COPPER_ORE    },
                { 10, xi.items.RED_ROCK               },
                {  5, xi.items.SQUARE_OF_VELVET_CLOTH },
                {  8, xi.items.PINCH_OF_BOMB_ASH      },
                {  8, xi.items.PINCH_OF_SULFUR        },
                {  5, xi.items.SPRIG_OF_HOLY_BASIL    },
                { 20, xi.items.TROLL_PAULDRON         },
                { 15, xi.items.CHUNK_OF_FLAN_MEAT     },
                {  1, xi.items.TROLL_BRONZE_INGOT     },
                {  2, xi.items.SILVER_BULLET_POUCH    },
                {  1, xi.items.SPARTAN_BULLET_POUCH   },
                {  2, xi.items.IRON_BULLET_POUCH      },
                {  4, xi.items.BRONZE_BULLET_POUCH    },
                {  3, xi.items.BULLET_POUCH           },
            },
        },

        [xi.assault.mission.SEAGULL_GROUNDED] =
        {
            items =
            {
                {  1, xi.items.CLEANING_TOOL_SET       },
                {  2, xi.items.SPOOL_OF_RAINBOW_THREAD },
                { 25, xi.items.BONE_CHIP               },
                {  5, xi.items.SPRIG_OF_APPLE_MINT     },
                {  3, xi.items.IGNEOUS_ROCK            },
                { 20, xi.items.QIQIRN_SANDBAG          },
                {  5, xi.items.IMP_WING                },
                { 10, xi.items.ROTTEN_QUIVER           },
                {  6, xi.items.BRONZE_BOLT_QUIVER      },
                { 10, xi.items.WILD_ONION              },
                {  5, xi.items.HOLY_BOLT_QUIVER        },
                {  3, xi.items.SLEEP_BOLT_QUIVER       },
            },
        },

        [xi.assault.mission.GOLDEN_SALVAGE] =
        {
            items =
            {
                {  1, xi.items.RUSTY_BUCKET               },
                { 24, xi.items.QUTRUB_GORGET              },
                { 20, xi.items.LAMIAN_ARMLET              },
                {  6, xi.items.AHT_URHGAN_BRASS_INGOT     },
                {  2, xi.items.STONE_QUIVER               },
                {  6, xi.items.BONE_QUIVER                },
                {  2, xi.items.BEETLE_QUIVER              },
                {  1, xi.items.HORN_QUIVER                },
                {  5, xi.items.SCORPION_QUIVER            },
                {  5, xi.items.DEMON_QUIVER               },
                {  3, xi.items.IRON_QUIVER                },
                {  4, xi.items.SILVER_QUIVER              },
                {  1, xi.items.FLASK_OF_DISTILLED_WATER   },
                {  5, xi.items.SCROLL_OF_PUPPETS_OPERETTA },
                {  5, xi.items.KABURA_QUIVER              },
                {  1, xi.items.SLEEP_QUIVER               },
                { 14, xi.items.ISTAKOZ                    },
                {  1, xi.items.WILLOW_FISHING_ROD         },
                {  1, xi.items.LITTLE_WORM                },
            },
        },

        [xi.assault.mission.LAMIA_NO_13] =
        {
            items =
            {
                {  2, xi.items.SPRIG_OF_APPLE_MINT    },
                { 25, xi.items.QUTRUB_GORGET          },
                { 25, xi.items.LAMIAN_ARMLET          },
                {  2, xi.items.AHT_URHGAN_BRASS_INGOT },
                {  2, xi.items.STONE_QUIVER           },
                {  6, xi.items.BONE_QUIVER            },
                {  2, xi.items.BEETLE_QUIVER          },
                {  2, xi.items.DEMON_QUIVER           },
                {  4, xi.items.SILVER_QUIVER          },
                {  6, xi.items.LIGHT_SPIRIT_PACT      },
                {  2, xi.items.KABURA_QUIVER          },
                {  2, xi.items.SLEEP_QUIVER           },
                { 19, xi.items.ISTAKOZ                },
                {  1, xi.items.RUSTY_BUCKET           },
            },
        },

        [xi.assault.mission.EXTERMINATION] =
        {
            items =
            {
                { 15, xi.items.RUSTY_BUCKET             },
                { 25, xi.items.LITTLE_WORM              },
                { 25, xi.items.FLASK_OF_DISTILLED_WATER },
                { 10, xi.items.LAMIAN_ARMLET            },
                {  5, xi.items.KING_TRUFFLE             },
                {  5, xi.items.QUTRUB_GORGET            },
                {  2, xi.items.SILVER_QUIVER            },
                {  2, xi.items.SLEEP_QUIVER             },
                {  4, xi.items.STONE_QUIVER             },
                {  3, xi.items.BONE_QUIVER              },
                {  4, xi.items.BEETLE_QUIVER            },
            },
        },

        [xi.assault.mission.TROLL_FUGITIVES] =
        {
            items =
            {
                { 10, xi.items.PINCH_OF_BOMB_ASH   },
                { 15, xi.items.CHUNK_OF_COPPER_ORE },
                {  8, xi.items.CHUNK_OF_FLAN_MEAT  },
                {  6, xi.items.SPRIG_OF_HOLY_BASIL },
                {  2, xi.items.IRON_BULLET_POUCH   },
                {  1, xi.items.SILVER_BULLET_POUCH },
                {  5, xi.items.PETRIFIED_LOG       },
                { 10, xi.items.RED_ROCK            },
                { 25, xi.items.PINCH_OF_SULFUR     },
                {  8, xi.items.TROLL_BRONZE_INGOT  },
                { 10, xi.items.TROLL_PAULDRON      },
            },
        },

        [xi.appraisal.origin.NYZUL_AIATAR] =
        {
            items =
            {
                { 80, xi.items.LEATHER_TROUSERS },
                { 10, xi.items.FALCONERS_HOSE   },
                { 10, xi.items.SABLE_CUISSES    },
            },
        },

        [xi.appraisal.origin.NYZUL_INTULO] =
        {
            items =
            {
                { 90, xi.items.SLACKS       },
                { 10, xi.items.MAGIC_SLACKS },
            },
        },

        [xi.appraisal.origin.NYZUL_FRIAR_RUSH] =
        {
            items =
            {
                { 90, xi.items.BOMB_ARM  },
                { 10, xi.items.BOMB_CORE },
            },
        },

        [xi.appraisal.origin.NYZUL_SABOTENDER_BAILARIN] =
        {
            items =
            {
                { 90, xi.items.DART       },
                { 10, xi.items.BAILATHORN },
            },
        },

        [xi.appraisal.origin.NYZUL_ODQAN] =
        {
            items =
            {
                { 90, xi.items.LEATHER_TROUSERS },
                { 10, xi.items.BRAVOS_SUBLIGAR  },
            },
        },

        [xi.appraisal.origin.NYZUL_STRAY_MARY] =
        {
            items =
            {
                { 90, xi.items.CORNETTE   },
                { 10, xi.items.MARYS_HORN },
            },
        },

        [xi.appraisal.origin.NYZUL_UNUT] =
        {
            items =
            {
                { 90, xi.items.LINEN_SLOPS   },
                { 10, xi.items.LUNA_SUBLIGAR },
            },
        },

        [xi.appraisal.origin.NYZUL_JADED_JODY] =
        {
            items =
            {
                { 90, xi.items.SLACKS        },
                { 10, xi.items.JET_SERAWEELS },
            },
        },
    },
}

xi.appraisal.appraiseItem = function(player, npc, trade, gil, appraisalCsid)
    if player:getGil() >= gil then
        for _, tradedItem in pairs(xi.appraisal.unappraisedItems) do
            if npcUtil.tradeHasExactly(trade, tradedItem) then
                local tradeID        = trade:getItemId()
                local info           = xi.appraisal.appraisalItems[tradeID]
                local appraisalID    = trade:getItem():getAppraisalID()
                local appraisedItem  = xi.appraisal.itemPick(player, info, appraisalID)

                if appraisedItem ~= 0 then
                    player:startEvent(appraisalCsid, 1, appraisedItem)
                    player:setLocalVar("Appraisal", appraisedItem) -- anticheat
                    player:confirmTrade()
                end

                break
            end
        end
    end
end

xi.appraisal.itemPick = function(player, info, appraisalID)
    -- possible drops
    local items = info[appraisalID].items

    -- sum weights
    local sum = 0
    for i = 1, #items do
        sum = sum + items[i][1]
    end

    -- pick weighted result
    local item = 0
    local pick = math.random(1, sum)
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

xi.appraisal.appraisalOnEventFinish = function(player, csid, option, gil, appraisalCsid, npc)
    if csid == appraisalCsid then
        local appraisedItem = player:getLocalVar("Appraisal")
        player:addTreasure(appraisedItem, npc)
        player:delGil(gil)
        player:setLocalVar("Appraisal", 0)
    end
end

xi.appraisal.canGetUnappraisedItem = function(player, area)
    local instance = player:getInstance()
    local result   = false
    local cap      = instance:getLevelCap()

    if cap == 0 or cap >= xi.assault.missionInfo[area].suggestedLevel then
        result = true
    end

    return result
end

xi.appraisal.pickUnappraisedItem = function(player, npc, qItemTable)
    if npc:getLocalVar("UnappraisedItem") == 0 then
        for i = 1, #qItemTable, 1 do
            local lootGroup = qItemTable[i]
            if lootGroup then
                local max = 0
                for _, entry in pairs(lootGroup) do
                    max = max + entry.droprate
                end

                local roll = math.random(1, max)

                for _, entry in pairs(lootGroup) do
                    max = max - entry.droprate
                    if roll > max then
                        if entry.itemid > 0 then
                            npc:setLocalVar("UnappraisedItem", entry.itemid)
                        end

                        break
                    end
                end
            end
        end
    end
end

xi.appraisal.assaultChestTrigger = function(player, npc, qItemTable, regItemTable)
    local instance = player:getInstance()
    local chars    = instance:getChars()
    local area     = player:getCurrentAssault()

    if instance:completed() and npc:getLocalVar("open") == 0 then
        if xi.appraisal.canGetUnappraisedItem(player, area) then
            xi.appraisal.pickUnappraisedItem(player, npc, qItemTable)
            local unappraisedItem = npc:getLocalVar("UnappraisedItem")
            if player:getFreeSlotsCount() == 0 then
                player:messageSpecial(zones[player:getZoneID()].text.ITEM_CANNOT_BE_OBTAINED, unappraisedItem)
                return
            else
                player:addItem({ id = unappraisedItem, appraisal = area })
                for _, players in pairs(chars) do
                    players:messageName(zones[player:getZoneID()].text.PLAYER_OBTAINS_ITEM, player, unappraisedItem)
                end
            end
        end

        npc:entityAnimationPacket("open")
        npc:setLocalVar("open", 1)
        npc:setUntargetable(true)
        npc:timer(15000, function(npcArg)
            npcArg:entityAnimationPacket("kesu")
        end)

        npc:timer(16000, function(npcArg)
            npcArg:setStatus(xi.status.DISAPPEAR)
        end)

        for i = 1, #regItemTable, 1 do
            local lootGroup = regItemTable[i]
            if lootGroup then
                local max = 0
                for _, entry in pairs(lootGroup) do
                    max = max + entry.droprate
                end

                local roll = math.random(1, max)
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
