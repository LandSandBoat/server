-----------------------------------
-- Onion Rings
--
-- Kohlo-Lakolo, !pos -26.8 -6 190 240
-----------------------------------
require('scripts/globals/items')
require("scripts/globals/keyitems")
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/titles')
require('scripts/globals/interaction/quest')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.WINDURST, xi.quest.id.windurst.ONION_RINGS)

quest.reward =
{
    fame     = 10,
    fameArea = WINDURST,
    title    = xi.title.STAR_ONION_BRIGADIER,
}

quest.sections =
{
    -- NOTE
    -- From the moment you speak with Kohlo-Lakolo, if you dont have the Old Ring, a 24 hour time limit will start.
    -- You still need to get the ring, no matter what.

    -- Section: Quest is available.
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.INSPECTOR_S_GADGET) == QUEST_COMPLETED
        end,

        [xi.zone.PORT_WINDURST] =
        {
            ['Kohlo-Lakolo'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:getMainLvl() >= 5 and
                        player:needToZone() == false and
                        player:getFameLevel(WINDURST) >= 3
                    then
                        if player:hasKeyItem(xi.ki.OLD_RING) then
                            if quest:getVar(player, 'Prog') == 0 then
                                return quest:progressEvent(432, 0, xi.ki.OLD_RING) -- Instant Quest Complete.
                            elseif quest:getVar(player, 'Prog') == 1 then
                                local daysPassed     = VanadielDayOfTheYear() - quest:getVar(player, 'DayStarted')
                                local totalHoursLeft = 24 - (VanadielHour() + daysPassed * 24) + quest:getVar(player, 'HourStarted')
                                if totalHoursLeft > 0 then
                                    return quest:progressEvent(430, 0, xi.ki.OLD_RING) -- Quest starting event.
                                else
                                    return quest:progressEvent(432, 0, xi.ki.OLD_RING) -- Instant Quest Complete.
                                end
                            end
                        else
                            return quest:progressEvent(429) -- Timer start and reminder text.
                        end
                    else
                        return quest:event(422) -- Default text.
                    end
                end,
            },

            onEventFinish =
            {
                [429] = function(player, csid, option, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        quest:setVar(player, 'Prog', 1)
                        quest:setVar(player, 'HourStarted', VanadielHour())        -- Set current quest started variables.
                        quest:setVar(player, 'DayStarted', VanadielDayOfTheYear()) -- Set current quest started variables.
                    end
                end,
                [430] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
                [432] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.OLD_RING)
                        player:needToZone(true)
                    end
                end,
            },
        },
    },

    -- Section: Quest accepeted. You didn't start with the "Old Ring" Key Item.
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and vars.Prog == 1
        end,

        [xi.zone.PORT_WINDURST] =
        {
            ['Kohlo-Lakolo'] =
            {
                onTrigger = function(player, npc)
                    local daysPassed     = VanadielDayOfTheYear() - quest:getVar(player, 'DayStarted')
                    local totalHoursLeft = 24 - (VanadielHour() + daysPassed * 24) + quest:getVar(player, 'HourStarted')
                    if totalHoursLeft > 0 then
                        return quest:event(431) -- Reminder text.
                    else
                        return quest:progressEvent(433) -- Instant Quest Complete.
                    end
                end,
            },
            ['Gomada-Vulmada'] =
            {
                onTrigger = function(player, npc)
                    local daysPassed     = VanadielDayOfTheYear() - quest:getVar(player, 'DayStarted')
                    local totalHoursLeft = 24 - (VanadielHour() + daysPassed * 24) + quest:getVar(player, 'HourStarted')
                    if totalHoursLeft > 0 then
                        return quest:event(435)
                    else
                        return quest:event(442)
                    end
                end,
            },
            ['Papo-Hopo'] =
            {
                onTrigger = function(player, npc)
                    local daysPassed     = VanadielDayOfTheYear() - quest:getVar(player, 'DayStarted')
                    local totalHoursLeft = 24 - (VanadielHour() + daysPassed * 24) + quest:getVar(player, 'HourStarted')
                    if totalHoursLeft > 0 then
                        return quest:event(434)
                    else
                        return quest:event(441)
                    end
                end,
            },
            ['Pichichi'] =
            {
                onTrigger = function(player, npc)
                    local daysPassed     = VanadielDayOfTheYear() - quest:getVar(player, 'DayStarted')
                    local totalHoursLeft = 24 - (VanadielHour() + daysPassed * 24) + quest:getVar(player, 'HourStarted')
                    if totalHoursLeft > 0 then
                        return quest:event(438)
                    else
                        return quest:event(445)
                    end
                end,
            },
            ['Pyo_Nzon'] =
            {
                onTrigger = function(player, npc)
                    local daysPassed     = VanadielDayOfTheYear() - quest:getVar(player, 'DayStarted')
                    local totalHoursLeft = 24 - (VanadielHour() + daysPassed * 24) + quest:getVar(player, 'HourStarted')
                    if totalHoursLeft > 0 then
                        return quest:event(436)
                    else
                        return quest:event(443)
                    end
                end,
            },
            ['Shanruru'] =
            {
                onTrigger = function(player, npc)
                    local daysPassed     = VanadielDayOfTheYear() - quest:getVar(player, 'DayStarted')
                    local totalHoursLeft = 24 - (VanadielHour() + daysPassed * 24) + quest:getVar(player, 'HourStarted')
                    if totalHoursLeft > 0 then
                        return quest:event(439)
                    else
                        return quest:event(446)
                    end
                end,
            },
            ['Yafa_Yaa'] =
            {
                onTrigger = function(player, npc)
                    local daysPassed     = VanadielDayOfTheYear() - quest:getVar(player, 'DayStarted')
                    local totalHoursLeft = 24 - (VanadielHour() + daysPassed * 24) + quest:getVar(player, 'HourStarted')
                    if totalHoursLeft > 0 then
                        return quest:event(437)
                    else
                        return quest:event(444)
                    end
                end,
            },

            onEventFinish =
            {
                [433] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.OLD_RING)
                        player:needToZone(true)
                    end
                end,
            },
        },

        [xi.zone.WINDURST_WALLS] =
        {
            ['_6n2'] =
            {
                onTrigger = function(player, npc)
                    local daysPassed     = VanadielDayOfTheYear() - quest:getVar(player, 'DayStarted')
                    local totalHoursLeft = 24 - (VanadielHour() + daysPassed * 24) + quest:getVar(player, 'HourStarted')
                    if totalHoursLeft > 0 then
                        return quest:progressEvent(289)
                    end
                end,
            },

            onEventFinish =
            {
                [289] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.OLD_RING)
                        player:needToZone(true)
                    end
                end,
            },
        },
    },

    -- Section: Quest completed.
    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED and
                player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.CRYING_OVER_ONIONS) == QUEST_AVAILABLE
        end,

        [xi.zone.PORT_WINDURST] =
        {
            -- New default texts.
            ['Gomada-Vulmada'] = quest:event(442):replaceDefault(),
            ['Papo-Hopo']      = quest:event(441):replaceDefault(),
            ['Pichichi']       = quest:event(445):replaceDefault(),
            ['Pyo_Nzon']       = quest:event(443):replaceDefault(),
            ['Shanruru']       = quest:event(446):replaceDefault(),
            ['Yafa_Yaa']       = quest:event(444):replaceDefault(),
        },
    },
}

return quest
