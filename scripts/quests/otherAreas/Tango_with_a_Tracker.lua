-----------------------------------
-- Tango With a Tracker
-----------------------------------
-- Log ID: 4, Quest ID: 82
-- Despachiaire !pos 111.209 -40.015 -85.481
-- Quest begins on battlefield entrance and completes on battlefield win
-- TODO: Verify CoP quest progression requirements to begin quest
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
                quest:getVar(player, 'Prog') == 0 and
                player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.A_FATE_DECIDED)
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Despachiaire'] = quest:progressEvent(576),

            onEventFinish =
            {
                [576] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.LETTER_FROM_SHIKAREE_X)
                    player:setCharVar('ShikareeBattleWait', NextConquestTally())   -- Player can only get a new letter once per conquest reset.
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return vars.Prog == 1 and
                status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Despachiaire'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:getCharVar('ShikareeBattleWait') < NextConquestTally() and
                        not player:hasKeyItem(xi.ki.LETTER_FROM_SHIKAREE_X)
                    then
                        return quest:progressEvent(577) -- Recieve a subsequent letter
                    end
                end,
            },

            onEventFinish =
            {
                [577] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.LETTER_FROM_SHIKAREE_X)
                    player:setCharVar('ShikareeBattleWait', NextConquestTally())   -- Player can only get a new letter once per conquest reset.
                end,
            },
        },

        [xi.zone.BONEYARD_GULLY] =
        {
            onEventFinish =
            {
                [32000] = function(player, csid, option, npc)
                    quest:begin(player)
                end,

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
