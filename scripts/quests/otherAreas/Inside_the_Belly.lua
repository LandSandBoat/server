-----------------------------------
-- Inside the Belly
-----------------------------------
-- Log ID: 4, Quest ID: 26
-- !addquest 4 26
-- Zaldon  : !pos -11.810 -7.287 -6.742 248
-----------------------------------

local quest = Quest:new(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.INSIDE_THE_BELLY)

quest.reward = {}

-- data from http://wiki.ffxiclopedia.org/wiki/Inside_the_Belly
local fishRewards =
{
    [xi.item.GRIMMONITE] = -- Grimmonite
    {
        gil = 350,
        items =
        {
            { chance = 5, itemId = xi.item.GOLD_RING }, -- guessing 5%. Wiki unknown
            { chance = 5, itemId = xi.item.MYTHRIL_RING }, -- guessing 5%. Wiki unknown
            { chance = 5, itemId = xi.item.SILVER_RING }, -- guessing 5%. Wiki unknown
        }
    },

    [xi.item.RYUGU_TITAN] =
    {
        gil = 800,
        items =
        {
            { chance = 1.3, itemId = xi.item.MERCURIAL_SWORD },
        }
    },

    [xi.item.GIANT_DONKO] =
    {
        gil = 96,
        items =
        {
            { chance = 4.7, itemId = xi.item.BROKEN_HALCYON_FISHING_ROD },
        }
    },

    [xi.item.JUNGLE_CATFISH] =
    {
        gil = 300,
        items =
        {
            { chance = 3, itemId = xi.item.BROKEN_HUME_FISHING_ROD },
        }
    },

    [xi.item.GIANT_CHIRAI] =
    {
        gil = 550,
        items =
        {
            { chance = 1.2, itemId = xi.item.SPOOL_OF_TWINTHREAD },
        }
    },

    [xi.item.CAVE_CHERAX] =
    {
        gil = 800,
        items =
        {
            { chance = 26.2, itemId = xi.item.DWARF_PUGIL },
        }
    },

    [xi.item.ARMORED_PISCES] =
    {
        gil = 475,
        items =
        {
            { chance = 0.4, itemId = xi.item.STOLID_BREASTPLATE },
        }
    },

    [xi.item.TRICORN] =
    {
        gil = 810,
        items =
        {
            { chance = 4, itemId = xi.item.CHUNK_OF_DARKSTEEL_ORE }, -- guessing 4%. Wiki unknown
        }
    },

    [xi.item.ZAFMLUG_BASS] =
    {
        gil = 15,
        items =
        {
            { chance = 1.4, itemId = xi.item.BLUE_ROCK },
        }
    },

    [xi.item.MONKE_ONKE] =
    {
        gil = 150,
        items =
        {
            { chance = 10, itemId = xi.item.PINCH_OF_POISON_DUST, min = 1, max = 6 }, -- guessing 10%. Wiki unknown
        }
    },

    [xi.item.DARK_BASS] =
    {
        gil = 10,
        items =
        {
            { chance = 4.6, itemId = xi.item.GREEN_ROCK },
        }
    },

    [xi.item.SILVER_SHARK] =
    {
        gil = 250,
        title = xi.title.ACE_ANGLER,
        items =
        {
            { chance = 1.4, itemId = xi.item.TRIDENT },
        }
    },

    [xi.item.EMPEROR_FISH] =
    {
        gil = 300,
        items =
        {
            { chance = 1, itemId = xi.item.CUIR_HIGHBOOTS }, -- guessing 1%. Wiki says 0%
        }
    },

    [xi.item.TAKITARO] =
    {
        gil = 350,
        items =
        {
            { chance = 2.4, itemId = xi.item.PHILOSOPHERS_STONE },
        }
    },

    [xi.item.BLADEFISH] =
    {
        gil = 200,
        items =
        {
            { chance = 11.7, itemId = xi.item.ROBBER_RIG },
        }
    },

    [xi.item.GIGANT_SQUID] =
    {
        gil = 300,
        items =
        {
            { chance = 2.5, itemId = xi.item.FLAME_SHIELD }, -- guessing 2.5%. Wiki unknown
        }
    },

    [xi.item.SEA_ZOMBIE] =
    {
        gil = 350,
        items =
        {
            { chance = 26.1, itemId = xi.item.DRILL_CALAMARY },
        }
    },

    [xi.item.TITANICTUS] =
    {
        gil = 350,
        title = xi.title.LU_SHANG_LIKE_FISHER_KING,
        items =
        {
            { chance = 1.3, itemId = xi.item.ANCIENT_SWORD },
            { chance =   5, itemId = xi.item.SEASHELL }, -- guessing 5%. Wiki unknown
        }
    },

    [xi.item.GAVIAL_FISH] =
    {
        gil = 250,
        items =
        {
            { chance = 4.9, itemId = xi.item.DRONE_EARRING },
        }
    },

    [xi.item.THREE_EYED_FISH] =
    {
        gil = 250,
        items =
        {
            { chance = 10, itemId = xi.item.PINCH_OF_PARALYSIS_DUST, min = 1, max = 10 }, -- guessing 10%. Wiki unknown
        }
    },

    [xi.item.BHEFHEL_MARLIN] =
    {
        gil = 150,
        items =
        {
            { chance = 14.3, itemId = xi.item.BRIGANDS_CHART },
            { chance =  4.4, itemId = xi.item.PIRATES_CHART },
        }
    },

    [xi.item.GUGRU_TUNA] =
    {
        gil = 50,
        items =
        {
            { chance = 2.5, itemId = xi.item.TINY_TATHLUM },
        }
    },

    [xi.item.OGRE_EEL] =
    {
        gil = 16,
        title = xi.title.CORDON_BLEU_FISHER,
        items =
        {
            { chance = 2.5, itemId = xi.item.TURQUOISE_RING },
        }
    },

    [xi.item.TITANIC_SAWFISH] =
    {
        gil = 810,
        items =
        {
            { chance = 0.7, itemId = xi.item.AIZENKUNITOSHI },
        }
    },

    [xi.item.GUGRUSAURUS] =
    {
        gil = 880,
        items =
        {
            { chance = 0.4, itemId = xi.item.SABER_SHOOT },
        }
    },

    [xi.item.LIK] =
    {
        gil = 880,
        items =
        {
            { chance = 0.5, itemId = xi.item.SPOOL_OF_OPAL_SILK },
        }
    },

    [xi.item.PTERYGOTUS] =
    {
        gil = 390,
        items =
        {
            { chance = 6.7, itemId = xi.item.LAPIS_LAZULI },
        }
    },

    [xi.item.MOLA_MOLA] =
    {
        gil = 487,
        items =
        {
            { chance = 1.8, itemId = xi.item.MERCURIAL_SPEAR },
        }
    },

    [xi.item.RHINOCHIMERA] =
    {
        gil = 300,
        items =
        {
            { chance = 3.2, itemId = xi.item.SOLON_TORQUE },
        }
    },

    [xi.item.ISTAVRIT] =
    {
        gil = 50,
        items =
        {
            { chance = 10, itemId = xi.item.PINCH_OF_VENOM_DUST, min = 1, max = 6 }, -- guessing 10%. Wiki unknown
        }
    },

    [xi.item.TURNABALIGI] =
    {
        gil = 340,
        items =
        {
            { chance =   1, itemId = xi.item.CHUNK_OF_DARK_ORE },
            { chance = 1.4, itemId = xi.item.CHUNK_OF_ICE_ORE },
            { chance = 1.4, itemId = xi.item.CHUNK_OF_WATER_ORE },
        }
    },

    [xi.item.KALKANBALIGI] =
    {
        gil = 390,
        items =
        {
            { chance = 3.3, itemId = xi.item.FLAT_SHIELD },
        }
    },

    [xi.item.VEYDAL_WRASSE] =
    {
        gil = 225,
        items =
        {
            { chance = 5, itemId = xi.item.NEBIMONITE }, -- guessing 5%. Wiki unknown
            { chance = 5, itemId = xi.item.SEASHELL }, -- guessing 5%. Wiki unknown
        }
    },

    [xi.item.LAKERDA] =
    {
        gil = 51,
        items =
        {
            { chance =   6, itemId = xi.item.PEARL },
            { chance = 1.9, itemId = xi.item.BLACK_PEARL },
        }
    },

    [xi.item.KILICBALIGI] =
    {
        gil = 150,
        items =
        {
            { chance = 2.5, itemId = xi.item.RUSTY_GREATSWORD }, -- guessing 2.5%. Wiki unknown
        }
    },

    [xi.item.AHTAPOT] =
    {
        gil = 350,
        items =
        {
            { chance = 18.5, itemId = xi.item.MILDEWY_INGOT },
            { chance = 10.2, itemId = xi.item.DECAYED_INGOT },
        }
    },

    [xi.item.MORINABALIGI] =
    {
        gil = 300,
        items =
        {
            { chance = 5, itemId = xi.item.CUIR_GLOVES }, -- guessing 5%. Wiki unknown
        }
    },

    [xi.item.YAYINBALIGI] =
    {
        gil = 50,
        items =
        {
            { chance = 5, itemId = xi.item.TELLURIC_RING }, -- guessing 5%. Wiki unknown
        }
    },

    [xi.item.MEGALODON] =
    {
        gil = 532,
        items =
        {
            { chance = 3, itemId = xi.item.BROKEN_MITHRAN_FISHING_ROD }, -- guessing 3%. Wiki unknown
            { chance = 3, itemId = xi.item.MITHRAN_FISHING_ROD }, -- guessing 3%. Wiki unknown
        }
    },

    [xi.item.MATSYA] =
    {
        gil = 12592,
        items =
        {
            { chance = 1.2, itemId = xi.item.SHAPERS_SHAWL },
        }
    },

    [xi.item.PIRARUCU] =
    {
        gil = 516,
        items =
        {
            { chance =   5, itemId = xi.item.WYVERN_SKIN }, -- guessing 5%. Wiki unknown
            { chance = 2.5, itemId = xi.item.PEISTE_SKIN }, -- guessing 2.5%. Wiki unknown
        }
    },

    [xi.item.GERROTHORAX] =
    {
        gil = 423,
        items =
        {
            { chance = 1.2, itemId = xi.item.RISKY_PATCH },
        }
    },

    [xi.item.GIGANT_OCTOPUS] =
    {
        gil = 119,
        items =
        {
            { chance = 10, itemId = xi.item.JAR_OF_BLACK_INK, min = 1, max = 6 }, --guessing 10%. Wiki unknown
        }
    },

    [xi.item.ABAIA] = -- Abaia
    {
        gil = 690,
        items =
        {
            { chance =  1.5, itemId = xi.item.AURORA_BASS, min = 1, max = 1 }, -- Aurora Bass x3
            { chance =  7.8, itemId = xi.item.AURORA_BASS, min = 2, max = 2 }, -- Aurora Bass x2
            { chance = 12.5, itemId = xi.item.AURORA_BASS, min = 3, max = 3 }, -- Aurora Bass x1
            { chance =  0.7, itemId = xi.item.PLUMB_BOOTS },
        }
    },

    [xi.item.SORYU] =
    {
        gil = 1512,
        items =
        {
            { chance = 46.8, itemId = xi.item.SORYUS_LIVER },
        }
    },

    [xi.item.SEKIRYU] =
    {
        gil = 1512,
        items =
        {
            { chance = 48.1, itemId = xi.item.SEKIRYUS_LIVER }, -- guessing 48.1%. Wiki unknown
        }
    },

    [xi.item.HAKURYU] =
    {
        gil = 1512,
        items =
        {
            { chance = 48.1, itemId = xi.item.HAKURYUS_LIVER },
        }
    },

    [xi.item.GIANT_CATFISH] =
    {
        gil = 50,
        title = xi.title.CORDON_BLEU_FISHER,
        items =
        {
            { chance = 6.2, itemId = xi.item.EARTH_WAND },
        }
    },

    [xi.item.DORADO_GAR] =
    {
        gil = 568,
        items =
        {
            { chance = 5, itemId = xi.item.GOLD_INGOT, min = 1, max = 4 }, -- guessing 5%. Wiki unknown
        }
    },

    [xi.item.CROCODILOS] =
    {
        gil = 1763,
        items =
        {
            { chance = 2.3, itemId = xi.item.PUFFIN_RING },
        }
    },

    [xi.item.PELAZOEA] =
    {
        gil = 360,
        items =
        {
            { chance = 1.8, itemId = xi.item.NODDY_RING },
        }
    },

    [xi.item.FAR_EAST_PUFFER] =
    {
        gil = 735,
        items =
        {
            { chance = 5, itemId = xi.item.STINKY_SUBLIGAR }, -- guessing 5%. Wiki unknown
        }
    },
}

local function tradeFish(player, fishId)
    quest:setLocalVar(player, 'fishId', fishId)
    quest:setLocalVar(player, 'itemIdx', 0)

    local rewards = fishRewards[fishId].items
    local roll    = math.random(1, 1000)
    local sum     = 0

    -- NOTE: We confirm the trade now, and not at the end of the cutscene as normal
    --     : because the cutscene gives away whether or not the trade was successful
    --     : or not, and it's possible for players to cheese this trade by force-dc-ing.
    player:confirmTrade()

    for idx = 1, #rewards do
        sum = sum + (rewards[idx].chance * 10)

        if roll <= sum then
            quest:setLocalVar(player, 'itemIdx', idx)

            return quest:event(166, 0, rewards[idx].itemId)
        end
    end

    return quest:event(167)
end

local function giveReward(player)
    local fishId  = quest:getLocalVar(player, 'fishId')
    local itemIdx = quest:getLocalVar(player, 'itemIdx')
    local reward  = fishRewards[fishId]

    if itemIdx > 0 then
        local rewardItem = reward.items[itemIdx]
        local itemId = rewardItem.itemId
        local itemQt = 1

        if rewardItem.min ~= nil and rewardItem.max ~= nil then
            itemQt = math.random(rewardItem.min, rewardItem.max)
        end

        npcUtil.giveItem(player, { { itemId, itemQt } })
    end

    npcUtil.giveCurrency(player, 'gil', reward.gil)
    quest:setLocalVar(player, 'fishId', 0)
    quest:setLocalVar(player, 'itemIdx', 0)

    if reward.title ~= nil then
        player:addTitle(reward.title)
    end
end

local function zaldonOnTrade(player, npc, trade)
    for itemSlot = 0, trade:getSlotCount() - 1 do
        local itemId = trade:getItemId(itemSlot)

        if
            fishRewards[itemId] ~= nil and
            npcUtil.tradeHasExactly(trade, itemId)
        then
            return tradeFish(player, itemId)
        end
    end
end

local function zaldonOnTrigger(player, npc)
    local fishingSkill = xi.crafting.getTotalSkill(player, xi.skill.FISHING)

    local tier = 4

    if fishingSkill < 40 then
        tier = 1
    elseif fishingSkill < 50 then
        tier = 2
    elseif fishingSkill < 75 then
        tier = 3
    end

    local csTier =
    {
        {
            162,
            xi.item.GIANT_CATFISH,
            xi.item.DARK_BASS,
            xi.item.OGRE_EEL,
            xi.item.ZAFMLUG_BASS,
        },

        {
            163,
            xi.item.ZAFMLUG_BASS,
            xi.item.GIANT_DONKO,
            xi.item.BHEFHEL_MARLIN,
            xi.item.BLADEFISH,
            xi.item.SILVER_SHARK,
        },

        {
            164,
            xi.item.JUNGLE_CATFISH,
            xi.item.GAVIAL_FISH,
            xi.item.PIRARUCU,
            xi.item.EMPEROR_FISH,
            xi.item.MEGALODON,
            xi.item.MORINABALIGI,
        },

        {
            165,
            xi.item.PTERYGOTUS,
            xi.item.KALKANBALIGI,
            xi.item.TAKITARO,
            xi.item.SEA_ZOMBIE,
            xi.item.TITANICTUS,
            xi.item.TURNABALIGI,
            xi.item.CAVE_CHERAX,
            xi.item.TRICORN,
        },
    }

    return quest:event(unpack(csTier[tier]))
end

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getQuestStatus(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.THE_REAL_GIFT) == xi.questStatus.QUEST_COMPLETED and
                xi.crafting.getTotalSkill(player, xi.skill.FISHING) >= 30 and
                xi.settings.map.FISHING_ENABLE == true
        end,

        [xi.zone.SELBINA] =
        {
            ['Zaldon'] = quest:progressEvent(161),

            onEventFinish =
            {
                [161] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
                xi.crafting.getTotalSkill(player, xi.skill.FISHING) >= 30 and
                xi.settings.map.FISHING_ENABLE == true
        end,

        [xi.zone.SELBINA] =
        {
            ['Zaldon'] =
            {
                onTrade = function(player, npc, trade)
                    return zaldonOnTrade(player, npc, trade)
                end,

                onTrigger = function(player, npc)
                    return zaldonOnTrigger(player, npc)
                end,
            },

            onEventFinish =
            {
                [166] = function(player, csid, option, npc)
                    giveReward(player)

                    quest:complete(player)
                end,

                [167] = function(player, csid, option, npc)
                    giveReward(player)

                    quest:complete(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED and
                xi.settings.map.FISHING_ENABLE == true
        end,

        [xi.zone.SELBINA] =
        {
            ['Zaldon'] =
            {
                onTrade = function(player, npc, trade)
                    return zaldonOnTrade(player, npc, trade)
                end,

                onTrigger = function(player, npc)
                    return zaldonOnTrigger(player, npc)
                end,
            },

            onEventFinish =
            {
                [166] = function(player, csid, option, npc)
                    giveReward(player)
                end,

                [167] = function(player, csid, option, npc)
                    giveReward(player)
                end,
            },
        },
    },
}

return quest
