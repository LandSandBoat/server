-----------------------------------
-- In the Mood for Love
-----------------------------------
-- Log ID: 3, Quest ID: 69
-- Odasel  !pos -58 -6 -111 245
-- Matoaka !pos -37 -6 -122 245
-----------------------------------
local quest = Quest:new(xi.questLog.JEUNO, xi.quest.id.jeuno.IN_THE_MOOD_FOR_LOVE)

quest.reward =
{
    gil = 4800,
    fame = 30,
    fameArea = xi.fameArea.JEUNO,
    title = xi.title.PICK_UP_ARTIST,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
            player:getCurrentMission(xi.mission.log_id.COP) > xi.mission.id.cop.A_VESSEL_WITHOUT_A_CAPTAIN
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Odasel'] = quest:progressEvent(10035, 0, xi.item.CHAMELEON_DIAMOND),

            onEventFinish =
            {
                [10035] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Odasel'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(10037, 0, xi.item.CHAMELEON_DIAMOND)
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.item.CHAMELEON_DIAMOND) then
                        return quest:progressEvent(10036, 0, xi.item.CHAMELEON_DIAMOND)
                    end
                end,
            },
            onEventFinish =
            {
                [10036] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                        quest:setVar(player, 'Option', 1)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Odasel'] = quest:event(10038):replaceDefault(),

            ['Matoaka'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Option') == 1 then
                        -- Additional Cutscene
                        return quest:progressEvent(10039)
                    end
                end,
            },
            onEventFinish =
            {
                [10039] = function(player, csid, option, npc)
                    quest:setVar(player, 'Option', 0)
                end,
            },
        },
    },
}

return quest
