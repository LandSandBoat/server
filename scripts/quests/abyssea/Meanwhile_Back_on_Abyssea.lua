-----------------------------------
-- Meanwhile, Back on Abyssea
-----------------------------------
-- !addquest 8 185
-- Joachim  : !pos -52.844 0 -9.978 246
-- Prishe   : !pos 536.353 -499.999 -591.338 255
-- Flagged on completion of The Wyrm God.
-- Talk to Joachim. Zone into the Hall of the Gods between 18:00 and 5:00. Talk to Prishe to flag A Moonlight Requite.
-- A Moonlight Requite signifies that you have completed the main Abyssea story, it cannot be completed.
-----------------------------------

local quest = Quest:new(xi.questLog.ABYSSEA, xi.quest.id.abyssea.MEANWHILE_BACK_ON_ABYSSEA)

quest.reward =
{
    keyItem = xi.ki.ABYSSITE_OF_THE_COSMOS,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.PORT_JEUNO] =
        {
            ['Joachim'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(345)
                    end
                end,
            },

            onEventFinish =
            {
                [345] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
                quest:getVar(player, 'Prog') == 1
        end,

        [xi.zone.HALL_OF_THE_GODS] =
        {
            onZoneIn = function(player, prevZone)
                local hour = VanadielHour()
                if hour >= 18 or hour < 5 then
                    return 9
                end
            end,

            onEventFinish =
            {
                [9] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
                quest:getVar(player, 'Prog') == 2
        end,

        [xi.zone.ABYSSEA_EMPYREAL_PARADOX] =
        {
            ['Prishe'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(204)
                end,
            },

            onEventFinish =
            {
                [204] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:addQuest(xi.questLog.ABYSSEA, xi.quest.id.abyssea.A_MOONLIGHT_REQUITE)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.ABYSSEA_EMPYREAL_PARADOX] =
        {
            ['Prishe'] = quest:event(207):replaceDefault()
        },
    },
}

return quest
