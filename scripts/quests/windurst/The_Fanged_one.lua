-----------------------------------
-- The Fanged One
-----------------------------------
-- Log ID: 2, Quest ID: 31
-- Perih Vashai: !pos 117 -3 92 241
-- Tiger Bones: !pos 666 -8 -379 120
-- Keeping Old Sabertooth and Tiger Bones in separate lua's due to special functions.
-----------------------------------
require('scripts/globals/quests')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------
local ID = require('scripts/zones/Windurst_Woods/IDs')
-----------------------------------
local quest = Quest:new(xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_FANGED_ONE)

quest.reward =
{
    fame     = 20,
    fameArea = xi.quest.fame_area.WINDURST,
    item     = xi.items.RANGERS_NECKLACE,
    title    = xi.title.THE_FANGED_ONE,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
            player:getMainLvl() >= xi.settings.main.ADVANCED_JOB_LEVEL
        end,

        [xi.zone.WINDURST_WOODS] =
        {
            ['Perih_Vashai'] = quest:progressEvent(351),

            onEventFinish =
            {
                [351] = function(player, csid, option, npc)
                    quest:begin(player)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.WINDURST_WOODS] =
        {
            ['Perih_Vashai'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:event(352)
                    elseif
                        quest:getVar(player, 'Prog') == 2 and
                        not player:hasKeyItem(xi.ki.OLD_TIGERS_FANG)
                    then
                        return quest:event(356)
                    elseif player:hasKeyItem(xi.ki.OLD_TIGERS_FANG) then
                        return quest:progressEvent(357)
                    end
                end,
            },

            ['Muhk_Johldy'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.OLD_TIGERS_FANG) then
                        return quest:event(353)
                    end
                end,
            },

            onEventFinish =
            {
                [357] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.OLD_TIGERS_FANG)
                        player:unlockJob(xi.job.RNG)
                        return quest:messageSpecial(ID.text.PERIH_VASHAI_DIALOG)
                    end
                end,
            },
        },
    },
}

return quest
