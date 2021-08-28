-----------------------------------
-- Abyssea Global
-----------------------------------
require("scripts/globals/spell_data")
require("scripts/globals/keyitems")
require("scripts/globals/utils")
require("scripts/globals/quests")
require("scripts/globals/weaponskillids")
require("scripts/globals/zone")
-----------------------------------
xi = xi or {}
xi.abyssea = xi.abyssea or {}

-- Abyssea Maw bit locations for char_unlocks column 'abyssea_maws'.  This
-- is used by the teleporter NPCs, and is unpacked into 3 values of 0..7 to allow
-- teleport to the maw (sorted by expansion).
xi.abyssea.maws =
{
    [xi.zone.ABYSSEA_LA_THEINE ] = 0,
    [xi.zone.ABYSSEA_KONSCHTAT ] = 1,
    [xi.zone.ABYSSEA_TAHRONGI  ] = 2,
    [xi.zone.ABYSSEA_VUNKERL   ] = 3,
    [xi.zone.ABYSSEA_MISAREAUX ] = 4,
    [xi.zone.ABYSSEA_ATTOHWA   ] = 5,
    [xi.zone.ABYSSEA_ALTEPA    ] = 6,
    [xi.zone.ABYSSEA_ULEGUERAND] = 7,
    [xi.zone.ABYSSEA_GRAUBERG  ] = 8,
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
{-- Light Type                         Cap  Maximum Tier
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

-- Sequential Abyssite Key Items.
-- NOTE: Demilune is not sequential, and handled in a separate table
local abyssiteKeyItems =
{--  Type                                      Beginning KI                            Ending KI
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

-- TODO: Separate by zone
xi.abyssea.mob =
{
    -- Attohwa Chasm
	[17658287] = {['Atma'] = {                                          }, ['Normal'] = { xi.keyItem.SHRIVELED_HECTEYES_STALK   }},
	[17658269] = {['Atma'] = { xi.keyItem.ATMA_OF_THE_GLUTINOUS_OOZE    }, ['Normal'] = {                                       }},
	[17658262] = {['Atma'] = {                                          }, ['Normal'] = { xi.keyItem.BULBOUS_CRAWLER_COCOON     }},
	[17658266] = {['Atma'] = {                                          }, ['Normal'] = { xi.keyItem.WRITHING_GHOST_FINGER      }},
	[17658288] = {['Atma'] = {                                          }, ['Normal'] = { xi.keyItem.RUSTED_HOUND_COLLAR        }},
	[17658264] = {['Atma'] = {                                          }, ['Normal'] = { xi.keyItem.BLOTCHED_DOOMED_TONGUE     }},
	[17658261] = {['Atma'] = {                                          }, ['Normal'] = { xi.keyItem.VENOMOUS_WAMOURA_FEELER    }},
	[17658277] = {['Atma'] = { xi.keyItem.ATMA_OF_THE_CLAWED_BUTTERFLY  }, ['Normal'] = {                                       }},
	[17658281] = {['Atma'] = { xi.keyItem.ATMA_OF_THE_CLAWED_BUTTERFLY  }, ['Normal'] = {                                       }},
	[17658285] = {['Atma'] = { xi.keyItem.ATMA_OF_THE_CLAWED_BUTTERFLY  }, ['Normal'] = {                                       }},
	[17658268] = {['Atma'] = { xi.keyItem.ATMA_OF_THE_GOLDEN_CLAW       }, ['Normal'] = {                                       }},
	[17658265] = {['Atma'] = {                                          }, ['Normal'] = { xi.keyItem.CRACKED_SKELETON_CLAVICLE  }},
	[17658270] = {['Atma'] = { xi.keyItem.ATMA_OF_THE_LIGHTNING_BEAST   }, ['Normal'] = {                                       }},
	[17658273] = {['Atma'] = {                                          }, ['Normal'] = { xi.keyItem.JADE_ABYSSITE_OF_SOJOURN   }},
	[17658271] = {['Atma'] = { xi.keyItem.ATMA_OF_THE_NOXIOUS_BLOOM     }, ['Normal'] = {                                       }},
	[17658263] = {['Atma'] = {                                          }, ['Normal'] = { xi.keyItem.MUCID_WORM_SEGMENT         }},
	[17658274] = {['Atma'] = { xi.keyItem.ATMA_OF_THE_SMOLDERING_SKY    }, ['Normal'] = {                                       }},
	[17658278] = {['Atma'] = { xi.keyItem.ATMA_OF_THE_SMOLDERING_SKY    }, ['Normal'] = {                                       }},
	[17658282] = {['Atma'] = { xi.keyItem.ATMA_OF_THE_SMOLDERING_SKY    }, ['Normal'] = {                                       }},
	[17658267] = {['Atma'] = {                                          }, ['Normal'] = { xi.keyItem.HOLLOW_DRAGON_EYE          }},
	[17658275] = {['Atma'] = { xi.keyItem.ATMA_OF_UNDYING               }, ['Normal'] = {                                       }},
	[17658279] = {['Atma'] = { xi.keyItem.ATMA_OF_UNDYING               }, ['Normal'] = {                                       }},
	[17658283] = {['Atma'] = { xi.keyItem.ATMA_OF_UNDYING               }, ['Normal'] = {                                       }},
	[17658286] = {['Atma'] = {                                          }, ['Normal'] = { xi.keyItem.DISTENDED_CHIGOE_ABDOMEN   }},
	[17658276] = {['Atma'] = {                                          }, ['Normal'] = { xi.keyItem.JADE_ABYSSITE_OF_MERIT     }},
	[17658280] = {['Atma'] = {                                          }, ['Normal'] = { xi.keyItem.JADE_ABYSSITE_OF_MERIT     }},
	[17658284] = {['Atma'] = {                                          }, ['Normal'] = { xi.keyItem.JADE_ABYSSITE_OF_MERIT     }},
	[17658272] = {['Atma'] = {                                          }, ['Normal'] = { xi.keyItem.JADE_ABYSSITE_OF_EXPERTISE }},
	[17658292] = {['Atma'] = { xi.keyItem.ATMA_OF_THE_IMPREGNABLE_TOWER }, ['Normal'] = {                                       }},

    -- Konschtat Highlands
	[16838751] = {['Atma'] = {                                         }, ['Normal'] = { xi.keyItem.FRAGRANT_TREANT_PETAL      }},
	[16838855] = {['Atma'] = { xi.keyItem.ATMA_OF_THRASHING_TENDRILS   }, ['Normal'] = { xi.keyItem.FETID_RAFFLESIA_STALK      }},
	[16838946] = {['Atma'] = {                                         }, ['Normal'] = { xi.keyItem.DECAYING_MORBOL_TOOTH      }},
	[16838913] = {['Atma'] = { xi.keyItem.ATMA_OF_VICISSITUDE          }, ['Normal'] = { xi.keyItem.TURBID_SLIME_OIL           }},
	[16838872] = {['Atma'] = { xi.keyItem.ATMA_OF_THE_NOXIOUS_FANG     }, ['Normal'] = { xi.keyItem.VENOMOUS_PEISTE_CLAW       }},
	[16839070] = {['Atma'] = { xi.keyItem.ATMA_OF_THE_NOXIOUS_FANG     }, ['Normal'] = { xi.keyItem.VENOMOUS_PEISTE_CLAW       }},
	[16839073] = {['Atma'] = { xi.keyItem.ATMA_OF_THE_NOXIOUS_FANG     }, ['Normal'] = { xi.keyItem.VENOMOUS_PEISTE_CLAW       }},
	[16839067] = {['Atma'] = {                                         }, ['Normal'] = { xi.keyItem.TWISTED_TONBERRY_CROWN     }},
	[16838979] = {['Atma'] = { xi.keyItem.ATMA_OF_GALES                }, ['Normal'] = { xi.keyItem.TATTERED_HIPPOGRYPH_WING   }},
	[16838871] = {['Atma'] = {                                         }, ['Normal'] = { xi.keyItem.CRACKED_WIVRE_HORN         }},
	[16838993] = {['Atma'] = {                                         }, ['Normal'] = { xi.keyItem.MUCID_AHRIMAN_EYEBALL      }},
	[16839006] = {['Atma'] = { xi.keyItem.ATMA_OF_STORMBREATH          }, ['Normal'] = {                                       }},
	[16839068] = {['Atma'] = { xi.keyItem.ATMA_OF_CLOAK_AND_DAGGER     }, ['Normal'] = {                                       }},
	[16839071] = {['Atma'] = { xi.keyItem.ATMA_OF_CLOAK_AND_DAGGER     }, ['Normal'] = {                                       }},
	[16839074] = {['Atma'] = { xi.keyItem.ATMA_OF_CLOAK_AND_DAGGER     }, ['Normal'] = {                                       }},
	[16839007] = {['Atma'] = { xi.keyItem.ATMA_OF_THE_VORACIOUS_VIOLET }, ['Normal'] = {                                       }},
	[16839069] = {['Atma'] = { xi.keyItem.ATMA_OF_THE_VORACIOUS_VIOLET }, ['Normal'] = {                                       }},
	[16839072] = {['Atma'] = { xi.keyItem.ATMA_OF_THE_VORACIOUS_VIOLET }, ['Normal'] = {                                       }},
	[16839033] = {['Atma'] = { xi.keyItem.AZURE_ABYSSITE_OF_THE_REAPER }, ['Normal'] = {                                       }},
	[16838820] = {['Atma'] = { xi.keyItem.ATMA_OF_THE_DRIFTER          }, ['Normal'] = {                                       }},
	[16838674] = {['Atma'] = { xi.keyItem.AZURE_ABYSSITE_OF_LENITY     }, ['Normal'] = {                                       }},
	[16838675] = {['Atma'] = { xi.keyItem.AZURE_ABYSSITE_OF_LENITY     }, ['Normal'] = {                                       }},
	[16838676] = {['Atma'] = { xi.keyItem.AZURE_ABYSSITE_OF_LENITY     }, ['Normal'] = {                                       }},
	[16838677] = {['Atma'] = { xi.keyItem.AZURE_ABYSSITE_OF_LENITY     }, ['Normal'] = {                                       }},
	[16838678] = {['Atma'] = { xi.keyItem.AZURE_ABYSSITE_OF_LENITY     }, ['Normal'] = {                                       }},
	[16838668] = {['Atma'] = { xi.keyItem.ATMA_OF_THE_STORMBIRD        }, ['Normal'] = {                                       }},

	--La Thiene Plateau
	[17318435] = {['Atma'] = {                                                                        }, ['Normal'] = { xi.keyItem.MARBLED_MUTTON_CHOP        }},
	[17318436] = {['Atma'] = { xi.keyItem.ATMA_OF_THE_SAVAGE_TIGER                                    }, ['Normal'] = { xi.keyItem.BLOODIED_SABER_TOOTH       }},
	[17318446] = {['Atma'] = { xi.keyItem.ATMA_OF_THE_STOUT_ARM                                       }, ['Normal'] = { xi.keyItem.BLOOD_SMEARED_GIGAS_HELM   }},
	[17318456] = {['Atma'] = { xi.keyItem.ATMA_OF_THE_STOUT_ARM                                       }, ['Normal'] = { xi.keyItem.BLOOD_SMEARED_GIGAS_HELM   }},
	[17318459] = {['Atma'] = { xi.keyItem.ATMA_OF_THE_STOUT_ARM                                       }, ['Normal'] = { xi.keyItem.BLOOD_SMEARED_GIGAS_HELM   }},
	[17318440] = {['Atma'] = {                                                                        }, ['Normal'] = { xi.keyItem.PELLUCID_FLY_EYE           }},
	[17318441] = {['Atma'] = {                                                                        }, ['Normal'] = { xi.keyItem.SHIMMERING_PIXIE_PINION    }},
	[17318438] = {['Atma'] = {                                                                        }, ['Normal'] = { xi.keyItem.WARPED_GIGAS_ARMBAND       }},
	[17318439] = {['Atma'] = {                                                                        }, ['Normal'] = { xi.keyItem.SEVERED_GIGAS_COLLAR       }},
	[17318437] = {['Atma'] = {                                                                        }, ['Normal'] = { xi.keyItem.DENTED_GIGAS_SHIELD        }},
	[17318447] = {['Atma'] = { xi.keyItem.ATMA_OF_ALLURE                                              }, ['Normal'] = { xi.keyItem.GLITTERING_PIXIE_CHOKER    }},
	[17318457] = {['Atma'] = { xi.keyItem.ATMA_OF_ALLURE                                              }, ['Normal'] = { xi.keyItem.GLITTERING_PIXIE_CHOKER    }},
	[17318460] = {['Atma'] = { xi.keyItem.ATMA_OF_ALLURE                                              }, ['Normal'] = { xi.keyItem.GLITTERING_PIXIE_CHOKER    }},
	[17318451] = {['Atma'] = { xi.keyItem.SCARLET_ABYSSITE_OF_PERSPICACITY                            }, ['Normal'] = {                                       }},
	[17318434] = {['Atma'] = { xi.keyItem.ATMA_OF_THE_EBON_HOOF                                       }, ['Normal'] = {                                       }},
	[17318448] = {['Atma'] = { xi.keyItem.ATMA_OF_THE_LION                                            }, ['Normal'] = {                                       }},
	[17318458] = {['Atma'] = { xi.keyItem.ATMA_OF_THE_LION                                            }, ['Normal'] = {                                       }},
	[17318461] = {['Atma'] = { xi.keyItem.ATMA_OF_THE_LION                                            }, ['Normal'] = {                                       }},
	[17317898] = {['Atma'] = { xi.keyItem.ATMA_OF_THE_TWIN_CLAW                                       }, ['Normal'] = {                                       }},
	[17318445] = {['Atma'] = { xi.keyItem.ATMA_OF_THE_BAYING_MOON                                     }, ['Normal'] = {                                       }},
	[17318449] = {['Atma'] = { xi.keyItem.SCARLET_ABYSSITE_OF_LENITY                                  }, ['Normal'] = {                                       }},
	[17318450] = {['Atma'] = { xi.keyItem.ATMA_OF_TREMORS                                             }, ['Normal'] = {                                       }},
	[17318455] = {['Atma'] = { xi.keyItem.ATMA_OF_THE_HEAVENS, xi.keyItem.SCARLET_ABYSSITE_OF_SOJOURN }, ['Normal'] = {                                       }},

    -- Misareaux Coast
	[17662494] = {['Atma'] = {                                         }, ['Normal']= { xi.keyItem.BLAZING_CLUSTER_SOUL             }},
	[17662477] = {['Atma'] = { xi.keyItem.ATMA_OF_THE_STRANGLING_WIND  }, ['Normal']= {                                             }},
	[17662482] = {['Atma'] = { xi.keyItem.ATMA_OF_THE_STRANGLING_WIND  }, ['Normal']= {                                             }},
	[17662487] = {['Atma'] = { xi.keyItem.ATMA_OF_THE_STRANGLING_WIND  }, ['Normal']= {                                             }},
	[17662492] = {['Atma'] = {                                         }, ['Normal']= { xi.keyItem.BLOODIED_BAT_FUR                 }},
	[17662471] = {['Atma'] = { xi.keyItem.ATMA_OF_THE_WINGED_ENIGMA    }, ['Normal']= {                                             }},
	[17662468] = {['Atma'] = {                                         }, ['Normal']= { xi.keyItem.GLISTENING_OROBON_LIVER          }},
	[17662476] = {['Atma'] = { xi.keyItem.ATMA_OF_THE_DEEP_DEVOURER    }, ['Normal']= {                                             }},
	[17662481] = {['Atma'] = { xi.keyItem.ATMA_OF_THE_DEEP_DEVOURER    }, ['Normal']= {                                             }},
	[17662486] = {['Atma'] = { xi.keyItem.ATMA_OF_THE_DEEP_DEVOURER    }, ['Normal']= {                                             }},
	[17662495] = {['Atma'] = {                                         }, ['Normal']= { xi.keyItem.SAPPHIRE_ABYSSITE_OF_FURTHERANCE }},
	[17662466] = {['Atma'] = {                                         }, ['Normal']= { xi.keyItem.JAGGED_APKALLU_BEAK              }},
	[17662491] = {['Atma'] = {                                         }, ['Normal']= { xi.keyItem.MOLTED_PEISTE_SKIN               }},
	[17662493] = {['Atma'] = {                                         }, ['Normal']= { xi.keyItem.DOFFED_POROGGO_HAT               }},
	[17662469] = {['Atma'] = {                                         }, ['Normal']= { xi.keyItem.SCALDING_IRONCLAD_SPIKE          }},
	[17662479] = {['Atma'] = { xi.keyItem.ATMA_OF_THE_RAZED_RUIN       }, ['Normal']= {                                             }},
	[17662480] = {['Atma'] = { xi.keyItem.ATMA_OF_THE_RAZED_RUIN       }, ['Normal']= {                                             }},
	[17662484] = {['Atma'] = { xi.keyItem.ATMA_OF_THE_RAZED_RUIN       }, ['Normal']= {                                             }},
	[17662485] = {['Atma'] = { xi.keyItem.ATMA_OF_THE_RAZED_RUIN       }, ['Normal']= {                                             }},
	[17662489] = {['Atma'] = { xi.keyItem.ATMA_OF_THE_RAZED_RUIN       }, ['Normal']= {                                             }},
	[17662490] = {['Atma'] = { xi.keyItem.ATMA_OF_THE_RAZED_RUIN       }, ['Normal']= {                                             }},
	[17662472] = {['Atma'] = { xi.keyItem.ATMA_OF_THE_CRADLE           }, ['Normal']= {                                             }},
	[17662497] = {['Atma'] = { xi.keyItem.ATMA_OF_THE_MOUNTED_CHAMPION }, ['Normal']= {                                             }},
	[17662467] = {['Atma'] = {                                         }, ['Normal']= { xi.keyItem.CLIPPED_BIRD_WING                }},
	[17662464] = {['Atma'] = {                                         }, ['Normal']= { xi.keyItem.BLOODSTAINED_BUGARD_FANG         }},
	[17662470] = {['Atma'] = { xi.keyItem.ATMA_OF_THE_RAPID_REPTILIAN  }, ['Normal']= {                                             }},
	[17662473] = {['Atma'] = { xi.keyItem.ATMA_OF_THE_UNTOUCHED        }, ['Normal']= {                                             }},
	[17662475] = {['Atma'] = {                                         }, ['Normal']= { xi.keyItem.SAPPHIRE_ABYSSITE_OF_FORTUNE     }},
	[17662465] = {['Atma'] = {                                         }, ['Normal']= { xi.keyItem.GNARLED_LIZARD_NAIL              }},
	[17662478] = {['Atma'] = { xi.keyItem.ATMA_OF_THE_GNARLED_HORN     }, ['Normal']= {                                             }},
	[17662483] = {['Atma'] = { xi.keyItem.ATMA_OF_THE_GNARLED_HORN     }, ['Normal']= {                                             }},
	[17662488] = {['Atma'] = { xi.keyItem.ATMA_OF_THE_GNARLED_HORN     }, ['Normal']= {                                             }},
	[17662474] = {['Atma'] = {                                         }, ['Normal']= { xi.keyItem.SAPPHIRE_ABYSSITE_OF_LENITY      }},

    -- Tahrongi Canyon
	[16961936] = {['Atma'] = { xi.keyItem.ATMA_OF_CALAMITY                                             }, ['Normal'] = { xi.keyItem.STICKY_GNAT_WING            }},
	[16961919] = {['Atma'] = {                                                                         }, ['Normal'] = { xi.keyItem.VEINOUS_HECTEYES_EYELID     }},
	[16961921] = {['Atma'] = {                                                                         }, ['Normal'] = { xi.keyItem.TORN_BAT_WING               }},
	[16961923] = {['Atma'] = {                                                                         }, ['Normal'] = { xi.keyItem.GORY_SCORPION_CLAW          }},
	[16961934] = {['Atma'] = { xi.keyItem.ATMA_OF_THE_ADAMANTINE                                       }, ['Normal'] = { xi.keyItem.MOSSY_ADAMANTOISE_SHELL     }},
	[16961925] = {['Atma'] = {                                                                         }, ['Normal'] = { xi.keyItem.FAT_LINED_COCKATRICE_SKIN   }},
	[16961935] = {['Atma'] = {                                                                         }, ['Normal'] = { xi.keyItem.SODDEN_SANDWORM_HUSK        }},
	[16961927] = {['Atma'] = {                                                                         }, ['Normal'] = { xi.keyItem.LUXURIANT_MANTICORE_MANE    }},
	[16961929] = {['Atma'] = { xi.keyItem.ATMA_OF_THE_HARVESTER                                        }, ['Normal'] = { xi.keyItem.OVERGROWN_MANDRAGORA_FLOWER }},
	[16961946] = {['Atma'] = { xi.keyItem.ATMA_OF_THE_HARVESTER                                        }, ['Normal'] = { xi.keyItem.OVERGROWN_MANDRAGORA_FLOWER }},
	[16961949] = {['Atma'] = { xi.keyItem.ATMA_OF_THE_HARVESTER                                        }, ['Normal'] = { xi.keyItem.OVERGROWN_MANDRAGORA_FLOWER }},
	[16961930] = {['Atma'] = { xi.keyItem.ATMA_OF_DUNES                                                }, ['Normal'] = { xi.keyItem.CHIPPED_SANDWORM_TOOTH      }},
	[16961947] = {['Atma'] = { xi.keyItem.ATMA_OF_DUNES                                                }, ['Normal'] = { xi.keyItem.CHIPPED_SANDWORM_TOOTH      }},
	[16961950] = {['Atma'] = { xi.keyItem.ATMA_OF_DUNES                                                }, ['Normal'] = { xi.keyItem.CHIPPED_SANDWORM_TOOTH      }},
	[16961904] = {['Atma'] = { xi.keyItem.VIRIDIAN_ABYSSITE_OF_MERIT                                   }, ['Normal'] = {                                        }},
	[16961905] = {['Atma'] = { xi.keyItem.VIRIDIAN_ABYSSITE_OF_MERIT                                   }, ['Normal'] = {                                        }},
	[16961906] = {['Atma'] = { xi.keyItem.VIRIDIAN_ABYSSITE_OF_MERIT                                   }, ['Normal'] = {                                        }},
	[16961907] = {['Atma'] = { xi.keyItem.VIRIDIAN_ABYSSITE_OF_MERIT                                   }, ['Normal'] = {                                        }},
	[16961908] = {['Atma'] = { xi.keyItem.VIRIDIAN_ABYSSITE_OF_MERIT                                   }, ['Normal'] = {                                        }},
	[16961932] = {['Atma'] = { xi.keyItem.VIRIDIAN_ABYSSITE_OF_DESTINY, xi.keyItem.ATMA_OF_THE_CLAW    }, ['Normal'] = {                                        }},
	[16961945] = {['Atma'] = { xi.keyItem.ATMA_OF_THE_COSMOS                                           }, ['Normal'] = {                                        }},
	[16961931] = {['Atma'] = { xi.keyItem.ATMA_OF_THE_STRONGHOLD                                       }, ['Normal'] = {                                        }},
	[16961948] = {['Atma'] = { xi.keyItem.ATMA_OF_THE_STRONGHOLD                                       }, ['Normal'] = {                                        }},
	[16961951] = {['Atma'] = { xi.keyItem.ATMA_OF_THE_STRONGHOLD                                       }, ['Normal'] = {                                        }},
	[16961938] = {['Atma'] = { xi.keyItem.VIRIDIAN_ABYSSITE_OF_DESTINY                                 }, ['Normal'] = {                                        }},
	[16961933] = {['Atma'] = { xi.keyItem.ATMA_OF_BALEFUL_BONES, xi.keyItem.VIRIDIAN_ABYSSITE_OF_MERIT }, ['Normal'] = {                                        }},
	[16961939] = {['Atma'] = { xi.keyItem.ATMA_OF_THE_IMPALER                                          }, ['Normal'] = {                                        }},
	[16961937] = {['Atma'] = { xi.keyItem.VIRIDIAN_ABYSSITE_OF_AVARICE                                 }, ['Normal'] = {                                        }},

    -- Vunkerl Inlet
	[17666496] = {['Atma'] = {                                            }, ['Normal'] = { xi.keyItem.CRIMSON_ABYSSITE_OF_ACUMEN     }},
	[17666516] = {['Atma'] = {                                            }, ['Normal'] = { xi.keyItem.MALODOROUS_MARID_FUR           }},
	[17666499] = {['Atma'] = { xi.keyItem.ATMA_OF_THE_SANGUINE_SCYTHE     }, ['Normal'] = {                                           }},
	[17666503] = {['Atma'] = { xi.keyItem.ATMA_OF_THE_SANGUINE_SCYTHE     }, ['Normal'] = {                                           }},
	[17666507] = {['Atma'] = { xi.keyItem.ATMA_OF_THE_SANGUINE_SCYTHE     }, ['Normal'] = {                                           }},
	[17666495] = {['Atma'] = { xi.keyItem.ATMA_OF_THE_MURKY_MIASMA        }, ['Normal'] = {                                           }},
	[17666515] = {['Atma'] = {                                            }, ['Normal'] = { xi.keyItem.CHIPPED_IMPS_OLIFANT           }},
	[17666501] = {['Atma'] = { xi.keyItem.ATMA_OF_THE_MINIKIN_MONSTROSITY }, ['Normal'] = {                                           }},
	[17666505] = {['Atma'] = { xi.keyItem.ATMA_OF_THE_MINIKIN_MONSTROSITY }, ['Normal'] = {                                           }},
	[17666509] = {['Atma'] = { xi.keyItem.ATMA_OF_THE_MINIKIN_MONSTROSITY }, ['Normal'] = {                                           }},
	[17666490] = {['Atma'] = {                                            }, ['Normal'] = { xi.keyItem.DECAYED_DVERGR_TOOTH           }},
	[17666517] = {['Atma'] = { xi.keyItem.ATMA_OF_THE_AVARICIOUS_APE      }, ['Normal'] = {                                           }},
	[17666514] = {['Atma'] = {                                            }, ['Normal'] = { xi.keyItem.SHIMMERING_PUGIL_SCALE         }},
	[17666518] = {['Atma'] = {                                            }, ['Normal'] = { xi.keyItem.CRIMSON_ABYSSITE_OF_DESTINY    }},
	[17666489] = {['Atma'] = {                                            }, ['Normal'] = { xi.keyItem.GLOSSY_SEA_MONK_SUCKER         }},
	[17666491] = {['Atma'] = {                                            }, ['Normal'] = { xi.keyItem.PULSATING_SOULFLAYER_BEARD     }},
	[17666502] = {['Atma'] = { xi.keyItem.ATMA_OF_THE_BLINDING_HORN       }, ['Normal'] = {                                           }},
	[17666506] = {['Atma'] = { xi.keyItem.ATMA_OF_THE_BLINDING_HORN       }, ['Normal'] = {                                           }},
	[17666510] = {['Atma'] = { xi.keyItem.ATMA_OF_THE_BLINDING_HORN       }, ['Normal'] = {                                           }},
	[17666487] = {['Atma'] = {                                            }, ['Normal'] = { xi.keyItem.INGROWN_TAURUS_NAIL            }},
	[17666513] = {['Atma'] = {                                            }, ['Normal'] = { xi.keyItem.IMBRUED_VAMPYR_FANG            }},
	[17666497] = {['Atma'] = {                                            }, ['Normal'] = { xi.keyItem.CRIMSON_ABYSSITE_OF_CONFLUENCE }},
	[17666488] = {['Atma'] = {                                            }, ['Normal'] = { xi.keyItem.OSSIFIED_GARGOUILLE_HAND       }},
	[17666492] = {['Atma'] = {                                            }, ['Normal'] = { xi.keyItem.WARPED_SMILODON_CHOKER         }},
	[17666493] = {['Atma'] = { xi.keyItem.ATMA_OF_THE_APPARITIONS         }, ['Normal'] = {                                           }},
	[17666500] = {['Atma'] = { xi.keyItem.ATMA_OF_THE_TUSKED_TERROR       }, ['Normal'] = {                                           }},
	[17666504] = {['Atma'] = { xi.keyItem.ATMA_OF_THE_TUSKED_TERROR       }, ['Normal'] = {                                           }},
	[17666508] = {['Atma'] = { xi.keyItem.ATMA_OF_THE_TUSKED_TERROR       }, ['Normal'] = {                                           }},
	[17666511] = {['Atma'] = { xi.keyItem.ATMA_OF_THE_WOULD_BE_KING       }, ['Normal'] = {                                           }},
	[17666494] = {['Atma'] = { xi.keyItem.ATMA_OF_THE_SHIMMERING_SHELL    }, ['Normal'] = {                                           }},
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
    [xi.magic.element.FIRE] =
    {
        xi.magic.spell.FIRE_III,
        xi.magic.spell.FIRE_IV,
        xi.magic.spell.FIRAGA_III,
        xi.magic.spell.FLARE,
        xi.magic.spell.HEAT_BREATH,
        xi.magic.spell.KATON_NI,
        xi.magic.spell.ICE_THRENODY,
    },

    [xi.magic.element.ICE] =
    {
        xi.magic.spell.BLIZZARD_III,
        xi.magic.spell.BLIZZARD_IV,
        xi.magic.spell.BLIZZAGA_III,
        xi.magic.spell.FREEZE,
        xi.magic.spell.ICE_BREAK,
        xi.magic.spell.HYOTON_NI,
        xi.magic.spell.WIND_THRENODY,
    },

    [xi.magic.element.WIND] =
    {
        xi.magic.spell.AERO_III,
        xi.magic.spell.AERO_IV,
        xi.magic.spell.AEROGA_III,
        xi.magic.spell.TORNADO,
        xi.magic.spell.MYSTERIOUS_LIGHT,
        xi.magic.spell.HUTON_NI,
        xi.magic.spell.EARTH_THRENODY,
    },

    [xi.magic.element.EARTH] =
    {
        xi.magic.spell.STONE_III,
        xi.magic.spell.STONE_IV,
        xi.magic.spell.STONEGA_III,
        xi.magic.spell.QUAKE,
        xi.magic.spell.MAGNETITE_CLOUD,
        xi.magic.spell.DOTON_NI,
        xi.magic.spell.LIGHTNING_THRENODY,
    },

    [xi.magic.element.THUNDER] =
    {
        xi.magic.spell.THUNDER_III,
        xi.magic.spell.THUNDER_IV,
        xi.magic.spell.THUNDAGA_III,
        xi.magic.spell.BURST,
        xi.magic.spell.MIND_BLAST,
        xi.magic.spell.RAITON_NI,
        xi.magic.spell.WATER_THRENODY,
    },

    [xi.magic.element.WATER] =
    {
        xi.magic.spell.WATER_III,
        xi.magic.spell.WATER_IV,
        xi.magic.spell.WATERGA_III,
        xi.magic.spell.FLOOD,
        xi.magic.spell.MAELSTROM,
        xi.magic.spell.SUITON_NI,
        xi.magic.spell.FIRE_THRENODY,
    },

    [xi.magic.element.LIGHT] =
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

    [xi.magic.element.DARK] =
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
        xi.weaponskill.SHADOWSTICH,
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

-- [ZoneID] = {Required Trades Event, Has Key Items Event, Missing Key Item Event}
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

-- returns Traverser Stone KI cap
xi.abyssea.getTraverserCap = function(player)
    local stones = 3

    for ki = xi.ki.VIRIDIAN_ABYSSITE_OF_AVARICE, xi.ki.VERMILLION_ABYSSITE_OF_AVARICE do
        if player:hasKeyItem(ki) then
            stones = stones + 1
        end
    end

    return stones
end

-- returns total Traverser Stone KI
-- (NOT the reserve value from currency menu)
xi.abyssea.getHeldTraverserStones = function(player)
    local stones = 0

    for ki = xi.ki.TRAVERSER_STONE1, xi.ki.TRAVERSER_STONE6 do
        if player:hasKeyItem(ki) then
            stones = stones + 1
        end
    end

    return stones
end

-- removes Traverser Stone KIs
xi.abyssea.spendTravStones = function(player, spentstones)
    local numRemoved = 0

    for ki = xi.ki.TRAVERSER_STONE6, xi.ki.TRAVERSER_STONE1 do
        if numRemoved == spentstones then
            break
        elseif player:hasKeyItem(ki) then
            player:delKeyItem(ki)
            numRemoved = numRemoved + 1
        end
    end
end

-- returns total "Abyssite of <thing>"
xi.abyssea.getAbyssiteTotal = function(player, enumVal)
    local kiCount = 0

    for keyItem = abyssiteKeyItems[enumVal][1], abyssiteKeyItems[enumVal][2] do
        if player:hasKeyItem(keyItem) then
            kiCount = kiCount + 1
        end
    end

    return kiCount
end

xi.abyssea.canGiveNMKI = function(player, mob, dropChance)
	local playerId = mob:getLocalVar("[ClaimedBy]")
	local redProcValue = mob:getLocalVar("[AbysseaRedProc]")

	if redProcValue == 1 then
		dropChance = 0
	end

    if playerId == player:getID() then
		math.randomseed(os.time())
		if math.random(1, 100) >= dropChance then
			return true
		end
    end

	return false
end

xi.abyssea.giveNMDrops = function(mob, player, ID)
	-- local redWeakness = mob:getLocalVar("[AbysseaRedProc]")
	-- local blueWeaknessValue = mob:getLocalVar("[AbysseaBlueProc]")
	-- local yellowWeaknessValue = mob:getLocalVar("[AbysseaYellowProc]")
	local atmaDrops = xi.abyssea.mob[mob:getID()]['Atma']
	local normalDrops = xi.abyssea.mob[mob:getID()]['Normal']

	for k, v in pairs(normalDrops) do
		if xi.abyssea.canGiveNMKI(player, mob, 70) then
			player:addKeyItem(v)
			player:messageSpecial(ID.text.KEYITEM_OBTAINED, v)
		end
	end

	for k, v in pairs(atmaDrops) do
		if xi.abyssea.canGiveNMKI(player, mob, 100) then
			local party = player:getParty()

			for _, member in ipairs(party) do
				if not member:hasKeyItem(v) then
					member:addKeyItem(v)
					member:messageSpecial(ID.text.KEYITEM_OBTAINED, v)
				end
			end

			if not player:hasKeyItem(v) then
				player:addKeyItem(v)
				player:messageSpecial(ID.text.KEYITEM_OBTAINED, v)
			end
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
			if mob:getLocalVar("[AbysseaRedProc]") == 0 then
				mob:setLocalVar("[AbysseaRedProc]", 1)
			else
				mob:setLocalVar("[AbysseaRedProc]", 0)
			end
			mob:weaknessTrigger(2)
			mob:addStatusEffect(xi.effect.TERROR, 0, 0, 30)
		elseif triggerType == xi.abyssea.triggerType.YELLOW then
			if mob:getLocalVar("[AbysseaYellowProc]") == 0 then
				mob:setLocalVar("[AbysseaYellowProc]", 1)
			else
				mob:setLocalVar("[AbysseaYellowProc]", 0)
			end
			mob:weaknessTrigger(1)
			mob:addStatusEffect(xi.effect.TERROR, 0, 0, 30)
		elseif triggerType == xi.abyssea.triggerType.BLUE then
			if mob:getLocalVar("[AbysseaBlueProc]") == 0 then
				mob:setLocalVar("[AbysseaBlueProc]", 1)
			else
				mob:setLocalVar("[AbysseaBlueProc]", 0)
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
	GetMobByID(mobId):setLocalVar("[ClaimedBy]", player:getID())

    return true
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
    for k, v in pairs(kis) do
        if not player:hasKeyItem(v) then
            validKis = false
            break
        end
    end

    -- infill kis
    for i = 1, 8, 1 do
        if not kis[i] then
            kis[i] = 0
        end
    end

    -- start event
    if validKis then
        player:setLocalVar("abysseaQM", npc:getID())
        player:startEvent(events[2], kis[1], kis[2], kis[3], kis[4], kis[5], kis[6], kis[7], kis[8]) -- player has all key items
        return true
    else
        player:startEvent(events[3], kis[1], kis[2], kis[3], kis[4], kis[5], kis[6], kis[7], kis[8]) -- player is missing key items
        return false
    end
end

xi.abyssea.qmOnEventUpdate = function(player, csid, option)
    return false
end

xi.abyssea.qmOnEventFinish = function(player, csid, option)
    local zoneId = player:getZoneID()
    local events = popEvents[zoneId]
    local pop = zones[zoneId].npc.QM_POPS[player:getLocalVar("abysseaQM")] -- TODO: Once I (Wren) finish entity-QC on all Abyssea zones, I must adjust the format of QM_POPS table
    player:setLocalVar("abysseaQM", 0)
    if not pop then
        return false
    end

    if csid == events[2] and option == 1 then
        -- delete kis
        local kis = pop[3]
        for k, v in pairs(kis) do
            if player:hasKeyItem(v) then
                player:delKeyItem(v)
            end
        end

        -- pop nm
        local nm = pop[4]
        local dx = player:getXPos() + math.random(-1, 1)
        local dy = player:getYPos()
        local dz = player:getZPos() + math.random(-1, 1)

        GetMobByID(nm):setSpawn(dx, dy, dz)
        SpawnMob(nm):updateClaim(player)
		GetMobByID(nm):setLocalVar("[ClaimedBy]", player:getID())

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
    local lightMaskFirst  = player:getCharVar("abysseaLights1")
    local lightMaskSecond = player:getCharVar("abysseaLights2")
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

    player:setCharVar("abysseaLights1", lightMaskFirst)
    player:setCharVar("abysseaLights2", lightMaskSecond)
end

xi.abyssea.displayAbysseaLights = function(player)
    if xi.abyssea.isInAbysseaZone(player) then
        local ID = zones[player:getZoneID()]
        local lightValues = xi.abyssea.getLightsTable(player)

        player:messageSpecial(ID.text.LIGHTS_MESSAGE_1,
                              lightValues[xi.abyssea.lightType.PEARL],
                              lightValues[xi.abyssea.lightType.EBON],
                              lightValues[xi.abyssea.lightType.GOLDEN],
                              lightValues[xi.abyssea.lightType.SILVERY])

        player:messageSpecial(ID.text.LIGHTS_MESSAGE_2,
                              lightValues[xi.abyssea.lightType.AZURE],
                              lightValues[xi.abyssea.lightType.RUBY],
                              lightValues[xi.abyssea.lightType.AMBER])
    end
end

xi.abyssea.resetPlayerLights = function(player)
    player:setCharVar("abysseaLights1", 0)
    player:setCharVar("abysseaLights2", 0)
end

xi.abyssea.setBonusLights = function(player)
    local lightTable = {}

    for _, v in ipairs(xi.abyssea.lightType) do
        lightTable[v] = xi.settings.ABYSSEA_BONUSLIGHT_AMOUNT
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
    return bit.band(bit.rshift(player:getCharVar("abysseaLights"), (light - 1) * 2), 0xFF)
end

xi.abyssea.canEnterAbyssea = function(player)
    -- TODO
    return true
end

-----------------------------------
-- Zone Global Functions
-----------------------------------
xi.abyssea.onZoneIn = function(player)
end

xi.abyssea.afterZoneIn = function(player)
    local zoneID = player:getZoneID()
    local ID = zones[zoneID]

    -- TODO: Verify if we need to be inside the instance before unlocking a Maw.
    if not player:hasUnlockedMaw(xi.abyssea.maws[zoneID]) then
        player:setUnlockedMaw(xi.abyssea.maws[zoneID])
    end

    -- Add 5 minutes of hidden time to get "real" visitant status.  The additional 4 seconds
    -- is intentional due to tick variances (up to 3s), and the status will be deleted should
    -- the countdown timer for visitant status reach 0 before actually running out of time on
    -- the effect.
    if not player:hasStatusEffect(xi.effect.VISITANT) then
        player:addStatusEffectEx(xi.effect.VISITANT, 0, 0, 3, 304)
    end

    local visitantEffect = player:getStatusEffect(xi.effect.VISITANT)
    if visitantEffect and visitantEffect:getIcon() == 0 then
        player:messageSpecial(ID.text.EXITING_ABYSSEA_OFFSET + 1, 5)
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
        player:timer(1500, function() xi.abyssea.searingWardTimer(player) end)
    elseif tetherTimer == 1 then
        player:setLocalVar('tetherTimer', 0)
        player:messageSpecial(ID.text.RETURNING_TO_WARD)
        player:setPos(unpack(searingWardTetherLocations[zoneID]))
    end
end

xi.abyssea.onWardRegionLeave = function(player)
    local ID = zones[player:getZoneID()]
    local visitantEffect = player:getStatusEffect(xi.effect.VISITANT)

    if visitantEffect and visitantEffect:getIcon() == 0 then
        player:messageSpecial(ID.text.NO_VISITANT_WARD, 10)
        player:setLocalVar('tetherTimer', 11)
    end
end

xi.abyssea.onWardRegionEnter = function(player)
    player:setLocalVar('tetherTimer', 0)
end

-----------------------------------
-- Support NPC Functions
-- Traverser Stone, Abyssea Warp
-----------------------------------
local supportNPCData =
{--                          Traverser,  Warp
    [xi.zone.HEAVENS_TOWER]  = {   434,   433 },
    [xi.zone.RULUDE_GARDENS] = { 10186, 10185 },
    [xi.zone.PORT_BASTOK]    = {   405,   404 },
    [xi.zone.PORT_JEUNO]     = {   328,   339 },
    [xi.zone.PORT_SAN_DORIA] = {   796,   795 },
    [xi.zone.PORT_WINDURST]  = {   874,   873 },
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

xi.abyssea.warpNPCOnTrigger = function(player, npc)
    local totalCruor = player:getCurrency("cruor")
    local unlockedMaws = player:getUnlockedMawTable()
    local statusParam = player:hasCompletedQuest(xi.quest.log_id.ABYSSEA, xi.quest.id.abyssea.THE_TRUTH_BECKONS) and 2 or 0

    player:startEvent(supportNPCData[player:getZoneID()][2], statusParam, totalCruor, unlockedMaws[1], unlockedMaws[2], unlockedMaws[3])
end

xi.abyssea.warpNPCOnEventUpdate = function(player, csid, option)
end

xi.abyssea.warpNPCOnEventFinish = function(player, csid, option, npc)
    local teleportSelection = bit.band(bit.rshift(option, 2), 0xF)

    -- Bit 8 is set for all teleport selections
    if
        utils.mask.getBit(option, 8) and
        player:getCurrency("cruor") >= 200
    then
        player:delCurrency("cruor", 200)
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
        player:startEvent(supportNPCData[zoneID][1], 0, availableStones, numTraverserHeld, messageType, 1, 1, 1, 3) -- Post "The Truth Beckons" Menu
    end
end

xi.abyssea.traverserNPCOnUpdate = function(player, csid, option)
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
