-----------------------------------
-- Wardrobe Unlock System
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('phoenix_wardrobe_unlocks')

local bagNames =
{
    [xi.inv.WARDROBE ] = 'Mog Wardrobe 1',
    [xi.inv.WARDROBE2] = 'Mog Wardrobe 2',
    [xi.inv.WARDROBE3] = 'Mog Wardrobe 3',
    [xi.inv.WARDROBE4] = 'Mog Wardrobe 4',
}

local missionRewards =
{
    [xi.mission.log_id.SANDORIA] =
    {
        [xi.mission.id.sandoria.SMASH_THE_ORCISH_SCOUTS] = { var = '[Wardrobe]Nation_Rank_1',  bag = xi.inv.WARDROBE, amount = 5 },
        [xi.mission.id.sandoria.SAVE_THE_CHILDREN      ] = { var = '[Wardrobe]Nation_Rank_2',  bag = xi.inv.WARDROBE, amount = 5 },
        [xi.mission.id.sandoria.JOURNEY_ABROAD         ] = { var = '[Wardrobe]Nation_Rank_3',  bag = xi.inv.WARDROBE, amount = 5 },
        [xi.mission.id.sandoria.APPOINTMENT_TO_JEUNO   ] = { var = '[Wardrobe]Nation_Rank_4',  bag = xi.inv.WARDROBE, amount = 5 },
        [xi.mission.id.sandoria.MAGICITE               ] = { var = '[Wardrobe]Nation_Rank_5',  bag = xi.inv.WARDROBE, amount = 5 },
        [xi.mission.id.sandoria.THE_SHADOW_LORD        ] = { var = '[Wardrobe]Nation_Rank_6',  bag = xi.inv.WARDROBE, amount = 5 },
        [xi.mission.id.sandoria.RANPERRES_FINAL_REST   ] = { var = '[Wardrobe]Nation_Rank_7',  bag = xi.inv.WARDROBE, amount = 5 },
        [xi.mission.id.sandoria.THE_SECRET_WEAPON      ] = { var = '[Wardrobe]Nation_Rank_8',  bag = xi.inv.WARDROBE, amount = 5 },
        [xi.mission.id.sandoria.LIGHTBRINGER           ] = { var = '[Wardrobe]Nation_Rank_9',  bag = xi.inv.WARDROBE, amount = 5 },
        [xi.mission.id.sandoria.THE_HEIR_TO_THE_LIGHT  ] = { var = '[Wardrobe]Nation_Rank_10', bag = xi.inv.WARDROBE, amount = 5 },
    },

    [xi.mission.log_id.BASTOK] =
    {
        [xi.mission.id.bastok.THE_ZERUHN_REPORT       ] = { var = '[Wardrobe]Nation_Rank_1',  bag = xi.inv.WARDROBE, amount = 5 },
        [xi.mission.id.bastok.FETICHISM               ] = { var = '[Wardrobe]Nation_Rank_2',  bag = xi.inv.WARDROBE, amount = 5 },
        [xi.mission.id.bastok.THE_EMISSARY            ] = { var = '[Wardrobe]Nation_Rank_3',  bag = xi.inv.WARDROBE, amount = 5 },
        [xi.mission.id.bastok.JEUNO                   ] = { var = '[Wardrobe]Nation_Rank_4',  bag = xi.inv.WARDROBE, amount = 5 },
        [xi.mission.id.bastok.MAGICITE                ] = { var = '[Wardrobe]Nation_Rank_5',  bag = xi.inv.WARDROBE, amount = 5 },
        [xi.mission.id.bastok.XARCABARD_LAND_OF_TRUTHS] = { var = '[Wardrobe]Nation_Rank_6',  bag = xi.inv.WARDROBE, amount = 5 },
        [xi.mission.id.bastok.THE_PIRATES_COVE        ] = { var = '[Wardrobe]Nation_Rank_7',  bag = xi.inv.WARDROBE, amount = 5 },
        [xi.mission.id.bastok.ON_MY_WAY               ] = { var = '[Wardrobe]Nation_Rank_8',  bag = xi.inv.WARDROBE, amount = 5 },
        [xi.mission.id.bastok.ENTER_THE_TALEKEEPER    ] = { var = '[Wardrobe]Nation_Rank_9',  bag = xi.inv.WARDROBE, amount = 5 },
        [xi.mission.id.bastok.WHERE_TWO_PATHS_CONVERGE] = { var = '[Wardrobe]Nation_Rank_10', bag = xi.inv.WARDROBE, amount = 5 },
    },

    [xi.mission.log_id.WINDURST] =
    {
        [xi.mission.id.windurst.THE_HORUTOTO_RUINS_EXPERIMENT] = { var = '[Wardrobe]Nation_Rank_1',  bag = xi.inv.WARDROBE, amount = 5 },
        [xi.mission.id.windurst.THE_PRICE_OF_PEACE           ] = { var = '[Wardrobe]Nation_Rank_2',  bag = xi.inv.WARDROBE, amount = 5 },
        [xi.mission.id.windurst.THE_THREE_KINGDOMS           ] = { var = '[Wardrobe]Nation_Rank_3',  bag = xi.inv.WARDROBE, amount = 5 },
        [xi.mission.id.windurst.A_NEW_JOURNEY                ] = { var = '[Wardrobe]Nation_Rank_4',  bag = xi.inv.WARDROBE, amount = 5 },
        [xi.mission.id.windurst.MAGICITE                     ] = { var = '[Wardrobe]Nation_Rank_5',  bag = xi.inv.WARDROBE, amount = 5 },
        [xi.mission.id.windurst.THE_SHADOW_AWAITS            ] = { var = '[Wardrobe]Nation_Rank_6',  bag = xi.inv.WARDROBE, amount = 5 },
        [xi.mission.id.windurst.SAINTLY_INVITATION           ] = { var = '[Wardrobe]Nation_Rank_7',  bag = xi.inv.WARDROBE, amount = 5 },
        [xi.mission.id.windurst.AWAKENING_OF_THE_GODS        ] = { var = '[Wardrobe]Nation_Rank_8',  bag = xi.inv.WARDROBE, amount = 5 },
        [xi.mission.id.windurst.THE_JESTER_WHOD_BE_KING      ] = { var = '[Wardrobe]Nation_Rank_9',  bag = xi.inv.WARDROBE, amount = 5 },
        [xi.mission.id.windurst.MOON_READING                 ] = { var = '[Wardrobe]Nation_Rank_10', bag = xi.inv.WARDROBE, amount = 5 },
    },

    [xi.mission.log_id.ZILART] =
    {
        [xi.mission.id.zilart.THE_TEMPLE_OF_UGGALEPIH    ] = { var = '[Wardrobe]Zilart_4',    bag = xi.inv.WARDROBE3, amount = 5 },
        [xi.mission.id.zilart.THROUGH_THE_QUICKSAND_CAVES] = { var = '[Wardrobe]Zilart_6',    bag = xi.inv.WARDROBE3, amount = 5 },
        [xi.mission.id.zilart.RETURN_TO_DELKFUTTS_TOWER  ] = { var = '[Wardrobe]Zilart_8',    bag = xi.inv.WARDROBE3, amount = 5 },
        [xi.mission.id.zilart.THE_GATE_OF_THE_GODS       ] = { var = '[Wardrobe]Zilart_13',   bag = xi.inv.WARDROBE3, amount = 5 },
        [xi.mission.id.zilart.ARK_ANGELS                 ] = { var = '[Wardrobe]DivineMight', bag = xi.inv.WARDROBE3, amount = 5 },
        [xi.mission.id.zilart.THE_CELESTIAL_NEXUS        ] = { var = '[Wardrobe]Zilart_16',   bag = xi.inv.WARDROBE3, amount = 5, deferred = true }, -- Warps to Hall of the Gods
    },

    [xi.mission.log_id.COP] =
    {
        [xi.mission.id.cop.THE_MOTHERCRYSTALS  ] = { var = '[Wardrobe]CoP_1_3', bag = xi.inv.WARDROBE2, amount = 5, deferred = true }, -- Warps to Lufaise Meadows
        [xi.mission.id.cop.ANCIENT_VOWS        ] = { var = '[Wardrobe]CoP_2_5', bag = xi.inv.WARDROBE2, amount = 5, deferred = true }, -- Warps to South Gustaberg
        [xi.mission.id.cop.THE_ROAD_FORKS      ] = { var = '[Wardrobe]CoP_3_3', bag = xi.inv.WARDROBE2, amount = 5  },
        [xi.mission.id.cop.DARKNESS_NAMED      ] = { var = '[Wardrobe]CoP_3_5', bag = xi.inv.WARDROBE2, amount = 5  },
        [xi.mission.id.cop.THE_SAVAGE          ] = { var = '[Wardrobe]CoP_4_2', bag = xi.inv.WARDROBE2, amount = 5  },
        [xi.mission.id.cop.DESIRES_OF_EMPTINESS] = { var = '[Wardrobe]CoP_5_2', bag = xi.inv.WARDROBE2, amount = 5  },
        [xi.mission.id.cop.THREE_PATHS         ] = { var = '[Wardrobe]CoP_5_3', bag = xi.inv.WARDROBE2, amount = 10 },
        [xi.mission.id.cop.ONE_TO_BE_FEARED    ] = { var = '[Wardrobe]CoP_6_4', bag = xi.inv.WARDROBE2, amount = 5, deferred = true }, -- Warps to Lufaise Meadows
        [xi.mission.id.cop.THE_WARRIORS_PATH   ] = { var = '[Wardrobe]CoP_7_5', bag = xi.inv.WARDROBE2, amount = 5  },
        [xi.mission.id.cop.WHEN_ANGELS_FALL    ] = { var = '[Wardrobe]CoP_8_3', bag = xi.inv.WARDROBE2, amount = 5  },
        [xi.mission.id.cop.DAWN                ] = { var = '[Wardrobe]CoP_8_4', bag = xi.inv.WARDROBE2, amount = 5  },
    },

    [xi.mission.log_id.TOAU] =
    {
        [xi.mission.id.toau.THE_BLACK_COFFIN   ] = { var = '[Wardrobe]ToAU_1', bag = xi.inv.WARDROBE3, amount = 5  },
        [xi.mission.id.toau.SHIELD_OF_DIPLOMACY] = { var = '[Wardrobe]ToAU_2', bag = xi.inv.WARDROBE3, amount = 5  },
        [xi.mission.id.toau.PUPPET_IN_PERIL    ] = { var = '[Wardrobe]ToAU_3', bag = xi.inv.WARDROBE3, amount = 5  },
        [xi.mission.id.toau.SHADES_OF_VENGEANCE] = { var = '[Wardrobe]ToAU_4', bag = xi.inv.WARDROBE3, amount = 5  },
        [xi.mission.id.toau.LEGACY_OF_THE_LOST ] = { var = '[Wardrobe]ToAU_5', bag = xi.inv.WARDROBE3, amount = 5  },
        [xi.mission.id.toau.PATH_OF_DARKNESS   ] = { var = '[Wardrobe]ToAU_6', bag = xi.inv.WARDROBE3, amount = 5  },
        [xi.mission.id.toau.NASHMEIRAS_PLEA    ] = { var = '[Wardrobe]ToAU_7', bag = xi.inv.WARDROBE3, amount = 5  },
        [xi.mission.id.toau.THE_EMPRESS_CROWNED] = { var = '[Wardrobe]ToAU_8', bag = xi.inv.WARDROBE3, amount = 10 },
    },
}

local questRewards =
{
    [xi.questLog.SANDORIA] =
    {
        [xi.quest.id.sandoria.A_KNIGHTS_TEST] = { var = '[Wardrobe]Advanced', bag = xi.inv.WARDROBE2, amount = 5 }, -- PLD
        [xi.quest.id.sandoria.THE_HOLY_CREST] = { var = '[Wardrobe]Advanced', bag = xi.inv.WARDROBE2, amount = 5 }, -- DRG
    },

    [xi.questLog.BASTOK] =
    {
        [xi.quest.id.bastok.BLADE_OF_DARKNESS] = { var = '[Wardrobe]Advanced', bag = xi.inv.WARDROBE2, amount = 5 }, -- DRK
        [xi.quest.id.bastok.AYAME_AND_KAEDE  ] = { var = '[Wardrobe]Advanced', bag = xi.inv.WARDROBE2, amount = 5 }, -- NIN
    },

    [xi.questLog.WINDURST] =
    {
        [xi.quest.id.windurst.THE_FANGED_ONE      ] = { var = '[Wardrobe]Advanced', bag = xi.inv.WARDROBE2, amount = 5 }, -- RNG
        [xi.quest.id.windurst.I_CAN_HEAR_A_RAINBOW] = { var = '[Wardrobe]Advanced', bag = xi.inv.WARDROBE2, amount = 5 }, -- SMN
    },

    [xi.questLog.JEUNO] =
    {
        [xi.quest.id.jeuno.PATH_OF_THE_BEASTMASTER   ] = { var = '[Wardrobe]Advanced', bag = xi.inv.WARDROBE2, amount = 5 }, -- BST
        [xi.quest.id.jeuno.PATH_OF_THE_BARD          ] = { var = '[Wardrobe]Advanced', bag = xi.inv.WARDROBE2, amount = 5 }, -- BRD
        [xi.quest.id.jeuno.LAKESIDE_MINUET           ] = { var = '[Wardrobe]Advanced', bag = xi.inv.WARDROBE2, amount = 5 }, -- DNC
        [xi.quest.id.jeuno.IN_DEFIANT_CHALLENGE      ] = { var = '[Wardrobe]Limit_1',  bag = xi.inv.WARDROBE,  amount = 5 }, -- Limit Break 1
        [xi.quest.id.jeuno.ATOP_THE_HIGHEST_MOUNTAINS] = { var = '[Wardrobe]Limit_2',  bag = xi.inv.WARDROBE,  amount = 5 }, -- Limit Break 2
        [xi.quest.id.jeuno.WHENCE_BLOWS_THE_WIND     ] = { var = '[Wardrobe]Limit_3',  bag = xi.inv.WARDROBE,  amount = 5 }, -- Limit Break 3
        [xi.quest.id.jeuno.RIDING_ON_THE_CLOUDS      ] = { var = '[Wardrobe]Limit_4',  bag = xi.inv.WARDROBE,  amount = 5 }, -- Limit Break 4
        [xi.quest.id.jeuno.SHADOWS_OF_THE_DEPARTED   ] = { var = '[Wardrobe]Shadows',  bag = xi.inv.WARDROBE2, amount = 5 }, -- Post Zilart / CoP quest
        [xi.quest.id.jeuno.APOCALYPSE_NIGH           ] = { var = '[Wardrobe]ApocNigh', bag = xi.inv.WARDROBE2, amount = 5 }, -- Post Zilart / CoP battlefield
        [xi.quest.id.jeuno.CHOCOBOS_WOUNDS           ] = { var = '[Wardrobe]Chocobo',  bag = xi.inv.WARDROBE2, amount = 5 }, -- Unlock Chocobo
    },

    [xi.questLog.OTHER_AREAS] =
    {
        [xi.quest.id.otherAreas.ELDER_MEMORIES] = { var = '[Wardrobe]Subjob', bag = xi.inv.WARDROBE, amount = 5 }, -- Subjob
        [xi.quest.id.otherAreas.THE_OLD_LADY  ] = { var = '[Wardrobe]Subjob', bag = xi.inv.WARDROBE, amount = 5 }, -- Subjob
    },

    [xi.questLog.OUTLANDS] =
    {
        [xi.quest.id.outlands.FORGE_YOUR_DESTINY] = { var = '[Wardrobe]Advanced',    bag = xi.inv.WARDROBE2, amount = 5 }, -- SAM
        [xi.quest.id.outlands.DIVINE_MIGHT      ] = { var = '[Wardrobe]DivineMight', bag = xi.inv.WARDROBE3, amount = 5 }, -- shares var with Ark Angels
    },

    [xi.questLog.AHT_URHGAN] =
    {
        [xi.quest.id.ahtUrhgan.AN_EMPTY_VESSEL    ] = { var = '[Wardrobe]Advanced', bag = xi.inv.WARDROBE2, amount = 5 }, -- BLU
        [xi.quest.id.ahtUrhgan.LUCK_OF_THE_DRAW   ] = { var = '[Wardrobe]Advanced', bag = xi.inv.WARDROBE2, amount = 5 }, -- COR
        [xi.quest.id.ahtUrhgan.NO_STRINGS_ATTACHED] = { var = '[Wardrobe]Advanced', bag = xi.inv.WARDROBE2, amount = 5 }, -- PUP
    },

    [xi.questLog.CRYSTAL_WAR] =
    {
        [xi.quest.id.crystalWar.A_LITTLE_KNOWLEDGE] = { var = '[Wardrobe]Advanced', bag = xi.inv.WARDROBE2, amount = 5 }, -- SCH
    },
}

-- Rewards based off of receiving specific key items
local keyItemRewards =
{
    [xi.ki.LIMIT_BREAKER  ] = { var = '[Wardrobe]UnlockMerits', bag = xi.inv.WARDROBE,  amount = 5 }, -- Unlocking merits
    [xi.ki.BOARDING_PERMIT] = { var = '[Wardrobe]ToAU_Access',  bag = xi.inv.WARDROBE3, amount = 5 }, -- Unlocking ToAU access
}

local function announceBagSpace(player, bag, amount)
    local bagName = bagNames[bag]

    local str = string.format(
        'Your %s capacity has been increased by %i!',
        bagName, amount)

    player:printToPlayer(str, xi.msg.channel.SYSTEM_3, '')
end

local function applyWardrobeReward(player, entry)
    if not entry then
        return
    end

    if player:getCharVar(entry.var) ~= 0 then
        return
    end

    player:setCharVar(entry.var, 1)
    player:changeContainerSize(entry.bag, entry.amount)

    if entry.deferred then
        player:setCharVar('[Wardrobe]PendingBag', entry.bag)
        player:setCharVar('[Wardrobe]PendingAmount', entry.amount)
    else
        announceBagSpace(player, entry.bag, entry.amount)
    end
end

m:addOverride('npcUtil.completeMission', function(player, logId, missionId, params)
    local result = super(player, logId, missionId, params)

    if result and missionRewards[logId] then
        applyWardrobeReward(player, missionRewards[logId][missionId])
    end

    return result
end)

m:addOverride('npcUtil.completeQuest', function(player, logId, questId, params)
    local result = super(player, logId, questId, params)

    if result and questRewards[logId] then
        applyWardrobeReward(player, questRewards[logId][questId])
    end

    return result
end)

m:addOverride('npcUtil.giveKeyItem', function(player, keyitems, msgId)
    local result = super(player, keyitems, msgId)

    local givenKeyItems = type(keyitems) == 'table' and keyitems or { keyitems }
    for _, keyItemId in ipairs(givenKeyItems) do
        applyWardrobeReward(player, keyItemRewards[keyItemId])
    end

    return result
end)

m:addOverride('InteractionGlobal.afterZoneIn', function(player, fallbackFn)
    local result = super(player, fallbackFn)

    local pendingBag = player:getCharVar('[Wardrobe]PendingBag')
    if pendingBag ~= 0 then
        announceBagSpace(player, pendingBag, player:getCharVar('[Wardrobe]PendingAmount'))
        player:setCharVar('[Wardrobe]PendingBag', 0)
        player:setCharVar('[Wardrobe]PendingAmount', 0)
    end

    return result
end)
