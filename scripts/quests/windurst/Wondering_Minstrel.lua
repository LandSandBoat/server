-----------------------------------
-- Wondering Minstrel
-----------------------------------
-- Log ID: 2, Quest ID: 6
-- !addquest 2 6
-- Jatan-Paratan : !pos -59.998 -4.105 19.775 238
-- Yuli Yaam     : !pos -62.241 -3.500 21.683 238
-- Yung Yaam     : !pos -65.622 -3.800 27.019 238
-- Aramu-Paramu  : !pos -66.924 -3.800 26.038 238
-- Ruslan        : !pos -19.293 -0.100 -56.648 245
-----------------------------------
-- Jatan-Paratan will not offer the quest until the player tells him they have no recollection of his playing at all (option 3).
-- On quest completion, all Tavern NPCs involved offer unique dialogue about the events that transpired until the player zones.
-- Then they all revert to normal dialogue.
-----------------------------------

local quest = Quest:new(xi.questLog.WINDURST, xi.quest.id.windurst.WONDERING_MINSTREL)

quest.reward =
{
    fame     = 50,
    fameArea = xi.fameArea.WINDURST,
    item     = xi.item.FAERIE_PICCOLO,
    title    = xi.title.DOWN_PIPER_PIPE_UPPERER,
}

quest.sections =
{
    -- Section: Quest is available.
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getFameLevel(xi.fameArea.WINDURST) >= 5
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Jatan-Paratan'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(633) -- Asks what the player made of his playing. Correct option neded to trigger next event.
                    else
                        return quest:progressEvent(634) -- Offers the quest
                    end
                end,
            },

            ['Yuli_Yaam'] = quest:event(637),
            ['Yung_Yaam'] = quest:event(636),

            onEventFinish =
            {
                [633] = function(player, csid, option, npc)
                    if option == 3 then
                        quest:setVar(player, 'Prog', 1)
                    end
                end,

                [634] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    -- Section: Quest accepted.
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Ruslan'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(10009, 0, xi.item.PIECE_OF_ROSEWOOD_LUMBER) -- Asks for the lumber.
                    else
                        return quest:event(10010, 0, xi.item.PIECE_OF_ROSEWOOD_LUMBER) -- Rminder.
                    end
                end,
            },

            onEventFinish =
            {
                [10009] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:setVar(player, 'Prog', 2)
                    end
                end,
            },
        },

        [xi.zone.WINDURST_WATERS] =
        {
            ['Jatan-Paratan'] =
            {
                onTrade = function(player, npc, trade)
                    -- The lumber means nothing to him until Ruslan has explained what it is for.
                    if
                        quest:getVar(player, 'Prog') == 2 and
                        npcUtil.tradeMatches(trade, { { xi.item.PIECE_OF_ROSEWOOD_LUMBER, 1 } })
                    then
                        return quest:progressEvent(638) -- Finishes the quest
                    end
                end,

                onTrigger = function(player, npc)
                    return quest:event(635)
                end,
            },

            ['Aramu-Paramu'] = quest:event(683),
            ['Yuli_Yaam']    = quest:event(637),
            ['Yung_Yaam']    = quest:event(636),

            onEventFinish =
            {
                [638] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:tradeComplete()
                        player:needToZone(true)
                    end
                end,
            },
        },
    },

    -- Section: Quest completed.
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Ruslan'] =
            {
                onTrigger = function(player, npc)
                    if math.randomInt(1, 3) == 1 then
                        return quest:event(10011)
                    end
                end,
            },
        },

        [xi.zone.WINDURST_WATERS] =
        {
            ['Aramu-Paramu'] =
            {
                onTrigger = function(player, npc)
                    if player:needToZone() then
                        return quest:event(684)
                    end
                end,
            },

            ['Jatan-Paratan'] =
            {
                onTrigger = function(player, npc)
                    if player:needToZone() then
                        return quest:event(639)
                    end
                end,
            },

            ['Yuli_Yaam'] =
            {
                onTrigger = function(player, npc)
                    if player:needToZone() then
                        return quest:event(641)
                    end
                end,
            },

            ['Yung_Yaam'] =
            {
                onTrigger = function(player, npc)
                    if player:needToZone() then
                        return quest:event(643)
                    end
                end,
            },
        },
    },
}

return quest
