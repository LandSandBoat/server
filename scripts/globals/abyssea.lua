-----------------------------------
-- Abyssea Global
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/utils')
require('scripts/globals/extravaganza')
-----------------------------------
xi = xi or {}
xi.abyssea = xi.abyssea or {}

xi.abyssea.exitPositions =
{
    [xi.zone.ABYSSEA_KONSCHTAT]  = {   88.4, -68.09, -579.97, 128, 108 },
    [xi.zone.ABYSSEA_TAHRONGI]   = {  -28.6,  46.17,  -680.3, 192, 117 },
    [xi.zone.ABYSSEA_LA_THEINE]  = {   -562,      0,     640, 158, 102 },
    [xi.zone.ABYSSEA_ATTOHWA]    = {   -340, -23.36,   48.49,  31, 118 },
    [xi.zone.ABYSSEA_MISAREAUX]  = { 363.47,      0, -119.72, 129, 103 },
    [xi.zone.ABYSSEA_VUNKERL]    = { 242.98,   0.24,    8.72, 157, 104 },
    [xi.zone.ABYSSEA_ALTEPA]     = {    340,  -0.52,    -668, 192, 107 },
    [xi.zone.ABYSSEA_ULEGUERAND] = {    270,   -7.8,     -82,  64, 112 },
    [xi.zone.ABYSSEA_GRAUBERG]   = {    -64,      0,     600,   0, 106 },
}

xi.abyssea.lightType =
{
    PEARL   = 1,
    GOLDEN  = 2,
    SILVERY = 3,
    EBON    = 4,
    AZURE   = 5,
    RUBY    = 6,
    AMBER   = 7,
}

local lightData =
{
--  Light Type                         Cap  Maximum Tier
    [xi.abyssea.lightType.PEARL  ] = { 230, 2 },
    [xi.abyssea.lightType.GOLDEN ] = { 200, 2 },
    [xi.abyssea.lightType.SILVERY] = { 200, 2 },
    [xi.abyssea.lightType.EBON   ] = { 200, 2 },
    [xi.abyssea.lightType.AZURE  ] = { 255, 4 },
    [xi.abyssea.lightType.RUBY   ] = { 255, 4 },
    [xi.abyssea.lightType.AMBER  ] = { 255, 4 },
}

xi.abyssea.abyssiteType =
{
    SOJOURN      =  1,
    CELERITY     =  2,
    AVARICE      =  3,
    CONFLUENCE   =  4,
    EXPERTISE    =  5,
    FORTUNE      =  6,
    KISMET       =  7,
    PROSPERITY   =  8,
    DESTINY      =  9,
    ACUMEN       = 10,
    LENITY       = 11,
    PERSPICACITY = 12,
    THE_REAPER   = 13,
    GUERDON      = 14,
    FURTHERANCE  = 15,
    MERIT        = 16,
    LUNAR        = 17,
    DISCERNMENT  = 18,
    COSMOS       = 19,
    DEMILUNE     = 20,
}

xi.abyssea.itemType =
{
    ITEM        = 1,
    TEMP        = 2,
    KEYITEM     = 3,
    ENHANCEMENT = 4,
}

local itemType = xi.abyssea.itemType

xi.abyssea.visionsCruorProspectorItems =
{
--  Sel      Item                                       Cost,  Qty
    [ 1] = { xi.item.PERLE_SALADE,                     4000 },
    [ 2] = { xi.item.PERLE_HAUBERK,                    5000 },
    [ 3] = { xi.item.PERLE_MOUFLES,                    3000 },
    [ 4] = { xi.item.PERLE_BRAYETTES,                  3000 },
    [ 5] = { xi.item.PERLE_SOLLERETS,                  3000 },
    [ 6] = { xi.item.AURORE_BERET,                     4000 },
    [ 7] = { xi.item.AURORE_DOUBLET,                   5000 },
    [ 8] = { xi.item.AURORE_GLOVES,                    3000 },
    [ 9] = { xi.item.AURORE_BRAIS,                     3000 },
    [10] = { xi.item.AURORE_GAITERS,                   3000 },
    [11] = { xi.item.TEAL_CHAPEAU,                     4000 },
    [12] = { xi.item.TEAL_SAIO,                        5000 },
    [13] = { xi.item.TEAL_CUFFS,                       3000 },
    [14] = { xi.item.TEAL_SLOPS,                       3000 },
    [15] = { xi.item.TEAL_PIGACHES,                    3000 },
    [16] = { xi.item.FORBIDDEN_KEY,                     500 },
    [17] = { xi.item.CIPHER_OF_JOACHIMS_ALTER_EGO,     5000 },
    [18] = { xi.item.SHADOW_THRONE,                 2000000 },
}

xi.abyssea.visionsCruorProspectorTemps =
{
--  Sel      Item                          Cost, Qty
    [ 1] = { xi.item.LUCID_POTION_I,             80 },
    [ 2] = { xi.item.LUCID_ETHER_I,              80 },
    [ 3] = { xi.item.BOTTLE_OF_CATHOLICON,       80 },
    [ 4] = { xi.item.DUSTY_ELIXIR,              120 },
    [ 5] = { xi.item.TUBE_OF_CLEAR_SALVE_I,     120 },
    [ 6] = { xi.item.BOTTLE_OF_STALWARTS_TONIC, 150 },
    [ 7] = { xi.item.BOTTLE_OF_ASCETICS_TONIC,  150 },
    [ 8] = { xi.item.BOTTLE_OF_CHAMPIONS_TONIC, 150 },
    [ 9] = { xi.item.LUCID_POTION_II,           200 },
    [10] = { xi.item.LUCID_ETHER_II,            200 },
    [11] = { xi.item.LUCID_ELIXIR_I,            300 },
    [12] = { xi.item.FLASK_OF_HEALING_POWDER,   300 },
    [13] = { xi.item.PINCH_OF_MANA_POWDER,      300 },
    [14] = { xi.item.TUBE_OF_HEALING_SALVE_I,   300 },
    [15] = { xi.item.BOTTLE_OF_VICARS_DRINK,    300 },
    [16] = { xi.item.TUBE_OF_CLEAR_SALVE_II,    300 },
    [17] = { xi.item.PRIMEVAL_BREW,         2000000 },
}

-- Each selection can contain multiple effects in the format of { abysseaEffect, actualEffect, Amt, keyItemRequired, bonusMultiplier }
-- and after that table, the cruor cost is defined.
xi.abyssea.visionsCruorProspectorBuffs =
{
    [6] =
    {
        {
            { xi.effect.ABYSSEA_HP, xi.effect.MAX_HP_BOOST, 20, xi.abyssea.abyssiteType.MERIT, 10 },
        },

        50,
    },

    [7] =
    {
        {
            { xi.effect.ABYSSEA_MP, xi.effect.MAX_MP_BOOST, 10, xi.abyssea.abyssiteType.MERIT, 5 },
        },

        120,
    },

    [8] =
    {
        {
            { xi.effect.ABYSSEA_STR, xi.effect.STR_BOOST, 10, xi.abyssea.abyssiteType.FURTHERANCE, 10 },
            { xi.effect.ABYSSEA_DEX, xi.effect.DEX_BOOST, 10, xi.abyssea.abyssiteType.FURTHERANCE, 10 },
        },

        120,
    },

    [9] =
    {
        {
            { xi.effect.ABYSSEA_VIT, xi.effect.VIT_BOOST, 10, xi.abyssea.abyssiteType.FURTHERANCE, 10 },
            { xi.effect.ABYSSEA_AGI, xi.effect.AGI_BOOST, 10, xi.abyssea.abyssiteType.FURTHERANCE, 10 },
        },

        100,
    },

    [10] =
    {
        {
            { xi.effect.ABYSSEA_INT, xi.effect.INT_BOOST, 10, xi.abyssea.abyssiteType.FURTHERANCE, 10 },
            { xi.effect.ABYSSEA_CHR, xi.effect.CHR_BOOST, 10, xi.abyssea.abyssiteType.FURTHERANCE, 10 },
            { xi.effect.ABYSSEA_MND, xi.effect.MND_BOOST, 10, xi.abyssea.abyssiteType.FURTHERANCE, 10 },
        },

        100,
    },

    [11] =
    {
        {
            { xi.effect.ABYSSEA_HP,  xi.effect.MAX_HP_BOOST, 20, xi.abyssea.abyssiteType.MERIT,       10 },
            { xi.effect.ABYSSEA_MP,  xi.effect.MAX_MP_BOOST, 10, xi.abyssea.abyssiteType.MERIT,        5 },
            { xi.effect.ABYSSEA_STR, xi.effect.STR_BOOST,    10, xi.abyssea.abyssiteType.FURTHERANCE, 10 },
            { xi.effect.ABYSSEA_DEX, xi.effect.DEX_BOOST,    10, xi.abyssea.abyssiteType.FURTHERANCE, 10 },
            { xi.effect.ABYSSEA_VIT, xi.effect.VIT_BOOST,    10, xi.abyssea.abyssiteType.FURTHERANCE, 10 },
            { xi.effect.ABYSSEA_AGI, xi.effect.AGI_BOOST,    10, xi.abyssea.abyssiteType.FURTHERANCE, 10 },
            { xi.effect.ABYSSEA_INT, xi.effect.INT_BOOST,    10, xi.abyssea.abyssiteType.FURTHERANCE, 10 },
            { xi.effect.ABYSSEA_CHR, xi.effect.CHR_BOOST,    10, xi.abyssea.abyssiteType.FURTHERANCE, 10 },
            { xi.effect.ABYSSEA_MND, xi.effect.MND_BOOST,    10, xi.abyssea.abyssiteType.FURTHERANCE, 10 },
        },

        470,
    },
}

-- Sequential Abyssite Key Items.
-- NOTE: Demilune is not sequential, and handled in a separate table
local abyssiteKeyItems =
{
--   Type                                      Beginning KI                            Ending KI
    [xi.abyssea.abyssiteType.SOJOURN     ] = { xi.ki.IVORY_ABYSSITE_OF_SOJOURN,        xi.ki.EMERALD_ABYSSITE_OF_SOJOURN    },
    [xi.abyssea.abyssiteType.CELERITY    ] = { xi.ki.AZURE_ABYSSITE_OF_CELERITY,       xi.ki.IVORY_ABYSSITE_OF_CELERITY     },
    [xi.abyssea.abyssiteType.AVARICE     ] = { xi.ki.VIRIDIAN_ABYSSITE_OF_AVARICE,     xi.ki.VERMILLION_ABYSSITE_OF_AVARICE },
    [xi.abyssea.abyssiteType.CONFLUENCE  ] = { xi.ki.IVORY_ABYSSITE_OF_CONFLUENCE,     xi.ki.INDIGO_ABYSSITE_OF_CONFLUENCE  },
    [xi.abyssea.abyssiteType.EXPERTISE   ] = { xi.ki.IVORY_ABYSSITE_OF_EXPERTISE,      xi.ki.EMERALD_ABYSSITE_OF_EXPERTISE  },
    [xi.abyssea.abyssiteType.FORTUNE     ] = { xi.ki.IVORY_ABYSSITE_OF_FORTUNE,        xi.ki.EMERALD_ABYSSITE_OF_FORTUNE    },
    [xi.abyssea.abyssiteType.KISMET      ] = { xi.ki.SCARLET_ABYSSITE_OF_KISMET,       xi.ki.VERMILLION_ABYSSITE_OF_KISMET  },
    [xi.abyssea.abyssiteType.PROSPERITY  ] = { xi.ki.AZURE_ABYSSITE_OF_PROSPERITY,     xi.ki.IVORY_ABYSSITE_OF_PROSPERITY   },
    [xi.abyssea.abyssiteType.DESTINY     ] = { xi.ki.VIRIDIAN_ABYSSITE_OF_DESTINY,     xi.ki.IVORY_ABYSSITE_OF_DESTINY      },
    [xi.abyssea.abyssiteType.ACUMEN      ] = { xi.ki.IVORY_ABYSSITE_OF_ACUMEN,         xi.ki.EMERALD_ABYSSITE_OF_ACUMEN     },
    [xi.abyssea.abyssiteType.LENITY      ] = { xi.ki.SCARLET_ABYSSITE_OF_LENITY,       xi.ki.EMERALD_ABYSSITE_OF_LENITY     },
    [xi.abyssea.abyssiteType.PERSPICACITY] = { xi.ki.SCARLET_ABYSSITE_OF_PERSPICACITY, xi.ki.VERM_ABYSSITE_OF_PERSPICACITY  },
    [xi.abyssea.abyssiteType.THE_REAPER  ] = { xi.ki.AZURE_ABYSSITE_OF_THE_REAPER,     xi.ki.INDIGO_ABYSSITE_OF_THE_REAPER  },
    [xi.abyssea.abyssiteType.GUERDON     ] = { xi.ki.VIRIDIAN_ABYSSITE_OF_GUERDON,     xi.ki.VERMILLION_ABYSSITE_OF_GUERDON },
    [xi.abyssea.abyssiteType.FURTHERANCE ] = { xi.ki.SCARLET_ABYSSITE_OF_FURTHERANCE,  xi.ki.IVORY_ABYSSITE_OF_FURTHERANCE  },
    [xi.abyssea.abyssiteType.MERIT       ] = { xi.ki.AZURE_ABYSSITE_OF_MERIT,          xi.ki.INDIGO_ABYSSITE_OF_MERIT       },
    [xi.abyssea.abyssiteType.LUNAR       ] = { xi.ki.LUNAR_ABYSSITE1,                  xi.ki.LUNAR_ABYSSITE3                },
    [xi.abyssea.abyssiteType.DISCERNMENT ] = { xi.ki.ABYSSITE_OF_DISCERNMENT,          xi.ki.ABYSSITE_OF_DISCERNMENT        },
    [xi.abyssea.abyssiteType.COSMOS      ] = { xi.ki.ABYSSITE_OF_THE_COSMOS,           xi.ki.ABYSSITE_OF_THE_COSMOS         },
}

local demiluneKeyItems =
{
    xi.ki.CLEAR_DEMILUNE_ABYSSITE,
    xi.ki.COLORFUL_DEMILUNE_ABYSSITE,
    xi.ki.SCARLET_DEMILUNE_ABYSSITE,
    xi.ki.AZURE_DEMILUNE_ABYSSITE,
    xi.ki.VIRIDIAN_DEMILUNE_ABYSSITE,
    xi.ki.JADE_DEMILUNE_ABYSSITE,
    xi.ki.SAPPHIRE_DEMILUNE_ABYSSITE,
    xi.ki.CRIMSON_DEMILUNE_ABYSSITE,
    xi.ki.EMERALD_DEMILUNE_ABYSSITE,
    xi.ki.VERMILLION_DEMILUNE_ABYSSITE,
    xi.ki.INDIGO_DEMILUNE_ABYSSITE,
}

xi.abyssea.mob =
{
    -- Abyssea - Konschtat (zone 15)
    ['Alkonost']           = { ['Atma'] = { xi.ki.ATMA_OF_GALES                }, ['Normal'] = { xi.ki.TATTERED_HIPPOGRYPH_WING     } },
    ['Arimaspi']           = { ['Atma'] = {                                    }, ['Normal'] = { xi.ki.MUCID_AHRIMAN_EYEBALL        } },
    ['Balaur']             = { ['Atma'] = { xi.ki.ATMA_OF_STORMBREATH          }, ['Normal'] = {                                    } },
    ['Bloodeye_Vileberry'] = { ['Atma'] = { xi.ki.ATMA_OF_CLOAK_AND_DAGGER     }, ['Normal'] = {                                    } },
    ['Clingy_Clare']       = { ['Atma'] = {                                    }, ['Normal'] = { xi.ki.DECAYING_MORBOL_TOOTH        } },
    ['Eccentric_Eve']      = { ['Atma'] = { xi.ki.ATMA_OF_THE_VORACIOUS_VIOLET }, ['Normal'] = {                                    } },
    ['Fear_Gorta']         = { ['Atma'] = {                                    }, ['Normal'] = { xi.ki.AZURE_ABYSSITE_OF_THE_REAPER } },
    ['Fistule']            = { ['Atma'] = { xi.ki.ATMA_OF_VICISSITUDE          }, ['Normal'] = { xi.ki.TURBID_SLIME_OIL             } },
    ['Gangly_Gean']        = { ['Atma'] = {                                    }, ['Normal'] = { xi.ki.FRAGRANT_TREANT_PETAL        } },
    ['Keratyrannos']       = { ['Atma'] = {                                    }, ['Normal'] = { xi.ki.CRACKED_WIVRE_HORN           } },
    ['Khalamari']          = { ['Atma'] = { xi.ki.ATMA_OF_THE_DRIFTER          }, ['Normal'] = {                                    } },
    ['Kukulkan']           = { ['Atma'] = { xi.ki.ATMA_OF_THE_NOXIOUS_FANG     }, ['Normal'] = { xi.ki.VENOMOUS_PEISTE_CLAW         } },
    ['Pavan']              = { ['Atma'] = {                                    }, ['Normal'] = { xi.ki.AZURE_ABYSSITE_OF_LENITY     } },
    ['Raskovnik']          = { ['Atma'] = { xi.ki.ATMA_OF_THRASHING_TENDRILS   }, ['Normal'] = { xi.ki.FETID_RAFFLESIA_STALK        } },
    ['Tonberry_Lieje']     = { ['Atma'] = {                                    }, ['Normal'] = { xi.ki.TWISTED_TONBERRY_CROWN       } },
    ['Turul']              = { ['Atma'] = { xi.ki.ATMA_OF_THE_STORMBIRD        }, ['Normal'] = {                                    } },
    ['Hadal_Satiator']     = { ['Atma'] = { xi.ki.ATMA_OF_THE_BEYOND           }, ['Normal'] = {                                    } },

    -- Abyssea - Tahrongi (zone 45)
    ['Adze']            = { ['Atma'] = { xi.ki.ATMA_OF_CALAMITY         }, ['Normal'] = { xi.ki.STICKY_GNAT_WING             } },
    ['Alectryon']       = { ['Atma'] = {                                }, ['Normal'] = { xi.ki.FAT_LINED_COCKATRICE_SKIN    } },
    ['Bhumi']           = { ['Atma'] = {                                }, ['Normal'] = { xi.ki.VIRIDIAN_ABYSSITE_OF_MERIT   } },
    ['Chloris']         = { ['Atma'] = { xi.ki.ATMA_OF_THE_HARVESTER    }, ['Normal'] = { xi.ki.OVERGROWN_MANDRAGORA_FLOWER  } },
    ['Chukwa']          = { ['Atma'] = { xi.ki.ATMA_OF_THE_ADAMANTINE   }, ['Normal'] = { xi.ki.MOSSY_ADAMANTOISE_SHELL      } },
    ['Cuelebre']        = { ['Atma'] = { xi.ki.ATMA_OF_THE_CLAW         }, ['Normal'] = { xi.ki.VIRIDIAN_ABYSSITE_OF_DESTINY } },
    ['Glavoid']         = { ['Atma'] = { xi.ki.ATMA_OF_DUNES            }, ['Normal'] = { xi.ki.CHIPPED_SANDWORM_TOOTH       } },
    ['Hedetet']         = { ['Atma'] = {                                }, ['Normal'] = { xi.ki.GORY_SCORPION_CLAW           } },
    ['Iratham']         = { ['Atma'] = { xi.ki.ATMA_OF_THE_COSMOS       }, ['Normal'] = {                                    } },
    ['Lacovie']         = { ['Atma'] = { xi.ki.ATMA_OF_THE_STRONGHOLD   }, ['Normal'] = {                                    } },
    ['Manananggal']     = { ['Atma'] = {                                }, ['Normal'] = { xi.ki.VIRIDIAN_ABYSSITE_OF_DESTINY } },
    ['Mictlantecuhtli'] = { ['Atma'] = { xi.ki.ATMA_OF_BALEFUL_BONES    }, ['Normal'] = { xi.ki.VIRIDIAN_ABYSSITE_OF_MERIT   } },
    ['Minhocao']        = { ['Atma'] = {                                }, ['Normal'] = { xi.ki.SODDEN_SANDWORM_HUSK         } },
    ['Muscaliet']       = { ['Atma'] = {                                }, ['Normal'] = { xi.ki.LUXURIANT_MANTICORE_MANE     } },
    ['Myrmecoleon']     = { ['Atma'] = { xi.ki.ATMA_OF_THE_IMPALER      }, ['Normal'] = {                                    } },
    ['Ophanim']         = { ['Atma'] = {                                }, ['Normal'] = { xi.ki.VEINOUS_HECTEYES_EYELID      } },
    ['Quetzalli']       = { ['Atma'] = {                                }, ['Normal'] = { xi.ki.VIRIDIAN_ABYSSITE_OF_AVARICE } },
    ['Treble_Noctules'] = { ['Atma'] = {                                }, ['Normal'] = { xi.ki.TORN_BAT_WING                } },
    ['Usurper']         = { ['Atma'] = { xi.ki.ATMA_OF_THE_SIREN_SHADOW }, ['Normal'] = {                                    } },

    -- Abyssea - La Theine (zone 132)
    ['Adamastor']           = { ['Atma'] = {                                }, ['Normal'] = { xi.ki.DENTED_GIGAS_SHIELD              } },
    ['Baba_Yaga']           = { ['Atma'] = {                                }, ['Normal'] = { xi.ki.SHIMMERING_PIXIE_PINION          } },
    ['Briareus']            = { ['Atma'] = { xi.ki.ATMA_OF_THE_STOUT_ARM    }, ['Normal'] = { xi.ki.BLOOD_SMEARED_GIGAS_HELM         } },
    ['Carabosse']           = { ['Atma'] = { xi.ki.ATMA_OF_ALLURE           }, ['Normal'] = { xi.ki.GLITTERING_PIXIE_CHOKER          } },
    ['Chasmic_Hornet']      = { ['Atma'] = {                                }, ['Normal'] = { xi.ki.SCARLET_ABYSSITE_OF_PERSPICACITY } },
    ['Dozing_Dorian']       = { ['Atma'] = { xi.ki.ATMA_OF_THE_EBON_HOOF    }, ['Normal'] = {                                        } },
    ['Grandgousier']        = { ['Atma'] = {                                }, ['Normal'] = { xi.ki.SEVERED_GIGAS_COLLAR             } },
    ['Hadhayosh']           = { ['Atma'] = { xi.ki.ATMA_OF_THE_LION         }, ['Normal'] = {                                        } },
    ['Karkinos']            = { ['Atma'] = { xi.ki.ATMA_OF_THE_TWIN_CLAW    }, ['Normal'] = {                                        } },
    ['La_Theine_Liege']     = { ['Atma'] = {                                }, ['Normal'] = { xi.ki.PELLUCID_FLY_EYE                 } },
    ['Lugarhoo']            = { ['Atma'] = { xi.ki.ATMA_OF_THE_BAYING_MOON  }, ['Normal'] = {                                        } },
    ['Mangy-tailed_Marvin'] = { ['Atma'] = {                                }, ['Normal'] = { xi.ki.SCARLET_ABYSSITE_OF_LENITY       } },
    ['Megamaw_Mikey']       = { ['Atma'] = { xi.ki.ATMA_OF_TREMORS          }, ['Normal'] = {                                        } },
    ['Megantereon']         = { ['Atma'] = { xi.ki.ATMA_OF_THE_SAVAGE_TIGER }, ['Normal'] = { xi.ki.BLOODIED_SABER_TOOTH             } },
    ['Nahn']                = { ['Atma'] = {                                }, ['Normal'] = { xi.ki.SMOLDERING_CRAB_SHELL            } },
    ['Ovni']                = { ['Atma'] = { xi.ki.ATMA_OF_THE_HEAVENS      }, ['Normal'] = { xi.ki.SCARLET_ABYSSITE_OF_SOJOURN      } },
    ['Pantagruel']          = { ['Atma'] = {                                }, ['Normal'] = { xi.ki.WARPED_GIGAS_ARMBAND             } },
    ['Trudging_Thomas']     = { ['Atma'] = {                                }, ['Normal'] = { xi.ki.MARBLED_MUTTON_CHOP              } },
    ['Ruminator']           = { ['Atma'] = { xi.ki.ATMA_OF_ETERNITY         }, ['Normal'] = {                                        } },

    -- Abyssea - Attohwa (zone 215)
    ['Amun']          = { ['Atma'] = {                                     }, ['Normal'] = { xi.ki.SHRIVELED_HECTEYES_STALK   } },
    ['Berstuk']       = { ['Atma'] = { xi.ki.ATMA_OF_THE_GLUTINOUS_OOZE    }, ['Normal'] = {                                  } },
    ['Blazing_Eruca'] = { ['Atma'] = {                                     }, ['Normal'] = { xi.ki.BULBOUS_CRAWLER_COCOON     } },
    ['Drekavac']      = { ['Atma'] = {                                     }, ['Normal'] = { xi.ki.WRITHING_GHOST_FINGER      } },
    ['Gaizkin']       = { ['Atma'] = {                                     }, ['Normal'] = { xi.ki.BLOTCHED_DOOMED_TONGUE     } },
    ['Gieremund']     = { ['Atma'] = {                                     }, ['Normal'] = { xi.ki.RUSTED_HOUND_COLLAR        } },
    ['Granite_Borer'] = { ['Atma'] = {                                     }, ['Normal'] = { xi.ki.VENOMOUS_WAMOURA_FEELER    } },
    ['Itzpapalotl']   = { ['Atma'] = { xi.ki.ATMA_OF_THE_CLAWED_BUTTERFLY  }, ['Normal'] = {                                  } },
    ['Kampe']         = { ['Atma'] = { xi.ki.ATMA_OF_THE_GOLDEN_CLAW       }, ['Normal'] = {                                  } },
    ['Kharon']        = { ['Atma'] = {                                     }, ['Normal'] = { xi.ki.CRACKED_SKELETON_CLAVICLE  } },
    ['Maahes']        = { ['Atma'] = { xi.ki.ATMA_OF_THE_LIGHTNING_BEAST   }, ['Normal'] = {                                  } },
    ['Mielikki']      = { ['Atma'] = {                                     }, ['Normal'] = { xi.ki.JADE_ABYSSITE_OF_SOJOURN   } },
    ['Nightshade']    = { ['Atma'] = { xi.ki.ATMA_OF_THE_NOXIOUS_BLOOM     }, ['Normal'] = {                                  } },
    ['Pallid_Percy']  = { ['Atma'] = {                                     }, ['Normal'] = { xi.ki.MUCID_WORM_SEGMENT         } },
    ['Smok']          = { ['Atma'] = { xi.ki.ATMA_OF_THE_SMOLDERING_SKY    }, ['Normal'] = {                                  } },
    ['Svarbhanu']     = { ['Atma'] = {                                     }, ['Normal'] = { xi.ki.HOLLOW_DRAGON_EYE          } },
    ['Titlacauan']    = { ['Atma'] = { xi.ki.ATMA_OF_UNDYING               }, ['Normal'] = {                                  } },
    ['Tunga']         = { ['Atma'] = {                                     }, ['Normal'] = { xi.ki.DISTENDED_CHIGOE_ABDOMEN   } },
    ['Ulhuadshi']     = { ['Atma'] = { xi.ki.ATMA_OF_THE_DESERT_WORM       }, ['Normal'] = {                                  } },
    ['Warbler']       = { ['Atma'] = {                                     }, ['Normal'] = { xi.ki.JADE_ABYSSITE_OF_MERIT     } },
    ['Wherwetrice']   = { ['Atma'] = {                                     }, ['Normal'] = { xi.ki.JADE_ABYSSITE_OF_EXPERTISE } },
    ['Yaanei']        = { ['Atma'] = { xi.ki.ATMA_OF_THE_IMPREGNABLE_TOWER }, ['Normal'] = {                                  } },
    ['Lusca']         = { ['Atma'] = { xi.ki.ATMA_OF_THE_DEMONIC_SKEWER    }, ['Normal'] = {                                  } },

    -- Abyssea - Misareaux (zone 216)
    ['Abyssic_Cluster']     = { ['Atma'] = {                                     }, ['Normal'] = { xi.ki.BLAZING_CLUSTER_SOUL             } },
    ['Amhuluk']             = { ['Atma'] = { xi.ki.ATMA_OF_THE_STRANGLING_WIND   }, ['Normal'] = {                                        } },
    ['Asanbosam']           = { ['Atma'] = {                                     }, ['Normal'] = { xi.ki.BLOODIED_BAT_FUR                 } },
    ['Avalerion']           = { ['Atma'] = { xi.ki.ATMA_OF_THE_WINGED_ENIGMA     }, ['Normal'] = {                                        } },
    ['Cep-Kamuy']           = { ['Atma'] = {                                     }, ['Normal'] = { xi.ki.GLISTENING_OROBON_LIVER          } },
    ['Cirein-croin']        = { ['Atma'] = { xi.ki.ATMA_OF_THE_DEEP_DEVOURER     }, ['Normal'] = {                                        } },
    ['Flame_Skimmer']       = { ['Atma'] = {                                     }, ['Normal'] = { xi.ki.SAPPHIRE_ABYSSITE_OF_FURTHERANCE } },
    ['Funereal_Apkallu']    = { ['Atma'] = {                                     }, ['Normal'] = { xi.ki.JAGGED_APKALLU_BEAK              } },
    ['Gukumatz']            = { ['Atma'] = {                                     }, ['Normal'] = { xi.ki.MOLTED_PEISTE_SKIN               } },
    ['Heqet']               = { ['Atma'] = {                                     }, ['Normal'] = { xi.ki.DOFFED_POROGGO_HAT               } },
    ['Ironclad_Observer']   = { ['Atma'] = {                                     }, ['Normal'] = { xi.ki.SCALDING_IRONCLAD_SPIKE          } },
    ['Ironclad_Pulverizer'] = { ['Atma'] = { xi.ki.ATMA_OF_THE_RAZED_RUIN        }, ['Normal'] = {                                        } },
    ['Karkatakam']          = { ['Atma'] = { xi.ki.ATMA_OF_THE_CRADLE            }, ['Normal'] = {                                        } },
    ['Kutharei']            = { ['Atma'] = { xi.ki.ATMA_OF_THE_MOUNTED_CHAMPION  }, ['Normal'] = {                                        } },
    ['Manohra']             = { ['Atma'] = {                                     }, ['Normal'] = { xi.ki.CLIPPED_BIRD_WING                } },
    ['Minax_Bugard']        = { ['Atma'] = {                                     }, ['Normal'] = { xi.ki.BLOODSTAINED_BUGARD_FANG         } },
    ['Nehebkau']            = { ['Atma'] = { xi.ki.ATMA_OF_THE_RAPID_REPTILIAN   }, ['Normal'] = {                                        } },
    ['Nonno']               = { ['Atma'] = { xi.ki.ATMA_OF_THE_UNTOUCHED         }, ['Normal'] = {                                        } },
    ['Npfundlwa']           = { ['Atma'] = {                                     }, ['Normal'] = { xi.ki.SAPPHIRE_ABYSSITE_OF_FORTUNE     } },
    ['Sirrush']             = { ['Atma'] = {                                     }, ['Normal'] = { xi.ki.GNARLED_LIZARD_NAIL              } },
    ['Sobek']               = { ['Atma'] = { xi.ki.ATMA_OF_THE_GNARLED_HORN      }, ['Normal'] = {                                        } },
    ['Tuskertrap']          = { ['Atma'] = {                                     }, ['Normal'] = { xi.ki.SAPPHIRE_ABYSSITE_OF_LENITY      } },
    ['Tristitia']           = { ['Atma'] = { xi.ki.ATMA_OF_THE_BLUDGEONING_BRUTE }, ['Normal'] = {                                        } },

    -- Abyssea - Vunkerl (zone 217)
    ['Armillaria']             = { ['Atma'] = {                                       }, ['Normal'] = { xi.ki.CRIMSON_ABYSSITE_OF_ACUMEN     } },
    ['Ayravata']               = { ['Atma'] = {                                       }, ['Normal'] = { xi.ki.MALODOROUS_MARID_FUR           } },
    ['Bukhis']                 = { ['Atma'] = { xi.ki.ATMA_OF_THE_SANGUINE_SCYTHE     }, ['Normal'] = {                                      } },
    ['Chhir_Batti']            = { ['Atma'] = { xi.ki.ATMA_OF_THE_MURKY_MIASMA        }, ['Normal'] = {                                      } },
    ['Div-e_Sepid']            = { ['Atma'] = {                                       }, ['Normal'] = { xi.ki.CHIPPED_IMPS_OLIFANT           } },
    ['Durinn']                 = { ['Atma'] = { xi.ki.ATMA_OF_THE_MINIKIN_MONSTROSITY }, ['Normal'] = {                                      } },
    ['Dvalinn']                = { ['Atma'] = {                                       }, ['Normal'] = { xi.ki.DECAYED_DVERGR_TOOTH           } },
    ['Hanuman']                = { ['Atma'] = { xi.ki.ATMA_OF_THE_AVARICIOUS_APE      }, ['Normal'] = {                                      } },
    ['Hrosshvalur']            = { ['Atma'] = {                                       }, ['Normal'] = { xi.ki.SHIMMERING_PUGIL_SCALE         } },
    ['Iktomi']                 = { ['Atma'] = {                                       }, ['Normal'] = { xi.ki.CRIMSON_ABYSSITE_OF_DESTINY    } },
    ['Iku-Turso']              = { ['Atma'] = {                                       }, ['Normal'] = { xi.ki.GLOSSY_SEA_MONK_SUCKER         } },
    ['Kadraeth_the_Hatespawn'] = { ['Atma'] = {                                       }, ['Normal'] = { xi.ki.PULSATING_SOULFLAYER_BEARD     } },
    ['Karkadann']              = { ['Atma'] = { xi.ki.ATMA_OF_THE_BLINDING_HORN       }, ['Normal'] = {                                      } },
    ['Khalkotaur']             = { ['Atma'] = {                                       }, ['Normal'] = { xi.ki.INGROWN_TAURUS_NAIL            } },
    ['Lord_Varney']            = { ['Atma'] = {                                       }, ['Normal'] = { xi.ki.IMBRUED_VAMPYR_FANG            } },
    ['Pascerpot']              = { ['Atma'] = {                                       }, ['Normal'] = { xi.ki.CRIMSON_ABYSSITE_OF_CONFLUENCE } },
    ['Quasimodo']              = { ['Atma'] = {                                       }, ['Normal'] = { xi.ki.OSSIFIED_GARGOUILLE_HAND       } },
    ['Rakshas']                = { ['Atma'] = {                                       }, ['Normal'] = { xi.ki.WARPED_SMILODON_CHOKER         } },
    ['Seps']                   = { ['Atma'] = { xi.ki.ATMA_OF_THE_APPARITIONS         }, ['Normal'] = {                                      } },
    ['Sedna']                  = { ['Atma'] = { xi.ki.ATMA_OF_THE_TUSKED_TERROR       }, ['Normal'] = {                                      } },
    ['Sippoy']                 = { ['Atma'] = { xi.ki.ATMA_OF_THE_WOULD_BE_KING       }, ['Normal'] = {                                      } },
    ['Xan']                    = { ['Atma'] = { xi.ki.ATMA_OF_THE_SHIMMERING_SHELL    }, ['Normal'] = {                                      } },
    ['Ketea']                  = { ['Atma'] = { xi.ki.ATMA_OF_THE_DEMONIC_LASH        }, ['Normal'] = {                                      } },

    -- Abyssea - Altepa (zone 218)
    ['Amarok']                = { ['Atma'] = { xi.ki.ATMA_OF_THE_LONE_WOLF           }, ['Normal'] = { xi.ki.STEAMING_CERBERUS_TONGUE                               } },
    ['Bennu']                 = { ['Atma'] = { xi.ki.ATMA_OF_THE_ASCENDING_ONE       }, ['Normal'] = {                                                              } },
    ['Cuijatender']           = { ['Atma'] = { xi.ki.ATMA_OF_A_THOUSAND_NEEDLES      }, ['Normal'] = {                                                              } },
    ['Dragua']                = { ['Atma'] = { xi.ki.ATMA_OF_THE_EARTH_WYRM          }, ['Normal'] = {                                                              } },
    ['Emperador_de_Altepa']   = { ['Atma'] = { xi.ki.ATMA_OF_THE_SAND_EMPEROR        }, ['Normal'] = {                                                              } },
    ['Hazhdiha']              = { ['Atma'] = { xi.ki.ATMA_OF_THE_CRIMSON_SCALE       }, ['Normal'] = { xi.ki.BLOODIED_DRAGON_EAR                                    } },
    ['Hedjedjet']             = { ['Atma'] = { xi.ki.ATMA_OF_THE_SCORPION_QUEEN      }, ['Normal'] = {                                                              } },
    ['Ironclad_Smiter']       = { ['Atma'] = { xi.ki.ATMA_OF_THE_SMITING_BLOW        }, ['Normal'] = { xi.ki.BROKEN_IRON_GIANT_SPIKE                                } },
    ['Long-Barreled_Chariot'] = { ['Atma'] = {                                       }, ['Normal'] = { xi.ki.RUSTED_CHARIOT_GEAR, xi.ki.EMERALD_ABYSSITE_OF_FORTUNE } },
    ['Orthrus']               = { ['Atma'] = { xi.ki.ATMA_OF_THE_BROTHER_WOLF        }, ['Normal'] = {                                                              } },
    ['Ouzelum']               = { ['Atma'] = { xi.ki.ATMA_OF_THE_SCARLET_WING        }, ['Normal'] = { xi.ki.RESPLENDENT_ROC_QUILL                                  } },
    ['Rani']                  = { ['Atma'] = { xi.ki.ATMA_OF_THE_MERCILESS_MATRIARCH }, ['Normal'] = {                                                              } },
    ['Shaula']                = { ['Atma'] = { xi.ki.ATMA_OF_THE_RAISED_TAIL         }, ['Normal'] = {                                                              } },
    ['Waugyl']                = { ['Atma'] = {                                       }, ['Normal'] = { xi.ki.EMERALD_ABYSSITE_OF_SOJOURN                            } },
    ['Koios']                 = { ['Atma'] = {                                       }, ['Normal'] = { xi.ki.EMERALD_ABYSSITE_OF_ACUMEN                             } },
    ['Brulo']                 = { ['Atma'] = { xi.ki.ATMA_OF_THE_BURNING_EFFIGY      }, ['Normal'] = {                                                              } },

    -- Abyssea - Uleguerand (zone 253)
    ['Apademak']              = { ['Atma'] = { xi.ki.ATMA_OF_THE_WAR_LION            }, ['Normal'] = {                                                                  } },
    ['Awahondo']              = { ['Atma'] = { xi.ki.ATMA_OF_THE_PERSISTANT_PREDATOR }, ['Normal'] = { xi.ki.DECAYING_DIREMITE_FANG                                     } },
    ['Blanga']                = { ['Atma'] = { xi.ki.ATMA_OF_THE_STONE_GOD           }, ['Normal'] = {                                                                  } },
    ['Dhorme_Khimaira']       = { ['Atma'] = { xi.ki.ATMA_OF_PURGATORY               }, ['Normal'] = { xi.ki.TORN_KHIMAIRA_WING                                         } },
    ['Empousa']               = { ['Atma'] = { xi.ki.ATMA_OF_THE_SHRIEKING_ONE       }, ['Normal'] = {                                                                  } },
    ['Impervious_Chariot']    = { ['Atma'] = {                                       }, ['Normal'] = { xi.ki.DENTED_CHARIOT_SHIELD, xi.ki.VERMILLION_ABYSSITE_OF_KISMET } },
    ['Indrik']                = { ['Atma'] = { xi.ki.ATMA_OF_THE_HOLY_MOUNTAIN       }, ['Normal'] = {                                                                  } },
    ['Ironclad_Triturator']   = { ['Atma'] = { xi.ki.ATMA_OF_THE_CRUSHING_CUDGEL     }, ['Normal'] = { xi.ki.WARPED_IRON_GIANT_NAIL                                     } },
    ['Isgebind']              = { ['Atma'] = { xi.ki.ATMA_OF_THE_FROZEN_FETTERS      }, ['Normal'] = {                                                                  } },
    ['Kur']                   = { ['Atma'] = { xi.ki.ATMA_OF_BLIGHTED_BREATH         }, ['Normal'] = { xi.ki.BEGRIMED_DRAGON_HIDE                                       } },
    ['Pantokrator']           = { ['Atma'] = { xi.ki.ATMA_OF_THE_OMNIPOTENT          }, ['Normal'] = {                                                                  } },
    ['Resheph']               = { ['Atma'] = { xi.ki.ATMA_OF_THE_PLAGUEBRINGER       }, ['Normal'] = {                                                                  } },
    ['Veri_Selen']            = { ['Atma'] = {                                       }, ['Normal'] = { xi.ki.VERMILLION_ABYSSITE_OF_GUERDON                             } },
    ['Yaguarogui']            = { ['Atma'] = { xi.ki.ATMA_OF_THE_SUN_EATER           }, ['Normal'] = {                                                                  } },
    ['Chione']                = { ['Atma'] = {                                       }, ['Normal'] = { xi.ki.VERMILLION_ABYSSITE_OF_PERSPICACITY                        } },
    ['Ogopogo']               = { ['Atma'] = { xi.ki.ATMA_OF_THE_LAKE_LURKER         }, ['Normal'] = {                                                                  } },

    -- Abyssea - Grauberg (zone 254)
    ['Alfard']                  = { ['Atma'] = { xi.ki.ATMA_OF_THE_SOLITARY_ONE      }, ['Normal'] = {                                                             } },
    ['Amphitrite']              = { ['Atma'] = { xi.ki.ATMA_OF_THE_SEA_DAUGTER       }, ['Normal'] = {                                                             } },
    ['Assailer_Chariot']        = { ['Atma'] = {                                     }, ['Normal'] = { xi.ki.WARPED_CHARIOT_PLATE, xi.ki.IVORY_ABYSSITE_OF_SOJOURN } },
    ['Azdaja']                  = { ['Atma'] = { xi.ki.ATMA_OF_THE_WINGED_GLOOM      }, ['Normal'] = {                                                             } },
    ['Bomblix_Flamefinger']     = { ['Atma'] = { xi.ki.ATMA_OF_FIRES_AND_FLARES      }, ['Normal'] = {                                                             } },
    ['Deelgeed']                = { ['Atma'] = { xi.ki.ATMA_OF_THE_HORNED_BEAST      }, ['Normal'] = { xi.ki.VACANT_BUGARD_EYE                                     } },
    ['Fleshflayer_Killakriq']   = { ['Atma'] = { xi.ki.ATMA_OF_THE_FOE_FLAYER        }, ['Normal'] = {                                                             } },
    ['Fuath']                   = { ['Atma'] = { xi.ki.ATMA_OF_THE_HATEFUL_STEAM     }, ['Normal'] = {                                                             } },
    ['Ironclad_Sunderer']       = { ['Atma'] = { xi.ki.ATMA_OF_THE_SUNDERING_SLASH   }, ['Normal'] = { xi.ki.SHATTERED_IRON_GIANT_CHAIN                            } },
    ['Melo_Melo']               = { ['Atma'] = { xi.ki.ATMA_OF_AQUADIC_ARDOR         }, ['Normal'] = { xi.ki.VARIEGATED_URAGNITE_SHELL                             } },
    ['Ningishzida']             = { ['Atma'] = { xi.ki.ATMA_OF_ENTWINED_SERPENTS     }, ['Normal'] = { xi.ki.VENOMOUS_HYDRA_FANG                                   } },
    ['Raja']                    = { ['Atma'] = { xi.ki.ATMA_OF_THE_DESPOT            }, ['Normal'] = {                                                             } },
    ['Teugghia']                = { ['Atma'] = { xi.ki.ATMA_OF_THE_FALLEN_ONE        }, ['Normal'] = {                                                             } },
    ['Xibalba']                 = { ['Atma'] = {                                     }, ['Normal'] = { xi.ki.INDIGO_ABYSSITE_OF_MERIT                              } },
    ['Gamayun']                 = { ['Atma'] = {                                     }, ['Normal'] = { xi.ki.INDIGO_ABYSSITE_OF_THE_REAPER                         } },
    ['Maere']                   = { ['Atma'] = { xi.ki.ATMA_OF_THE_ENDLESS_NIGHTMARE }, ['Normal'] = {                                                             } },
}

xi.abyssea.triggerType =
{
    RED    = 0,
    YELLOW = 1,
    BLUE   = 2,
}

xi.abyssea.deathType =
{
    NONE        = 0,
    PHYSICAL    = 1,
    MAGICAL     = 2,
    WS_PHYSICAL = 3,
    WS_MAGICAL  = 4,
}

local redWeakness =
{
    xi.weaponskill.SERAPH_BLADE,
    xi.weaponskill.SERAPH_STRIKE,
    xi.weaponskill.TACHI_KOKI,
    xi.weaponskill.SUNBURST,
    xi.weaponskill.ENERGY_DRAIN,
    xi.weaponskill.BLADE_EI,
    xi.weaponskill.SHADOW_OF_DEATH,
    xi.weaponskill.RED_LOTUS_BLADE,
    xi.weaponskill.EARTH_CRUSHER,
    xi.weaponskill.CYCLONE,
    xi.weaponskill.TACHI_JINPU,
    xi.weaponskill.FREEZEBITE,
    xi.weaponskill.RAIDEN_THRUST,
}

local yellowWeakness =
{
    [xi.element.FIRE] =
    {
        xi.magic.spell.FIRE_III,
        xi.magic.spell.FIRE_IV,
        xi.magic.spell.FIRAGA_III,
        xi.magic.spell.FLARE,
        xi.magic.spell.HEAT_BREATH,
        xi.magic.spell.KATON_NI,
        xi.magic.spell.ICE_THRENODY,
    },

    [xi.element.ICE] =
    {
        xi.magic.spell.BLIZZARD_III,
        xi.magic.spell.BLIZZARD_IV,
        xi.magic.spell.BLIZZAGA_III,
        xi.magic.spell.FREEZE,
        xi.magic.spell.ICE_BREAK,
        xi.magic.spell.HYOTON_NI,
        xi.magic.spell.WIND_THRENODY,
    },

    [xi.element.WIND] =
    {
        xi.magic.spell.AERO_III,
        xi.magic.spell.AERO_IV,
        xi.magic.spell.AEROGA_III,
        xi.magic.spell.TORNADO,
        xi.magic.spell.MYSTERIOUS_LIGHT,
        xi.magic.spell.HUTON_NI,
        xi.magic.spell.EARTH_THRENODY,
    },

    [xi.element.EARTH] =
    {
        xi.magic.spell.STONE_III,
        xi.magic.spell.STONE_IV,
        xi.magic.spell.STONEGA_III,
        xi.magic.spell.QUAKE,
        xi.magic.spell.MAGNETITE_CLOUD,
        xi.magic.spell.DOTON_NI,
        xi.magic.spell.LIGHTNING_THRENODY,
    },

    [xi.element.THUNDER] =
    {
        xi.magic.spell.THUNDER_III,
        xi.magic.spell.THUNDER_IV,
        xi.magic.spell.THUNDAGA_III,
        xi.magic.spell.BURST,
        xi.magic.spell.MIND_BLAST,
        xi.magic.spell.RAITON_NI,
        xi.magic.spell.WATER_THRENODY,
    },

    [xi.element.WATER] =
    {
        xi.magic.spell.WATER_III,
        xi.magic.spell.WATER_IV,
        xi.magic.spell.WATERGA_III,
        xi.magic.spell.FLOOD,
        xi.magic.spell.MAELSTROM,
        xi.magic.spell.SUITON_NI,
        xi.magic.spell.FIRE_THRENODY,
    },

    [xi.element.LIGHT] =
    {
        xi.magic.spell.BANISH_II,
        xi.magic.spell.BANISH_III,
        xi.magic.spell.BANISHGA,
        xi.magic.spell.BANISHGA_II,
        xi.magic.spell.HOLY,
        xi.magic.spell.FLASH,
        xi.magic.spell.RADIANT_BREATH,
        xi.magic.spell.DARK_THRENODY,
    },

    [xi.element.DARK] =
    {
        xi.magic.spell.ASPIR,
        xi.magic.spell.DRAIN,
        xi.magic.spell.BIO_II,
        xi.magic.spell.DISPEL,
        xi.magic.spell.EYES_ON_ME,
        xi.magic.spell.KURAYAMI_NI,
        xi.magic.spell.LIGHT_THRENODY,
    },
}

local blueWeakness =
{
    -- Piercing: 0600 - 1400
    {
        xi.weaponskill.SIDEWINDER,
        xi.weaponskill.BLAST_ARROW,
        xi.weaponskill.ARCHING_ARROW,
        xi.weaponskill.EMPYREAL_ARROW,
        xi.weaponskill.SLUG_SHOT,
        xi.weaponskill.BLAST_SHOT,
        xi.weaponskill.HEAVY_SHOT,
        xi.weaponskill.DETONATOR,
        xi.weaponskill.SHADOWSTITCH,
        xi.weaponskill.DANCING_EDGE,
        xi.weaponskill.SHARK_BITE,
        xi.weaponskill.EVISCERATION,
        xi.weaponskill.SKEWER,
        xi.weaponskill.WHEELING_THRUST,
        xi.weaponskill.IMPULSE_DRIVE,
    },

    -- Slashing: 1400 - 2200
    {
        xi.weaponskill.VORPAL_BLADE,
        xi.weaponskill.SWIFT_BLADE,
        xi.weaponskill.SAVAGE_BLADE,
        xi.weaponskill.BLADE_TEN,
        xi.weaponskill.BLADE_KU,
        xi.weaponskill.MISTRAL_AXE,
        xi.weaponskill.DECIMATION,
        xi.weaponskill.CROSS_REAPER,
        xi.weaponskill.SPIRAL_HELL,
        xi.weaponskill.FULL_BREAK,
        xi.weaponskill.STEEL_CYCLONE,
        xi.weaponskill.TACHI_GEKKO,
        xi.weaponskill.TACHI_KASHA,
        xi.weaponskill.SPINNING_SLASH,
        xi.weaponskill.GROUND_STRIKE,
    },

    -- Blunt: 2200 - 0600
    {
        xi.weaponskill.SKULLBREAKER,
        xi.weaponskill.TRUE_STRIKE,
        xi.weaponskill.JUDGMENT,
        xi.weaponskill.HEXA_STRIKE,
        xi.weaponskill.BLACK_HALO,
        xi.weaponskill.RAGING_FISTS,
        xi.weaponskill.SPINNING_ATTACK,
        xi.weaponskill.HOWLING_FIST,
        xi.weaponskill.DRAGON_KICK,
        xi.weaponskill.ASURAN_FISTS,
        xi.weaponskill.HEAVY_SWING,
        xi.weaponskill.SHELL_CRUSHER,
        xi.weaponskill.FULL_SWING,
        xi.weaponskill.SPIRIT_TAKER,
        xi.weaponskill.RETRIBUTION,
    },
}

-- [ZoneID] = { Required Trades Event, Has Key Items Event, Missing Key Item Event }
local popEvents =
{
    [xi.zone.ABYSSEA_KONSCHTAT]        = { 1010, 1020, 1021 },
    [xi.zone.ABYSSEA_TAHRONGI]         = { 1010, 1020, 1021 },
    [xi.zone.ABYSSEA_LA_THEINE]        = { 1010, 1020, 1021 },
    [xi.zone.ABYSSEA_ATTOHWA]          = { 1010, 1022, 1023 },
    [xi.zone.ABYSSEA_MISAREAUX]        = { 1010, 1022, 1021 },
    [xi.zone.ABYSSEA_VUNKERL]          = { 1010, 1015, 1120 },
    [xi.zone.ABYSSEA_ALTEPA]           = { 1010, 1020, 1021 },
    [xi.zone.ABYSSEA_ULEGUERAND]       = { 1010, 1020, 1025 },
    [xi.zone.ABYSSEA_GRAUBERG]         = { 1010, 1020, 1021 },
    [xi.zone.ABYSSEA_EMPYREAL_PARADOX] = { 1010, 1020, 1021 },
}

-----------------------------------
-- public functions
-----------------------------------

xi.abyssea.visionsCruorProspectorOnTrigger = function(player, npc)
    local active = xi.extravaganza.campaignActive()
    local cipher = 0
    local cruor = player:getCurrency('cruor')
    local demilune = xi.abyssea.getDemiluneAbyssite(player)

    if
        active == xi.extravaganza.campaign.SUMMER_NY or
        active == xi.extravaganza.campaign.BOTH
    then
        cipher = 1
    end

    player:startEvent(2002, cruor, demilune, 0, 0, cipher)
end

xi.abyssea.visionsCruorProspectorOnEventFinish = function(player, csid, option, prospectorItems)
    local itemCategory = bit.band(option, 0x07)
    local itemSelected = bit.band(bit.rshift(option, 16), 0x1F)
    local cruorTotal = player:getCurrency('cruor')

    if itemCategory == itemType.ITEM then
        local itemData = prospectorItems[itemCategory][itemSelected]
        local itemQty = itemData[1] ~= xi.item.FORBIDDEN_KEY and 1 or bit.rshift(option, 24)
        local itemCost = itemData[2] * itemQty

        if
            itemCost <= cruorTotal and
            npcUtil.giveItem(player, { { itemData[1], itemQty } })
        then
            player:delCurrency('cruor', itemCost)
        end
    elseif itemCategory == itemType.TEMP then
        local itemData = prospectorItems[itemCategory][itemSelected]
        local itemCost = itemData[2]

        if
            itemCost <= cruorTotal and
            npcUtil.giveTempItem(player, { { itemData[1], 1 } })
        then
            player:delCurrency('cruor', itemCost)
        end
    elseif itemCategory == itemType.KEYITEM then
        local itemData = prospectorItems[itemCategory][itemSelected]

        if
            itemData[2] <= cruorTotal and
            npcUtil.giveKeyItem(player, itemData[1])
        then
            player:delCurrency('cruor', itemData[2])
        end
    elseif itemCategory == itemType.ENHANCEMENT then
        local enhanceData = prospectorItems[itemCategory][itemSelected]

        if enhanceData[2] <= cruorTotal then
            for _, v in ipairs(enhanceData[1]) do
                player:addStatusEffectEx(v[1], v[2], v[3] + xi.abyssea.getAbyssiteTotal(player, v[4]) * v[5], 0, 0)

                if v[1] == xi.effect.ABYSSEA_HP then
                    player:addHP(v[3] + xi.abyssea.getAbyssiteTotal(player, v[4]) * v[5])
                elseif v[1] == xi.effect.ABYSSEA_MP then
                    player:addMP(v[3] + xi.abyssea.getAbyssiteTotal(player, v[4]) * v[5])
                end
            end

            player:delCurrency('cruor', enhanceData[2])
        end
    end
end

-- returns Traverser Stone KI cap
xi.abyssea.getTraverserCap = function(player)
    local stones = 3

    for keyItem = xi.ki.VIRIDIAN_ABYSSITE_OF_AVARICE, xi.ki.VERMILLION_ABYSSITE_OF_AVARICE do
        if player:hasKeyItem(keyItem) then
            stones = stones + 1
        end
    end

    return stones
end

-- returns total Traverser Stone KI
-- (NOT the reserve value from currency menu)
xi.abyssea.getHeldTraverserStones = function(player)
    local stones = 0

    for keyItem = xi.ki.TRAVERSER_STONE1, xi.ki.TRAVERSER_STONE6 do
        if player:hasKeyItem(keyItem) then
            stones = stones + 1
        end
    end

    return stones
end

-- removes Traverser Stone KIs
xi.abyssea.spendTravStones = function(player, spentstones)
    local numRemoved = 0

    for keyItem = xi.ki.TRAVERSER_STONE6, xi.ki.TRAVERSER_STONE1, -1 do
        if numRemoved == spentstones then
            break
        elseif player:hasKeyItem(keyItem) then
            player:delKeyItem(keyItem)
            numRemoved = numRemoved + 1
        end
    end
end

-- returns total 'Abyssite of <thing>'
xi.abyssea.getAbyssiteTotal = function(player, enumVal)
    local kiCount = 0

    for keyItem = abyssiteKeyItems[enumVal][1], abyssiteKeyItems[enumVal][2] do
        if player:hasKeyItem(keyItem) then
            kiCount = kiCount + 1
        end
    end

    return kiCount
end

xi.abyssea.canGiveNMKI = function(mob, dropChance)
    local redProcValue = mob:getLocalVar('[AbysseaRedProc]')

    if math.random(1, 100) <= dropChance or redProcValue == 1 then
        return true
    end

    return false
end

xi.abyssea.giveNMDrops = function(mob, player, ID)
    if not xi.abyssea.mob[mob:getName()] then
        return
    end

    local atmaDrops = xi.abyssea.mob[mob:getName()]['Atma']
    local normalDrops = xi.abyssea.mob[mob:getName()]['Normal']
    local playerClaimed = GetPlayerByID(mob:getLocalVar('[ClaimedBy]'))

    for _, keyItemId in pairs(normalDrops) do
        if xi.abyssea.canGiveNMKI(mob, 20) then
            npcUtil.giveKeyItem(playerClaimed, keyItemId, ID.text.PLAYER_KEYITEM_OBTAINED)
        end
    end

    for _, keyItemId in pairs(atmaDrops) do
        local ally = playerClaimed:getAlliance()

        for _, member in ipairs(ally) do
            if not member:hasKeyItem(keyItemId) and xi.abyssea.canGiveNMKI(mob, 10) then
                npcUtil.giveKeyItem(member, keyItemId, ID.text.PLAYER_KEYITEM_OBTAINED)
            end
        end

        if not playerClaimed:hasKeyItem(keyItemId) then
            npcUtil.giveKeyItem(playerClaimed, keyItemId, ID.text.PLAYER_KEYITEM_OBTAINED)
        end
    end

    -- TODO: Handle increased droprate with Yellow and Blue procs
end

-- Returns Bitmask of Demulune KeyItems
xi.abyssea.getDemiluneAbyssite = function(player)
    local demiluneMask = 0

    for k, keyItem in ipairs(demiluneKeyItems) do
        if player:hasKeyItem(keyItem) then
            demiluneMask = demiluneMask + bit.lshift(1, k - 1)
        end
    end

    return demiluneMask
end

xi.abyssea.getNewYellowWeakness = function(mob)
    local day = VanadielDayOfTheWeek()
    local weakness = math.random(day - 1, day + 1)

    if weakness < 0 then
        weakness = 7
    elseif weakness > 7 then
        weakness = 0
    end

    local element = xi.magic.dayElement[weakness]
    return yellowWeakness[element][math.random(#yellowWeakness[element])]
end

xi.abyssea.getNewRedWeakness = function(mob)
    return redWeakness[math.random(#redWeakness)]
end

xi.abyssea.getNewBlueWeakness = function(mob)
    local time = VanadielHour()
    local table = 3

    if time >= 6 and time < 14 then
        table = 1
    elseif time >= 14 and time < 22 then
        table = 2
    end

    return blueWeakness[table][math.random(#blueWeakness[table])]
end

xi.abyssea.procMonster = function(mob, player, triggerType)
    if player and player:getAllegiance() == 1 then
        local master = player:getMaster()

        if master then
            player = master
        end

        if triggerType == xi.abyssea.triggerType.RED then
            if mob:getLocalVar('[AbysseaRedProc]') == 0 then
                mob:setLocalVar('[AbysseaRedProc]', 1)
            else
                mob:setLocalVar('[AbysseaRedProc]', 0)
            end

            mob:weaknessTrigger(2)
            mob:addStatusEffect(xi.effect.TERROR, 0, 0, 30)
        elseif triggerType == xi.abyssea.triggerType.YELLOW then
            if mob:getLocalVar('[AbysseaYellowProc]') == 0 then
                mob:setLocalVar('[AbysseaYellowProc]', 1)
            else
                mob:setLocalVar('[AbysseaYellowProc]', 0)
            end

            mob:weaknessTrigger(1)
            mob:addStatusEffect(xi.effect.TERROR, 0, 0, 30)
        elseif triggerType == xi.abyssea.triggerType.BLUE then
            if mob:getLocalVar('[AbysseaBlueProc]') == 0 then
                mob:setLocalVar('[AbysseaBlueProc]', 1)
            else
                mob:setLocalVar('[AbysseaBlueProc]', 0)
            end

            mob:weaknessTrigger(0)
            mob:addStatusEffect(xi.effect.TERROR, 0, 0, 30)
        end
    end
end

-- trade to QM to pop mob
xi.abyssea.qmOnTrade = function(player, npc, trade, mobId, reqTrade)
    -- validate QM pop data
    -- local zoneId = player:getZoneID()
    -- validate trade-to-pop
    if #reqTrade == 0 or trade:getItemCount() ~= #reqTrade then
        return false
    end

    -- validate traded items
    for k, v in pairs(reqTrade) do
        if not trade:hasItemQty(v, 1) then
            return false
        end
    end

    if GetMobByID(mobId):isSpawned() then
        return false
    end

    -- complete trade and pop nm
    player:tradeComplete()
    local dx = player:getXPos() + math.random(-1, 1)
    local dy = player:getYPos()
    local dz = player:getZPos() + math.random(-1, 1)
    GetMobByID(mobId):setSpawn(dx, dy, dz)

    SpawnMob(mobId):updateClaim(player)
    GetMobByID(mobId):setLocalVar('[ClaimedBy]', player:getID())

    return true
end

local checkMobID = function(zoneId, mobId)
    for i, v in pairs(zones[zoneId].mob) do
        if v == mobId then
            return true
        end
    end

    return false
end

xi.abyssea.qmOnTrigger = function(player, npc, mobId, kis, tradeReqs)
    -- validate QM pop data
    local zoneId = player:getZoneID()
    local events = popEvents[zoneId]

    if mobId == 0 then
        -- validate trade-to-pop
        local t = tradeReqs
        if #t > 0 then
            for i = 1, 8 do
                if not t[i] then
                    t[i] = 0
                end
            end

            player:startEvent(events[1], t[1], t[2], t[3], t[4], t[5], t[6], t[7], t[8]) -- report required trades
            return true
        end
    end

    -- validate nm status
    if GetMobByID(mobId):isSpawned() then
        return false
    end

    if #kis == 0 then
        return false
    end

    -- validate kis
    local validKis = true
    local kisExpected = {}

    for index = 1, 8 do
        local keyItem = kis[index] or 0

        if keyItem ~= 0 and not player:hasKeyItem(keyItem) then
            validKis = false
        end

        player:setLocalVar('KI' .. index, keyItem)
        kisExpected[index] = keyItem
    end

    local pop = checkMobID(zoneId, mobId)
    player:setLocalVar('[AbysseaPopNmID]', mobId)
    -- start event
    if validKis and pop then
        player:startEvent(events[2], kisExpected[1], kisExpected[2], kisExpected[3], kisExpected[4], kisExpected[5], kisExpected[6], kisExpected[7], kisExpected[8]) -- player has all key items
        return true
    else
        player:startEvent(events[3], kisExpected[1], kisExpected[2], kisExpected[3], kisExpected[4], kisExpected[5], kisExpected[6], kisExpected[7], kisExpected[8]) -- player is missing key items
        return false
    end
end

xi.abyssea.qmOnEventUpdate = function(player, csid, option, npc)
    return false
end

xi.abyssea.qmOnEventFinish = function(player, csid, option, npc)
    local zoneId = player:getZoneID()
    local events = popEvents[zoneId]
    local ID = zones[player:getZoneID()]

    if csid == events[2] and option == 1 then

        for i = 1, 8 do
            local keyItem = player:getLocalVar('KI' .. i)
            if keyItem == 0 then
                break
            end

            if player:hasKeyItem(keyItem) then
                player:delKeyItem(keyItem)
                player:messageSpecial(ID.text.LOST_KEYITEM, keyItem)
            end
        end

        -- pop nm
        local nm = player:getLocalVar('[AbysseaPopNmID]')
        local dx = player:getXPos() + math.random(-1, 1)
        local dy = player:getYPos()
        local dz = player:getZPos() + math.random(-1, 1)

        GetMobByID(nm):setSpawn(dx, dy, dz)
        SpawnMob(nm):updateClaim(player)
        GetMobByID(nm):setLocalVar('[ClaimedBy]', player:getID())

        return true
    end
end

xi.abyssea.isInAbysseaZone = function(player)
    return player:getCurrentRegion() == xi.region.ABYSSEA
end

-----------------------------------
-- Light Handling
-----------------------------------
xi.abyssea.getLightsTable = function(player)
    local lightMaskFirst  = player:getCharVar('abysseaLights1')
    local lightMaskSecond = player:getCharVar('abysseaLights2')
    local lightValues = { 0, 0, 0, 0, 0, 0, 0 }

    for v = 1, 7 do
        if v <= 4 then
            lightValues[v] = bit.band(bit.rshift(lightMaskFirst, (v - 1) * 8), 0xFF)
        else
            lightValues[v] = bit.band(bit.rshift(lightMaskSecond, (v - 5) * 8), 0xFF)
        end
    end

    return lightValues
end

local function setLightsFromTable(player, lightTable)
    local lightMaskFirst  = 0
    local lightMaskSecond = 0

    for k = 1, 7 do
        if k <= 4 then
            lightMaskFirst = lightMaskFirst + bit.lshift(lightTable[k], (k - 1) * 8)
        else
            lightMaskSecond = lightMaskSecond + bit.lshift(lightTable[k], (k - 1) * 8)
        end
    end

    player:setCharVar('abysseaLights1', lightMaskFirst)
    player:setCharVar('abysseaLights2', lightMaskSecond)
end

xi.abyssea.displayAbysseaLights = function(player)
    if xi.abyssea.isInAbysseaZone(player) then
        local ID = zones[player:getZoneID()]
        local lightValues = xi.abyssea.getLightsTable(player)

        player:messageName(ID.text.LIGHTS_MESSAGE_1, nil,
            lightValues[xi.abyssea.lightType.PEARL],
            lightValues[xi.abyssea.lightType.EBON],
            lightValues[xi.abyssea.lightType.GOLDEN],
            lightValues[xi.abyssea.lightType.SILVERY])

        player:messageName(ID.text.LIGHTS_MESSAGE_2, nil,
            lightValues[xi.abyssea.lightType.AZURE],
            lightValues[xi.abyssea.lightType.RUBY],
            lightValues[xi.abyssea.lightType.AMBER])
    end
end

xi.abyssea.resetPlayerLights = function(player)
    player:setCharVar('abysseaLights1', 0)
    player:setCharVar('abysseaLights2', 0)
end

xi.abyssea.setBonusLights = function(player)
    local lightTable = {}

    for _, v in ipairs(xi.abyssea.lightType) do
        lightTable[v] = xi.settings.main.ABYSSEA_BONUSLIGHT_AMOUNT
    end

    setLightsFromTable(player, lightTable)
end

xi.abyssea.addPlayerLights = function(player, light, amount)
    local zoneId = player:getZoneID()
    local ID = zones[zoneId]
    local tierMsg = 0
    local lightAmount = amount or 0

    if lightAmount <= 8 then
        tierMsg = 0
    elseif lightAmount <= 16 then
        tierMsg = 1
    elseif lightAmount <= 32 then
        tierMsg = 2
    elseif lightAmount <= 64 then
        tierMsg = 3
    else
        tierMsg = 4
    end

    if tierMsg > lightData[light][2] then
        tierMsg = lightData[light][2]
    end

    local lightTable = xi.abyssea.getLightsTable(player)
    lightTable[light] = utils.clamp(lightTable[light] + lightAmount, 0, lightData[light][1])
    player:messageSpecial(ID.text.BODY_EMITS_OFFSET + (light - 1), tierMsg)
    setLightsFromTable(player, lightTable)
end

xi.abyssea.getLightValue = function(player, light)
    return bit.band(bit.rshift(player:getCharVar('abysseaLights'), (light - 1) * 2), 0xFF)
end

xi.abyssea.canEnterAbyssea = function(player)
    -- TODO
    return true
end

xi.abyssea.displayTimeRemaining = function(player)
    local ID = zones[player:getZoneID()]
    local visitantEffect = player:getStatusEffect(xi.effect.VISITANT)
    local secondsRemaining = visitantEffect:getTimeRemaining() / 1000

    if secondsRemaining >= 120 then
        player:messageSpecial(ID.text.ABYSSEA_TIME_OFFSET + 1, secondsRemaining / 60, 1)
    elseif secondsRemaining >= 60 then
        player:messageSpecial(ID.text.ABYSSEA_TIME_OFFSET, secondsRemaining / 60, 1)
    else
        player:messageSpecial(ID.text.ABYSSEA_TIME_OFFSET + 1, secondsRemaining, 0)
    end
end

-----------------------------------
-- Zone Global Functions
-----------------------------------
xi.abyssea.onZoneIn = function(player)
    -- If the player is a GM, and has GM toggled active, give them permanent visitant
    -- status.  TODO: nameFlags enum
    if player:getGMLevel() > 0 and player:checkNameFlags(0x04000000) then
        player:addStatusEffectEx(xi.effect.VISITANT, xi.effect.VISITANT, 0, 0, 0)
    end
end

xi.abyssea.onEventFinish = function(player, csid, option, npc)
    if csid == 2180 then
        local zoneID = player:getZoneID()
        player:setPos(unpack(xi.abyssea.exitPositions[zoneID]))
    end
end

xi.abyssea.afterZoneIn = function(player)
    local zoneID = player:getZoneID()
    local ID = zones[zoneID]

    -- Add 5 minutes of hidden time to get 'real' visitant status.  The additional 4 seconds
    -- is intentional due to tick variances (up to 3s), and the status will be deleted should
    -- the countdown timer for visitant status reach 0 before actually running out of time on
    -- the effect.
    if not player:hasStatusEffect(xi.effect.VISITANT) then
        player:addStatusEffectEx(xi.effect.VISITANT, 0, 0, 3, 304)
    end

    local visitantEffect = player:getStatusEffect(xi.effect.VISITANT)
    if visitantEffect and visitantEffect:getIcon() == 0 then
        player:messageName(ID.text.ABYSSEA_TIME_OFFSET + 5, nil, 5)
    end
end

-----------------------------------
-- Searing Ward Functions
-----------------------------------
local searingWardTetherLocations =
{
    [xi.zone.ABYSSEA_KONSCHTAT]  = {  114, -72.39, -808, 160 },
    [xi.zone.ABYSSEA_TAHRONGI]   = {    0,     40, -676, 192 },
    [xi.zone.ABYSSEA_LA_THEINE]  = { -480,      0,  760,  64 },
    [xi.zone.ABYSSEA_ATTOHWA]    = { -140,     20, -162, 192 },
    [xi.zone.ABYSSEA_MISAREAUX]  = {  608,  -15.8,  280, 128 },
    [xi.zone.ABYSSEA_VUNKERL]    = { -324,  -38.8,  664,   0 },
    [xi.zone.ABYSSEA_ALTEPA]     = {  396,      0,  276,  64 },
    [xi.zone.ABYSSEA_ULEGUERAND] = { -180,    -40, -504, 192 },
    [xi.zone.ABYSSEA_GRAUBERG]   = { -506,     25, -764,   0 },
}

xi.abyssea.searingWardTimer = function(player)
    local zoneID = player:getZoneID()
    local ID = zones[zoneID]
    local tetherTimer = player:getLocalVar('tetherTimer')

    if tetherTimer > 1 then
        if tetherTimer == 11 or tetherTimer <= 6 then
            player:messageSpecial(ID.text.RETURNING_TO_SEARING_IN, tetherTimer - 1)
        end

        player:setLocalVar('tetherTimer', tetherTimer - 1)
        player:timer(1500, function()
            xi.abyssea.searingWardTimer(player)
        end)
    elseif tetherTimer == 1 then
        player:setLocalVar('tetherTimer', 0)
        player:messageSpecial(ID.text.RETURNING_TO_WARD)
        player:setPos(unpack(searingWardTetherLocations[zoneID]))
    end
end

xi.abyssea.onWardTriggerAreaLeave = function(player)
    local ID = zones[player:getZoneID()]
    local visitantEffect = player:getStatusEffect(xi.effect.VISITANT)

    if visitantEffect and visitantEffect:getIcon() == 0 then
        player:messageName(ID.text.NO_VISITANT_WARD, nil, 10)
        player:setLocalVar('tetherTimer', 11)
    end
end

xi.abyssea.onWardTriggerAreaEnter = function(player)
    player:setLocalVar('tetherTimer', 0)
end

-----------------------------------
-- Support NPC Functions
-- Traverser Stone, Abyssea Warp
-----------------------------------
local supportNPCData =
{
--                           Traverser,  Warp
    [xi.zone.HEAVENS_TOWER]  = {   434,   433 },
    [xi.zone.RULUDE_GARDENS] = { 10186, 10185 },
    [xi.zone.PORT_BASTOK]    = {   405,   404 },
    [xi.zone.PORT_JEUNO]     = {   328,   339 },
    [xi.zone.PORT_SAN_DORIA] = {   796,   795 },
    [xi.zone.PORT_WINDURST]  = {   874,   873 },
}

-- TODO: Combine this into one table with teleportData
local abysseaMawQuests =
{
    [0] = xi.quest.id.abyssea.A_GOLDSTRUCK_GIGAS,
    [1] = xi.quest.id.abyssea.TO_PASTE_A_PEISTE,
    [2] = xi.quest.id.abyssea.MEGADRILE_MENACE,
    [3] = xi.quest.id.abyssea.THE_BEAST_OF_BASTORE,
    [4] = xi.quest.id.abyssea.A_DELECTABLE_DEMON,
    [5] = xi.quest.id.abyssea.A_FLUTTERY_FIEND,
    [6] = xi.quest.id.abyssea.A_BEAKED_BLUSTERER,
    [7] = xi.quest.id.abyssea.A_MAN_EATING_MITE,
    [8] = xi.quest.id.abyssea.AN_ULCEROUS_URAGNITE,
}

local teleportData =
{
    { -562,   0,  640,  26, 102 }, -- La Theine Plateau
    {   91, -68, -582, 237, 108 }, -- Konschtat Highlands
    {  -28,  46, -680,  76, 117 }, -- Tahrongi Canyon
    {  241,   0,   11,  42, 104 }, -- Jugner Forest (Vunkerl)
    {  362,   0, -119,   4, 103 }, -- Valkurm Dunes (Misareaux)
    { -338, -23,   47, 167, 118 }, -- Buburimu Peninsula (Attohwa)
    {  337,   0, -675,  52, 107 }, -- South Gustaberg (Altepa)
    {  269,  -7,  -75, 192, 112 }, -- Xarcabard (Uleguerand)
    {  -71,   0,  601, 126, 106 }, -- North Gustaberg (Grauberg)
}

local function getUnlockedMawTable(player)
    local unlockedMawTable = { 0, 0, 0 }

    for mawIndex = 0, 8 do
        if player:getQuestStatus(xi.quest.log_id.ABYSSEA, abysseaMawQuests[mawIndex]) >= QUEST_ACCEPTED then
            local tableKey = math.floor(mawIndex / 3) + 1

            unlockedMawTable[tableKey] = utils.mask.setBit(unlockedMawTable[tableKey], mawIndex % 3, 1)
        end
    end

    return unlockedMawTable
end

xi.abyssea.warpNPCOnTrigger = function(player, npc)
    local totalCruor = player:getCurrency('cruor')
    local unlockedMaws = getUnlockedMawTable(player)
    local statusParam = player:hasCompletedQuest(xi.quest.log_id.ABYSSEA, xi.quest.id.abyssea.THE_TRUTH_BECKONS) and 2 or 0

    player:startEvent(supportNPCData[player:getZoneID()][2], statusParam, totalCruor, unlockedMaws[1], unlockedMaws[2], unlockedMaws[3])
end

xi.abyssea.warpNPCOnEventUpdate = function(player, csid, option, npc)
end

xi.abyssea.warpNPCOnEventFinish = function(player, csid, option, npc)
    local teleportSelection = bit.band(bit.rshift(option, 2), 0xF)

    -- Bit 8 is set for all teleport selections
    if
        utils.mask.getBit(option, 8) and
        player:getCurrency('cruor') >= 200
    then
        player:delCurrency('cruor', 200)
        player:setPos(unpack(teleportData[teleportSelection]))
    end
end

xi.abyssea.traverserNPCOnTrigger = function(player, npc)
    local zoneID = player:getZoneID()
    local ID = zones[zoneID]
    local availableStones = player:getAvailableTraverserStones()
    local numTraverserHeld = xi.abyssea.getHeldTraverserStones(player)
    local maxTraverserCanHold = xi.abyssea.getTraverserCap(player)
    local messageType = availableStones > 0 and 0 or 2

    -- messageType parameter determines what is displayed to the player depending
    -- on other values: 0 = Eligible for Stone, 1 = Holding maximum stones, and
    -- 2 = No stones available

    if numTraverserHeld >= maxTraverserCanHold then
        messageType = 1
    end

    if
        zoneID ~= xi.zone.PORT_JEUNO and
        not player:hasCompletedQuest(xi.quest.log_id.ABYSSEA, xi.quest.id.abyssea.THE_TRUTH_BECKONS)
    then
        player:messageText(npc, ID.text.NOT_ACQUAINTED)
    elseif player:getQuestStatus(xi.quest.log_id.ABYSSEA, xi.quest.id.abyssea.DAWN_OF_DEATH) >= QUEST_ACCEPTED then
        player:startEvent(supportNPCData[zoneID][1], 0, availableStones, numTraverserHeld, messageType, 1, 1, 1, 3) -- Post 'The Truth Beckons' Menu
    end
end

xi.abyssea.traverserNPCOnUpdate = function(player, csid, option, npc)
    if csid == supportNPCData[player:getZoneID()][1] then
        if option == 3 then
            -- The following values calculates the amount of time remaining for a stone by working backwards from current time.
            -- Recharge interval is the adjusted value in hours, and remaining is in seconds initially.  Retail will display
            -- the result as a minute value to the player.

            local rechargeInterval = 20 - xi.abyssea.getAbyssiteTotal(player, xi.abyssea.abyssiteType.CELERITY)
            local lastStoneClaimedTime = os.time() - player:getTraverserEpoch() - rechargeInterval * 3600 * player:getClaimedTraverserStones()
            local rechargeRemaining = rechargeInterval * 60 - lastStoneClaimedTime / 60

            player:updateEvent(0, 0, 0, 0, rechargeRemaining)
        end
    end
end

xi.abyssea.traverserNPCOnEventFinish = function(player, csid, option, npc)
    local zoneID = player:getZoneID()

    if
        csid == supportNPCData[zoneID][1] and
        option == 6
    then
        local ID = zones[zoneID]
        local availableStones = player:getAvailableTraverserStones()
        local numTraverserHeld = xi.abyssea.getHeldTraverserStones(player)
        local requestedStones = xi.abyssea.getTraverserCap(player) - numTraverserHeld

        -- Make sure we don't hand out stones if the player doesn't have them in reserve
        if requestedStones > availableStones then
            requestedStones = availableStones
        end

        player:addClaimedTraverserStones(requestedStones)

        local startKeyItem = xi.ki.TRAVERSER_STONE1 + numTraverserHeld - 1
        for keyItem = startKeyItem, startKeyItem + requestedStones do
            player:addKeyItem(keyItem)
        end

        local kiMessage = requestedStones > 1 and ID.text.OBTAINED_NUM_KEYITEMS or ID.text.OBTAINED_NUM_KEYITEMS + 1
        player:messageSpecial(kiMessage, xi.ki.TRAVERSER_STONE1, requestedStones)
    end
end

local zoneQuestReward =
{
    xi.ki.LUNAR_ABYSSITE2,
    xi.ki.IVORY_ABYSSITE_OF_FORTUNE,
    xi.ki.IVORY_ABYSSITE_OF_ACUMEN,
    xi.ki.IVORY_ABYSSITE_OF_THE_REAPER,
    xi.ki.IVORY_ABYSSITE_OF_PERSPICACITY,
    xi.ki.IVORY_ABYSSITE_OF_GUERDON,
    xi.ki.LUNAR_ABYSSITE3,
    xi.ki.IVORY_ABYSSITE_OF_PROSPERITY,
    xi.ki.IVORY_ABYSSITE_OF_DESTINY,
}

xi.abyssea.getZoneKIReward = function(player)
    local numCompleted = 0

    for i = 0, 8 do
        if player:hasCompletedQuest(xi.quest.log_id.ABYSSEA, abysseaMawQuests[i]) then
            numCompleted = numCompleted + 1
        end
    end

    return zoneQuestReward[numCompleted + 1]
end
