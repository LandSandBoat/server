-----------------------------------
-- Dormant Powers Dislodged
-----------------------------------
-- Log ID: 3, Quest ID: 136
-- Nomad Moogle : !pos 10.012 1.453 121.883 243
require('scripts/globals/items')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/interaction/quest')
-----------------------------------
local ruludeID = require('scripts/zones/RuLude_Gardens/IDs')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.DORMANT_POWERS_DISLODGED)

-- NOTE: Timing minigame was guesstimated! No capture available.
-- The event seems to handle the actual timing. As in, it counts for us.
-- Always the same camera angle at victory. That is, close up of player, at arround 9 seconds.
-- Wining timing: 10 seconds aprox.

local itemWantedTable =
{
    [0] = { xi.items.PINCH_OF_VALKURM_SUNSAND },
    [1] = { xi.items.FADED_CRYSTAL            },
    [2] = { xi.items.ORCISH_PLATE_ARMOR       },
    [3] = { xi.items.MAGICKED_SKULL           },
    [4] = { xi.items.CUP_OF_DHALMEL_SALIVA    },
    [5] = { xi.items.YAGUDO_CAULK             },
    [6] = { xi.items.SIRENS_TEAR              },
    [7] = { xi.items.DANGRUF_STONE            },
    [8] = { xi.items.ORCISH_AXE               },
    [9] = { xi.items.QUADAV_BACKSCALE         },
    -- 10+ = It repeats the pattern ad nauseam. Supposedly, it can request more items, but I cannot figure them out without a cap.
}

quest.reward =
{
    fame = 50,
    fameArea = xi.quest.fame_area.JEUNO,
    keyItem = xi.ki.SOUL_GEM,
}

quest.sections =
{
    -- Section: Quest available.
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getMainLvl() >= 86 and
                player:getLevelCap() == 90 and
                xi.settings.main.MAX_LEVEL >= 95
        end,

        [xi.zone.RULUDE_GARDENS] =
        {
            ['Nomad_Moogle'] =
            {
                onTrigger = function(player, npc)
                    -- Requested item is an additional argument. (csid, 0, 1, 4, 0, 0, ITEM). See table on top.
                    local itemWanted = math.random(0, 9)
                    quest:setVar(player, 'itemWanted', itemWanted + 1)
                    return quest:progressEvent(10045, 0, 1, 4, 0, 0, itemWanted)
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

        [xi.zone.RULUDE_GARDENS] =
        {
            ['Nomad_Moogle'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(10192) -- Timing Minigame starting event.
                    else
                        local itemWanted = quest:getVar(player, 'itemWanted') - 1
                        return quest:event(10045, 0, 1, 4, 1, 0, itemWanted)
                    end
                end,

                onTrade = function(player, npc, trade)
                    local itemWanted  = quest:getVar(player, 'itemWanted') - 1
                    local itemToTrade = itemWantedTable[itemWanted][1]

                    if
                        npcUtil.tradeHasExactly(trade, { { xi.items.KINDREDS_CREST, 1 }, { itemToTrade, 1 } }) and
                        player:getMeritCount() > 9
                    then
                        return quest:progressEvent(10191)
                    end
                end,
            },

            onEventUpdate =
            {
                [10192] = function(player, csid, option, npc)
                    -- Option: Push! The option is the number of frames. 1 sec = 60 frames. Probably.
                    if option >= 901 then
                        player:updateEvent(4, 1) -- Slime. Way too late?
                    elseif option >= 631 and option <= 900 then
                        player:updateEvent(3, 1) -- Big Egg. Too late?
                    elseif option >= 571 and option <= 630 then
                        player:updateEvent(2, 1) -- Glowing Egg. Win!
                        quest:setVar(player, 'Win', 1)
                    elseif option >= 301 and option <= 570 then
                        player:updateEvent(1, 1) -- Regular Egg. Too soon?
                    elseif option <= 360 then
                        player:updateEvent(0, 1) -- Mandragora. Way too soon?
                    end
                end,
            },

            onEventFinish =
            {
                [10191] = function(player, csid, option, npc)
                    player:confirmTrade()
                    player:setMerits(player:getMeritCount() - 10)
                    quest:setVar(player, 'Prog', 1)
                end,

                [10192] = function(player, csid, option, npc)
                    if quest:getVar(player, 'Win') == 1 then
                        if quest:complete(player) then
                            player:setLevelCap(95)
                            player:messageSpecial(ruludeID.text.YOUR_LEVEL_LIMIT_IS_NOW_95)
                        end
                    end
                end,
            },
        },
    },
}

return quest
