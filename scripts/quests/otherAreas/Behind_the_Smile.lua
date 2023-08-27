-----------------------------------
-- Behind the Smile
-----------------------------------
-- Log ID: 4, Quest ID: 77
-- Enaremand       :
-- Fyi_Chalmwoh    : !pos -39.273 -16.000 70.126 249
-- Red Oil KI      : 704
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/titles')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------
local landingID = require('scripts/zones/Carpenters_Landing/IDs')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.BEHIND_THE_SMILE)

quest.reward =
{
    item = xi.items.MANNEQUIN_PUMPS,
}

quest.sections =
{
    -- START: Talk to Enaremand (J-7) on the upper level in Tavnazian Safehold
    -- QUEST AVAILABLE
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
            player:hasCompletedQuest(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.ITS_RAINING_MANNEQUINS)
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Enaremand'] = quest:progressEvent(533),

            onEventFinish =
            {
                [533] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    -- QUEST ACCEPTED
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.MHAURA] =
        {
            ['Fyi_Chalmwoh'] =
            {
                onTrigger = function(player, csid, option, npc)
                    if quest:getVar(player, 'prog') == 0 then
                        return quest:progressEvent(320, { [1] = xi.ki.RED_OIL })
                    end
                end,
            },

            onEventFinish =
            {
                [320] = function(player, csid, option, npc)
                    quest:setVar(player, 'prog', 1)
                end,
            }
        },

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Enaremand'] =
            {
                onTrigger = function(player, csid, option, npc)
                    if quest:getVar(player, 'prog') == 3 and
                    player:hasKeyItem(xi.ki.RED_OIL) then
                        return quest:event(534)
                    end
                end,
            },

            onEventFinish =
            {
                [534] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.RED_OIL)
                    end
                end,
            },
        },

        [xi.zone.CARPENTERS_LANDING] =
        {
            ['qm_bullheaded'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'prog') == 1 and
                    npcUtil.popFromQM(player, npc, landingID.mob.BULLHEADED_GROSVEZ, { claim = true, hide = 0 }) then
                        return quest:messageSpecial(landingID.text.STENCH_OF_DECAY)
                    elseif quest:getVar(player, 'prog') == 2 then
                        player:addKeyItem(xi.ki.RED_OIL)
                        quest:setVar(player, 'prog', 3)
                        return quest:messageSpecial(landingID.text.KEYITEM_OBTAINED, xi.ki.RED_OIL)
                    end
                end,
            },

            ['Bullheaded_Grosvez'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if quest:getVar(player, 'prog') == 1 then
                        quest:setVar(player, 'prog', 2)
                    end
                end,
            },
        },
    },
}

return quest
