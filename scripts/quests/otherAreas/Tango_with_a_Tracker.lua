-----------------------------------
-- Tango With a Tracker
-----------------------------------
-- Log ID: 4, Quest ID: 82
-- Despachiaire !pos 111.209 -40.015 -85.481
-- TODO: Exact quest start is unknown but proven to be flaggable once the player is on CoP 8-3 from captures.
-- TODO: The quest doesn't show up in the log right away after accepting the first time.
--       The quest might flag as active upon entering the battlefield the first time, needs capture confirmation.
-----------------------------------

local quest = Quest:new(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.TANGO_WITH_A_TRACKER)

quest.reward =
{
    gil   = 10000,
    title = xi.title.SIN_HUNTER_HUNTER,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.A_FATE_DECIDED)
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Despachiaire'] = quest:progressEvent(576),

            onEventFinish =
            {
                [576] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.LETTER_FROM_SHIKAREE_X)
                    quest:setVar(player, 'Prog', 1)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return vars.Prog == 1 and
                (status == xi.questStatus.QUEST_ACCEPTED or
                status == xi.questStatus.QUEST_COMPLETED)
        end,

        [xi.zone.BONEYARD_GULLY] =
        {
            onEventFinish =
            {
                [32000] = function(player, csid, option, npc)
                    if option == 105 then
                        quest:setVar(player, 'Prog', 2)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return vars.Prog == 2 and
                (status == xi.questStatus.QUEST_ACCEPTED or
                status == xi.questStatus.QUEST_COMPLETED)
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Despachiaire'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Wait') < NextConquestTally() then
                        return quest:progressEvent(577) -- Recieve a subsequent letter
                    end
                end,
            },

            onEventFinish =
            {
                [577] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.LETTER_FROM_SHIKAREE_X)
                    quest:setVar(player, 'Wait', NextConquestTally())   -- Player can only get a new letter once per conquest reset.
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },

        [xi.zone.BONEYARD_GULLY] =
        {
            onEventFinish =
            {
                [32001] = function(player, csid, option, npc)
                    if player:getLocalVar('battlefieldWin') == xi.battlefield.id.TANGO_WITH_A_TRACKER then
                        quest:complete(player)
                    end
                end,
            },
        },
    },
}

return quest
