-----------------------------------
-- Save My Son
-----------------------------------
-- Log ID: 3, Quest ID: 5
-- Merchants Door !gotoid 17780840
-- Shalott: !gotoid 17776654
-- Nightflowers !gotoid 17293708
-----------------------------------
require('scripts/globals/quests')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')

local ID = require("scripts/zones/Qufim_Island/IDs")
-----------------------------------
local quest = Quest:new(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.SAVE_MY_SON)

quest.reward =
{
    gil = 2100,
    fame = 30,
    fameArea = xi.quest.fame_area.JEUNO,
    item = xi.items.BEAST_WHISTLE,
    title = xi.title.LIFE_SAVER,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
            player:hasCompletedQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.CHOCOBOS_WOUNDS) and
            player:getMainLvl() >= 30
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['_6t2'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(164)
                end,

            },
            onEventFinish =
            {
                [164] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.UPPER_JEUNO] =
        {
            ['Shalott'] = quest:event(101) -- optional dialog
        },

        [xi.zone.QUFIM_ISLAND] = -- UPDATE char_vars SET varname = 'Quest[3][5]Prog' WHERE varname = "SaveMySon_Event";
        {
            ['Nightflowers'] =
            {
                onTrigger = function(player, npc)
                    local currentTime = VanadielHour()

                    if currentTime >= 2132 or currentTime <= 0540 then --https://ffxiclopedia.fandom.com/wiki/Save_My_Son
                        if quest:getVar(player, 'Prog') == 0 then
                            return quest:progressEvent(0)
                        else
                            return quest:messageSpecial(ID.text.NOW_THAT_NIGHT_HAS_FALLEN)
                        end
                    else
                        return quest:messageSpecial(ID.text.THESE_WITHERED_FLOWERS)
                    end
                end,
            },

            onEventFinish =
            {
                [0] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },

        [xi.zone.LOWER_JEUNO] =
        {
            ['_6t2'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:event(229)
                    elseif quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(163)
                    end
                end,
            },

            onEventFinish =
            {
                [163] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },
    },
}

return quest
