-----------------------------------
-- Inside the Belly
-----------------------------------
-- Log ID: 4, Quest ID: 26
-- Zaldon  : !pos -11.810 -7.287 -6.742
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.INSIDE_THE_BELLY)

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

    local rewards = xi.zones.Selbina.npcs.Zaldon.fishRewards[fishId].items
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
        local reward  = xi.zones.Selbina.npcs.Zaldon.fishRewards[fishId]

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
                    for fish, _ in pairs(xi.zones.Selbina.npcs.Zaldon.fishRewards) do
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
                    for fish, _ in pairs(xi.zones.Selbina.npcs.Zaldon.fishRewards) do
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
