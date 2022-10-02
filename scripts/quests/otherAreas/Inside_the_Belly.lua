-----------------------------------
-- Inside the Belly
-----------------------------------
-- Log ID: 4, Quest ID: 26
-- Zaldon  : !pos -11.810 -7.287 -6.742
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/status')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.INSIDE_THE_BELLY)

quest.reward = { }

local fishRewards =
{
    ----- Quest 1 -----
    [     xi.items.DARK_BASS] = { gil =  10, items = { { chance =  4.9, itemId =     xi.items.GREEN_ROCK } } },
    [ xi.items.VEYDAL_WRASSE] = { gil = 225, items = { { chance =    5, itemId =     xi.items.NEBIMONITE }, { chance = 5, itemId = xi.items.SEASHELL } } },
    [      xi.items.OGRE_EEL] = { gil =  16, items = { { chance =  2.6, itemId = xi.items.TURQUOISE_RING } }, title = xi.title.CORDON_BLEU_FISHER },
    [ xi.items.GIANT_CATFISH] = { gil =  50, items = { { chance =  7.2, itemId =     xi.items.EARTH_WAND } }, title = xi.title.CORDON_BLEU_FISHER },
    ----- Quest 2 -----
    [  xi.items.ZAFMLUG_BASS] = { gil =  15, items = { { chance =  1.4, itemId =                  xi.items.BLUE_ROCK } } },
    [   xi.items.GIANT_DONKO] = { gil =  96, items = { { chance =  4.7, itemId = xi.items.BROKEN_HALCYON_FISHING_ROD } } },
    [     xi.items.BLADEFISH] = { gil = 200, items = { { chance = 11.7, itemId =                 xi.items.ROBBER_RIG } } },
    [xi.items.BHEFHEL_MARLIN] = { gil = 150, items = { { chance =  3.0, itemId =             xi.items.BRIGANDS_CHART }, { chance = 4.4, itemId = xi.items.PIRATES_CHART } } },
    [  xi.items.SILVER_SHARK] = { gil = 250, items = { { chance =  1.3, itemId =                    xi.items.TRIDENT } }, title = xi.title.ACE_ANGLER },
    ----- Quest 3 -----
    [xi.items.JUNGLE_CATFISH] = { gil = 300, items = { { chance = 3, itemId =    xi.items.BROKEN_HUME_FISHING_ROD } } },
    [   xi.items.GAVIAL_FISH] = { gil = 250, items = { { chance = 5, itemId =              xi.items.DRONE_EARRING } } },
    [  xi.items.EMPEROR_FISH] = { gil = 300, items = { { chance = 1, itemId =             xi.items.CUIR_HIGHBOOTS } } },
    [  xi.items.MORINABALIGI] = { gil = 300, items = { { chance = 5, itemId =                xi.items.CUIR_GLOVES } } },
    [      xi.items.PIRARUCU] = { gil = 516, items = { { chance = 5, itemId =                xi.items.WYVERN_SKIN }, { chance = 2.5, itemId =         xi.items.PEISTE_SKIN } } },
    [     xi.items.MEGALODON] = { gil = 532, items = { { chance = 3, itemId = xi.items.BROKEN_MITHRAN_FISHING_ROD }, { chance =   3, itemId = xi.items.MITHRAN_FISHING_ROD } } },
    ----- Quest 4 -----
    [    xi.items.PTERYGOTUS] = { gil = 390, items = { { chance =  6.6, itemId =           xi.items.LAPIS_LAZULI } } },
    [  xi.items.KALKANBALIGI] = { gil = 390, items = { { chance =  3.3, itemId =            xi.items.FLAT_SHIELD } } },
    [      xi.items.TAKITARO] = { gil = 350, items = { { chance =  2.1, itemId =     xi.items.PHILOSOPHERS_STONE } } },
    [    xi.items.SEA_ZOMBIE] = { gil = 350, items = { { chance = 23.4, itemId =         xi.items.DRILL_CALAMARY } } },
    [   xi.items.CAVE_CHERAX] = { gil = 800, items = { { chance = 23.2, itemId =            xi.items.DWARF_PUGIL } } },
    [       xi.items.TRICORN] = { gil = 810, items = { { chance =    4, itemId = xi.items.CHUNK_OF_DARKSTEEL_ORE } } },
    [   xi.items.TURNABALIGI] = { gil = 340, items = { { chance =  0.8, itemId =      xi.items.CHUNK_OF_DARK_ORE }, { chance = 1.6, itemId = xi.items.CHUNK_OF_ICE_ORE }, { chance = 1.3, itemId = xi.items.CHUNK_OF_WATER_ORE } } },
    [    xi.items.TITANICTUS] = { gil = 350, items = { { chance =  1.4, itemId =          xi.items.ANCIENT_SWORD } }, title = xi.title.LU_SHANG_LIKE_FISHER_KING },
    ----- Unlisted -----
    [  xi.items.GIANT_CHIRAI] = { gil = 550, items = { { chance =  1.2, itemId =  xi.items.SPOOL_OF_TWINTHREAD } } },
    [   xi.items.GUGRUSAURUS] = { gil = 880, items = { { chance =  0.4, itemId =          xi.items.SABER_SHOOT } } },
    [           xi.items.LIK] = { gil = 880, items = { { chance =  0.5, itemId =   xi.items.SPOOL_OF_OPAL_SILK } } },
    [   xi.items.RYUGU_TITAN] = { gil = 800, items = { { chance =    1, itemId =      xi.items.MERCURIAL_SWORD } } },
    [   xi.items.GERROTHORAX] = { gil = 423, items = { { chance =  1.2, itemId =          xi.items.RISKY_PATCH } } },
    [    xi.items.MONKE_ONKE] = { gil = 150, items = { { chance =    2, itemId = xi.items.PINCH_OF_POISON_DUST } } },
    [   xi.items.KILICBALIGI] = { gil = 150, items = { { chance =    2, itemId =     xi.items.RUSTY_GREATSWORD } } },
    [xi.items.ARMORED_PISCES] = { gil = 475, items = { { chance =  0.4, itemId =   xi.items.STOLID_BREASTPLATE } } },
    [     xi.items.MOLA_MOLA] = { gil = 478, items = { { chance =  1.8, itemId =      xi.items.MERCURIAL_SPEAR } } },
    [       xi.items.AHTAPOT] = { gil = 350, items = { { chance = 18.8, itemId =        xi.items.DECAYED_INGOT }, { chance = 10.6, itemId = xi.items.MILDEWY_INGOT } } },
    [       xi.items.LAKERDA] = { gil =  51, items = { { chance =    2, itemId =                xi.items.PEARL }, { chance = 10.6, itemId =   xi.items.BLACK_PEARL } } },
}

local skillCheck = function(player)
    local fishingSkill = player:getSkillLevel(xi.skill.FISHING)
    local fishingRank = player:getSkillRank(xi.skill.FISHING)
    local realSkill = (fishingSkill - fishingRank) / 32

    return realSkill
end

local tradeFish = function(player, fishId)
    player:setCharVar("insideBellyFishId", fishId)
    player:setCharVar("insideBellyItemIdx", 0)

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
        local reward = fishRewards[fishId]

        local itemId = nil
        local itemQt = nil
        local rewardSet = {}

        -- Reset the character variables
        player:setCharVar("insideBellyFishId", 0)
        player:setCharVar("insideBellyItemIdx", 0)

        -- Regardless of success or failure, confirm the trade, give gil, and set the char vars to 0
        player:confirmTrade()
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
                    for fish, _ in pairs(fishRewards) do
                        if npcUtil.tradeHasExactly(trade, fish) then
                            return tradeFish(player, fish)
                        end
                    end
                end,

                onTrigger = function(player, npc)
                    if skillCheck(player) >= 30 and skillCheck(player) < 39 then
                        return quest:event(162, xi.items.DARK_BASS, xi.items.GIANT_CATFISH, xi.items.OGRE_EEL, xi.items.VEYDAL_WRASSE)
                    elseif skillCheck(player) >= 40 and skillCheck(player) < 49 then
                        return quest:event(163, xi.items.ZAFMLUG_BASS, xi.items.GIANT_DONKO, xi.items.BHEFHEL_MARLIN, xi.items.BLADEFISH, xi.items.SILVER_SHARK)
                    elseif skillCheck(player) >= 50 and skillCheck(player) <= 74 then
                        return quest:event(164, xi.items.JUNGLE_CATFISH, xi.items.GAVIAL_FISH, xi.items.PIRARUCU, xi.items.EMPEROR_FISH, xi.items.MEGALODON, xi.items.MORINABALIGI)
                    elseif skillCheck(player) >= 75 then
                        return quest:event(165, xi.items.PTERYGOTUS, xi.items.KALKANBALIGI, xi.items.TAKITARO, xi.items.SEA_ZOMBIE, xi.items.TITANICTUS, xi.items.TURNABALIGI, xi.items.CAVE_CHERAX, xi.items.TRICORN)
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
                        return quest:event(162, xi.items.DARK_BASS, xi.items.GIANT_CATFISH, xi.items.OGRE_EEL, xi.items.VEYDAL_WRASSE)
                    elseif skillCheck(player) >= 40 and skillCheck(player) < 49 then
                        return quest:event(163, xi.items.ZAFMLUG_BASS, xi.items.GIANT_DONKO, xi.items, xi.items.BHEFHEL_MARLIN, xi.items.SILVER_SHARK)
                    elseif skillCheck(player) >= 50 and skillCheck(player) <= 74 then
                        return quest:event(164, xi.items.JUNGLE_CATFISH, xi.items.GAVIAL_FISH, xi.items.PIRARUCU, xi.items.EMPEROR_FISH, xi.items.MEGALODON, xi.items.MORINABALIGI)
                    elseif skillCheck(player) >= 75 then
                        return quest:event(165, xi.items.PTERYGOTUS, xi.items.KALKANBALIGI, xi.items.TAKITARO, xi.items.SEA_ZOMBIE, xi.items.TITANICTUS, xi.items.TURNABALIGI, xi.items.CAVE_CHERAX, xi.items.TRICORN)
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
