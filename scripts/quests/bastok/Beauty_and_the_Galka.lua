-----------------------------------
-- Beauty and the Galka
-----------------------------------
-- Log ID: 1, Quest ID: 1
-- Talib : !pos -101.133 4.649 28.803 236
-----------------------------------

local quest = Quest:new(xi.questLog.BASTOK, xi.quest.id.bastok.BEAUTY_AND_THE_GALKA)

quest.reward =
{
    fame     = 30,
    fameArea = xi.fameArea.NORG,
    item     = xi.item.BRONZE_KNIFE,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE
        end,

        [xi.zone.PORT_BASTOK] =
        {
            ['Talib'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:event(4) -- Denied Cornelia's request.
                    else
                        return quest:progressEvent(2) -- First time.
                    end
                end,
            },

            onEventFinish =
            {
                [2] = function(player, csid, option, npc)
                    if option == 1 then -- Decline quest
                        quest:setVar(player, 'Prog', 1)
                    else
                        quest:begin(player)
                    end
                end,
            },
        },

        [xi.zone.BASTOK_MINES] =
        {
            ['Parraggoh'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(7) -- Cornelia told the player of Parraggoh's predicament.
                    end
                end,
            },

            onEventFinish =
            {
                [7] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:begin(player)
                    end
                end,
            },
        }
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.PORT_BASTOK] =
        {
            ['Talib'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(4)
                end,

                onTrade = function(player, npc, trade)
                    if
                        not player:hasKeyItem(xi.ki.PALBOROUGH_MINES_LOGS) and
                        npcUtil.tradeMatches(trade, { { xi.item.CHUNK_OF_ZINC_ORE, 1 } })
                    then
                        return quest:progressEvent(3)
                    end
                end,
            },

            onEventFinish =
            {
                [3] = function(player, csid, option, npc)
                    player:tradeComplete()
                    npcUtil.giveKeyItem(player, xi.ki.PALBOROUGH_MINES_LOGS)
                end,
            },
        },

        [xi.zone.BASTOK_MINES] =
        {
            ['Parraggoh'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.PALBOROUGH_MINES_LOGS) then
                        return quest:progressEvent(10, quest:getVar(player, 'Prog'))
                    elseif math.randomInt(1, 100) <= 50 then
                        return quest:event(8)
                    else
                        return quest:event(9)
                    end
                end,
            },

            onEventFinish =
            {
                [10] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.PALBOROUGH_MINES_LOGS)
                    end
                end,
            },
        }
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.BASTOK_MINES] =
        {
            -- New default texts.
            ['Parraggoh'] = quest:event(12):replaceDefault(),
        },
    },
}

return quest
