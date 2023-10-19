-----------------------------------
-- func: zone
-- desc: Teleports a player to the given zone.
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 'b'
}

-----------------------------------
-- desc: List of zones with their auto-translated group and message id.
-- note: The format is as follows: groupId, messageId, zoneId
-----------------------------------
local zoneList =
{
    { 0x14, 0xA9, xi.zone.PHANAUET_CHANNEL             },
    { 0x14, 0xAA, xi.zone.CARPENTERS_LANDING           },
    { 0x14, 0x84, xi.zone.MANACLIPPER                  },
    { 0x14, 0x85, xi.zone.BIBIKI_BAY                   },
    { 0x14, 0x8A, xi.zone.ULEGUERAND_RANGE             },
    { 0x14, 0x8B, xi.zone.BEARCLAW_PINNACLE            },
    { 0x14, 0x86, xi.zone.ATTOHWA_CHASM                },
    { 0x14, 0x87, xi.zone.BONEYARD_GULLY               },
    { 0x14, 0x88, xi.zone.PSOXJA                       },
    { 0x14, 0x89, xi.zone.THE_SHROUDED_MAW             },
    { 0x14, 0x8C, xi.zone.OLDTON_MOVALPOLOS            },
    { 0x14, 0x8D, xi.zone.NEWTON_MOVALPOLOS            },
    { 0x14, 0x8E, xi.zone.MINE_SHAFT_2716              },
    { 0x14, 0xDC, xi.zone.MINE_SHAFT_2716              },
    { 0x14, 0xAB, xi.zone.HALL_OF_TRANSFERENCE         },
    { 0x14, 0x9B, xi.zone.PROMYVION_HOLLA              },
    { 0x14, 0x9A, xi.zone.PROMYVION_HOLLA              },
    { 0x14, 0x9C, xi.zone.SPIRE_OF_HOLLA               },
    { 0x14, 0x9E, xi.zone.PROMYVION_DEM                },
    { 0x14, 0x9D, xi.zone.PROMYVION_DEM                },
    { 0x14, 0x9F, xi.zone.SPIRE_OF_DEM                 },
    { 0x14, 0xA0, xi.zone.PROMYVION_MEA                },
    { 0x14, 0xA1, xi.zone.PROMYVION_MEA                },
    { 0x14, 0xA2, xi.zone.SPIRE_OF_MEA                 },
    { 0x14, 0xA3, xi.zone.PROMYVION_VAHZL              },
    { 0x14, 0xA4, xi.zone.PROMYVION_VAHZL              },
    { 0x14, 0xA5, xi.zone.PROMYVION_VAHZL              },
    { 0x14, 0xA6, xi.zone.PROMYVION_VAHZL              },
    { 0x14, 0xA7, xi.zone.SPIRE_OF_VAHZL               },
    { 0x14, 0xA8, xi.zone.SPIRE_OF_VAHZL               },
    { 0x14, 0x90, xi.zone.LUFAISE_MEADOWS              },
    { 0x14, 0x91, xi.zone.MISAREAUX_COAST              },
    { 0x14, 0x8F, xi.zone.TAVNAZIAN_SAFEHOLD           },
    { 0x14, 0x93, xi.zone.PHOMIUNA_AQUEDUCTS           },
    { 0x14, 0x94, xi.zone.SACRARIUM                    },
    { 0x14, 0x96, xi.zone.RIVERNE_SITE_B01             },
    { 0x14, 0x95, xi.zone.RIVERNE_SITE_B01             },
    { 0x14, 0x98, xi.zone.RIVERNE_SITE_A01             },
    { 0x14, 0x97, xi.zone.RIVERNE_SITE_A01             },
    { 0x14, 0x99, xi.zone.MONARCH_LINN                 },
    { 0x14, 0x92, xi.zone.SEALIONS_DEN                 },
    { 0x14, 0xAC, xi.zone.ALTAIEU                      },
    { 0x14, 0xAD, xi.zone.GRAND_PALACE_OF_HUXZOI       },
    { 0x14, 0xAE, xi.zone.THE_GARDEN_OF_RUHMET         },
    { 0x14, 0xB0, xi.zone.EMPYREAL_PARADOX             },
    { 0x14, 0xB1, xi.zone.TEMENOS                      },
    { 0x14, 0xB2, xi.zone.APOLLYON                     },
    { 0x14, 0xB4, xi.zone.DYNAMIS_VALKURM              },
    { 0x14, 0xB5, xi.zone.DYNAMIS_BUBURIMU             },
    { 0x14, 0xB6, xi.zone.DYNAMIS_QUFIM                },
    { 0x14, 0xB7, xi.zone.DYNAMIS_TAVNAZIA             },
    { 0x14, 0xAF, xi.zone.DIORAMA_ABDHALJS_GHELSBA     },
    { 0x14, 0xB8, xi.zone.ABDHALJS_ISLE_PURGONORGO     },
    { 0x14, 0xB9, xi.zone.OPEN_SEA_ROUTE_TO_AL_ZAHBI   },
    { 0x14, 0xBA, xi.zone.OPEN_SEA_ROUTE_TO_MHAURA     },
    { 0x14, 0xBB, xi.zone.AL_ZAHBI                     },
    { 0x14, 0xDB, xi.zone.AHT_URHGAN_WHITEGATE         },
    { 0x14, 0xBC, xi.zone.AHT_URHGAN_WHITEGATE         },
    { 0x14, 0xBD, xi.zone.WAJAOM_WOODLANDS             },
    { 0x14, 0xBE, xi.zone.BHAFLAU_THICKETS             },
    { 0x14, 0xBF, xi.zone.NASHMAU                      },
    { 0x14, 0xC0, xi.zone.ARRAPAGO_REEF                },
    { 0x14, 0xC1, xi.zone.ILRUSI_ATOLL                 },
    { 0x14, 0xC2, xi.zone.PERIQIA                      },
    { 0x14, 0xC3, xi.zone.TALACCA_COVE                 },
    { 0x14, 0xC4, xi.zone.SILVER_SEA_ROUTE_TO_NASHMAU  },
    { 0x14, 0xC5, xi.zone.SILVER_SEA_ROUTE_TO_AL_ZAHBI },
    { 0x14, 0xC6, xi.zone.THE_ASHU_TALIF               },
    { 0x14, 0xC7, xi.zone.MOUNT_ZHAYOLM                },
    { 0x14, 0xC8, xi.zone.HALVUNG                      },
    { 0x14, 0xC9, xi.zone.LEBROS_CAVERN                },
    { 0x14, 0xCA, xi.zone.NAVUKGO_EXECUTION_CHAMBER    },
    { 0x14, 0xCB, xi.zone.MAMOOK                       },
    { 0x14, 0xCC, xi.zone.MAMOOL_JA_TRAINING_GROUNDS   },
    { 0x14, 0xCD, xi.zone.JADE_SEPULCHER               },
    { 0x14, 0xCE, xi.zone.AYDEEWA_SUBTERRANE           },
    { 0x14, 0xCF, xi.zone.LEUJAOAM_SANCTUM             },
    { 0x27, 0x0F, xi.zone.CHOCOBO_CIRCUIT              },
    { 0x27, 0x10, xi.zone.THE_COLOSSEUM                },
    { 0x14, 0xDD, xi.zone.ALZADAAL_UNDERSEA_RUINS      },
    { 0x14, 0xDE, xi.zone.ZHAYOLM_REMNANTS             },
    { 0x14, 0xDF, xi.zone.ARRAPAGO_REMNANTS            },
    { 0x14, 0xE0, xi.zone.BHAFLAU_REMNANTS             },
    { 0x14, 0xE1, xi.zone.SILVER_SEA_REMNANTS          },
    { 0x14, 0xE2, xi.zone.NYZUL_ISLE                   },
    { 0x14, 0xDA, xi.zone.HAZHALM_TESTING_GROUNDS      },
    { 0x14, 0xD0, xi.zone.CAEDARVA_MIRE                },
    { 0x27, 0x11, xi.zone.SOUTHERN_SAN_DORIA_S         },
    { 0x27, 0x13, xi.zone.EAST_RONFAURE_S              },
    { 0x27, 0x15, xi.zone.JUGNER_FOREST_S              },
    { 0x27, 0x23, xi.zone.VUNKERL_INLET_S              },
    { 0x27, 0x17, xi.zone.BATALLIA_DOWNS_S             },
    { 0x27, 0x3E, xi.zone.LA_VAULE_S                   },
    { 0x27, 0x40, xi.zone.LA_VAULE_S                   },
    { 0x27, 0x19, xi.zone.EVERBLOOM_HOLLOW             },
    { 0x27, 0x1C, xi.zone.BASTOK_MARKETS_S             },
    { 0x27, 0x1E, xi.zone.NORTH_GUSTABERG_S            },
    { 0x27, 0x20, xi.zone.GRAUBERG_S                   },
    { 0x27, 0x25, xi.zone.PASHHOW_MARSHLANDS_S         },
    { 0x27, 0x27, xi.zone.ROLANBERRY_FIELDS_S          },
    { 0x27, 0x42, xi.zone.BEADEAUX_S                   },
    { 0x27, 0x22, xi.zone.RUHOTZ_SILVERMINES           },
    { 0x27, 0x2B, xi.zone.WINDURST_WATERS_S            },
    { 0x27, 0x2D, xi.zone.WEST_SARUTABARUTA_S          },
    { 0x27, 0x2F, xi.zone.FORT_KARUGO_NARUGO_S         },
    { 0x27, 0x32, xi.zone.MERIPHATAUD_MOUNTAINS_S      },
    { 0x27, 0x34, xi.zone.SAUROMUGUE_CHAMPAIGN_S       },
    { 0x27, 0x44, xi.zone.CASTLE_OZTROJA_S             },
    { 0x14, 0x11, xi.zone.WEST_RONFAURE                },
    { 0x14, 0x0F, xi.zone.EAST_RONFAURE                },
    { 0x14, 0x51, xi.zone.LA_THEINE_PLATEAU            },
    { 0x14, 0x60, xi.zone.VALKURM_DUNES                },
    { 0x14, 0x01, xi.zone.JUGNER_FOREST                },
    { 0x14, 0x02, xi.zone.BATALLIA_DOWNS               },
    { 0x14, 0x64, xi.zone.NORTH_GUSTABERG              },
    { 0x14, 0x63, xi.zone.SOUTH_GUSTABERG              },
    { 0x14, 0x69, xi.zone.KONSCHTAT_HIGHLANDS          },
    { 0x14, 0x2B, xi.zone.PASHHOW_MARSHLANDS           },
    { 0x14, 0x07, xi.zone.ROLANBERRY_FIELDS            },
    { 0x14, 0x24, xi.zone.BEAUCEDINE_GLACIER           },
    { 0x14, 0x4D, xi.zone.XARCABARD                    },
    { 0x14, 0x3D, xi.zone.CAPE_TERIGGAN                },
    { 0x14, 0x3E, xi.zone.EASTERN_ALTEPA_DESERT        },
    { 0x14, 0x18, xi.zone.WEST_SARUTABARUTA            },
    { 0x14, 0x27, xi.zone.EAST_SARUTABARUTA            },
    { 0x14, 0x17, xi.zone.TAHRONGI_CANYON              },
    { 0x14, 0x16, xi.zone.BUBURIMU_PENINSULA           },
    { 0x14, 0x20, xi.zone.MERIPHATAUD_MOUNTAINS        },
    { 0x14, 0x2E, xi.zone.SAUROMUGUE_CHAMPAIGN         },
    { 0x14, 0x3F, xi.zone.THE_SANCTUARY_OF_ZITAH       },
    { 0x14, 0x7D, xi.zone.ROMAEVE                      },
    { 0x14, 0x7C, xi.zone.ROMAEVE                      },
    { 0x14, 0x40, xi.zone.YUHTUNGA_JUNGLE              },
    { 0x14, 0x41, xi.zone.YHOATOR_JUNGLE               },
    { 0x14, 0x42, xi.zone.WESTERN_ALTEPA_DESERT        },
    { 0x14, 0x08, xi.zone.QUFIM_ISLAND                 },
    { 0x14, 0x0A, xi.zone.BEHEMOTHS_DOMINION           },
    { 0x14, 0x43, xi.zone.VALLEY_OF_SORROWS            },
    { 0x27, 0x31, xi.zone.GHOYUS_REVERIE               },
    { 0x14, 0x6F, xi.zone.RUAUN_GARDENS                },
    { 0x14, 0x82, xi.zone.DYNAMIS_BEAUCEDINE           },
    { 0x14, 0x83, xi.zone.DYNAMIS_XARCABARD            },
    { 0x27, 0x46, xi.zone.BEAUCEDINE_GLACIER_S         },
    { 0x27, 0x48, xi.zone.XARCABARD_S                  },
    { 0x14, 0x65, xi.zone.HORLAIS_PEAK                 },
    { 0x14, 0x6C, xi.zone.GHELSBA_OUTPOST              },
    { 0x14, 0x1F, xi.zone.FORT_GHELSBA                 },
    { 0x14, 0x5E, xi.zone.YUGHOTT_GROTTO               },
    { 0x14, 0x66, xi.zone.PALBOROUGH_MINES             },
    { 0x14, 0x1A, xi.zone.WAUGHROON_SHRINE             },
    { 0x14, 0x21, xi.zone.GIDDEUS                      },
    { 0x14, 0x19, xi.zone.BALGAS_DAIS                  },
    { 0x14, 0x2A, xi.zone.BEADEAUX                     },
    { 0x14, 0x28, xi.zone.QULUN_DOME                   },
    { 0x14, 0x68, xi.zone.DAVOI                        },
    { 0x14, 0x6D, xi.zone.MONASTIC_CAVERN              },
    { 0x14, 0x23, xi.zone.CASTLE_OZTROJA               },
    { 0x14, 0x04, xi.zone.ALTAR_ROOM                   },
    { 0x14, 0x44, xi.zone.THE_BOYAHDA_TREE             },
    { 0x14, 0x37, xi.zone.DRAGONS_AERY                 },
    { 0x14, 0x0C, xi.zone.MIDDLE_DELKFUTTS_TOWER       },
    { 0x14, 0x0B, xi.zone.UPPER_DELKFUTTS_TOWER        },
    { 0x14, 0x36, xi.zone.TEMPLE_OF_UGGALEPIH          },
    { 0x14, 0x35, xi.zone.DEN_OF_RANCOR                },
    { 0x14, 0x26, xi.zone.CASTLE_ZVAHL_BAILEYS         },
    { 0x14, 0x25, xi.zone.CASTLE_ZVAHL_BAILEYS         },
    { 0x14, 0x50, xi.zone.CASTLE_ZVAHL_KEEP            },
    { 0x14, 0x4F, xi.zone.CASTLE_ZVAHL_KEEP            },
    { 0x14, 0x39, xi.zone.SACRIFICIAL_CHAMBER          },
    { 0x27, 0x36, xi.zone.GARLAIGE_CITADEL_S           },
    { 0x14, 0x5D, xi.zone.THRONE_ROOM                  },
    { 0x14, 0x2D, xi.zone.RANGUEMONT_PASS              },
    { 0x14, 0x32, xi.zone.BOSTAUNIEUX_OUBLIETTE        },
    { 0x14, 0x3B, xi.zone.CHAMBER_OF_ORACLES           },
    { 0x14, 0x1D, xi.zone.TORAIMARAI_CANAL             },
    { 0x14, 0x5C, xi.zone.FULL_MOON_FOUNTAIN           },
    { 0x27, 0x29, xi.zone.CRAWLERS_NEST_S              },
    { 0x14, 0x61, xi.zone.ZERUHN_MINES                 },
    { 0x14, 0x5B, xi.zone.KORROLOKA_TUNNEL             },
    { 0x14, 0x5A, xi.zone.KUFTAL_TUNNEL                },
    { 0x27, 0x1A, xi.zone.THE_ELDIEME_NECROPOLIS_S     },
    { 0x14, 0x59, xi.zone.SEA_SERPENT_GROTTO           },
    { 0x14, 0x71, xi.zone.VELUGANNON_PALACE            },
    { 0x14, 0x70, xi.zone.VELUGANNON_PALACE            },
    { 0x14, 0x72, xi.zone.THE_SHRINE_OF_RUAVITAU       },
    { 0x14, 0xB3, xi.zone.STELLAR_FULCRUM              },
    { 0x14, 0x73, xi.zone.LALOFF_AMPHITHEATER          },
    { 0x14, 0x74, xi.zone.THE_CELESTIAL_NEXUS          },
    { 0x14, 0x0D, xi.zone.LOWER_DELKFUTTS_TOWER        },
    { 0x14, 0x7E, xi.zone.DYNAMIS_SAN_DORIA            },
    { 0x14, 0x7F, xi.zone.DYNAMIS_BASTOK               },
    { 0x14, 0x80, xi.zone.DYNAMIS_WINDURST             },
    { 0x14, 0x81, xi.zone.DYNAMIS_JEUNO                },
    { 0x14, 0x6E, xi.zone.KING_RANPERRES_TOMB          },
    { 0x14, 0x62, xi.zone.DANGRUF_WADI                 },
    { 0x14, 0x1C, xi.zone.INNER_HORUTOTO_RUINS         },
    { 0x14, 0x03, xi.zone.ORDELLES_CAVES               },
    { 0x14, 0x1B, xi.zone.OUTER_HORUTOTO_RUINS         },
    { 0x14, 0x6A, xi.zone.THE_ELDIEME_NECROPOLIS       },
    { 0x14, 0x67, xi.zone.GUSGEN_MINES                 },
    { 0x14, 0x2C, xi.zone.CRAWLERS_NEST                },
    { 0x14, 0x15, xi.zone.MAZE_OF_SHAKHRAMI            },
    { 0x14, 0x14, xi.zone.GARLAIGE_CITADEL             },
    { 0x14, 0x77, xi.zone.CLOISTER_OF_GALES            },
    { 0x14, 0x75, xi.zone.CLOISTER_OF_STORMS           },
    { 0x14, 0x7A, xi.zone.CLOISTER_OF_FROST            },
    { 0x14, 0x4A, xi.zone.FEIYIN                       },
    { 0x14, 0x58, xi.zone.IFRITS_CAULDRON              },
    { 0x14, 0x6B, xi.zone.QUBIA_ARENA                  },
    { 0x14, 0x78, xi.zone.CLOISTER_OF_FLAMES           },
    { 0x14, 0x57, xi.zone.QUICKSAND_CAVES              },
    { 0x14, 0x76, xi.zone.CLOISTER_OF_TREMORS          },
    { 0x14, 0x79, xi.zone.CLOISTER_OF_TIDES            },
    { 0x14, 0x34, xi.zone.GUSTAV_TUNNEL                },
    { 0x14, 0x33, xi.zone.LABYRINTH_OF_ONZOZO          },
    { 0x14, 0x4C, xi.zone.SOUTHERN_SAN_DORIA           },
    { 0x14, 0x30, xi.zone.NORTHERN_SAN_DORIA           },
    { 0x14, 0x52, xi.zone.PORT_SAN_DORIA               },
    { 0x14, 0x22, xi.zone.CHATEAU_DORAGUILLE           },
    { 0x14, 0x46, xi.zone.BASTOK_MINES                 },
    { 0x14, 0x56, xi.zone.BASTOK_MARKETS               },
    { 0x14, 0x3C, xi.zone.PORT_BASTOK                  },
    { 0x14, 0x2F, xi.zone.METALWORKS                   },
    { 0x14, 0x3A, xi.zone.WINDURST_WATERS              },
    { 0x14, 0x54, xi.zone.WINDURST_WALLS               },
    { 0x14, 0x45, xi.zone.PORT_WINDURST                },
    { 0x14, 0x38, xi.zone.WINDURST_WOODS               },
    { 0x14, 0x55, xi.zone.HEAVENS_TOWER                },
    { 0x14, 0x13, xi.zone.RULUDE_GARDENS               },
    { 0x14, 0x4E, xi.zone.UPPER_JEUNO                  },
    { 0x14, 0x0E, xi.zone.LOWER_JEUNO                  },
    { 0x14, 0x06, xi.zone.PORT_JEUNO                   },
    { 0x14, 0x31, xi.zone.RABAO                        },
    { 0x14, 0x5F, xi.zone.SELBINA                      },
    { 0x14, 0x1E, xi.zone.MHAURA                       },
    { 0x14, 0x29, xi.zone.KAZHAM                       },
    { 0x14, 0x7B, xi.zone.HALL_OF_THE_GODS             },
    { 0x14, 0x09, xi.zone.NORG                         },
    { 0x27, 0x4C, xi.zone.WESTERN_ADOULIN              },
    { 0x27, 0x4D, xi.zone.EASTERN_ADOULIN              },
    { 0x27, 0x4E, xi.zone.RALA_WATERWAYS               },
    { 0x27, 0x4F, xi.zone.YAHSE_HUNTING_GROUNDS        },
    { 0x27, 0x50, xi.zone.CEIZAK_BATTLEGROUNDS         },
    { 0x27, 0x51, xi.zone.FORET_DE_HENNETIEL           },
    { 0x27, 0x56, xi.zone.YORCIA_WEALD                 },
    { 0x27, 0x52, xi.zone.MORIMAR_BASALT_FIELDS        },
    { 0x27, 0x57, xi.zone.MARJAMI_RAVINE               },
    { 0x27, 0x5C, xi.zone.KAMIHR_DRIFTS                },
    { 0x27, 0x53, xi.zone.SIH_GATES                    },
    { 0x27, 0x54, xi.zone.MOH_GATES                    },
    { 0x27, 0x55, xi.zone.CIRDAS_CAVERNS               },
    { 0x27, 0x58, xi.zone.DHO_GATES                    },
    { 0x27, 0x5D, xi.zone.WOH_GATES                    },
    { 0x27, 0x12, xi.zone.OUTER_RAKAZNAR               },
    { 0x27, 0x5A, xi.zone.MOG_GARDEN                   },
    { 0x27, 0x59, xi.zone.CELENNIA_MEMORIAL_LIBRARY    },
    { 0x27, 0x5B, xi.zone.FERETORY                     },
    { 0x14, 0x09, xi.zone.ESCHA_ZITAH                  },
    { 0x27, 0x1B, xi.zone.ESCHA_RUAUN                  },
    { 0x27, 0x1D, xi.zone.REISENJIMA                   },
}

local function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer('!zone <zone ID or autotranslate phrase>')
end

local function getBytePos(s, needle)
    for i = 1, string.len(s), 1 do
        if string.byte(s, i) == needle then
            return i
        end
    end

    return nil
end

-----------------------------------
-- func: onTrigger
-- desc: Called when this command is invoked.
-----------------------------------
commandObj.onTrigger = function(player, bytes)
    local x = 0
    local y = 0
    local z = 0
    local rot = 0
    local zone

    if bytes == nil then
        error(player, 'You must provide a zone ID or autotranslate phrase.')
        return
    end

    bytes = string.sub(bytes, 6)
    local atpos = getBytePos(bytes, 253)

    -- validate destination
    if atpos ~= nil then
        -- destination is an auto-translate phrase
        local groupId = string.byte(bytes, atpos + 3)
        local messageId = string.byte(bytes, atpos + 4)
        for k, v in pairs(zoneList) do
            if v[1] == groupId and v[2] == messageId then
                x = v[4] or 0
                y = v[5] or 0
                z = v[6] or 0
                rot = 0
                zone = v[3]
                break
            end
        end

        if zone == nil then
            error(player, 'Auto-translated phrase is not a zone.')
            return
        end
    else
        -- destination is a zone ID.
        zone = tonumber(bytes)
        if zone == nil or zone < 0 or zone >= xi.zone.MAX_ZONE then
            error(player, 'Invalid zone ID.')
            return
        end

        for k, v in pairs(zoneList) do
            if v[3] == zone then
                x = v[4] or 0
                y = v[5] or 0
                z = v[6] or 0
                rot = 0
                zone = v[3]
                break
            end
        end
    end

    -- send player to destination
    player:setPos(x, y, z, rot, zone)
end

return commandObj
