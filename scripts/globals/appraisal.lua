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
        [xi.assault.mission.AZURE_EXPERIMENTS] =
        {
            items =
            {
                { 1000, xi.items.MACUAHUITL_M1 },
            },
        },

        [xi.assault.mission.RED_VERSUS_BLUE] =
        {
            items =
            {
                { 1000, xi.items.KILIJ },
            },
        },

        [xi.assault.mission.SAGELORD_ELIMINATION] =
        {
            items =
            {
                { 550, xi.items.GUST_CLAYMORE },
                { 400, xi.items.UCHIGATANA_P1 },
                {  50, xi.items.DJINNBRINGER  },
            },
        },

        [xi.assault.mission.BREAKING_MORALE] =
        {
            items =
            {
                { 450, xi.items.GUST_CLAYMORE   },
                { 300, xi.items.UCHIGATANA_P1   },
                { 200, xi.items.PEALING_ANELACE },
                { 100, xi.items.KAGIROI         },
                {  50, xi.items.STORM_SCIMITAR  },
            },
        },

        [xi.assault.mission.THE_DOUBLE_AGENT] =
        {
            items =
            {
                { 100, xi.items.DJINNBRINGER    },
                { 450, xi.items.GUST_CLAYMORE   },
                {  50, xi.items.PEALING_NAGAN   },
                { 350, xi.items.UCHIGATANA_P1   },
                {  50, xi.items.KAGIROI         },
            },
        },

        [xi.assault.mission.BLITZKRIEG] =
        {
            items =
            {
                { 450, xi.items.GUST_CLAYMORE  },
                { 300, xi.items.UCHIGATANA_P1  },
                { 200, xi.items.DURANDAL       },
                {  50, xi.items.SANGUINE_SWORD },
            },
        },

        [xi.assault.mission.WAMOURA_FARM_RAID] =
        {
            items =
            {
                { 450, xi.items.GUST_CLAYMORE },
                { 300, xi.items.UCHIGATANA_P1 },
                { 200, xi.items.HOTARUMARU    },
                {  50, xi.items.KUMOKIRIMARU  },
            },
        },

        [xi.assault.mission.SEAGULL_GROUNDED] =
        {
            items =
            {
                { 650, xi.items.GUST_CLAYMORE  },
                { 300, xi.items.UCHIGATANA_P1  },
                {  50, xi.items.KOSETSUSAMONJI },
            },
        },

        [xi.assault.mission.STOP_THE_BLOODSHED] =
        {
            items =
            {
                { 650, xi.items.GUST_CLAYMORE    },
                { 300, xi.items.UCHIGATANA_P1    },
                {  50, xi.items.IMMORTALS_SHOTEL },
            },
        },

        [xi.appraisal.origin.NYZUL_FROSTMANE] =
        {
            items =
            {
                { 600, xi.items.CLAYMORE      },
                { 350, xi.items.GUST_CLAYMORE },
                {  50, xi.items.LOCKHEART     },
            },
        },

        [xi.appraisal.origin.NYZUL_CARNERO] =
        {
            items =
            {
                { 750, xi.items.BRONZE_SWORD       },
                { 250, xi.items.KATAYAMA_ICHIMONJI },
            },
        },

        [xi.appraisal.origin.NYZUL_EMERGENT_ELM] =
        {
            items =
            {
                { 600, xi.items.BRONZE_SWORD   },
                { 350, xi.items.XIPHOS         },
                {  50, xi.items.GLOOM_CLAYMORE },
            },
        },

        [xi.appraisal.origin.NYZUL_ZIZZY_ZILLAH] =
        {
            items =
            {
                { 600, xi.items.BRONZE_SWORD  },
                { 350, xi.items.UCHIGATANA_P1 },
                {  50, xi.items.NAMIKIRIMARU  },
            },
        },

        [xi.appraisal.origin.NYZUL_KEEPER_OF_HALIDOM] =
        {
            items =
            {
                { 650, xi.items.BRONZE_SWORD  },
                { 320, xi.items.UCHIGATANA_P1 },
                {  30, xi.items.DAIHANNYA     },
            },
        },

        [xi.appraisal.origin.NYZUL_AMIKIRI] =
        {
            items =
            {
                { 750, xi.items.BRONZE_SWORD },
                { 250, xi.items.KAMEWARI     },
            },
        },

        [xi.appraisal.origin.NYZUL_CARGO_CRAB_COLIN] =
        {
            items =
            {
                { 850, xi.items.BRONZE_SWORD },
                { 150, xi.items.NADRS        },
            },
        },
    },

    [xi.items.UNAPPRAISED_DAGGER] =
    {
        [xi.assault.mission.COUNTING_SHEEP] =
        {
            items =
            {
                { 300, xi.items.KYOFU              },
                { 250, xi.items.HUSHED_DAGGER      },
                { 200, xi.items.SPARK_DAGGER       },
                { 100, xi.items.KATARS             },
                {  50, xi.items.PONDEROUS_GULLY    },
                {  50, xi.items.PONDEROUS_MANOPLES },
                {  50, xi.items.PAHLUWAN_KATARS    },
            },
        },

        [xi.assault.mission.SUPPLIES_RECOVERY] =
        {
            items =
            {
                { 400, xi.items.KYOFU            },
                { 250, xi.items.HUSHED_DAGGER    },
                { 250, xi.items.SPARK_DAGGER     },
                {  50, xi.items.ARGENT_DAGGER    },
                {  50, xi.items.PALLADIUM_DAGGER },
            },
        },

        [xi.assault.mission.EVADE_AND_ESCAPE] =
        {
            items =
            {
                { 350, xi.items.KYOFU              },
                { 270, xi.items.HUSHED_DAGGER      },
                { 270, xi.items.SPARK_DAGGER       },
                {  50, xi.items.KARASUAGEHA        },
                {  30, xi.items.KATARS             },
                {  10, xi.items.TOJAKU             },
                {  10, xi.items.PONDEROUS_GULLY    },
                {  10, xi.items.PONDEROUS_MANOPLES },
            },
        },

        -- Low sample rate. Droprates derived from logical similarities
        [xi.assault.mission.SEARAT_SALVATION] =
        {
            items =
            {
                { 350, xi.items.KYOFU              },
                { 270, xi.items.SPARK_DAGGER       },
                { 150, xi.items.HUSHED_DAGGER      },
                {  80, xi.items.KATARS             },
                {  50, xi.items.PONDEROUS_GULLY    },
                {  40, xi.items.PONDEROUS_MANOPLES },
                {  30, xi.items.TOJAKU             },
                {  30, xi.items.ASSASSINS_JAMBIYA  },
            },
        },

        [xi.appraisal.origin.NYZUL_TOM_TIT_TAT] =
        {
            items =
            {
                { 700, xi.items.BRONZE_KNIFE  },
                { 250, xi.items.KUNAI         },
                {  50, xi.items.FRUIT_PUNCHES },
            },
        },

        [xi.appraisal.origin.NYZUL_ORCTRAP] =
        {
            items =
            {
                { 950, xi.items.BRONZE_KNIFE },
                {  50, xi.items.NIKKARIAOE   },
            },
        },

        [xi.appraisal.origin.NYZUL_STINGING_SOPHIE] =
        {
            items =
            {
                { 950, xi.items.BRONZE_KNIFE },
                {  50, xi.items.BEESTINGER   },
            },
        },

        [xi.appraisal.origin.NYZUL_WESTERN_SHADOW] =
        {
            items =
            {
                { 950, xi.items.KUNAI       },
                {  50, xi.items.RETALIATORS },
            },
        },

        [xi.appraisal.origin.NYZUL_MISCHIEVOUS_MICHOLAS] =
        {
            items =
            {
                { 950, xi.items.BRONZE_KNIFE  },
                {  50, xi.items.KIDNEY_DAGGER },
            },
        },

        [xi.appraisal.origin.NYZUL_NIGHTMARE_VASE] =
        {
            items =
            {
                { 900, xi.items.KUNAI   },
                { 100, xi.items.SHINOGI },
            },
        },

        [xi.appraisal.origin.NYZUL_DAGGERCLAW_DRACOS] =
        {
            items =
            {
                { 900, xi.items.BRONZE_KNUCKLES },
                { 100, xi.items.SONIC_KNUCKLES  },
            },
        },

        [xi.appraisal.origin.NYZUL_SABOTENDER_MARIACHI] =
        {
            items =
            {
                { 900, xi.items.BRONZE_KNIFE },
                { 100, xi.items.BANO_DEL_SOL },
            },
        },
    },

    [xi.items.UNAPPRAISED_POLEARM] =
    {
        [xi.assault.mission.BREAKING_MORALE] =
        {
            items =
            {
                { 1000, xi.items.SPARK_SPEAR },
            },
        },

        [xi.assault.mission.THE_DOUBLE_AGENT] =
        {
            items =
            {
                { 1000, xi.items.SPARK_SPEAR },
            },
        },

        [xi.assault.mission.TROLL_FUGITIVES] =
        {
            items =
            {
                { 1000, xi.items.SICKLE }
            },
        },

        [xi.assault.mission.SIEGEMASTER_ASSASSINATION] =
        {
            items =
            {
                { 200, xi.items.IMPERIAL_WAND    },
                { 200, xi.items.BRASS_ZAGHNAL    },
                { 150, xi.items.HOLLY_STAFF_P1   },
                { 350, xi.items.SPARK_SPEAR      },
                { 100, xi.items.STEELSPLITTER   },
                { 100, xi.items.WILLOW_WAND_P1   },
                { 100, xi.items.PEALING_BUZDYGAN },
            },
        },

        [xi.assault.mission.SEAGULL_GROUNDED] =
        {
            items =
            {
                { 1000, xi.items.SPARK_SPEAR },
            },
        },

        [xi.assault.mission.REQUIEM] =
        {
            items =
            {
                { 200, xi.items.HOLLY_STAFF_P1 },
                { 400, xi.items.BRASS_ZAGHNAL  },
                { 200, xi.items.WILLOW_WAND_P1 },
                {  50, xi.items.PUK_LANCE      },
                { 150, xi.items.SPARK_SPEAR    },
            },
        },

        [xi.assault.mission.SAVING_PRIVATE_RYAAF] =
        {
            items =
            {
                { 250, xi.items.HOLLY_STAFF_P1 },
                { 250, xi.items.BRASS_ZAGHNAL  },
                { 200, xi.items.SPARK_SPEAR    },
                { 150, xi.items.HOLLY_POLE_P1  },
                { 100, xi.items.WILLOW_WAND_P1 },
                {  50, xi.items.YIGIT_STAFF    },
            },
        },

        [xi.assault.mission.STOP_THE_BLOODSHED] =
        {
            items =
            {
                { 750, xi.items.SPARK_SPEAR },
                { 250, xi.items.SPARK_LANCE },
            },
        },

        [xi.assault.mission.EXTERMINATION] =
        {
            items =
            {
                { 200, xi.items.SPARK_SPEAR       },
                { 200, xi.items.WILLOW_WAND_P1    },
                { 150, xi.items.HOLLY_STAFF_P1    },
                { 350, xi.items.BRASS_ZAGHNAL     },
                { 100, xi.items.VOLUNTEERS_SCYTHE },
            },
        },

        [xi.appraisal.origin.NYZUL_JUGGLER_HECATOMB] =
        {
            items =
            {
                { 900, xi.items.ASH_CLUB      },
                { 100, xi.items.HEAVY_HALBERD },
            },
        },

        [xi.appraisal.origin.NYZUL_HELLION] =
        {
            items =
            {
                { 700, xi.items.MAPLE_WAND  },
                { 300, xi.items.A_LOUTRANCE },
            },
        },

        [xi.appraisal.origin.NYZUL_FALCATUS_ARANEI] =
        {
            items =
            {
                { 700, xi.items.MAPLE_WAND     },
                { 200, xi.items.BRONZE_ZAGHNAL },
                { 100, xi.items.WEBCUTTER      },
            },
        },

        [xi.appraisal.origin.NYZUL_NUNYENUNC] =
        {
            items =
            {
                { 900, xi.items.ASH_CLUB      },
                { 100, xi.items.PILGRIMS_WAND },
            },
        },

        [xi.appraisal.origin.NYZUL_ROC] =
        {
            items =
            {
                { 900, xi.items.MAPLE_WAND  },
                { 100, xi.items.DRYAD_STAFF },
            },
        },

        [xi.appraisal.origin.NYZUL_SWAMFISK] =
        {
            items =
            {
                { 900, xi.items.MAPLE_WAND   },
                { 100, xi.items.GELONG_STAFF },
            },
        },

        [xi.appraisal.origin.NYZUL_VOUIVRE] =
        {
            items =
            {
                { 900, xi.items.ASH_CLUB },
                { 100, xi.items.GAE_BOLG },
            },
        },
    },

    [xi.items.UNAPPRAISED_AXE] =
    {
        [xi.assault.mission.REQUIEM] =
        {
            items =
            {
                { 1000, xi.items.PICKAXE },
            },
        },

        [xi.assault.mission.SAVING_PRIVATE_RYAAF] =
        {
            items =
            {
                { 1000, xi.items.PICKAXE },
            },
        },

        [xi.assault.mission.BUILDING_BRIDGES] =
        {
            items =
            {
                { 400, xi.items.HATCHET          },
                { 300, xi.items.PROMINENCE_AXE   },
                { 100, xi.items.TOMAHAWK_P1      },
                { 100, xi.items.FURNACE_TABARZIN },
                {  50, xi.items.BLIZZARD_TOPOROK },
                {  50, xi.items.MARID_ANCUS      },
            },
        },

        [xi.assault.mission.EXTERMINATION] =
        {
            items =
            {
                { 1000, xi.items.PICKAXE },
            },
        },

        [xi.assault.mission.TROLL_FUGITIVES] =
        {
            items =
            {
                { 600, xi.items.HATCHET        },
                { 100, xi.items.TOMAHAWK_P1    },
                { 150, xi.items.WAMOURA_AXE    },
                { 150, xi.items.PROMINENCE_AXE },
            },
        },

        [xi.assault.mission.SIEGEMASTER_ASSASSINATION] =
        {
            items =
            {
                { 1000, xi.items.PICKAXE },
            },
        },

        -- Terribly low drop rate sample
        [xi.assault.mission.APKALLU_SEIZURE] =
        {
            items =
            {
                { 400, xi.items.HATCHET        },
                { 300, xi.items.PICKAXE        },
                { 100, xi.items.TOMAHAWK_P1    },
                { 100, xi.items.PROMINENCE_AXE },
                {  50, xi.items.ERIKS_AXE      },
                -- {  50, xi.items.RAMPAGER       }, -- Not verified
            },
        },

        [xi.appraisal.origin.NYZUL_BAT_EYE] =
        {
            items =
            {
                { 950, xi.items.BONE_AXE  },
                {  50, xi.items.STORM_AXE },
            },
        },

        [xi.appraisal.origin.NYZUL_NORTHERN_SHADOW] =
        {
            items =
            {
                { 900, xi.items.BUTTERFLY_AXE },
                { 100, xi.items.EXECUTIONER   },
            },
        },

        [xi.appraisal.origin.NYZUL_AQUARIUS] =
        {
            items =
            {
                { 900, xi.items.BONE_AXE  },
                { 100, xi.items.FRANSISCA },
            },
        },

        [xi.appraisal.origin.NYZUL_TRICKSTER_KINETIX] =
        {
            items =
            {
                { 900, xi.items.BONE_AXE },
                { 100, xi.items.TABAR    },
            },
        },

        [xi.appraisal.origin.NYZUL_TYRANNIC_TUNNOK] =
        {
            items =
            {
                { 900, xi.items.BONE_AXE },
                { 100, xi.items.LOHAR    },
            },
        },

        [xi.appraisal.origin.NYZUL_PANZER_PERCIVAL] =
        {
            items =
            {
                { 900, xi.items.BUTTERFLY_AXE },
                { 100, xi.items.NECKCHOPPER   },
            },
        },

        [xi.appraisal.origin.NYZUL_PEG_POWLER] =
        {
            items =
            {
                { 900, xi.items.BUTTERFLY_AXE },
                { 100, xi.items.SCHWARZ_AXT   },
            },
        },
    },

    [xi.items.UNAPPRAISED_BOW] =
    {
        [xi.assault.mission.LAMIA_NO_13] =
        {
            items =
            {
                { 430, xi.items.LONGBOW_P1   },
                { 430, xi.items.CROSSBOW_P1  },
                { 140, xi.items.IMPERIAL_BOW },
            },
        },

        [xi.assault.mission.SHOOTING_DOWN_THE_BARON] =
        {
            items =
            {
                { 330, xi.items.CROSSBOW_P1    },
                { 550, xi.items.LONGBOW_P1     },
                { 100, xi.items.CULVERIN       },
                {  10, xi.items.CULVERIN_P1    },
                {  10, xi.items.STORM_ZAMBURAK },
            },
        },

        [xi.appraisal.origin.NYZUL_GYRE_CARLIN] =
        {
            items =
            {
                { 900, xi.items.SHORTBOW },
                { 100, xi.items.RIKONODO },
            },
        },

        [xi.appraisal.origin.NYZUL_EASTERN_SHADOW] =
        {
            items =
            {
                { 900, xi.items.LONGBOW   },
                { 100, xi.items.VALIS_BOW },
            },
        },

        [xi.appraisal.origin.NYZUL_HELLDIVER] =
        {
            items =
            {
                { 900, xi.items.SELF_BOW },
                { 100, xi.items.WINGEDGE },
            },
        },

        [xi.appraisal.origin.NYZUL_UNGUR] =
        {
            items =
            {
                { 900, xi.items.CROSSBOW        },
                { 100, xi.items.UNGUR_BOOMERANG },
            },
        },

        [xi.appraisal.origin.NYZUL_FRAELISSA] =
        {
            items =
            {
                { 900, xi.items.CROSSBOW      },
                { 100, xi.items.ALMOGAVAR_BOW },
            },
        },
    },

    [xi.items.UNAPPRAISED_GLOVES] =
    {
        [xi.assault.mission.ORICHALCUM_SURVEY] =
        {
            items =
            {
                { 1000, xi.items.STORM_GAGES },
            },
        },

        [xi.assault.mission.SEAGULL_GROUNDED] =
        {
            items =
            {
                { 280, xi.items.BRONZE_MITTENS_P1 },
                { 300, xi.items.LEATHER_GLOVES    },
                { 200, xi.items.COTTON_GLOVES     },
                { 180, xi.items.CUFFS             },
                {  50, xi.items.STORM_MANOPOLAS   },
            },
        },

        [xi.assault.mission.REQUIEM] =
        {
            items =
            {
                { 300, xi.items.LEATHER_GLOVES    },
                { 280, xi.items.BRONZE_MITTENS_P1 },
                { 200, xi.items.COTTON_GLOVES     },
                { 180, xi.items.CUFFS             },
                {  50, xi.items.STORM_GAGES       },
            },
        },

        [xi.appraisal.origin.NYZUL_PEALLAIDH] =
        {
            items =
            {
                { 900, xi.items.LEATHER_GLOVES   },
                { 100, xi.items.NIGHTMARE_GLOVES },
            },
        },

        [xi.appraisal.origin.NYZUL_ENERGETIC_ERUCA] =
        {
            items =
            {
                { 900, xi.items.COTTON_GLOVES },
                { 100, xi.items.HANZO_TEKKO   },
            },
        },
    },

    [xi.items.UNAPPRAISED_FOOTWEAR] =
    {
        [xi.assault.mission.LAMIA_NO_13] =
        {
            items =
            {
                { 200, xi.items.ASH_CLOGS          },
                { 380, xi.items.BRONZE_LEGGINGS_P1 },
                { 180, xi.items.LEATHER_HIGHBOOTS  },
                {  60, xi.items.SOLEA              },
                { 180, xi.items.STORM_GAMBIERAS    },
            },
        },

        [xi.assault.mission.EXTERMINATION] =
        {
            items =
            {
                {  50, xi.items.STORM_CRACKOWS     },
                { 350, xi.items.ASH_CLOGS          },
                { 250, xi.items.BRONZE_LEGGINGS_P1 },
                { 350, xi.items.LEATHER_HIGHBOOTS  },
            },
        },

        [xi.appraisal.origin.NYZUL_LEAPING_LIZZY] =
        {
            items =
            {
                { 950, xi.items.LEATHER_HIGHBOOTS },
                {  50, xi.items.LEAPING_BOOTS     },
            },
        },

        [xi.appraisal.origin.NYZUL_CACTUAR_CANTAUTOR] =
        {
            items =
            {
                { 900, xi.items.LEATHER_HIGHBOOTS },
                { 100, xi.items.KUNG_FU_SHOES     },
            },
        },

        [xi.appraisal.origin.NYZUL_BONNACON] =
        {
            items =
            {
                { 900, xi.items.ASH_CLOGS       },
                { 100, xi.items.TREDECIM_SCYTHE }, -- Tredecim Scythe or Cure Clogs
            },
        },

        [xi.appraisal.origin.NYZUL_TOTTERING_TOBY] =
        {
            items =
            {
                { 900, xi.items.ASH_CLOGS         },
                { 100, xi.items.STUMBLING_SANDALS },
            },
        },

        [xi.appraisal.origin.NYZUL_SIMURGH] =
        {
            items =
            {
                { 900, xi.items.LEATHER_HIGHBOOTS },
                { 100, xi.items.TROTTER_BOOTS     },
            },
        },
    },

    [xi.items.UNAPPRAISED_HEADPIECE] =
    {
        [xi.assault.mission.SAGELORD_ELIMINATION] =
        {
            items =
            {
                { 150, xi.items.BRONZE_CAP_P1   },
                { 200, xi.items.CIRCLET         },
                { 300, xi.items.COTTON_HEADGEAR },
                { 300, xi.items.LEATHER_BANDANA },
                {  50, xi.items.STORM_ZUCCHETTO },
            },
        },

        [xi.assault.mission.TROLL_FUGITIVES] =
        {
            items =
            {
                {  50, xi.items.STORM_TURBAN    },
                { 200, xi.items.COTTON_HEADGEAR },
                { 150, xi.items.BRONZE_CAP_P1   },
                { 300, xi.items.LEATHER_BANDANA },
                { 300, xi.items.CIRCLET         },
            },
        },

        [xi.appraisal.origin.NYZUL_VALKURM_EMPEROR] =
        {
            items =
            {
                { 900, xi.items.COPPER_HAIRPIN  },
                { 100, xi.items.EMPRESS_HAIRPIN },
            },
        },

        [xi.appraisal.origin.NYZUL_ELLYLLON] =
        {
            items =
            {
                { 900, xi.items.LEATHER_BANDANA },
                { 100, xi.items.MUSHROOM_HELM   },
            },
        },

        [xi.appraisal.origin.NYZUL_TAISAIJIN] =
        {
            items =
            {
                { 900, xi.items.LEATHER_BANDANA },
                { 100, xi.items.SPELUNKERS_HAT  },
            },
        },

        [xi.appraisal.origin.NYZUL_DROOLING_DAISY] =
        {
            items =
            {
                { 900, xi.items.BONE_HAIRPIN   },
                { 100, xi.items.DODGE_HEADBAND },
            },
        },

        [xi.appraisal.origin.NYZUL_SHARP_EARED_ROPIPI] =
        {
            items =
            {
                { 900, xi.items.COPPER_HAIRPIN    },
                { 100, xi.items.ENTRANCING_RIBBON },
            },
        },

        [xi.appraisal.origin.NYZUL_TUMBLING_TRUFFLE] =
        {
            items =
            {
                { 900, xi.items.LEATHER_BANDANA },
                { 100, xi.items.FUNGUS_HAT      },
            },
        },
    },

    [xi.items.UNAPPRAISED_EARRING] =
    {
        [xi.assault.mission.EXCAVATION_DUTY] =
        {
            items =
            {
                { 250, xi.items.SHELL_EARRING   },
                { 210, xi.items.BONE_EARRING    },
                { 250, xi.items.BEETLE_EARRING  },
                { 200, xi.items.SILVER_EARRING  },
                {  60, xi.items.RERAISE_EARRING },
                {  30, xi.items.STORM_LOOP      },
            },
        },

        [xi.assault.mission.APKALLU_BREEDING] =
        {
            items =
            {
                { 220, xi.items.MAGNIFYING_EARRING },
                { 200, xi.items.BONE_EARRING       },
                { 210, xi.items.BEETLE_EARRING     },
                { 270, xi.items.ELUSIVE_EARRING    },
                {  60, xi.items.SILVER_EARRING     },
                {  40, xi.items.SHELL_EARRING      },
            },
        },

        [xi.assault.mission.GOLDEN_SALVAGE] =
        {
            items =
            {
                { 220, xi.items.SHELL_EARRING  },
                { 200, xi.items.BONE_EARRING   },
                { 210, xi.items.BEETLE_EARRING },
                { 270, xi.items.SILVER_EARRING },
                {  60, xi.items.HEIMS_EARRING  },
                {  40, xi.items.STORM_EARRING  },
            },
        },

        [xi.appraisal.origin.NYZUL_LEECH_KING] =
        {
            items =
            {
                { 900, xi.items.SHELL_EARRING     },
                { 100, xi.items.BLOODBEAD_EARRING },
            },
        },

        [xi.appraisal.origin.NYZUL_CAPRICIOUS_CASSIE] =
        {
            items =
            {
                { 900, xi.items.BONE_EARRING   },
                { 100, xi.items.CASSIE_EARRING },
            },
        },

        [xi.appraisal.origin.NYZUL_MAIGHDEAN_UAINE] =
        {
            items =
            {
                { 900, xi.items.BEETLE_EARRING  },
                { 100, xi.items.OPTICAL_EARRING },
            },
        },
    },

    [xi.items.UNAPPRAISED_RING] =
    {
        [xi.assault.mission.LEUJAOAM_CLEANSING] =
        {
            items =
            {
                { 500, xi.items.COPPER_RING   },
                { 300, xi.items.BRASS_RING    },
                { 150, xi.items.ARCHERS_RING  },
                {  50, xi.items.IMPERIAL_RING },
            },
        },

        [xi.assault.mission.IMPERIAL_TREASURE_RETRIEVAL] =
        {
            items =
            {
                { 500, xi.items.COPPER_RING  },
                { 300, xi.items.BRASS_RING   },
                {  50, xi.items.HORIZON_RING },
            },
        },

        [xi.assault.mission.IMPERIAL_AGENT_RESCUE] =
        {
            items =
            {
                { 500, xi.items.COPPER_RING },
                { 300, xi.items.BRASS_RING  },
                { 150, xi.items.ETHER_RING  },
                {  50, xi.items.STORM_RING  },
            },
        },

        [xi.appraisal.origin.NYZUL_BOMB_KING] =
        {
            items =
            {
                { 600, xi.items.COPPER_RING },
                { 300, xi.items.BRASS_RING  },
                { 100, xi.items.BOMB_RING   },
            },
        },

        [xi.appraisal.origin.NYZUL_SMOTHERING_SCHMIDT] =
        {
            items =
            {
                { 600, xi.items.COPPER_RING   },
                { 300, xi.items.BRASS_RING    },
                { 100, xi.items.MALFLOOD_RING },
            },
        },

        [xi.appraisal.origin.NYZUL_ASPHYXIATED_AMSEL] =
        {
            items =
            {
                { 900, xi.items.BRASS_RING   },
                { 100, xi.items.MALGUST_RING },
            },
        },

        [xi.appraisal.origin.NYZUL_CRUSHED_KRAUSE] =
        {
            items =
            {
                { 900, xi.items.COPPER_RING  },
                { 100, xi.items.MALDUST_RING },
            },
        },

        [xi.appraisal.origin.NYZUL_PULVERIZED_PFEFFER] =
        {
            items =
            {
                { 900, xi.items.COPPER_RING   },
                { 100, xi.items.MALFROST_RING },
            },
        },

        [xi.appraisal.origin.NYZUL_SERKET] =
        {
            items =
            {
                { 900, xi.items.BRASS_RING  },
                { 100, xi.items.SERKET_RING },
            },
        },

        [xi.appraisal.origin.NYZUL_BURNED_BERGMANN] =
        {
            items =
            {
                { 900, xi.items.COPPER_RING   },
                { 100, xi.items.MALFLAME_RING },
            },
        },

        [xi.appraisal.origin.NYZUL_BLOODSUCKER] =
        {
            items =
            {
                { 900, xi.items.COPPER_RING    },
                { 100, xi.items.BLOODBEAD_RING },
            },
        },

        [xi.appraisal.origin.NYZUL_SEWER_SYRUP] =
        {
            items =
            {
                { 900, xi.items.BRASS_RING },
                { 100, xi.items.JELLY_RING },
            },
        },

        [xi.appraisal.origin.NYZUL_WOUNDED_WURFEL] =
        {
            items =
            {
                { 900, xi.items.COPPER_RING   },
                { 100, xi.items.MALFLASH_RING },
            },
        },
    },

    [xi.items.UNAPPRAISED_CAPE] =
    {
        [xi.assault.mission.ESCORT_PROFESSOR_CHANOIX] =
        {
            items =
            {
                { 350, xi.items.COTTON_CAPE_P1    },
                { 300, xi.items.DHALMEL_MANTLE_P1 },
                { 250, xi.items.LIZARD_MANTLE_P1  },
                {  50, xi.items.RED_CAPE_P1       },
                {  50, xi.items.STORM_MANTLE      },
            },
        },

        [xi.assault.mission.IMPERIAL_TREASURE_RETRIEVAL] =
        {
            items =
            {
                { 250, xi.items.LIZARD_MANTLE_P1  },
                { 300, xi.items.DHALMEL_MANTLE_P1 },
                { 250, xi.items.COTTON_CAPE_P1    },
                { 150, xi.items.SNIPERS_MANTLE    },
                {  50, xi.items.VOLITIONAL_MANTLE },
            },
        },

        [xi.assault.mission.LEBROS_SUPPLIES] =
        {
            items =
            {
                { 300, xi.items.DHALMEL_MANTLE_P1 },
                { 250, xi.items.COTTON_CAPE_P1    },
                { 250, xi.items.LIZARD_MANTLE_P1  },
                {  50, xi.items.STORM_CAPE        },
                { 150, xi.items.ENHANCING_MANTLE  },
            },
        },

        [xi.assault.mission.STOP_THE_BLOODSHED] =
        {
            items =
            {
                { 350, xi.items.COTTON_CAPE_P1    },
                { 150, xi.items.LIZARD_MANTLE_P1  },
                { 400, xi.items.DHALMEL_MANTLE_P1 },
                {  50, xi.items.AILERON_MANTLE    },
                {  50, xi.items.TEMPLARS_MANTLE   },
            },
        },

        [xi.appraisal.origin.NYZUL_OLD_TWO_WINGS] =
        {
            items =
            {
                { 900, xi.items.LIZARD_MANTLE_P1 },
                { 100, xi.items.BAT_CAPE         },
            },
        },

        [xi.appraisal.origin.NYZUL_FRAELISSA] =
        {
            items =
            {
                { 900, xi.items.COTTON_CAPE_P1   },
                { 100, xi.items.BELLICOSE_MANTLE },
            },
        },

        [xi.appraisal.origin.NYZUL_SPINY_SPIPI] =
        {
            items =
            {
                { 900, xi.items.RABBIT_MANTLE  },
                { 100, xi.items.MIST_SILK_CAPE },
            },
        },

        [xi.appraisal.origin.NYZUL_GOLDEN_BAT] =
        {
            items =
            {
                { 900, xi.items.COTTON_CAPE_P1 },
                { 100, xi.items.NIGHT_CAPE     },
            },
        },
    },

    [xi.items.UNAPPRAISED_SASH] =
    {
        [xi.assault.mission.SHANARHA_GRASS_CONSERVATION] =
        {
            items =
            {
                { 250, xi.items.TALISMAN_OBI         },
                { 250, xi.items.LUGWORM_BELT         },
                { 150, xi.items.SILVER_OBI_P1        },
                { 150, xi.items.LITTLE_WORM_BELT     },
                { 100, xi.items.DEDUCTIVE_GOLD_OBI   },
                {  50, xi.items.ENTHRALLING_GOLD_OBI },
                {  50, xi.items.STORM_BELT           },
            },
        },

        [xi.assault.mission.APKALLU_BREEDING] =
        {
            items =
            {
                { 600, xi.items.TALISMAN_OBI  },
                { 150, xi.items.LUGWORM_BELT  },
                { 100, xi.items.SILVER_OBI_P1 },
                {  50, xi.items.GRACE_CORSET  },
                {  50, xi.items.GLEEMANS_BELT },
            },
        },

        [xi.assault.mission.DEMOLITION_DUTY] =
        {
            items =
            {
                { 200, xi.items.TALISMAN_OBI   },
                { 200, xi.items.LUGWORM_BELT   },
                { 300, xi.items.SILVER_OBI_P1  },
                { 100, xi.items.CZARS_BELT     },
                { 100, xi.items.MAHARAJAS_BELT },
                {  50, xi.items.SULTANS_BELT   },
                {  50, xi.items.STORM_SASH     },
            },
        },
    },

    [xi.items.UNAPPRAISED_SHIELD] =
    {
        [xi.assault.mission.SAVING_PRIVATE_RYAAF] =
        {
            items =
            {
                { 250, xi.items.MAPLE_SHIELD    },
                { 200, xi.items.ELM_SHIELD      },
                { 200, xi.items.OAK_SHIELD      },
                { 150, xi.items.LAUAN_SHIELD    },
                { 150, xi.items.MAHOGANY_SHIELD },
                {  50, xi.items.STORM_SHIELD    },
            },
        },

        [xi.appraisal.origin.NYZUL_BLOODTEAR_BALDURF] =
        {
            items =
            {
                { 900, xi.items.OAK_SHIELD    },
                { 100, xi.items.VIKING_SHIELD },
            },
        },

        [xi.appraisal.origin.NYZUL_FUNGUS_BEETLE] =
        {
            items =
            {
                { 900, xi.items.LAUAN_SHIELD },
                { 100, xi.items.CLIPEUS      },
            },
        },

        [xi.appraisal.origin.NYZUL_STEELFLEECE_BALDARICH] =
        {
            items =
            {
                { 900, xi.items.OAK_SHIELD    },
                { 100, xi.items.VIKING_SHIELD },
            },
        },

        [xi.appraisal.origin.NYZUL_SOUTHERN_SHADOW] =
        {
            items =
            {
                { 900, xi.items.ELM_SHIELD    },
                { 100, xi.items.MASTER_SHIELD },
            },
        },

        [xi.appraisal.origin.NYZUL_PELICAN] =
        {
            items =
            {
                { 900, xi.items.ASPIS        },
                { 100, xi.items.ASTRAL_ASPIS },
            },
        },
    },

    [xi.items.UNAPPRAISED_NECKLACE] =
    {
        [xi.assault.mission.ORICHALCUM_SURVEY] =
        {
            items =
            {
                { 550, xi.items.FEATHER_COLLAR },
                { 300, xi.items.GORGET_P1      },
                { 100, xi.items.JAGD_GORGET    },
                {  50, xi.items.STORM_MUFFLER  },
            },
        },

        [xi.assault.mission.PREEMPTIVE_STRIKE] =
        {
            items =
            {
                { 550, xi.items.FEATHER_COLLAR },
                { 300, xi.items.GORGET_P1      },
                { 100, xi.items.SPECTACLES     },
                {  50, xi.items.STORM_TORQUE   },
            },
        },

        [xi.appraisal.origin.NYZUL_SHADOW_EYE] =
        {
            items =
            {
                { 950, xi.items.REGEN_COLLAR },
                {  50, xi.items.MOON_AMULET  },
            },
        },

        [xi.appraisal.origin.NYZUL_JAGGEDY_EARED_JACK] =
        {
            items =
            {
                { 900, xi.items.LEATHER_GORGET },
                { 100, xi.items.RABBIT_CHARM   },
            },
        },

        [xi.appraisal.origin.NYZUL_GARGANTUA] =
        {
            items =
            {
                { 900, xi.items.FEATHER_COLLAR  },
                { 100, xi.items.ELEMENTAL_CHARM },
            },
        },

        [xi.appraisal.origin.NYZUL_SERPOPARD_ISHTAR] =
        {
            items =
            {
                { 900, xi.items.FEATHER_COLLAR   },
                { 100, xi.items.CERULEAN_PENDANT },
            },
        },

        [xi.appraisal.origin.NYZUL_ARGUS] =
        {
            items =
            {
                { 900, xi.items.REGEN_COLLAR  },
                { 100, xi.items.PEACOCK_CHARM },
            },
        },

        [xi.appraisal.origin.NYZUL_BLOODPOOL_VORAX] =
        {
            items =
            {
                { 900, xi.items.GORGET_P1        },
                { 100, xi.items.BLOODBEAD_AMULET },
            },
        },

        [xi.appraisal.origin.NYZUL_BUBURIMBOO] =
        {
            items =
            {
                { 900, xi.items.GORGET_P1       },
                { 100, xi.items.BUBURIMU_GORGET },
            },
        },

        [xi.appraisal.origin.NYZUL_DUNE_WIDOW] =
        {
            items =
            {
                { 900, xi.items.REGEN_COLLAR  },
                { 100, xi.items.SPIDER_TORQUE },
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
                { 100, xi.items.WHITE_ROCK        },
                { 200, xi.items.TSURARA           },
                {  20, xi.items.PHALAENOPSIS      },
                {  50, xi.items.GARDENIA_SEED     },
                {  80, xi.items.GLASS_SHEET       },
                { 200, xi.items.MERROW_SCALE      },
                { 150, xi.items.SOULFLAYER_STAFF  },
                { 100, xi.items.ICE_CRYSTAL       },
                {  10, xi.items.TOOLBAG_JUSATSU   },
                {  30, xi.items.IRON_BULLET_POUCH },
                {  60, xi.items.LAKERDA           },
            },
        },

        [xi.assault.mission.ORICHALCUM_SURVEY] =
        {
            items =
            {
                { 100, xi.items.EGGPLANT              },
                {  90, xi.items.GARDENIA_SEED         },
                { 100, xi.items.ICE_CRYSTAL           },
                {  70, xi.items.KABURA_QUIVER         },
                { 130, xi.items.SQUARE_OF_LINEN_CLOTH },
                {  80, xi.items.MERROW_SCALE          },
                {  50, xi.items.PHALAENOPSIS          },
                { 100, xi.items.POROGGO_HAT           },
                {  60, xi.items.SOULFLAYER_STAFF      },
                { 150, xi.items.TSURARA               },
                {  70, xi.items.WHITE_ROCK            },
            },
        },

        [xi.assault.mission.ESCORT_PROFESSOR_CHANOIX] =
        {
            items =
            {
                { 100, xi.items.EGGPLANT              },
                {  90, xi.items.GARDENIA_SEED         },
                { 100, xi.items.ICE_CRYSTAL           },
                {  70, xi.items.KABURA_QUIVER         },
                { 130, xi.items.SQUARE_OF_LINEN_CLOTH },
                {  80, xi.items.TITANICTUS_SHELL      },
                {  50, xi.items.PHALAENOPSIS          },
                { 100, xi.items.POROGGO_HAT           },
                {  60, xi.items.SOULFLAYER_STAFF      },
                { 150, xi.items.TSURARA               },
                {  70, xi.items.WHITE_ROCK            },
            },
        },

        [xi.assault.mission.SHANARHA_GRASS_CONSERVATION] =
        {
            items =
            {
                {  50, xi.items.EGGPLANT            },
                {  90, xi.items.GARDENIA_SEED       },
                {  50, xi.items.ICE_CRYSTAL         },
                {  70, xi.items.SILVER_BULLET_POUCH },
                {  80, xi.items.MERROW_SCALE        },
                {  50, xi.items.PHALAENOPSIS        },
                {  50, xi.items.POROGGO_HAT         },
                {  60, xi.items.SOULFLAYER_STAFF    },
                {  50, xi.items.TSURARA             },
                {  70, xi.items.WHITE_ROCK          },
                {  50, xi.items.LAMP_MARIMO         },
                { 150, xi.items.TOOLBAG_HIRAISHIN   },
                { 150, xi.items.TOOLBAG_UCHITAKE    },
            },
        },

        [xi.assault.mission.COUNTING_SHEEP] =
        {
            items =
            {
                {  50, xi.items.EGGPLANT             },
                {  50, xi.items.GARDENIA_SEED        },
                {  50, xi.items.ICE_CRYSTAL          },
                { 150, xi.items.SPARTAN_BULLET_POUCH },
                {  70, xi.items.MERROW_SCALE         },
                {  50, xi.items.PHALAENOPSIS         },
                {  50, xi.items.POROGGO_HAT          },
                {  60, xi.items.SOULFLAYER_STAFF     },
                {  50, xi.items.TSURARA              },
                {  70, xi.items.WHITE_ROCK           },
                {  50, xi.items.IRON_BULLET_POUCH    },
                { 150, xi.items.VENOM_BOLT_QUIVER    },
                { 150, xi.items.GLASS_SHEET          },
            },
        },

        -- Low sample rate. Borrowing similar Leujaoam Sanctum tables
        [xi.assault.mission.SUPPLIES_RECOVERY] =
        {
            items =
            {
                {  50, xi.items.EGGPLANT             },
                {  50, xi.items.GARDENIA_SEED        },
                {  50, xi.items.ICE_CRYSTAL          },
                { 150, xi.items.SPARTAN_BULLET_POUCH },
                {  70, xi.items.MERROW_SCALE         },
                {  50, xi.items.PHALAENOPSIS         },
                {  50, xi.items.POROGGO_HAT          },
                {  60, xi.items.SOULFLAYER_STAFF     },
                {  50, xi.items.TSURARA              },
                {  70, xi.items.WHITE_ROCK           },
                {  50, xi.items.IRON_BULLET_POUCH    },
                { 150, xi.items.VENOM_BOLT_QUIVER    },
                { 150, xi.items.GLASS_SHEET          },
            },
        },

        [xi.assault.mission.IMPERIAL_AGENT_RESCUE] =
        {
            items =
            {
                {  70, xi.items.DATE                         },
                {  50, xi.items.EGGPLANT                     },
                { 100, xi.items.CLUMP_OF_IMPERIAL_TEA_LEAVES },
                {  40, xi.items.CHUNK_OF_KAOLIN              },
                { 200, xi.items.MAMOOL_JA_COLLAR             },
                { 150, xi.items.POROGGO_HAT                  },
                {  60, xi.items.SPRIG_OF_SAGE                },
                {  50, xi.items.SQUARE_OF_SILK_CLOTH         },
                {  10, xi.items.TOOLBAG_KAWAHORI_OGI         },
                {  10, xi.items.TOOLBAG_SHIHEI               },
                {  10, xi.items.TOOLBAG_TSURARA              },
                { 100, xi.items.WILD_ONION                   },
                {  10, xi.items.TOOLBAG_UCHITAKE             },
                { 140, xi.items.ISTAKOZ                      },
            },
        },

        [xi.assault.mission.PREEMPTIVE_STRIKE] =
        {
            items =
            {
                { 170, xi.items.EGGPLANT                     },
                { 150, xi.items.SPRIG_OF_SAGE                },
                { 150, xi.items.CLUMP_OF_IMPERIAL_TEA_LEAVES },
                {  70, xi.items.WILD_ONION                   },
                { 100, xi.items.SPOOL_OF_RED_GRASS_THREAD    },
                {  70, xi.items.MAMOOL_JA_COLLAR             },
                {  40, xi.items.TOOLBAG_SAIRUI_RAN           },
                {  30, xi.items.TOOLBAG_SHIHEI               },
                {  40, xi.items.TOOLBAG_JUSATSU              },
                { 100, xi.items.CHUNK_OF_KAOLIN              },
                {  80, xi.items.POROGGO_HAT                  },
            },
        },

        [xi.assault.mission.BREAKING_MORALE] =
        {
            items =
            {
                { 100, xi.items.DATE                    },
                {  25, xi.items.EGGPLANT                },
                {  25, xi.items.IMPERIAL_TEA_LEAVES     },
                {  25, xi.items.CHUNK_OF_KAOLIN         },
                {  25, xi.items.LAMIAN_ARMLET           },
                { 100, xi.items.MAMOOL_JA_COLLAR        },
                { 100, xi.items.TROLL_PAULDRON          },
                { 100, xi.items.POROGGO_HAT             },
                {  25, xi.items.SPRIG_OF_SAGE           },
                {  25, xi.items.SOULFLAYER_STAFF        },
                { 100, xi.items.TOOLBAG_JUSATSU         },
                { 100, xi.items.TOOLBAG_KAGINAWA        },
                { 100, xi.items.TOOLBAG_MIZU_DEPPO      },
                { 100, xi.items.TOOLBAG_SHIHEI          },
                {  25, xi.items.SQUARE_OF_WAMOURA_CLOTH },
                {  25, xi.items.WILD_ONION              },
            },
        },

        [xi.assault.mission.THE_DOUBLE_AGENT] =
        {
            items =
            {
                { 250, xi.items.DATE                     },
                {  40, xi.items.CHUNK_OF_IMPERIAL_CERMET },
                {  40, xi.items.KAOLIN                   },
                {  40, xi.items.LAMIAN_ARMET             },
                { 280, xi.items.MAMOOL_JA_COLLAR         },
                { 230, xi.items.POROGGO_HAT              },
                {  40, xi.items.TOOLBAG_HIRAISHIN        },
                {  20, xi.items.TOOLBAG_MIZU_DEPPO       },
                {  20, xi.items.TOOLBAG_SHINOBI_TABI     },
                {  20, xi.items.TOOLBAG_SHIHEI           },
            },
        },

        [xi.assault.mission.EXCAVATION_DUTY] =
        {
            items =
            {
                { 150, xi.items.CHUNK_OF_COPPER_ORE    },
                { 100, xi.items.RED_ROCK               },
                {  50, xi.items.SQUARE_OF_VELVET_CLOTH },
                {  80, xi.items.PINCH_OF_BOMB_ASH      },
                {  80, xi.items.PINCH_OF_SULFUR        },
                {  50, xi.items.SPRIG_OF_HOLY_BASIL    },
                { 200, xi.items.TROLL_PAULDRON         },
                { 150, xi.items.CHUNK_OF_FLAN_MEAT     },
                {  10, xi.items.TROLL_BRONZE_INGOT     },
                {  20, xi.items.SILVER_BULLET_POUCH    },
                {  10, xi.items.SPARTAN_BULLET_POUCH   },
                {  20, xi.items.IRON_BULLET_POUCH      },
                {  40, xi.items.BRONZE_BULLET_POUCH    },
                {  30, xi.items.BULLET_POUCH           },
            },
        },

        [xi.assault.mission.LEBROS_SUPPLIES] =
        {
            items =
            {
                { 200, xi.items.PINCH_OF_SULFUR     },
                { 200, xi.items.CHUNK_OF_FLAN_MEAT  },
                {  50, xi.items.BULLET_POUCH        },
                { 200, xi.items.TROLL_PAULDRON      },
                { 100, xi.items.SPARTAN_BULLET      },
                { 250, xi.items.SPRIG_OF_HOLY_BASIL },
            },
        },

        [xi.assault.mission.TROLL_FUGITIVES] =
        {
            items =
            {
                { 100, xi.items.PINCH_OF_BOMB_ASH   },
                { 150, xi.items.CHUNK_OF_COPPER_ORE },
                {  80, xi.items.CHUNK_OF_FLAN_MEAT  },
                {  60, xi.items.SPRIG_OF_HOLY_BASIL },
                {  20, xi.items.IRON_BULLET_POUCH   },
                {  10, xi.items.SILVER_BULLET_POUCH },
                {  50, xi.items.PETRIFIED_LOG       },
                { 100, xi.items.RED_ROCK            },
                { 250, xi.items.PINCH_OF_SULFUR     },
                {  80, xi.items.TROLL_BRONZE_INGOT  },
                { 100, xi.items.TROLL_PAULDRON      },
            },
        },

        [xi.assault.mission.EVADE_AND_ESCAPE] =
        {
            items =
            {
                {  35, xi.items.CHUNK_OF_COPPER_ORE  },
                {  35, xi.items.PINCH_OF_SULFUR      },
                {  35, xi.items.RED_ROCK             },
                {  35, xi.items.PINCH_OF_BOMB_ASH    },
                {  35, xi.items.TROLL_BROWNZE_SHEET  },
                {  35, xi.items.TROLL_BRONZE_INGOT   },
                { 300, xi.items.TROLL_PAULDRON       },
                {  35, xi.items.SPRIG_OF_HOLY_BASIL  },
                {  35, xi.items.IRON_BULLET_POUCH    },
                {  35, xi.items.SILVER_BULLET_POUCH  },
                { 100, xi.items.BRONZE_BULLET_POUCH  },
                {  35, xi.items.BULLET_POUCH         },
                { 100, xi.items.SPARTAN_BULLET_POUCH },
                { 150, xi.items.FLAN_MEAT            },
            },
        },

        [xi.assault.mission.APKALLU_BREEDING] =
        {
            items =
            {
                {  35, xi.items.CHUNK_OF_COPPER_ORE  },
                {  35, xi.items.PINCH_OF_SULFUR      },
                {  35, xi.items.RED_ROCK             },
                {  35, xi.items.PINCH_OF_BOMB_ASH    },
                {  35, xi.items.TROLL_BROWNZE_SHEET  },
                {  35, xi.items.TROLL_BRONZE_INGOT   },
                { 300, xi.items.TROLL_PAULDRON       },
                {  35, xi.items.SPRIG_OF_HOLY_BASIL  },
                {  35, xi.items.IRON_BULLET_POUCH    },
                {  35, xi.items.SILVER_BULLET_POUCH  },
                { 100, xi.items.BRONZE_BULLET_POUCH  },
                {  35, xi.items.BULLET_POUCH         },
                { 100, xi.items.SPARTAN_BULLET_POUCH },
                { 150, xi.items.APKALLU_EGG          },
            },
        },

        [xi.assault.mission.REQUIEM] =
        {
            items =
            {
                {  40, xi.items.IGNEOUS_ROCK             },
                {  50, xi.items.ROTTEN_QUIVER            },
                {  50, xi.items.HOLY_BOLT_QUIVER         },
                { 200, xi.items.BONE_CHIP                },
                {  50, xi.items.CLEANING_TOOL_SET        },
                {  20, xi.items.HANDFUL_OF_DRAGON_SCALES },
                {  90, xi.items.QIQIRN_SANDBAG           },
                { 150, xi.items.IMP_WING                 },
                { 200, xi.items.BRONZE_BOLT              },
                { 150, xi.items.SPRIG_OF_APPLE_MINT      },
            },
        },

        [xi.assault.mission.SEAGULL_GROUNDED] =
        {
            items =
            {
                {  10, xi.items.CLEANING_TOOL_SET       },
                {  20, xi.items.SPOOL_OF_RAINBOW_THREAD },
                { 250, xi.items.BONE_CHIP               },
                {  50, xi.items.SPRIG_OF_APPLE_MINT     },
                {  30, xi.items.IGNEOUS_ROCK            },
                { 200, xi.items.QIQIRN_SANDBAG          },
                {  50, xi.items.IMP_WING                },
                { 100, xi.items.ROTTEN_QUIVER           },
                {  60, xi.items.BRONZE_BOLT_QUIVER      },
                { 100, xi.items.WILD_ONION              },
                {  50, xi.items.HOLY_BOLT_QUIVER        },
                {  30, xi.items.SLEEP_BOLT_QUIVER       },
            },
        },

        [xi.assault.mission.SAVING_PRIVATE_RYAAF] =
        {
            items =
            {
                {  30, xi.items.CHUNK_OF_GOLD_ORE     },
                { 340, xi.items.QIQIRN_SANDBAG        },
                { 200, xi.items.SPRIG_OF_APPLE_MINT   },
                {  30, xi.items.BLOODY_BOLT_QUIVER    },
                {  30, xi.items.HOLY_BOLT_QUIVER      },
                {  30, xi.items.MYTHRIL_BOLT_QUIVER   },
                {  30, xi.items.SLEEP_BOLT_QUIVER     },
                {  30, xi.items.DARKSTEEL_BOLT_QUIVER },
                { 250, xi.items.IMP_WING              },
                {  30, xi.items.QIQIRN_SANDBAG        },
            },
        },

        -- Low sample rate. Borrowing similar Periqia tables for now
        [xi.assault.mission.SHOOTING_DOWN_THE_BARON] =
        {
            items =
            {
                {  30, xi.items.CHUNK_OF_GOLD_ORE     },
                { 340, xi.items.QIQIRN_SANDBAG        },
                { 200, xi.items.SPRIG_OF_APPLE_MINT   },
                {  30, xi.items.BLOODY_BOLT_QUIVER    },
                {  30, xi.items.HOLY_BOLT_QUIVER      },
                {  30, xi.items.MYTHRIL_BOLT_QUIVER   },
                {  30, xi.items.SLEEP_BOLT_QUIVER     },
                {  30, xi.items.DARKSTEEL_BOLT_QUIVER },
                { 250, xi.items.IMP_WING              },
                {  30, xi.items.QIQIRN_SANDBAG        },
            },
        },

        -- Low sample rate. Borrowing similar Periqia tables for now
        [xi.assault.mission.BUILDING_BRIDGES] =
        {
            items =
            {
                {  30, xi.items.CHUNK_OF_GOLD_ORE     },
                { 340, xi.items.QIQIRN_SANDBAG        },
                { 200, xi.items.SPRIG_OF_APPLE_MINT   },
                {  30, xi.items.BLOODY_BOLT_QUIVER    },
                {  30, xi.items.HOLY_BOLT_QUIVER      },
                {  30, xi.items.MYTHRIL_BOLT_QUIVER   },
                {  30, xi.items.SLEEP_BOLT_QUIVER     },
                {  30, xi.items.DARKSTEEL_BOLT_QUIVER },
                { 250, xi.items.IMP_WING              },
                {  30, xi.items.QIQIRN_SANDBAG        },
            },
        },

        -- Low sample rate. Borrowing similar Periqia tables for now
        [xi.assault.mission.BUILDING_BRIDGES] =
        {
            items =
            {
                {  30, xi.items.CHUNK_OF_GOLD_ORE     },
                { 340, xi.items.QIQIRN_SANDBAG        },
                { 200, xi.items.SPRIG_OF_APPLE_MINT   },
                {  30, xi.items.BLOODY_BOLT_QUIVER    },
                {  30, xi.items.HOLY_BOLT_QUIVER      },
                {  30, xi.items.MYTHRIL_BOLT_QUIVER   },
                {  30, xi.items.SLEEP_BOLT_QUIVER     },
                {  30, xi.items.DARKSTEEL_BOLT_QUIVER },
                { 250, xi.items.IMP_WING              },
                {  30, xi.items.QIQIRN_SANDBAG        },
            },
        },

        [xi.assault.mission.GOLDEN_SALVAGE] =
        {
            items =
            {
                {  10, xi.items.RUSTY_BUCKET               },
                { 240, xi.items.QUTRUB_GORGET              },
                { 200, xi.items.LAMIAN_ARMLET              },
                {  60, xi.items.AHT_URHGAN_BRASS_INGOT     },
                {  20, xi.items.STONE_QUIVER               },
                {  60, xi.items.BONE_QUIVER                },
                {  20, xi.items.BEETLE_QUIVER              },
                {  10, xi.items.HORN_QUIVER                },
                {  50, xi.items.SCORPION_QUIVER            },
                {  50, xi.items.DEMON_QUIVER               },
                {  30, xi.items.IRON_QUIVER                },
                {  40, xi.items.SILVER_QUIVER              },
                {  10, xi.items.FLASK_OF_DISTILLED_WATER   },
                {  50, xi.items.SCROLL_OF_PUPPETS_OPERETTA },
                {  50, xi.items.KABURA_QUIVER              },
                {  10, xi.items.SLEEP_QUIVER               },
                { 140, xi.items.ISTAKOZ                    },
                {  10, xi.items.WILLOW_FISHING_ROD         },
                {  10, xi.items.LITTLE_WORM                },
            },
        },

        [xi.assault.mission.LAMIA_NO_13] =
        {
            items =
            {
                {  20, xi.items.SPRIG_OF_APPLE_MINT    },
                { 250, xi.items.QUTRUB_GORGET          },
                { 250, xi.items.LAMIAN_ARMLET          },
                {  20, xi.items.AHT_URHGAN_BRASS_INGOT },
                {  20, xi.items.STONE_QUIVER           },
                {  60, xi.items.BONE_QUIVER            },
                {  20, xi.items.BEETLE_QUIVER          },
                {  20, xi.items.DEMON_QUIVER           },
                {  40, xi.items.SILVER_QUIVER          },
                {  60, xi.items.LIGHT_SPIRIT_PACT      },
                {  20, xi.items.KABURA_QUIVER          },
                {  20, xi.items.SLEEP_QUIVER           },
                { 190, xi.items.ISTAKOZ                },
                {  10, xi.items.RUSTY_BUCKET           },
            },
        },

        [xi.assault.mission.EXTERMINATION] =
        {
            items =
            {
                { 150, xi.items.RUSTY_BUCKET             },
                { 250, xi.items.LITTLE_WORM              },
                { 250, xi.items.FLASK_OF_DISTILLED_WATER },
                { 100, xi.items.LAMIAN_ARMLET            },
                {  50, xi.items.KING_TRUFFLE             },
                {  50, xi.items.QUTRUB_GORGET            },
                {  20, xi.items.SILVER_QUIVER            },
                {  20, xi.items.SLEEP_QUIVER             },
                {  40, xi.items.STONE_QUIVER             },
                {  30, xi.items.BONE_QUIVER              },
                {  40, xi.items.BEETLE_QUIVER            },
            },
        },

        -- Borrowing similar Ilrusi Atoll tables due to low sample rate
        [xi.assault.mission.DEMOLITION_DUTY] =
        {
            items =
            {
                { 150, xi.items.RUSTY_BUCKET             },
                { 250, xi.items.LITTLE_WORM              },
                { 250, xi.items.FLASK_OF_DISTILLED_WATER },
                { 100, xi.items.LAMIAN_ARMLET            },
                {  50, xi.items.KING_TRUFFLE             },
                {  50, xi.items.QUTRUB_GORGET            },
                {  20, xi.items.SILVER_QUIVER            },
                {  20, xi.items.SLEEP_QUIVER             },
                {  40, xi.items.STONE_QUIVER             },
                {  30, xi.items.BONE_QUIVER              },
                {  40, xi.items.BEETLE_QUIVER            },
            },
        },

        -- Borrowing similar Ilrusi Atoll tables due to low sample rate
        [xi.assault.mission.SEARAT_SALVATION] =
        {
            items =
            {
                { 150, xi.items.RUSTY_BUCKET             },
                { 250, xi.items.LITTLE_WORM              },
                { 250, xi.items.FLASK_OF_DISTILLED_WATER },
                { 100, xi.items.LAMIAN_ARMLET            },
                {  50, xi.items.KING_TRUFFLE             },
                {  50, xi.items.QUTRUB_GORGET            },
                {  20, xi.items.SILVER_QUIVER            },
                {  20, xi.items.SLEEP_QUIVER             },
                {  40, xi.items.STONE_QUIVER             },
                {  30, xi.items.BONE_QUIVER              },
                {  40, xi.items.BEETLE_QUIVER            },
            },
        },

        -- Borrowing similar Ilrusi Atoll tables due to low sample rate
        [xi.assault.mission.APKALLU_SEIZURE] =
        {
            items =
            {
                { 150, xi.items.RUSTY_BUCKET             },
                { 250, xi.items.LITTLE_WORM              },
                { 250, xi.items.FLASK_OF_DISTILLED_WATER },
                { 100, xi.items.LAMIAN_ARMLET            },
                {  50, xi.items.KING_TRUFFLE             },
                {  50, xi.items.QUTRUB_GORGET            },
                {  20, xi.items.SILVER_QUIVER            },
                {  20, xi.items.SLEEP_QUIVER             },
                {  40, xi.items.STONE_QUIVER             },
                {  30, xi.items.BONE_QUIVER              },
                {  40, xi.items.BEETLE_QUIVER            },
            },
        },

        [xi.appraisal.origin.NYZUL_AIATAR] =
        {
            items =
            {
                { 800, xi.items.LEATHER_TROUSERS },
                { 100, xi.items.FALCONERS_HOSE   },
                { 100, xi.items.SABLE_CUISSES    },
            },
        },

        [xi.appraisal.origin.NYZUL_INTULO] =
        {
            items =
            {
                { 900, xi.items.SLACKS       },
                { 100, xi.items.MAGIC_SLACKS },
            },
        },

        [xi.appraisal.origin.NYZUL_FRIAR_RUSH] =
        {
            items =
            {
                { 900, xi.items.BOMB_ARM  },
                { 100, xi.items.BOMB_CORE },
            },
        },

        [xi.appraisal.origin.NYZUL_SABOTENDER_BAILARIN] =
        {
            items =
            {
                { 900, xi.items.DART       },
                { 100, xi.items.BAILATHORN },
            },
        },

        [xi.appraisal.origin.NYZUL_ODQAN] =
        {
            items =
            {
                { 900, xi.items.LEATHER_TROUSERS },
                { 100, xi.items.BRAVOS_SUBLIGAR  },
            },
        },

        [xi.appraisal.origin.NYZUL_STRAY_MARY] =
        {
            items =
            {
                { 900, xi.items.CORNETTE   },
                { 100, xi.items.MARYS_HORN },
            },
        },

        [xi.appraisal.origin.NYZUL_UNUT] =
        {
            items =
            {
                { 900, xi.items.LINEN_SLOPS   },
                { 100, xi.items.LUNA_SUBLIGAR },
            },
        },

        [xi.appraisal.origin.NYZUL_JADED_JODY] =
        {
            items =
            {
                { 900, xi.items.SLACKS        },
                { 100, xi.items.JET_SERAWEELS },
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
