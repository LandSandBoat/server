-----------------------------------
-- Inside the Belly
-----------------------------------
-- Log ID: 4, Quest ID: 26
-- Zaldon  : !pos -11.810 -7.287 -6.742
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/interaction/quest')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.INSIDE_THE_BELLY)

local fishRewards =
{
    ----- Quest 1 -----
    [     xi.item.DARK_BASS] = { gil =  10, items = { { chance =  4.9, itemId =                 xi.item.GREEN_ROCK } } },
    [ xi.item.VEYDAL_WRASSE] = { gil = 225, items = { { chance =    5, itemId =                 xi.item.NEBIMONITE }, { chance = 5, itemId = xi.item.SEASHELL } } },
    [      xi.item.OGRE_EEL] = { gil =  16, items = { { chance =  2.6, itemId =             xi.item.TURQUOISE_RING } }, title = xi.title.CORDON_BLEU_FISHER },
    [ xi.item.GIANT_CATFISH] = { gil =  50, items = { { chance =  7.2, itemId =                 xi.item.EARTH_WAND } }, title = xi.title.CORDON_BLEU_FISHER },
    ----- Quest 2 -----
    [  xi.item.ZAFMLUG_BASS] = { gil =  15, items = { { chance =  1.4, itemId =                  xi.item.BLUE_ROCK } } },
    [   xi.item.GIANT_DONKO] = { gil =  96, items = { { chance =  4.7, itemId = xi.item.BROKEN_HALCYON_FISHING_ROD } } },
    [     xi.item.BLADEFISH] = { gil = 200, items = { { chance = 11.7, itemId =                 xi.item.ROBBER_RIG } } },
    [xi.item.BHEFHEL_MARLIN] = { gil = 150, items = { { chance =  3.0, itemId =             xi.item.BRIGANDS_CHART }, { chance = 4.4, itemId = xi.item.PIRATES_CHART } } },
    [  xi.item.SILVER_SHARK] = { gil = 250, items = { { chance =  1.3, itemId =                    xi.item.TRIDENT } }, title = xi.title.ACE_ANGLER },
    ----- Quest 3 -----
    [xi.item.JUNGLE_CATFISH] = { gil = 300, items = { { chance =    3, itemId =    xi.item.BROKEN_HUME_FISHING_ROD } } },
    [   xi.item.GAVIAL_FISH] = { gil = 250, items = { { chance =    5, itemId =              xi.item.DRONE_EARRING } } },
    [  xi.item.EMPEROR_FISH] = { gil = 300, items = { { chance =    1, itemId =             xi.item.CUIR_HIGHBOOTS } } },
    [  xi.item.MORINABALIGI] = { gil = 300, items = { { chance =    5, itemId =                xi.item.CUIR_GLOVES } } },
    [      xi.item.PIRARUCU] = { gil = 516, items = { { chance =    5, itemId =                xi.item.WYVERN_SKIN }, { chance = 2.5, itemId =         xi.item.PEISTE_SKIN } } },
    [     xi.item.MEGALODON] = { gil = 532, items = { { chance =    3, itemId = xi.item.BROKEN_MITHRAN_FISHING_ROD }, { chance =   3, itemId = xi.item.MITHRAN_FISHING_ROD } } },
    ----- Quest 4 -----
    [    xi.item.PTERYGOTUS] = { gil = 390, items = { { chance =  6.6, itemId =               xi.item.LAPIS_LAZULI } } },
    [  xi.item.KALKANBALIGI] = { gil = 390, items = { { chance =  3.3, itemId =                xi.item.FLAT_SHIELD } } },
    [      xi.item.TAKITARO] = { gil = 350, items = { { chance =  2.1, itemId =         xi.item.PHILOSOPHERS_STONE } } },
    [    xi.item.SEA_ZOMBIE] = { gil = 350, items = { { chance = 23.4, itemId =             xi.item.DRILL_CALAMARY } } },
    [   xi.item.CAVE_CHERAX] = { gil = 800, items = { { chance = 23.2, itemId =                xi.item.DWARF_PUGIL } } },
    [       xi.item.TRICORN] = { gil = 810, items = { { chance =    4, itemId =     xi.item.CHUNK_OF_DARKSTEEL_ORE } } },
    [   xi.item.TURNABALIGI] = { gil = 340, items = { { chance =  0.8, itemId =          xi.item.CHUNK_OF_DARK_ORE }, { chance = 1.6, itemId = xi.item.CHUNK_OF_ICE_ORE }, { chance = 1.3, itemId = xi.item.CHUNK_OF_WATER_ORE } } },
    [    xi.item.TITANICTUS] = { gil = 350, items = { { chance =  1.4, itemId =              xi.item.ANCIENT_SWORD } }, title = xi.title.LU_SHANG_LIKE_FISHER_KING },
    ----- Unlisted -----
    [  xi.item.GIANT_CHIRAI] = { gil = 550, items = { { chance =  1.2, itemId =        xi.item.SPOOL_OF_TWINTHREAD } } },
    [   xi.item.GUGRUSAURUS] = { gil = 880, items = { { chance =  0.4, itemId =                xi.item.SABER_SHOOT } } },
    [           xi.item.LIK] = { gil = 880, items = { { chance =  0.5, itemId =         xi.item.SPOOL_OF_OPAL_SILK } } },
    [   xi.item.RYUGU_TITAN] = { gil = 800, items = { { chance =    1, itemId =            xi.item.MERCURIAL_SWORD } } },
    [   xi.item.GERROTHORAX] = { gil = 423, items = { { chance =  1.2, itemId =                xi.item.RISKY_PATCH } } },
    [    xi.item.MONKE_ONKE] = { gil = 150, items = { { chance =    2, itemId =       xi.item.PINCH_OF_POISON_DUST } } },
    [   xi.item.KILICBALIGI] = { gil = 150, items = { { chance =    2, itemId =           xi.item.RUSTY_GREATSWORD } } },
    [xi.item.ARMORED_PISCES] = { gil = 475, items = { { chance =  0.4, itemId =         xi.item.STOLID_BREASTPLATE } } },
    [     xi.item.MOLA_MOLA] = { gil = 478, items = { { chance =  1.8, itemId =            xi.item.MERCURIAL_SPEAR } } },
    [       xi.item.AHTAPOT] = { gil = 350, items = { { chance = 18.8, itemId =              xi.item.DECAYED_INGOT }, { chance = 10.6, itemId = xi.item.MILDEWY_INGOT } } },
    [       xi.item.LAKERDA] = { gil =  51, items = { { chance =    2, itemId =                      xi.item.PEARL }, { chance = 10.6, itemId =   xi.item.BLACK_PEARL } } },
}

quest.reward = { }

local skillCheck = function(player)
    local fishingSkill = player:getSkillLevel(xi.skill.FISHING)
    local fishingRank = player:getSkillRank(xi.skill.FISHING)
    local realSkill = (fishingSkill - fishingRank) / 32

    return realSkill
end

local tradeFish = function(player, fishId)
    player:setCharVar("insideBellyFishId", fishId)
    player:setCharVar("insideBellyItemIdx", 0)

    -- local rewards = fishRewards[fishId].items
    local rewards = fishRewards[fishId].items
    local roll = math.random(1000) / 10
    local sum = 0
    local item = nil

    for i = 1, #rewards do
        sum = sum + rewards[i].chance

        if roll <= sum then
            player:setCharVar("insideBellyItemIdx", i)
            item = rewards[i].itemId
            break
        end
    end

    -- NOTE: We confirm the trade now, and not at the end of the cutscene as normal
    --     : because the cutscene gives away whether or not the trade was successful
    --     : or not, and it's possible for players to cheese this trade by force-dc-ing.
    player:confirmTrade()

    if item then
        return quest:progressEvent(166, 0, item)
    else
        return quest:progressEvent(167)
    end
end

local giveReward = function(player, csid)
    if csid == 166 or csid == 167 then
        local fishId  = player:getCharVar("insideBellyFishId")
        local itemIdx = player:getCharVar("insideBellyItemIdx")
        local reward  = fishRewards[fishId]

        local itemId = nil
        local itemQt = nil
        local rewardSet = {}

        -- Reset the character variables
        player:setCharVar("insideBellyFishId", 0)
        player:setCharVar("insideBellyItemIdx", 0)

        -- Regardless of success or failure, confirm the trade, give gil, and set the char vars to 0
        npcUtil.giveCurrency(player, 'gil', xi.settings.main.GIL_RATE * reward.gil)

        --If successful (other than gil) give the item
        if itemIdx > 0 then
            local r = reward.items[itemIdx]
            itemId = r.itemId
            itemQt = 1
            if r.min ~= nil and r.max ~= nil then
                itemQt = math.random(r.min, r.max)
            end

            -- Issue the reward
            rewardSet = { itemId, itemQt }
            npcUtil.giveItem(player, { rewardSet })

            -- If there's a title to grant based on the reward, grant it.
            if reward.title ~= nil then
                player:addTitle(reward.title)
            end
        end
    end
end

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
            skillCheck(player) >= 30 and
            player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.THE_REAL_GIFT) == QUEST_COMPLETED
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
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.SELBINA] =
        {
            ['Zaldon'] =
            {
                onTrade = function(player, npc, trade)
                    -- for fish, _ in pairs(fishRewards) do
                    for fish, _ in pairs(fishRewards) do
                        if npcUtil.tradeHasExactly(trade, fish) then
                            return tradeFish(player, fish)
                        end
                    end
                end,

                onTrigger = function(player, npc)
                    if skillCheck(player) >= 30 and skillCheck(player) < 39 then
                        return quest:event(162, xi.item.DARK_BASS, xi.item.GIANT_CATFISH, xi.item.OGRE_EEL, xi.item.VEYDAL_WRASSE)
                    elseif skillCheck(player) >= 40 and skillCheck(player) < 49 then
                        return quest:event(163, xi.item.ZAFMLUG_BASS, xi.item.GIANT_DONKO, xi.item.BHEFHEL_MARLIN, xi.item.BLADEFISH, xi.item.SILVER_SHARK)
                    elseif skillCheck(player) >= 50 and skillCheck(player) <= 74 then
                        return quest:event(164, xi.item.JUNGLE_CATFISH, xi.item.GAVIAL_FISH, xi.item.PIRARUCU, xi.item.EMPEROR_FISH, xi.item.MEGALODON, xi.item.MORINABALIGI)
                    elseif skillCheck(player) >= 75 then
                        return quest:event(165, xi.item.PTERYGOTUS, xi.item.KALKANBALIGI, xi.item.TAKITARO, xi.item.SEA_ZOMBIE, xi.item.TITANICTUS, xi.item.TURNABALIGI, xi.item.CAVE_CHERAX, xi.item.TRICORN)
                    end
                end,
            },

            onEventFinish =
            {
                [166] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        giveReward(player, csid)
                    end
                end,

                [167] = function(player, csid, option, npc)
                    giveReward(player, csid)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.SELBINA] =
        {
            ['Zaldon'] =
            {
                onTrade = function(player, npc, trade)
                    for fish, _ in pairs(fishRewards) do
                        if npcUtil.tradeHasExactly(trade, fish) then
                            return tradeFish(player, fish)
                        end
                    end
                end,

                onTrigger = function(player, npc)
                    if skillCheck(player) >= 30 and skillCheck(player) < 39 then
                        return quest:event(162, xi.item.DARK_BASS, xi.item.GIANT_CATFISH, xi.item.OGRE_EEL, xi.item.VEYDAL_WRASSE)
                    elseif skillCheck(player) >= 40 and skillCheck(player) < 49 then
                        return quest:event(163, xi.item.ZAFMLUG_BASS, xi.item.GIANT_DONKO, xi.items, xi.item.BHEFHEL_MARLIN, xi.item.SILVER_SHARK)
                    elseif skillCheck(player) >= 50 and skillCheck(player) <= 74 then
                        return quest:event(164, xi.item.JUNGLE_CATFISH, xi.item.GAVIAL_FISH, xi.item.PIRARUCU, xi.item.EMPEROR_FISH, xi.item.MEGALODON, xi.item.MORINABALIGI)
                    elseif skillCheck(player) >= 75 then
                        return quest:event(165, xi.item.PTERYGOTUS, xi.item.KALKANBALIGI, xi.item.TAKITARO, xi.item.SEA_ZOMBIE, xi.item.TITANICTUS, xi.item.TURNABALIGI, xi.item.CAVE_CHERAX, xi.item.TRICORN)
                    end
                end,
            },

            onEventFinish =
            {
                [166] = function(player, csid, option, npc)
                    giveReward(player, csid)
                end,

                [167] = function(player, csid, option, npc)
                    giveReward(player, csid)
                end,
            },
        },
    },
}

return quest
