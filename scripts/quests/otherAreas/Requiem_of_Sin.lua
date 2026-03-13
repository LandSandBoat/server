-----------------------------------
-- Requiem of Sin
-----------------------------------
-- Log ID: 4, Quest ID: 83
-- Despachiaire !pos 111.209 -40.015 -85.481
-----------------------------------
local quest = Quest:new(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.REQUIEM_OF_SIN)

quest.reward =
{
    title = xi.title.DISCIPLE_OF_JUSTICE,
}

quest.sections =
{
    -- Section 1: Player has completed Tango with a Tracker and can receive the initial letter from Despachiaire.
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.TANGO_WITH_A_TRACKER)
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Despachiaire'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:getCharVar('ShikareeBattleWait') < NextConquestTally() and
                        quest:getVar(player, 'Prog') == 0
                    then
                        return quest:progressEvent(578)
                    end
                end,
            },

            onEventFinish =
            {
                [578] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.LETTER_FROM_SHIKAREE_Y)
                    player:setCharVar('ShikareeBattleWait', NextConquestTally())
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },

        [xi.zone.BONEYARD_GULLY] =
        {
            onEventFinish =
            {
                [32000] = function(player, csid, option, npc)
                    local battlefield = player:getBattlefield()
                    if not battlefield then
                        return
                    end

                    if battlefield:getID() == xi.battlefield.id.REQUIEM_OF_SIN then
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    -- Section 2: Player has the letter and can obtain replacement letters or enter the battlefield.
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Despachiaire'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:getCharVar('ShikareeBattleWait') < NextConquestTally() and
                        not player:hasKeyItem(xi.ki.LETTER_FROM_SHIKAREE_Y)
                    then
                        return quest:progressEvent(579)
                    end
                end,
            },

            onEventFinish =
            {
                [579] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.LETTER_FROM_SHIKAREE_Y)
                    player:setCharVar('ShikareeBattleWait', NextConquestTally())
                end,
            },
        },

        [xi.zone.BONEYARD_GULLY] =
        {
            onEventFinish =
            {
                [32001] = function(player, csid, option, npc)
                    if player:getLocalVar('battlefieldWin') == xi.battlefield.id.REQUIEM_OF_SIN then
                        quest:complete(player)
                    end
                end,
            },
        },
    },

    -- Section 3: Quest is completed. Player can obtain a new Letter From the Mithran Trackers once per conquest tally
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED and
                player:getCharVar('ShikareeBattleWait') < NextConquestTally() and
                not player:hasKeyItem(xi.ki.LETTER_FROM_THE_MITHRAN_TRACKERS)
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Despachiaire'] = quest:progressEvent(579),

            onEventFinish =
            {
                [579] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.LETTER_FROM_THE_MITHRAN_TRACKERS)
                    player:setCharVar('ShikareeBattleWait', NextConquestTally())
                end,
            },
        },
    },
}

return quest
