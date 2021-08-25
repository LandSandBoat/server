-----------------------------------
-- Dormant Powers Dislodged
-----------------------------------
-- Log ID: 3, Quest ID: 136
-- Nomad Moogle : !pos 10.012 1.453 121.883 243
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/items")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require('scripts/globals/interaction/quest')
local ID = require("scripts/zones/RuLude_Gardens/IDs")
-----------------------------------
local quest = Quest:new(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.DORMANT_POWERS_DISLODGED)
-----------------------------------

-- TODO: Properly code timing minigame. Awaiting for a capture.
-- Amount of visual qeues selected at random. Min: Probably 3. Max: 7. Camera angle keeps changing qithout hints.
-- Always the same camera angle at victory.

quest.reward =
{
    fame  = 50,
    fameArea = JEUNO,
    keyItem = SOUL_GEM,
}

quest.sections =
{
    -- Section: Quest available.
    {
        check = function(player, status)
            return status == QUEST_AVAILABLE and
                player:getMainLvl() >= 86 and
                player:getLevelCap() == 90 and
                xi.settings.MAX_LEVEL >= 95
        end,

        [xi.zone.RULUDE_GARDENS] =
        {
            ['Nomad_Moogle'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(10045, 0, 1, 4, 0)
                end,
            },

            onEventFinish =
            {
                [10045] = function(player, csid, option, npc)
                    if option == 11 then -- Accept quest option.
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

        [xi.zone.JEUNO] =
        {
            ['Nomad_Moogle'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        -- Timing Minigame starting event.
                        -- return quest:progressEvent(10162) ??? Unknown. I gotta check this shit.
                    else
                        return quest:event(10045, 0, 1, 4, 1)
                    end
                end,

                onTrade = function(player, npc, trade)
                    -- TODO: Select a item at random on a precious step and add it to the trade here.
                    if npcUtil.tradeHasExactly(trade, {{xi.items.KINDREDS_CREST, 1}}) and player:getMeritCount() > 9 then
                        return quest:progressEvent(10138)
                    end
                end,
            },

            onEventFinish =
            {
                [10137] = function(player, csid, option, npc)
                    player:tradeComplete()
                    player:setMerits(player:getMeritCount() - 10)
                    quest:setVar(player, 'Prog', 1)
                end,

                [10162] = function(player, csid, option, npc) -- Unkonwn minigame event. For now.
                    if quest:complete(player) then
                        player:setLevelCap(95)
                        player:messageSpecial(ID.text.YOUR_LEVEL_LIMIT_IS_NOW_95)
                    end
                end,
            },
        },
    },
}

return quest
