-----------------------------------
-- Beyond the Stars
-----------------------------------
-- Log ID: 3, Quest ID: 135
-- Nomad Moogle : !pos 10.012 1.453 121.883 243
-----------------------------------
local ruludeID = zones[xi.zone.RULUDE_GARDENS]
-----------------------------------

local quest = Quest:new(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.BEYOND_THE_STARS)

-- TODO: Properly code the rock, paper, scissors minigame. Awaiting for a capture.
-- Probably a matter of chaining onEventUpdates and tracking Maat's and Degengard's HP. Maybe not.
-- It seems that the event tracks HP on it's own.
-- Degengard's moves are selected at random.

quest.reward =
{
    fame = 50,
    fameArea = xi.quest.fame_area.JEUNO,
}

quest.sections =
{
    -- Section: Quest available.
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getMainLvl() >= 81 and
                player:getLevelCap() == 85 and
                xi.settings.main.MAX_LEVEL >= 90
        end,

        [xi.zone.RULUDE_GARDENS] =
        {
            ['Nomad_Moogle'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(10045, 0, 1, 3, 0)
                end,
            },

            onEventFinish =
            {
                [10045] = function(player, csid, option, npc)
                    if option == 9 then -- Accept quest option.
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    -- Section: Quest accepted.
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.RULUDE_GARDENS] =
        {
            ['Nomad_Moogle'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        -- Rock, Paper, Scissor Minigame starting event.
                        -- NOT CODED. WAITING FOR CAPS.
                        return quest:progressEvent(10161)
                    else
                        return quest:event(10045, 0, 1, 3, 1)
                    end
                end,

                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, { { xi.item.KINDREDS_CREST, 10 } }) and
                        player:getMeritCount() > 4
                    then
                        return quest:progressEvent(10137)
                    end
                end,
            },

            -- onEventUpdate =
            -- {
                -- [10161] = function(player, csid, option, npc)
                -- end,
            -- },

            onEventFinish =
            {
                [10137] = function(player, csid, option, npc)
                    player:confirmTrade()
                    player:setMerits(player:getMeritCount() - 5)
                    quest:setVar(player, 'Prog', 1)
                end,

                [10161] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:setLevelCap(90)
                        player:messageSpecial(ruludeID.text.YOUR_LEVEL_LIMIT_IS_NOW_90)
                    end
                end,
            },
        },
    },
}

return quest
