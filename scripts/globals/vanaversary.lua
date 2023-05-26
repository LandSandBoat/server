-------------------------------------
-- Vana'versary Celebration Campaign
-------------------------------------
require('scripts/globals/settings')
require('scripts/globals/items')
require('scripts/globals/npc_util')
-------------------------------------

xi = xi or {}
xi.vanaversary = {}

xi.vanaversary.active =
{
    INACTIVE = 0,
    ACTIVE   = 1,
}

----------------------------------------------------
-- Index of Vanaversary Coffer Items Female and Male
----------------------------------------------------

xi.vanaversary.cofferItemsF =
{
    [ 0] = { xi.items.DINNER_JACKET                     },
    [ 1] = { xi.items.DINNER_HOSE                       },
    [ 2] = { xi.items.NOVENNIAL_DRESS                   },
    [ 3] = { xi.items.NOVENNIAL_THIGH_BOOTS             },
    [ 4] = { xi.items.DECENNIAL_TIARA                   },
    [ 5] = { xi.items.DECENNIAL_DRESS                   },
    [ 6] = { xi.items.DECENNIAL_HOSE                    },
    [ 7] = { xi.items.DECENNIAL_TIARA_P1                },
    [ 8] = { xi.items.DECENNIAL_DRESS_P1                },
    [ 9] = { xi.items.DECENNIAL_HOSE_P1                 },
    [10] = { xi.items.MEMORIAL_CAKE                     },
    [11] = { xi.items.MOOGLE_GUARD                      },
    [12] = { xi.items.CHOCOBO_SHIELD                    },
    [13] = { xi.items.MOOGLE_GUARD_P1                   },
    [14] = { xi.items.CHOCOBO_SHIELD_P1                 },
    [15] = { xi.items.GREEN_MOOGLE_MASQUE               },
    [16] = { xi.items.GREEN_MOOGLE_SUIT                 },
    [17] = { xi.items.GOBLIN_MASQUE                     },
    [18] = { xi.items.GOBLIN_SUIT                       },
    [19] = { xi.items.CIPHER_OF_A_MOOGLES_ALTER_EGO     },
    [20] = { xi.items.CIPHER_OF_FABLINIXS_ALTER_EGO     },
    [21] = { xi.items.CIPHER_OF_ALDOS_ALTER_EGO         },
    [22] = { xi.items.BEHEMOTH_MASQUE                   },
    [23] = { xi.items.BEHEMOTH_SUIT                     },
    [24] = { xi.items.BEHEMOTH_MASQUE_P1                },
    [25] = { xi.items.BEHEMOTH_SUIT_P1                  },
    [26] = { xi.items.VANACLOCK                         },
    [27] = { xi.items.CIPHER_OF_KUPOFRIEDS_ALTER_EGO    },
    [28] = { xi.items.AKITU_SHIRT                       },
    [29] = { xi.items.RED_CRAB_NOTEBOOK                 },
    [30] = { xi.items.CRUSTACEAN_SHIRT                  },
    [31] = { xi.items.HAPY_STAFF                        },
    [32] = { xi.items.CORNELIA_STATUE                   },
    [33] = { xi.items.PREMIUM_MOGTI                     },
    [34] = { xi.items.JODY_SHIRT                        },
    [35] = { xi.items.JODY_SHIELD                       },
    [36] = { xi.items.MANDRAGORA_SHIRT                  },
    [37] = { xi.items.PAINTING_OF_A_MERCENARY           },
    [38] = { xi.items.KORRIGAN_POT                      },
    [39] = { xi.items.ADENIUM_POT                       },
    [40] = { xi.items.CITRULLUS_POT                     },
}

xi.vanaversary.cofferItemsM =
{
    [ 0] = { xi.items.DINNER_JACKET                     },
    [ 1] = { xi.items.DINNER_HOSE                       },
    [ 2] = { xi.items.NOVENNIAL_COAT                    },
    [ 3] = { xi.items.NOVENNIAL_HOSE                    },
    [ 4] = { xi.items.DECENNIAL_CROWN                   },
    [ 5] = { xi.items.DECENNIAL_COAT                    },
    [ 6] = { xi.items.DECENNIAL_TIGHTS                  },
    [ 7] = { xi.items.DECENNIAL_CROWN_P1                },
    [ 8] = { xi.items.DECENNIAL_COAT_P1                 },
    [ 9] = { xi.items.DECENNIAL_TIGHTS_P1               },
    [10] = { xi.items.MEMORIAL_CAKE                     },
    [11] = { xi.items.MOOGLE_GUARD                      },
    [12] = { xi.items.CHOCOBO_SHIELD                    },
    [13] = { xi.items.MOOGLE_GUARD_P1                   },
    [14] = { xi.items.CHOCOBO_SHIELD_P1                 },
    [15] = { xi.items.GREEN_MOOGLE_MASQUE               },
    [16] = { xi.items.GREEN_MOOGLE_SUIT                 },
    [17] = { xi.items.GOBLIN_MASQUE                     },
    [18] = { xi.items.GOBLIN_SUIT                       },
    [19] = { xi.items.CIPHER_OF_A_MOOGLES_ALTER_EGO     },
    [20] = { xi.items.CIPHER_OF_FABLINIXS_ALTER_EGO     },
    [21] = { xi.items.CIPHER_OF_ALDOS_ALTER_EGO         },
    [22] = { xi.items.BEHEMOTH_MASQUE                   },
    [23] = { xi.items.BEHEMOTH_SUIT                     },
    [24] = { xi.items.BEHEMOTH_MASQUE_P1                },
    [25] = { xi.items.BEHEMOTH_SUIT_P1                  },
    [26] = { xi.items.VANACLOCK                         },
    [27] = { xi.items.CIPHER_OF_KUPOFRIEDS_ALTER_EGO    },
    [28] = { xi.items.AKITU_SHIRT                       },
    [29] = { xi.items.RED_CRAB_NOTEBOOK                 },
    [30] = { xi.items.CRUSTACEAN_SHIRT                  },
    [31] = { xi.items.HAPY_STAFF                        },
    [32] = { xi.items.CORNELIA_STATUE                   },
    [33] = { xi.items.PREMIUM_MOGTI                     },
    [34] = { xi.items.JODY_SHIRT                        },
    [35] = { xi.items.JODY_SHIELD                       },
    [36] = { xi.items.MANDRAGORA_SHIRT                  },
    [37] = { xi.items.PAINTING_OF_A_MERCENARY           },
    [38] = { xi.items.KORRIGAN_POT                      },
    [39] = { xi.items.ADENIUM_POT                       },
    [40] = { xi.items.CITRULLUS_POT                     },
}

xi.vanaversary.goods = xi.vanaversary.cofferItemsF -- Default to Female Goods

xi.vanaversary.campaignActive = function()
    return xi.settings.main.VANAVERSARY_CAMPAIGN
end

---------------------------------------------------------
-- Check if Vana'versary is active, hide NPCs if inactive
---------------------------------------------------------

xi.vanaversary.hideNpc = function(npc)
    local active = xi.vanaversary.campaignActive()

    if active == xi.vanaversary.active.INACTIVE then
        GetNPCByID(npc):setStatus(xi.status.DISAPPEAR)
    end
end

---------------------------------
-- "Free to Take" Treasure Coffer
---------------------------------

xi.vanaversary.treasureCoffer = function(player, csid, option)
    if player:getGender() == 1 then -- Male
        xi.vanaversary.goods = xi.vanaversary.cofferItemsM
    end

    player:startEvent(csid)
end

xi.vanaversary.treaureCofferGoods = function(player, csid, option)
    npcUtil.giveItem(player, xi.vanaversary.goods[option])
end

---------------------------------------------
-- Vanaversary Moogle (Next to Coffer) Dialog
---------------------------------------------

xi.vanaversary.cofferMoogle = function(player, csid)
    local greeting = player:getCharVar("[VANAVERSARY]CofferGreeting")

    if not player:hasItem(xi.items.MOOGLE_SHIRT) then
        if greeting > 0 then
            player:startEvent(csid, 2)
        else
            player:startEvent(csid)
        end
    else
        player:startEvent(csid, greeting)
    end
end

xi.vanaversary.cofferMoogleEnd = function(player, csid)
    if not player:hasItem(xi.items.MOOGLE_SHIRT) then
        npcUtil.giveItem(player, xi.items.MOOGLE_SHIRT)
    end

    if player:getCharVar("[VANAVERSARY]CofferGreeting") ~= 1 then
        player:setCharVar("[VANAVERSARY]CofferGreeting", 1)
    end
end

-----------------
-- History Moogle
-----------------

xi.vanaversary.historyRewards =
{
    [0] = { xi.items.ECHAD_RING     },
    [1] = { xi.items.TRIZEK_RING    },
    [2] = { xi.items.CALIBER_RING   },
    [3] = { xi.items.FACILITY_RING  },
    [4] = { xi.items.LEAF_BENCH     },
    [5] = { xi.items.ASTRAL_CUBE    },
    [6] = { xi.items.ALLIANCE_SHIRT }
}

xi.vanaversary.historyMoogle = function(player, csid)
    local chatHist          = player:getHistory(xi.history.CHATS_SENT)
    local npcHist           = player:getHistory(xi.history.NPC_INTERACTIONS)
    local partiesJoined     = player:getHistory(xi.history.JOINED_PARTIES)
    local allianceJoined    = player:getHistory(xi.history.JOINED_ALLIANCES)
    local battlesFought     = player:getHistory(xi.history.BATTLES_FOUGHT)
    local koCount           = player:getHistory(xi.history.TIMES_KNOCKED_OUT)
    local enemiesDefeated   = player:getHistory(xi.history.ENEMIES_DEFEATED)
    local gmCalls           = player:getHistory(xi.history.GM_CALLS)

    player:startEvent(csid, chatHist, npcHist, partiesJoined, allianceJoined, battlesFought, koCount, enemiesDefeated, gmCalls)
end

xi.vanaversary.historyMoogleUpdate = function(player, csid, option)
    local rewardsClaimed = player:getCharVar("[VANAVERSARY]RewardCount")

    player:updateEvent(0, 0, 0, 0, 0, 0, rewardsClaimed, 0)

    if option < 7 then
        if rewardsClaimed == 0 then
            if npcUtil.giveItem(player, xi.vanaversary.historyRewards[option]) then
                player:incrementCharVar("[VANAVERSARY]RewardCount", 1)
            end
        elseif rewardsClaimed == 1 then
            if npcUtil.giveItem(player, xi.vanaversary.historyRewards[option]) then
                player:incrementCharVar("[VANAVERSARY]RewardCount", 2) -- Not enough information is available for the "Bonus" time based gift to implement.
            end
        end
    end
end
