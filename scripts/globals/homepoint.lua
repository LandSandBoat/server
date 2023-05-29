require("scripts/globals/settings")
require("scripts/globals/teleports")
require("scripts/globals/zone")
-----------------------------------

xi = xi or {}
xi.homepoint = xi.homepoint or {}

local homepointData =
{
    -- [Index]= [1]group(if to/from both same group, then no cost) [2]fee multiplier [3]dest { x, y, z, rot, zone }
    [  0] = { group = 1, fee = 1, dest = {  -85.554,       1, -64.554,  45, xi.zone.SOUTHERN_SAN_DORIA     } }, -- Southern San d'Oria #1
    [  1] = { group = 1, fee = 1, dest = {     44.1,       2,   -34.5, 170, xi.zone.SOUTHERN_SAN_DORIA     } }, -- Southern San d'Oria #2
    [  2] = { group = 1, fee = 1, dest = {    140.5,      -2,     121,   0, xi.zone.SOUTHERN_SAN_DORIA     } }, -- Southern San d'Oria #3
    [  3] = { group = 1, fee = 1, dest = {     -178,       4,      71,   0, xi.zone.NORTHERN_SAN_DORIA     } }, -- Northern San d'Oria #1
    [  4] = { group = 1, fee = 1, dest = {       10,    -0.2,      95,   0, xi.zone.NORTHERN_SAN_DORIA     } }, -- Northern San d'Oria #2
    [  5] = { group = 1, fee = 1, dest = {       70,    -0.2,      10,   0, xi.zone.NORTHERN_SAN_DORIA     } }, -- Northern San d'Oria #3
    [  6] = { group = 1, fee = 1, dest = {      -38,      -4,     -63,   0, xi.zone.PORT_SAN_DORIA         } }, -- Port San d'Oria #1
    [  7] = { group = 1, fee = 1, dest = {       48,     -12,    -105,   0, xi.zone.PORT_SAN_DORIA         } }, -- Port San d'Oria #2
    [  8] = { group = 1, fee = 1, dest = {       -6,     -13,    -150,   0, xi.zone.PORT_SAN_DORIA         } }, -- Port San d'Oria #3
    [  9] = { group = 2, fee = 1, dest = {       39,       0,     -43,   0, xi.zone.BASTOK_MINES           } }, -- Bastok Mines #1
    [ 10] = { group = 2, fee = 1, dest = {      118,       1,     -58,   0, xi.zone.BASTOK_MINES           } }, -- Bastok Mines #2
    [ 11] = { group = 2, fee = 1, dest = {     -342,     -10,    -154,   0, xi.zone.BASTOK_MARKETS         } }, -- Bastok Markets #1
    [ 12] = { group = 2, fee = 1, dest = {     -328,     -12,     -33,   0, xi.zone.BASTOK_MARKETS         } }, -- Bastok Markets #2
    [ 13] = { group = 2, fee = 1, dest = {     -189,      -8,      26,   0, xi.zone.BASTOK_MARKETS         } }, -- Bastok Markets #3
    [ 14] = { group = 2, fee = 1, dest = {      124,       8,       7,   0, xi.zone.PORT_BASTOK            } }, -- Port Bastok #1
    [ 15] = { group = 2, fee = 1, dest = {       42,     8.5,    -244,   0, xi.zone.PORT_BASTOK            } }, -- Port Bastok #2
    [ 16] = { group = 2, fee = 1, dest = {       46,     -14,     -19,   0, xi.zone.METALWORKS             } }, -- Metalworks #1
    [ 17] = { group = 3, fee = 1, dest = {      -32,      -5,     132,   0, xi.zone.WINDURST_WATERS        } }, -- Windurst Waters #1
    [ 18] = { group = 3, fee = 1, dest = {    138.5,       0,     -14,   0, xi.zone.WINDURST_WATERS        } }, -- Windurst Waters #2
    [ 19] = { group = 3, fee = 1, dest = {      -72,      -5,     125,   0, xi.zone.WINDURST_WALLS         } }, -- Windurst Walls #1
    [ 20] = { group = 3, fee = 1, dest = {     -212,       0,     -99,   0, xi.zone.WINDURST_WALLS         } }, -- Windurst Walls #2
    [ 21] = { group = 3, fee = 1, dest = {       31,    -6.5,     -40,   0, xi.zone.WINDURST_WALLS         } }, -- Windurst Walls #3
    [ 22] = { group = 3, fee = 1, dest = {     -188,      -4,     101,   0, xi.zone.PORT_WINDURST          } }, -- Port Windurst #1
    [ 23] = { group = 3, fee = 1, dest = {     -207,      -8,     210,   0, xi.zone.PORT_WINDURST          } }, -- Port Windurst #2
    [ 24] = { group = 3, fee = 1, dest = {      180,     -12,     226,   0, xi.zone.PORT_WINDURST          } }, -- Port Windurst #3
    [ 25] = { group = 3, fee = 1, dest = {        9,      -2,       0,   0, xi.zone.WINDURST_WOODS         } }, -- Windurst Woods #1
    [ 26] = { group = 3, fee = 1, dest = {      107,      -5,     -56,   0, xi.zone.WINDURST_WOODS         } }, -- Windurst Woods #2
    [ 27] = { group = 3, fee = 1, dest = {      -92,      -5,      62,   0, xi.zone.WINDURST_WOODS         } }, -- Windurst Woods #3
    [ 28] = { group = 3, fee = 1, dest = {       74,      -7,    -139,   0, xi.zone.WINDURST_WOODS         } }, -- Windurst Woods #4
    [ 29] = { group = 4, fee = 1, dest = {       -6,       3,       0,   0, xi.zone.RULUDE_GARDENS         } }, -- Ru'Lude Gardens #1
    [ 30] = { group = 4, fee = 1, dest = {       53,       9,     -57,   0, xi.zone.RULUDE_GARDENS         } }, -- Ru'Lude Gardens #2
    [ 31] = { group = 4, fee = 1, dest = {      -67,       6,     -25,   1, xi.zone.RULUDE_GARDENS         } }, -- Ru'Lude Gardens #3
    [ 32] = { group = 4, fee = 1, dest = {      -99,       0,     167,   0, xi.zone.UPPER_JEUNO            } }, -- Upper Jeuno #1
    [ 33] = { group = 4, fee = 1, dest = {       32,      -1,     -44,   0, xi.zone.UPPER_JEUNO            } }, -- Upper Jeuno #2
    [ 34] = { group = 4, fee = 1, dest = {      -52,       1,      16,   0, xi.zone.UPPER_JEUNO            } }, -- Upper Jeuno #3
    [ 35] = { group = 4, fee = 1, dest = {      -99,       0,    -183,   0, xi.zone.LOWER_JEUNO            } }, -- Lower Jeuno #1
    [ 36] = { group = 4, fee = 1, dest = {       18,      -1,      54,   0, xi.zone.LOWER_JEUNO            } }, -- Lower Jeuno #2
    [ 37] = { group = 4, fee = 1, dest = {       37,       0,       9,   0, xi.zone.PORT_JEUNO             } }, -- Port Jeuno #1
    [ 38] = { group = 4, fee = 1, dest = {     -155,      -1,      -4,   0, xi.zone.PORT_JEUNO             } }, -- Port Jeuno #2
    [ 39] = { group = 0, fee = 1, dest = {       78,     -13,     -94,   0, xi.zone.KAZHAM                 } }, -- Kazham #1
    [ 40] = { group = 0, fee = 1, dest = {      -13,     -15,      87,   0, xi.zone.MHAURA                 } }, -- Mhaura #1
    [ 41] = { group = 8, fee = 1, dest = {      -27,       0,     -47,   0, xi.zone.NORG                   } }, -- Norg #1
    [ 42] = { group = 9, fee = 1, dest = {      -29,       0,     -76,   0, xi.zone.RABAO                  } }, -- Rabao #1
    [ 43] = { group = 0, fee = 1, dest = {       36,     -11,      35,   0, xi.zone.SELBINA                } }, -- Selbina #1
    [ 44] = { group = 5, fee = 1, dest = {      -84,       4,     -32, 128, xi.zone.WESTERN_ADOULIN        } }, -- Western Adoulin #1
    [ 45] = { group = 5, fee = 1, dest = {      -51,       0,      59, 128, xi.zone.EASTERN_ADOULIN        } }, -- Eastern Adoulin #1
    [ 46] = { group = 0, fee = 2, dest = {     -107,       3,     295, 128, xi.zone.CEIZAK_BATTLEGROUNDS   } }, -- Ceizak Battlegrounds #1
    [ 47] = { group = 0, fee = 2, dest = {     -193,    -0.5,    -252, 128, xi.zone.FORET_DE_HENNETIEL     } }, -- Foret de Hennetiel #1
    [ 48] = { group = 0, fee = 2, dest = {     -415,   -63.2,     409, 106, xi.zone.MORIMAR_BASALT_FIELDS  } }, -- Morimar Basalt Fields #1
    [ 49] = { group = 0, fee = 2, dest = {     -420,       0,     -62,  64, xi.zone.YORCIA_WEALD           } }, -- Yorcia Weald #1
    [ 50] = { group = 0, fee = 2, dest = {      -23,       0,     174,   0, xi.zone.MARJAMI_RAVINE         } }, -- Marjami Ravine #1
    [ 51] = { group = 0, fee = 2, dest = {      210,  20.299,     315, 192, xi.zone.KAMIHR_DRIFTS          } }, -- Kamihr Drifts #1
    [ 52] = { group = 0, fee = 2, dest = {      434,     -40,     171,   0, xi.zone.YUGHOTT_GROTTO         } }, -- Yughott Grotto #1
    [ 53] = { group = 0, fee = 2, dest = {      109,     -38,    -147,   0, xi.zone.PALBOROUGH_MINES       } }, -- Palborough Mines #1
    [ 54] = { group = 0, fee = 2, dest = {     -132,      -3,    -303,   0, xi.zone.GIDDEUS                } }, -- Giddeus #1
    [ 55] = { group = 0, fee = 2, dest = {      243,     -24,      62,   0, xi.zone.FEIYIN                 } }, -- Fei'Yin #1
    [ 56] = { group = 0, fee = 2, dest = {     -984,      17,    -289,   0, xi.zone.QUICKSAND_CAVES        } }, -- Quicksand Caves #1
    [ 57] = { group = 0, fee = 2, dest = {      -80,      46,      62,   0, xi.zone.DEN_OF_RANCOR          } }, -- Den of Rancor #1
    [ 58] = { group = 0, fee = 2, dest = {     -554,     -70,      66,   0, xi.zone.CASTLE_ZVAHL_KEEP      } }, -- Castle Zvahl Keep #1
    [ 59] = { group = 0, fee = 2, dest = {        5,     -42,     526,   0, xi.zone.RUAUN_GARDENS          } }, -- Ru'Aun Gardens #1
    [ 60] = { group = 0, fee = 2, dest = {     -312,     -42,    -422,   0, xi.zone.RUAUN_GARDENS          } }, -- Ru'Aun Gardens #3
    [ 61] = { group = 0, fee = 2, dest = {     -499,     -42,     167,   0, xi.zone.RUAUN_GARDENS          } }, -- Ru'Aun Gardens #2
    [ 62] = { group = 0, fee = 2, dest = {      500,     -42,     158,   0, xi.zone.RUAUN_GARDENS          } }, -- Ru'Aun Gardens #4
    [ 63] = { group = 0, fee = 2, dest = {      305,     -42,    -427,   0, xi.zone.RUAUN_GARDENS          } }, -- Ru'Aun Gardens #5
    [ 64] = { group = 6, fee = 1, dest = {       -1,     -28,     107,   0, xi.zone.TAVNAZIAN_SAFEHOLD     } }, -- Tavnazian Safehold #1
    [ 65] = { group = 7, fee = 1, dest = {      -21,       0,     -21,   0, xi.zone.AHT_URHGAN_WHITEGATE   } }, -- Aht Urhgan Whitegate #1
    [ 66] = { group = 0, fee = 1, dest = {      -20,       0,     -25,   0, xi.zone.NASHMAU                } }, -- Nashmau #1
    [ 67] = { group = 0, fee = 1, dest = {        0,       0,       0,   0, xi.zone.AL_ZAHBI               } }, -- Al Zahbi #1 (DOESN'T CURRENTLY EXIST)
    [ 68] = { group = 0, fee = 1, dest = {      -85,       1,     -66,   0, xi.zone.SOUTHERN_SAN_DORIA_S   } }, -- Southern San d'Oria [ S] #1
    [ 69] = { group = 0, fee = 1, dest = {     -293,     -10,    -102,   0, xi.zone.BASTOK_MARKETS_S       } }, -- Bastok Markets [S] #1
    [ 70] = { group = 0, fee = 1, dest = {      -32,      -5,     131,   0, xi.zone.WINDURST_WATERS_S      } }, -- Windurst Waters [S] #1
    [ 71] = { group = 0, fee = 2, dest = {     -365,  -176.5,     -36,   0, xi.zone.UPPER_DELKFUTTS_TOWER  } }, -- Upper Delkfutt's Tower #1
    [ 72] = { group = 0, fee = 2, dest = {      -13,      48,      61,   0, xi.zone.THE_SHRINE_OF_RUAVITAU } }, -- The Shrine of Ru'Avitau #1
    [ 73] = { group = 0, fee = 2, dest = {     -520,     -18,     505, 127, xi.zone.RIVERNE_SITE_B01       } }, -- Riverne - Site #B01 #1
    [ 74] = { group = 0, fee = 2, dest = {      -98,     -10,    -493, 192, xi.zone.BHAFLAU_THICKETS       } }, -- Bhaflau Thickets #1
    [ 75] = { group = 0, fee = 2, dest = {     -449,      13,    -497,   0, xi.zone.CAEDARVA_MIRE          } }, -- Caedarva Mire #1
    [ 76] = { group = 0, fee = 2, dest = {       64,    -196,     181,   0, xi.zone.ULEGUERAND_RANGE       } }, -- Uleguerand Range #1
    [ 77] = { group = 0, fee = 2, dest = {      380,      23,     -62,   0, xi.zone.ULEGUERAND_RANGE       } }, -- Uleguerand Range #2
    [ 78] = { group = 0, fee = 2, dest = {      424,     -32,     221,   0, xi.zone.ULEGUERAND_RANGE       } }, -- Uleguerand Range #3
    [ 79] = { group = 0, fee = 2, dest = {       64,     -96,     461,   0, xi.zone.ULEGUERAND_RANGE       } }, -- Uleguerand Range #4
    [ 80] = { group = 0, fee = 2, dest = {     -220,      -1,     -62,   0, xi.zone.ULEGUERAND_RANGE       } }, -- Uleguerand Range #5
    [ 81] = { group = 0, fee = 2, dest = {     -200,     -10,     342,   0, xi.zone.ATTOHWA_CHASM          } }, -- Attohwa Chasm #1
    [ 82] = { group = 0, fee = 2, dest = {      -58,      40,      14,  64, xi.zone.PSOXJA                 } }, -- Pso'Xja #1
    [ 83] = { group = 0, fee = 2, dest = {      445,      27,     -22,   0, xi.zone.NEWTON_MOVALPOLOS      } }, -- Newton Movalpolos #1
    [ 84] = { group = 0, fee = 2, dest = {      189,       0,     362,   0, xi.zone.RIVERNE_SITE_A01       } }, -- Riveren - Site #A01 #1
    [ 85] = { group = 0, fee = 2, dest = {        7,       0,     709, 192, xi.zone.ALTAIEU                } }, -- Al'Taieu #1
    [ 86] = { group = 0, fee = 2, dest = {     -532,       0,     447, 128, xi.zone.ALTAIEU                } }, -- Al'Taieu #2
    [ 87] = { group = 0, fee = 2, dest = {      569,       0,     410, 192, xi.zone.ALTAIEU                } }, -- Al'Taieu #3
    [ 88] = { group = 0, fee = 2, dest = {      -12,       0,    -288, 192, xi.zone.GRAND_PALACE_OF_HUXZOI } }, -- Grand Palace of Hu'Xzoi #1
    [ 89] = { group = 0, fee = 2, dest = {     -426,       0,     368, 224, xi.zone.THE_GARDEN_OF_RUHMET   } }, -- The Garden of Ru'Hmet #1
    [ 90] = { group = 0, fee = 2, dest = { -540.844,  -4.000,  70.809,  74, xi.zone.MOUNT_ZHAYOLM          } }, -- Mount Zhayolm #1
    [ 91] = { group = 0, fee = 2, dest = {     -303,      -8,     526,   0, xi.zone.CAPE_TERIGGAN          } }, -- Cape Teriggan #1
    [ 92] = { group = 0, fee = 2, dest = {       88,     -15,    -217,   0, xi.zone.THE_BOYAHDA_TREE       } }, -- The Boyahda Tree #1
    [ 93] = { group = 0, fee = 2, dest = {      182,      34,     -62, 223, xi.zone.DEN_OF_RANCOR          } }, -- Den of Rancor #2
    [ 94] = { group = 0, fee = 2, dest = {      102,       0,     269, 191, xi.zone.FEIYIN                 } }, -- Fei'Yin #2
    [ 95] = { group = 0, fee = 2, dest = {      -63,      50,      81, 192, xi.zone.IFRITS_CAULDRON        } }, -- Ifrit's Cauldron #1
    [ 96] = { group = 0, fee = 2, dest = {      573,       9,    -500,   0, xi.zone.QUICKSAND_CAVES        } }, -- Quicksand Caves #2
    [ 97] = { group = 1, fee = 1, dest = {     -165,      -1,      12,  65, xi.zone.SOUTHERN_SAN_DORIA     } }, -- Southern San d'Oria #4
    [ 98] = { group = 1, fee = 1, dest = {     -132,      12,     194, 170, xi.zone.NORTHERN_SAN_DORIA     } }, -- Northern San d'Oria #4
    [ 99] = { group = 2, fee = 1, dest = {       87,       7,       1,   0, xi.zone.BASTOK_MINES           } }, -- Bastok Mines #3
    [100] = { group = 2, fee = 1, dest = {     -192,      -6,     -69,   0, xi.zone.BASTOK_MARKETS         } }, -- Bastok Markets #4
    [101] = { group = 2, fee = 1, dest = {     -127,      -6,       8, 206, xi.zone.PORT_BASTOK            } }, -- Port Bastok #3
    [102] = { group = 2, fee = 1, dest = {      -76,       2,       3, 124, xi.zone.METALWORKS             } }, -- Metalworks #2
    [103] = { group = 3, fee = 1, dest = {        5,      -4,    -175, 130, xi.zone.WINDURST_WATERS        } }, -- Windurst Waters #3
    [104] = { group = 8, fee = 1, dest = {      -65,      -5,      54, 127, xi.zone.NORG                   } }, -- Norg #2
    [105] = { group = 9, fee = 1, dest = {      -21,       8,     110,  64, xi.zone.RABAO                  } }, -- Rabao #2
    [106] = { group = 7, fee = 1, dest = {      130,       0,     -16,   0, xi.zone.AHT_URHGAN_WHITEGATE   } }, -- Aht Urhgan Whitegate #2
    [107] = { group = 7, fee = 1, dest = {     -108,      -6,     108, 192, xi.zone.AHT_URHGAN_WHITEGATE   } }, -- Aht Urhgan Whitegate #3
    [108] = { group = 7, fee = 1, dest = {      -99,       0,     -68,   0, xi.zone.AHT_URHGAN_WHITEGATE   } }, -- Aht Urhgan Whitegate #4
    [109] = { group = 5, fee = 1, dest = {       32,       0,    -164,  32, xi.zone.WESTERN_ADOULIN        } }, -- Western Adoulin #2
    [110] = { group = 5, fee = 1, dest = {      -51,       0,     -96,  96, xi.zone.EASTERN_ADOULIN        } }, -- Eastern Adoulin #2
    [111] = { group = 0, fee = 2, dest = {      223,     -13,    -254,   0, xi.zone.XARCABARD_S            } }, -- Xarcabard [S] #1
    [112] = { group = 0, fee = 2, dest = {    5.539,  -0.434,   8.133,  73, xi.zone.LEAFALLIA              } }, -- Leafallia #1
    [113] = { group = 0, fee = 2, dest = {     -554,     -70,      66, 128, xi.zone.CASTLE_ZVAHL_KEEP_S    } }, -- Castle Zvahl Keep [S] #1
    [114] = { group = 0, fee = 1, dest = {     -212,     -21,      93,  64, xi.zone.QUFIM_ISLAND           } }, -- Qufim Island #1
    [115] = { group = 0, fee = 1, dest = {   -257.5,      24,      82, 192, xi.zone.TORAIMARAI_CANAL       } }, -- Toraimorai Canal #1
    [116] = { group = 0, fee = 2, dest = {      757,     120,    17.5, 128, xi.zone.RAKAZNAR_INNER_COURT   } }, -- Ra'Kaznar Inner Court #1
    [117] = { group = 0, fee = 2, dest = {      -65,   -17.5,     563, 224, xi.zone.MISAREAUX_COAST        } }, -- Misareaux Coast #1
    [118] = { group = 3, fee = 1, dest = {      -92,      -2,      54, 155, xi.zone.WINDURST_WATERS        } }, -- Windurst Waters #4
    [119] = { group = 3, fee = 1, dest = {    -43.5,       0,    -145,   0, xi.zone.WINDURST_WOODS         } }, -- Windurst Woods #5
    [120] = { group = 6, fee = 1, dest = {       14,   -9.96,      -5,   0, xi.zone.TAVNAZIAN_SAFEHOLD     } }, -- Tavnazian Safehold #2
    [121] = { group = 6, fee = 1, dest = {    73.59, -36.149,   38.87,   0, xi.zone.TAVNAZIAN_SAFEHOLD     } }, -- Tavnazian Safehold #3
}

local selection =
{
    SET_HOMEPOINT = 1,
    TELEPORT      = 2,
    SAME_ZONE     = 3,
    SET_LAYOUT    = 4,
    ADD_FAVORITE  = 5,
    REM_FAVORITE  = 6,
    REP_FAVORITE  = 7,
    SHOW_MENU     = 8
}

local function getCost(from, to, key)
    if
        homepointData[from].group == homepointData[to].group and
        homepointData[to].group ~= 0
    then
        return 0
    else
        return (500 * homepointData[to].fee) / (key and 5 or 1)
    end
end

local function goToHP(player, choice, index)
    local origin = player:getLocalVar("originIndex")
    local hasKI  = player:hasKeyItem(xi.ki.RHAPSODY_IN_WHITE)

    if choice == selection.SAME_ZONE then
        -- For zones like Sky and Uleguerand Range, this will force gil deletion
        -- Positioning within same zone handled by client, no need to setPos
        player:delGil(getCost(origin, origin, hasKI))
    elseif choice == selection.TELEPORT then
        player:delGil(getCost(origin, index, hasKI))
        player:setPos(unpack(homepointData[index].dest))
    end
end

-- Functions called by homepoint scripts.
xi.homepoint.onTrigger = function(player, csid, index)
    if xi.settings.main.HOMEPOINT_TELEPORT ~= 1 then -- Settings.lua Homepoints disabled
        player:startEvent(csid, 0, 0, 0, 0, 0, player:getGil(), 4095, index)
        return
    end

    local hpBit  = index % 32
    local hpSet  = math.floor(index / 32)
    local menu   = player:getTeleportMenu(xi.teleport.type.HOMEPOINT)
    local params = bit.bor(index, bit.lshift(menu[10] < 1 and 0 or 1, 18)) -- Include menu layout

    if not player:hasTeleport(xi.teleport.type.HOMEPOINT, hpBit, hpSet) then
        player:addTeleport(xi.teleport.type.HOMEPOINT, hpBit, hpSet)
        params = bit.bor(params, 0x10000) -- OR in New HP Bit Flag
    end

    if player:hasKeyItem(xi.ki.RHAPSODY_IN_WHITE) then
        -- "Rhapsody in White" key item reduces teleport fee by 80%
        params = bit.bor(params, 0x20000)
    end

    player:setLocalVar("originIndex", index)

    local g1, g2, g3, g4 = unpack(player:getTeleportTable(xi.teleport.type.HOMEPOINT))
    player:startEvent(csid, 1, g1, g2, g3, g4, player:getGil(), 4095, params)
end

xi.homepoint.onEventUpdate = function(player, csid, option)
    local choice = bit.band(option, 0xFF)
    local favs   = player:getTeleportMenu(xi.teleport.type.HOMEPOINT)

    if xi.settings.main.HOMEPOINT_TELEPORT == 1 then
        if choice >= selection.SET_LAYOUT and choice <= selection.REP_FAVORITE then

            local index = bit.rshift(bit.lshift(option, 8), 24) -- Ret HP #

            if choice == selection.ADD_FAVORITE then
                local temp = 0
                for x = 1, 9 do
                    temp = favs[x]
                    favs[x] = index
                    index = temp
                end
            elseif choice == selection.REM_FAVORITE then
                for x = 1, 9 do
                    if favs[x] == index then
                        for y = x, 8 do
                            favs[y] = favs[y + 1]
                        end

                        favs[9] = -1
                        break
                    end
                end
            elseif choice == selection.REP_FAVORITE then
                favs[bit.rshift(option, 24) + 1] = index
            elseif choice == selection.SET_LAYOUT then
                -- 1 = Sort by content/expansion else sort by region
                favs[10] = bit.rshift(option, 16) == 1 and 1 or 0
            end

            player:setTeleportMenu(xi.teleport.type.HOMEPOINT, favs)
        end

        for x = 1, 3 do -- Condense arrays for event params
            favs[1] = favs[1] + favs[x + 1] * 256^x
            favs[5] = favs[5] + favs[x + 5] * 256^x
        end

        favs[9] = favs[9] + favs[10] * 256
        player:updateEvent(favs[1], favs[5], favs[9])
    else
        player:updateEvent(-1, -1, -1)
    end
end

xi.homepoint.onEventFinish = function(player, csid, option, event)
    if csid == event then
        local choice = bit.band(option, 0xFF)

        if choice == selection.SET_HOMEPOINT then
            player:setHomePoint()
            if zones[player:getZoneID()].text.HOMEPOINT_SET then
                player:messageSpecial(zones[player:getZoneID()].text.HOMEPOINT_SET)
            else
                print(string.format("ERROR: missing ID.text.HOMEPOINT_SET in zone %s.", player:getZoneName()))
            end
        elseif
            xi.settings.main.HOMEPOINT_TELEPORT == 1 and
            (choice == selection.TELEPORT or choice == selection.SAME_ZONE)
        then
            goToHP(player, choice, bit.rshift(option, 16))
        end
    end
end
