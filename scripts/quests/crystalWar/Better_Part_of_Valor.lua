-----------------------------------
-- Better Part of Valor
-----------------------------------
-- !addquest 7 12
-- Wolfram    : !pos -249 0 88 87
-- Engelhart  : !pos -79 -4 -123 87
-- ???        : !pos -232 41 425 88
-- Leadavox   : !pos 206 -32 316 83
-----------------------------------

local quest = Quest:new(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.BETTER_PART_OF_VALOR)

quest.reward =
{
    gil     = 10000,
    keyItem = xi.ki.WARNING_LETTER,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE
        end,

        [xi.zone.NORTH_GUSTABERG_S] =
        {
            onZoneIn = function(player, prevZone)
                if
                    prevZone == xi.zone.BASTOK_MARKETS_S and
                    player:getCampaignAllegiance() > 0
                then
                    return 1
                end
            end,

            onEventFinish =
            {
                [1] = function(player, csid, option, npc)
                    quest:begin(player)
                    npcUtil.giveKeyItem(player, xi.ki.CLUMP_OF_ANIMAL_HAIR)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.BASTOK_MARKETS_S] =
        {
            ['Engelhart'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 0 then
                        return quest:progressEvent(116)
                    elseif questProgress == 4 then
                        return quest:progressEvent(118)
                    else
                        return quest:event(117)
                    end
                end,
            },

            onEventFinish =
            {
                [116] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                    player:delKeyItem(xi.ki.CLUMP_OF_ANIMAL_HAIR)
                end,

                [118] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.XHIFHUT)
                        player:needToZone(true)
                    end
                end,
            },
        },

        [xi.zone.NORTH_GUSTABERG_S] =
        {
            ['qm1'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(3)
                    end
                end,
            },

            onEventFinish =
            {
                [3] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,
            },

            ['Solitary_Ant'] = quest:event(2):replaceDefault(),
        },

        [xi.zone.VUNKERL_INLET_S] =
        {
            ['Leadavox'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 2 then
                        return quest:progressEvent(101)
                    elseif questProgress == 3 then
                        return quest:event(102)
                    end
                end,

                onTrade = function(player, npc, trade)
                    if
                        quest:getVar(player, 'Prog') == 3 and
                        npcUtil.tradeHasExactly(trade, { { xi.item.GNOLE_CLAW, 1 } })
                    then
                        return quest:progressEvent(103)
                    end
                end,
            },

            onEventFinish =
            {
                [101] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,

                [103] = function(player, csid, option, npc)
                    player:confirmTrade()
                    npcUtil.giveKeyItem(player, xi.ki.XHIFHUT)
                    quest:setVar(player, 'Prog', 4)
                end,
            },
        },
    },
}

return quest
