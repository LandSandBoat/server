-----------------------------------
-- Prelude_to_Puissance
-----------------------------------
-- Log ID: 3, Quest ID: 170
-- Nomad Moogle : !pos 10.012 1.453 121.883 243
require('scripts/globals/items')
require('scripts/globals/keyitems')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/interaction/quest')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.PRELUDE_TO_PUISSANCE)

-- TODO: Properly code timing minigame. Awaiting for a capture.
-- Amount of visual qeues selected at random. Min: Probably 3. Max: 7. Camera angle keeps changing qithout hints.
-- Always the same camera angle at victory.

quest.reward =
{
    fame = 50,
    fameArea = xi.quest.fame_area.JEUNO,
    keyItem = xi.ki.SOUL_GEM_CLASP,
}

quest.sections =
{
    -- Section: Quest available.
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getMainLvl() >= 91 and
                player:getLevelCap() == 95 and
                xi.settings.main.MAX_LEVEL >= 99
        end,

        [xi.zone.RULUDE_GARDENS] =
        {
            ['Nomad_Moogle'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(10194)
                end,
            },

            onEventFinish =
            {
                [10194] = function(player, csid, option, npc)
                    quest:begin(player)
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
                    if quest:getVar(player, 'tradeCompleted') == 1 then
                        return quest:progressEvent(10045, 0, 1, 5)
                    else
                        return quest:event(10045, 0, 1, 6, 2)
                    end
                end,

                onTrade = function(player, npc, trade)
                    if
                        quest:getVar(player, 'tradeCompleted') == 0 and
                        npcUtil.tradeHasExactly(trade, xi.items.SEASONING_STONE)
                    then
                        return quest:progressEvent(10045, 0, 1, 5)
                    end
                end,
            },

            onEventFinish =
            {
                [10045] = function(player, csid, option, npc)
                    -- Trade is completed regardless of option chosen.
                    if quest:getVar(player, 'tradeCompleted') == 0 then
                        player:confirmTrade()
                        quest:setVar(player, 'tradeCompleted', 1)
                    end

                    -- All this options complete the current quest.
                    if
                        option == 0 or
                        option == 13 or
                        option == 14 or
                        option == 15 or
                        option == 19 or
                        option == 20 or
                        option == 21
                    then
                        if quest:complete(player) then
                            -- This options immediately start next quest. (All except 0 and 15).
                            if
                                not option == 0 or
                                not option == 15
                            then
                                player:addQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.BEYOND_INFINITY)
                            end

                            -- This options also warp you to a BCNM. Note that the quest "Beyond Infinity" is already activated in this cases.
                            if option == 14 then
                                player:setPos(-511.459, 159.004, -210.543, 10, 139) -- Horlais Peek
                            elseif option == 19 then
                                player:setPos(-349.899, 104.213, -260.150, 0, 144) -- Waughrum Shrine
                            elseif option == 20 then
                                player:setPos(299.316, -123.591, 353.760, 66, 146) -- Balga's Dais
                            elseif option == 21 then
                                player:setPos(-225.146, -24.250, 20.057, 255, 206) -- Qu'bia Arena
                            end
                        end
                    end
                end,
            },
        },
    },
}

return quest
