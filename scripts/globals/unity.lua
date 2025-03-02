-----------------------------------
-- Unity Concord NPC Global
-----------------------------------
require('scripts/globals/utils')
-----------------------------------
xi = xi or {}
xi.unity = xi.unity or {}

-- Table Format: Needs 10 RoE Objectives, All for One not set, All for One set, Unity Joined, Zone Directory Name
local zoneEventIds =
{
    [xi.zone.SOUTHERN_SAN_DORIA] = { 3528, 3525, 3526, 3529 },
    [xi.zone.BASTOK_MARKETS    ] = {  597,  594,  595,  598 },
    [xi.zone.WINDURST_WOODS    ] = {  878,  875,  876,  879 },
    [xi.zone.WESTERN_ADOULIN   ] = { 5148, 5145, 5146, 5149 },
}

-- Table Format: X, Y, Z, Rot, Zone ID
local unityOptions =
{
    [1] =
    { -- Unity Warp
        [ 0] = {  176.000,  -20.002, -240.000,   7, xi.zone.EAST_RONFAURE           },
        [ 1] = { -450.000,   38.750, -149.000,  95, xi.zone.SOUTH_GUSTABERG         },
        [ 2] = {  358.750,  -12.375,   10.000, 127, xi.zone.EAST_SARUTABARUTA       },
        [ 3] = {    2.180,    0.000,    0.420, 114, xi.zone.LA_THEINE_PLATEAU       },
        [ 4] = { -112.100,   12.428,  271.180, 166, xi.zone.KONSCHTAT_HIGHLANDS     },
        [ 5] = {  360.000,   -0.133,  -45.000,  83, xi.zone.TAHRONGI_CANYON         },
        [ 6] = {   63.000,    1.149,  -75.000, 179, xi.zone.VALKURM_DUNES           },
        [ 7] = { -325.560,  -40.923,  286.500,  40, xi.zone.BUBURIMU_PENINSULA      },
        [ 8] = {  187.500,  -21.374,  -20.200, 131, xi.zone.QUFIM_ISLAND            },
        [ 9] = {  641.500,  -20.000,  881.500,  85, xi.zone.BIBIKI_BAY              },
        [10] = {   34.500,   -5.861, -740.820, 253, xi.zone.CARPENTERS_LANDING      },
        [11] = { -478.620,   16.301, -379.840,   0, xi.zone.YUHTUNGA_JUNGLE         },
        [12] = {  408.000,   -0.375,  -73.520,  99, xi.zone.LUFAISE_MEADOWS         },
        [13] = {   60.000,    0.549,  -10.000, 192, xi.zone.JUGNER_FOREST           },
        [14] = { -499.000,   25.000, -597.500, 192, xi.zone.PASHHOW_MARSHLANDS      },
        [15] = { -159.220,  -24.000, -560.320, 144, xi.zone.MERIPHATAUD_MOUNTAINS   },
        [16] = {  454.810,  -11.415,  -25.850,  91, xi.zone.EASTERN_ALTEPA_DESERT   },
        [17] = {  253.850,    3.228,  103.290,  81, xi.zone.YHOATOR_JUNGLE          },
        [18] = {  508.600,    2.450, -577.550, 143, xi.zone.THE_SANCTUARY_OF_ZITAH  },
        [19] = { -245.460,  -32.247,  245.440,  31, xi.zone.MISAREAUX_COAST         },
        [20] = {  -60.000,    5.209,  110.000, 192, xi.zone.LABYRINTH_OF_ONZOZO     },
        [21] = { -378.000,   -4.000, -220.000,   0, xi.zone.BOSTAUNIEUX_OUBLIETTE   },
        [22] = {  439.530,    8.212, -151.750, 148, xi.zone.BATALLIA_DOWNS          },
        [23] = { -770.980,  -35.768, -491.900, 222, xi.zone.ROLANBERRY_FIELDS       },
        [24] = {  303.910,   37.775,  305.350, 160, xi.zone.SAUROMUGUE_CHAMPAIGN    },
        [25] = {  120.570,   -3.645, -179.600, 255, xi.zone.BEAUCEDINE_GLACIER      },
        [26] = {  576.200,    0.000, -264.850, 110, xi.zone.XARCABARD               },
        [27] = {    0.000,   -8.000, -145.000, 192, xi.zone.ROMAEVE                 },
        [28] = {   91.340,   -1.167,  -23.440, 127, xi.zone.WESTERN_ALTEPA_DESERT   },
        [29] = { -311.000,   -5.085,  167.000, 111, xi.zone.ATTOHWA_CHASM           },
        [30] = { -300.000,   18.000,  322.500,  63, xi.zone.GARLAIGE_CITADEL        },
        [31] = {   80.000,    0.000,  259.000, 127, xi.zone.IFRITS_CAULDRON         },
        [32] = {  -60.000,  -19.329,   17.000,  15, xi.zone.THE_BOYAHDA_TREE        },
        [33] = {   27.450,  -13.531,  264.000,   7, xi.zone.KUFTAL_TUNNEL           },
        [34] = {   18.500,   19.969, -105.500,  99, xi.zone.SEA_SERPENT_GROTTO      },
        [35] = {  -60.000,   -8.000,   82.000,  63, xi.zone.TEMPLE_OF_UGGALEPIH     },
        [36] = {  860.000,   -8.094, -372.000,  63, xi.zone.QUICKSAND_CAVES         },
        [37] = {  100.000,  -12.000, -163.000,  63, xi.zone.WAJAOM_WOODLANDS        },
        [38] = {  408.000,   -0.375,  -73.520,  99, xi.zone.LUFAISE_MEADOWS         },
        [39] = {   68.230,   -6.185,  148.040,   0, xi.zone.CAPE_TERIGGAN           },
        [40] = nil, -- no option
        [41] = { -418.320,  -16.758, -103.470, 176, xi.zone.ULEGUERAND_RANGE        },
        [42] = {   23.750,   26.593, -259.740, 212, xi.zone.DEN_OF_RANCOR           },
        [43] = { -177.000,  -23.979, -171.000, 232, xi.zone.FEIYIN                  },
        [44] = nil, -- no option
        [45] = { -100.000,   -8.500,   20.000,  63, xi.zone.ALZADAAL_UNDERSEA_RUINS },
        [46] = { -245.460,  -32.247,  245.440,  31, xi.zone.MISAREAUX_COAST         },
        [47] = { -613.000,  -21.301,  230.000, 224, xi.zone.MOUNT_ZHAYOLM           },
        [48] = {  -60.000,  -10.000, -119.000, 192, xi.zone.GUSTAV_TUNNEL           },
        [49] = { -183.100,  -19.854,   57.900, 127, xi.zone.BEHEMOTHS_DOMINION      },
        [50] = {  -60.000,  -19.329,   17.000,  15, xi.zone.THE_BOYAHDA_TREE        },
        [51] = { -141.500,   -5.511,   19.800,  31, xi.zone.VALLEY_OF_SORROWS       },
        [52] = {  100.000,  -12.000, -163.000,  63, xi.zone.WAJAOM_WOODLANDS        },
        [53] = { -613.000,  -21.301,  230.000, 224, xi.zone.MOUNT_ZHAYOLM           },
        [54] = {  660.000,   -4.000,  239.500,  79, xi.zone.CAEDARVA_MIRE           },
        [55] = {    9.500,   21.123,   87.500,   0, xi.zone.AYDEEWA_SUBTERRANE      },
    },

    [4] = -- Items (Item ID, askQuantity (0 = true), limitSize (99 = limit by accolades), cost)
    {
        [ 0] = { xi.item.REFRACTIVE_CRYSTAL,          0, 99, 15000 },
        [ 1] = { xi.item.SPECIAL_GOBBIEDIAL_KEY,      0, 99, 15000 },
        [ 2] = { xi.item.SCROLL_OF_INSTANT_WARP,      1,  1, 10    },
        [ 3] = { xi.item.SCROLL_OF_INSTANT_RERAISE,   1,  1, 10    },
        [ 4] = { xi.item.SCROLL_OF_INSTANT_PROTECT,   1,  1, 10    },
        [ 5] = { xi.item.SCROLL_OF_INSTANT_SHELL,     1,  1, 10    },
        [ 6] = { xi.item.MOIST_ROLANBERRY,            0, 99, 10    },
        [ 7] = { xi.item.CLUMP_OF_RAVAGED_MOKO_GRASS, 0, 99, 10    },
        [ 8] = { xi.item.CAVORTING_WORM,              0, 99, 10    },
        [ 9] = { xi.item.LEVIGATED_ROCK,              0, 99, 10    },
        [10] = { xi.item.LITTLE_LUGWORM,              0, 99, 10    },
        [11] = { xi.item.TRAINING_MANUAL,             0, 99, 10    },
        [12] = { xi.item.PINCH_OF_PRIZE_POWDER,       0, 99, 10    },
    },
}

local function changeUnityLeader(player, leader)
    player:setCharVar('unity_changed', 1)
    player:setCurrency('current_accolades', 0)
    player:setCurrency('prev_accolades', 0)
    player:setUnityLeader(leader)
end

local function getChangeUnityCost(player, selection)
    local currentRank = player:getUnityRank()
    local newRank     = player:getUnityRank(selection)
    local changeCost  = (500 * (11 - newRank)) - ((11 - currentRank) * 400)

    if changeCost < 100 then
        changeCost = 100
    end

    return changeCost
end

function xi.unity.onTrade(player, npc, trade, eventid)
end

function xi.unity.onTrigger(player, npc)
    local zoneId             = player:getZoneID()
    local hasAllForOne       = player:hasEminenceRecord(5)
    local allForOneCompleted = player:getEminenceCompleted(5)
    local accolades          = player:getCurrency('unity_accolades')
    local remainingLimit     = xi.settings.main.WEEKLY_EXCHANGE_LIMIT - player:getCharVar('weekly_accolades_spent')

    -- Check player total records completed
    if player:getNumEminenceCompleted() < 10 then
        player:startEvent(zoneEventIds[zoneId][1])

    -- Check for 'All for One'
    elseif
        not hasAllForOne and
        not allForOneCompleted
    then
        player:startEvent(zoneEventIds[zoneId][2])

    -- First time selecting Unity
    elseif not allForOneCompleted then
        player:startEvent(zoneEventIds[zoneId][3])
    else
        player:startEvent(zoneEventIds[zoneId][4], 0, player:getUnityLeader(), accolades, remainingLimit, 0, 0, 0, 0)
    end
end

function xi.unity.onEventUpdate(player, csid, option, npc)
    local zoneId               = player:getZoneID()
    local ID                   = zones[zoneId]
    local accolades            = player:getCurrency('unity_accolades')
    local weeklyAccoladesSpent = player:getCharVar('weekly_accolades_spent')
    local remainingLimit       = xi.settings.main.WEEKLY_EXCHANGE_LIMIT - player:getCharVar('weekly_accolades_spent')
    local category             = bit.band(option, 0xF)
    local selection            = bit.band(bit.rshift(option, 5), 0xFF)

    if csid == zoneEventIds[zoneId][4] then
        if option == 10 then
            player:updateEvent(0, 0, 0, remainingLimit, 0, 0, 0, 0)

        -- Item Selected, enter amount/confirm
        elseif category == 3 then
            player:updateEvent(unityOptions[4][selection][2], unityOptions[4][selection][3], 0, 0, 0, 0, 0, player:getUnityLeader())

        -- Attempt to grant the Item selected
        elseif category == 4 then
            local qty    = bit.rshift(option, 13)
            local itemId = unityOptions[category][selection][1]
            local cost   = unityOptions[category][selection][4] * qty

            if npcUtil.giveItem(player, { { itemId, qty } }) then
                accolades = accolades - cost
                player:delCurrency('unity_accolades', cost)
                if xi.settings.main.ENABLE_EXCHANGE_LIMIT == 1 then
                    remainingLimit = remainingLimit - cost
                    player:setCharVar('weekly_accolades_spent', weeklyAccoladesSpent + cost)
                end

                player:updateEvent(itemId, qty, accolades, remainingLimit, 0, 0, 0, player:getUnityLeader())
            else
                player:updateEvent(utils.MAX_UINT32)
            end

        -- Change Unity
        elseif category == 5 then
            if player:getCharVar('unity_changed') == 1 then
                player:updateEvent(utils.MAX_UINT32)
                player:messageSpecial(ID.text.HAVE_ALREADY_CHANGED_UNITY, option)
            else
                local changeUnityCost = getChangeUnityCost(player, selection)
                player:updateEvent(changeUnityCost, changeUnityCost)
            end
        end
    end
end

function xi.unity.onEventFinish(player, csid, option, npc)
    local zoneId    = player:getZoneID()
    local ID        = zones[zoneId]
    local category  = bit.band(option, 0x1F)
    local selection = bit.rshift(option, 5) -- This may need tuning for other menu options

    -- First time joining Unity (Requirements met for num Objectives and All for One set)
    if
        csid == zoneEventIds[zoneId][3] and
        option >= 1 and
        option <= 11
    then
        changeUnityLeader(player, option)
        xi.roe.onRecordTrigger(player, 5)
        player:messageSpecial(ID.text.YOU_HAVE_JOINED_UNITY, option - 1)

    -- Player is a member of a Unity
    elseif csid == zoneEventIds[zoneId][4] then

        -- Unity Warp
        if category == 1 and unityOptions[category][selection] ~= nil then
            player:delCurrency('unity_accolades', 100)
            player:setPos(unpack(unityOptions[category][selection]))

        -- Change Unity
        elseif category == 6 then
            local newUnityLeader = bit.band(selection, 0xF)

            player:delCurrency('unity_accolades', getChangeUnityCost(player, newUnityLeader))
            changeUnityLeader(player, newUnityLeader)
            player:messageSpecial(ID.text.YOU_HAVE_JOINED_UNITY, newUnityLeader - 1)
        end
    end
end
