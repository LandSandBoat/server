-----------------------------------
-- Chocobo on the Loose
-----------------------------------
-- Log ID: 3, Quest ID: 92
-- Brutus         : !pos -55 8 95 244
-- Chocobo Tracks : !pos -556 0 523 102
-- Hantileon      : !pos -2.675 -1.1 -105.287 230
-----------------------------------
require("scripts/globals/items")
require("scripts/globals/quests")
require("scripts/globals/zone")
require('scripts/globals/interaction/quest')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.CHOCOBO_ON_THE_LOOSE)

quest.reward =
{
    -- TODO: Verify this is the correct egg for Quest Reward
    item = xi.items.CHOCOBO_EGG,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
        end,

        [xi.zone.UPPER_JEUNO] =
        {
            -- TODO: This isn't the flagging event, but is actually added when flagging
            -- Chocobo's Wounds.  Need safety for future players added as well when fixing this.
            ['Brutus'] = quest:progressEvent(10093),

            onEventFinish =
            {
                [10093] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.LA_THEINE_PLATEAU] =
        {
            ['Chocobo_Tracks'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(209)
                    end
                end,
            },
            

            onEventFinish =
            {
                [209] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Hantileon'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 2 then
                        return quest:progressEvent(821)
                    elseif questProgress == 3 then
                        return quest:progressEvent(822)
                    end
                end,
            },

            onEventFinish =
            {
                [821] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,
            },
        },

        [xi.zone.UPPER_JEUNO] =
        {
            ['Brutus'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 0 then
                        return quest:progressEvent(10094):oncePerZone()
                    elseif questProgress == 1 then
                        return quest:progressEvent(10095)
                    elseif questProgress == 2 then
                        return quest:progressEvent(10099)
                    elseif questProgress == 3 then
                        return quest:progressEvent(10100)
                    elseif
                        questProgress == 4 and
                        not quest:getMustZone(player) and
                        quest:getVar(player, 'Timer') <= VanadielUniqueDay()
                    then
                        return quest:progressEvent(10109)
                    end
                end,
            },

            onEventFinish =
            {
                [10095] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,

                [10100] = function(player, csid, option, npc)
                    quest:setMustZone(player)
                    quest:setVar(player, 'Prog', 4)
                    quest:setVar(player, 'Timer', VanadielUniqueDay() + 1)
                end,

                [10109] = function(player, csid, option, npc)

                end,
            },
        },
    },
}

return quest
