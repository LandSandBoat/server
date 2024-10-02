-----------------------------------
-- Fisherman's Heart
-- Katsunaga !pos -4.726 -1.148 2.183
-- Log ID: 4, Quest ID: 11
-----------------------------------
local quest = Quest:new(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.FISHERMAN_S_HEART)

quest.reward =
{
    fame_area = xi.fameArea.WINDURST,
    fame = 30,
}

quest.sections =
{
    -- Quest available, but fishing rank is 1 and skill < 20
    -- (NOTE: Fishing Rank 0 is handled as default action)
    {
        check = function(player, status, vars)
            return
                status == xi.questStatus.QUEST_AVAILABLE and
                player:getSkillRank(xi.skill.FISHING) >= 1 and   -- Must have leveled up to first fishing rank
                player:getCharSkillLevel(xi.skill.FISHING) < 200 -- Skill is below 20.0
        end,

        [xi.zone.MHAURA] =
        {
            ['Katsunaga'] = quest:event(191),
        },
    },

    -- Quest available, skill >= 20, Windurst Fame >= 2
    {
        check = function(player, status, vars)
            return
                status == xi.questStatus.QUEST_AVAILABLE and
                player:getFameLevel(xi.fameArea.WINDURST) >= 2 and
                player:getCharSkillLevel(xi.skill.FISHING) >= 200
        end,

        [xi.zone.MHAURA] =
        {
            ['Katsunaga'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(192, xi.item.GUGRU_TUNA)
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
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.MHAURA] =
        {
            ['Katsunaga'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(194, xi.item.GUGRU_TUNA)
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.item.GUGRU_TUNA) then
                        local fishingStats = player:getFishingStats() or {}
                        return quest:progressEvent(193, {
                            [1] = fishingStats['fishLinesCast'] or 0,
                            [2] = fishingStats['fishReeled'] or 0,
                            [3] = fishingStats['fishLongestLength'] or 0,
                            [4] = fishingStats['fishLongestId'] or 0,
                            [5] = fishingStats['fishHeaviestWeight'] or 0,
                            [6] = fishingStats['fishHeaviestId'] or 0,
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
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.MHAURA] =
        {
            ['Katsunaga'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(197, player:getFishingCatchCount() or 0) -- Number of fish types caught
                end,
            },

            onEventUpdate =
            {
                [197] = function(player, csid, option, npc)
                    if option == 33554432 then
                        -- 'Catching Fish'
                        local fishingStats = player:getFishingStats() or {}
                        player:updateEvent({
                            [0] = player:getFishingCatchCount(),
                            [1] = fishingStats['fishLinesCast'] or 0,
                            [2] = fishingStats['fishReeled'] or 0,
                            [3] = fishingStats['fishLongestLength'] or 0,
                            [4] = fishingStats['fishLongestId'] or 0,
                            [5] = fishingStats['fishHeaviestWeight'] or 0,
                            [6] = fishingStats['fishHeaviestId'] or 0,
                        })
                    elseif option == 0 then
                        -- 'Types of Fish Caught'
                        local fishingCatches = player:getFishingCatches() or {}
                        -- The server sends the client the bitmap data as a series of 32-bit integers
                        player:updateEvent({
                            [0] = fishingCatches[0] or 0,
                            [1] = fishingCatches[1] or 0,
                            [2] = fishingCatches[2] or 0,
                            [3] = fishingCatches[3] or 0,
                            [4] = fishingCatches[4] or 0,
                            [5] = fishingCatches[5] or 0,
                        })
                    end
                end,
            },
        },
    },
}

return quest
