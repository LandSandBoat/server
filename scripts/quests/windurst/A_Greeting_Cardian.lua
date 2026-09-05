-----------------------------------
-- A Greeting Cardian
-----------------------------------
-- Log ID: 2, Quest ID: 43
-- !addquest 2 43
-- Kororo           : !pos -11.883 -2.750 5.508 241
-- Spare One        : !pos -8.201 -2.750 10.018 241
-- Boizo-Naizo      : !pos -9.581 -2.750 -26.062 241
-- Five of Diamonds : !pos -220.954 0.999 -122.708 239
-- Five of Hearts   : !pos 126.369 -2.002 45.531 238
-- Five of Clubs    : !pos 97.481 -4.000 151.498 240
-- Five of Spades   : !pos -478.100 -32.120 47.394 118
-----------------------------------
-- Only Spare One offers the greeting menu. Event 295 arms the quest.
-- The log stays empty until Kororo's offer is accepted. He offers it after a zone change.
-- Event 296 is a nudge, not the offer. The greeting chosen on 295 is replayed later.
-----------------------------------
local buburimuID = zones[xi.zone.BUBURIMU_PENINSULA]
-----------------------------------

local quest = Quest:new(xi.questLog.WINDURST, xi.quest.id.windurst.A_GREETING_CARDIAN)

quest.reward =
{
    fame     = 30,
    fameArea = xi.fameArea.WINDURST,
    item     = xi.item.TOURMALINE_EARRING,
}

quest.sections =
{
    -- Section: Quest is available.
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.questLog.WINDURST, xi.quest.id.windurst.THE_ALL_NEW_C_2000) and
                player:getFameLevel(xi.fameArea.WINDURST) >= 3
        end,

        [xi.zone.WINDURST_WOODS] =
        {
            ['Kororo'] =
            {
                onTrigger = function(player, npc)
                    -- Points at Spare One until a greeting is taught.
                    if quest:getVar(player, 'Greeting') == 0 then
                        return quest:event(296)
                    end

                    -- The offer needs the zone change and the timer. Kororo gives his default line until then.
                    if
                        not quest:getMustZone(player) and
                        GetSystemTime() >= quest:getVar(player, 'Wait')
                    then
                        return quest:progressEvent(298)
                    end
                end,
            },

            ['Spare_One'] =
            {
                onTrigger = function(player, npc)
                    local greeting = quest:getVar(player, 'Greeting')

                    -- Spare One repeats the greeting he was taught.
                    if greeting ~= 0 then
                        return quest:event(495, 0, greeting)
                    end

                    return quest:progressEvent(295)
                end,
            },

            onEventFinish =
            {
                [295] = function(player, csid, option, npc)
                    -- The menu offers three greetings. Escaping the cutscene teaches nothing.
                    if option < 1 or option > 3 then
                        return
                    end

                    quest:setVar(player, 'Greeting', option)
                    quest:setVar(player, 'Wait', GetSystemTime() + 60) -- 1 minute wait time
                    quest:setMustZone(player)
                end,

                [298] = function(player, csid, option, npc)
                    -- Declining changes nothing. The offer can be taken again.
                    if option == 1 then
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

        [xi.zone.BUBURIMU_PENINSULA] =
        {
            ['Five_of_Spades'] =
            {
                onTrigger = function(player, npc)
                    local greeting = quest:getVar(player, 'Greeting')

                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(1, xi.zone.BUBURIMU_PENINSULA, greeting)
                    end

                    -- Five of Spades keeps the taught greeting until Kororo corrects him.
                    return quest:messageName(buburimuID.text.FIVEOFSPADES_GREETING_OFFSET + greeting)
                end,
            },

            onEventFinish =
            {
                [1] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },

        [xi.zone.PORT_WINDURST] =
        {
            ['Five_of_Clubs'] = quest:event(448),
        },

        [xi.zone.WINDURST_WALLS] =
        {
            ['Five_of_Diamonds'] = quest:event(339),
        },

        [xi.zone.WINDURST_WATERS] =
        {
            ['Five_of_Hearts'] = quest:event(686),
        },

        [xi.zone.WINDURST_WOODS] =
        {
            ['Boizo-Naizo'] = quest:event(302),

            ['Kororo'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(303)
                    end

                    return quest:event(299)
                end,
            },

            onEventFinish =
            {
                [303] = function(player, csid, option, npc)
                    if quest:complete(player) then
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

        [xi.zone.WINDURST_WOODS] =
        {
            ['Boizo-Naizo'] = quest:event(307),
            ['Kororo']      = quest:event(304),
        },
    },
}

return quest
