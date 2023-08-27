-----------------------------------
-- Fisherman's Heart
-----------------------------------
-- Log ID: 4, Quest ID: 1
-----------------------------------
require('scripts/globals/fish')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/titles')
require('scripts/globals/utils')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.FISHERMAN_S_HEART)

quest.reward =
{
    fame_area = xi.quest.fame_area.WINDURST,
    fame = 30,
}

quest.sections =
{
    -- Quest available, but fishing rank is 1 and skill < 20
    -- (NOTE: Fishing Rank 0 is handled as default action)
    {
        check = function(player, status, vars)
            return
                status == QUEST_AVAILABLE and
                player:getSkillRank(xi.skill.FISHING) >= 1 and   -- Must have leveled up to first fishing rank
                player:getCharSkillLevel(xi.skill.FISHING) < 200 -- Skill is below 20.0
        end,

        [xi.zone.MHAURA] =
        {
            ['Katsunaga'] = quest:event(191),
        },

    },

    -- Quest available, skill >= 20
    {
        check = function(player, status, vars)
            return
                status == QUEST_AVAILABLE and
                player:getFameLevel(xi.quest.fame_area.WINDURST) >= 2 and
                player:getCharSkillLevel(xi.skill.FISHING) >= 200
        end,

        [xi.zone.MHAURA] =
        {
            ['Katsunaga'] =
            {
                onTrigger = function(player, csid, option, npc)
                    return quest:progressEvent(192, xi.items.GUGRU_TUNA)
                end,
            },

            onEventFinish =
            {
                [192] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    -- Quest Accepted
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.MHAURA] =
        {
            ['Katsunaga'] =
            {
                onTrigger = function(player, csid, option, npc)
                    return quest:progressEvent(194, xi.items.GUGRU_TUNA)
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.items.GUGRU_TUNA) then
                        local fishingStats = player:getFishingStats()
                        return quest:progressEvent(193, {
                            [1] = fishingStats["fishLinesCast"],
                            [2] = fishingStats["fishReeled"],
                            [3] = fishingStats["fishLongestLength"],
                            [4] = fishingStats["fishLongestId"],
                            [5] = fishingStats["fishHeaviestWeight"],
                            [6] = fishingStats["fishHeaviestId"],
                        })
                    end
                end,
            },

            onEventFinish =
            {
                [193] = function(player, csid, option, npc)
                    player:confirmTrade()
                    quest:complete(player)
                end,
            },
        },
    },

    -- Quest Complete
    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.MHAURA] =
        {
            ['Katsunaga'] =
            {
                onTrigger = function(player, csid, option, npc)
                    return quest:progressEvent(197, xi.fishing.countFish(player:getFishingCatches())) -- Number of fish caught
                end,
            },

            onEventUpdate =
            {
                [197] = function(player, csid, option, npc)
                    if option == 33554432 then
                        -- "Catching Fish"
                        local fishingStats = player:getFishingStats()
                        player:updateEvent({
                            [0] = xi.fishing.countFish(player:getFishingCatches()),
                            [1] = fishingStats["fishLinesCast"],
                            [2] = fishingStats["fishReeled"],
                            [3] = fishingStats["fishLongestLength"],
                            [4] = fishingStats["fishLongestId"],
                            [5] = fishingStats["fishHeaviestWeight"],
                            [6] = fishingStats["fishHeaviestId"],
                        })
                    elseif option == 0 then
                        -- "Types of Fish Caught"
                        local fishingCatches = player:getFishingCatches()
                        player:updateEvent({
                            [0] = fishingCatches[1],
                            [1] = fishingCatches[2],
                            [2] = fishingCatches[3],
                            [3] = fishingCatches[4],
                            [4] = fishingCatches[5],
                            [5] = fishingCatches[6],
                        })
                    end
                end,
            },
        },
    },
}

return quest
