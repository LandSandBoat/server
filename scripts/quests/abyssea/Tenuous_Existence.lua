-----------------------------------
-- Tenuous Existence
-----------------------------------
-- !addquest 8 170
-- qm3     : !pos -179 8 254 102
-- Joachim : !pos -52.844 0 -9.978 246
-- Flagged on completion of Heart of Madness.
-- Click ??? in La Theine Plateau between 18:00 and 5:00, then return to Joachim. Flags Champions of Abyssea upon completion.
-----------------------------------

local quest = Quest:new(xi.questLog.ABYSSEA, xi.quest.id.abyssea.TENUOUS_EXISTENCE)

quest.reward = {}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
                VanadielHour() >= 18 and
                VanadielHour() < 5
        end,

        [xi.zone.LA_THEINE_PLATEAU] =
        {
            ['qm3'] = quest:progressEvent(12),

            onEventFinish =
            {
                [12] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and quest:getVar(player, 'Prog') == 1
        end,

        [xi.zone.PORT_JEUNO] =
        {
            ['Joachim'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(336)
                end,
            },

            onEventFinish =
            {
                [336] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:addQuest(xi.questLog.ABYSSEA, xi.quest.id.abyssea.CHAMPIONS_OF_ABYSSEA)
                    end
                end,
            },
        },
    },
}

return quest
