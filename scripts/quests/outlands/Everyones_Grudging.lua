-----------------------------------
-- Everyone's Grudging
-- Log ID: 5, Quest ID: 4
-- Jakoh Wahcondalo !pos 98.153 -15.000 -113.251
-- Rancor Flame     !pos -76 16 -1
-- Alter of Rancor  !pos 116.448 16.000 -318.659
-----------------------------------

local quest = Quest:new(xi.questLog.OUTLANDS, xi.quest.id.outlands.EVERYONES_GRUDGING)

quest.reward =
{
    gil = 11000,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getFameLevel(xi.fameArea.WINDURST) >= 7 and
                player:hasCompletedQuest(xi.questLog.OUTLANDS, xi.quest.id.outlands.A_QUESTION_OF_TASTE) and
                not xi.quest.getMustZone(player, xi.questLog.WINDURST, xi.quest.id.windurst.A_POSE_BY_ANY_OTHER_NAME) and
                player:getCharVar('rancorCurse') == 1
        end,

        [xi.zone.KAZHAM] =
        {
            ['Jakoh_Wahcondalo'] = quest:progressCutscene(107, 0, xi.item.RANCOR_FLAME),

            onEventFinish =
            {
                [107] = function(player, csid, option, npc)
                    quest:begin(player)
                    player:addTitle(xi.title.EXCOMMUNICATE_OF_KAZHAM)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.KAZHAM] =
        {
            ['Etteh_Sulaej'] = quest:event(109, 0, xi.item.RANCOR_FLAME),

            ['Jakoh_Wahcondalo'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:event(108, 0, xi.item.RANCOR_FLAME)
                    else
                        return quest:event(110, 0, xi.item.RANCOR_FLAME)
                    end
                end,
            },

            ['Romaa_Mihgo'] = quest:event(276, 0, xi.item.RANCOR_FLAME),

            onEventFinish =
            {
                [110] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },

        [xi.zone.DEN_OF_RANCOR] =
        {
            ['Rancor_Torch'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if quest:getVar(player, 'Prog') == 0 then
                        quest:setVar(player, 'Prog', 1)
                    end
                end,
            },
        },
    },
}

return quest
