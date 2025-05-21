-----------------------------------
-- Waking the Beast
-----------------------------------
-- Log ID: 4, Quest ID: 32
-- ???: !pos -179 8 254
-----------------------------------
require('scripts/globals/common')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/interaction/quest')
-----------------------------------

local quest = Quest:new(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.WAKING_THE_BEAST)

quest.reward =
{
    item = xi.item.CARBUNCLES_POLE,
}

quest.sections =
{
    -- check to start the quest the first time
    {
        check = function(player, status, vars)
            -- condition for the starting the quest the first time
            return (status == xi.questStatus.QUEST_AVAILABLE and
            player:hasSpell(xi.magic.spell.IFRIT) and
            player:hasSpell(xi.magic.spell.GARUDA) and
            player:hasSpell(xi.magic.spell.SHIVA) and
            player:hasSpell(xi.magic.spell.RAMUH) and
            player:hasSpell(xi.magic.spell.LEVIATHAN) and
            player:hasSpell(xi.magic.spell.TITAN)) or
            -- condition for the starting the quest (after completing previously)
            (status == xi.questStatus.QUEST_COMPLETED and
            not player:hasKeyItem(xi.ki.FADED_RUBY) and
            not player:hasKeyItem(xi.ki.RAINBOW_RESONATOR) and
            quest:getVar(player, 'completedThisWeek') == 0)
        end,

        [xi.zone.LA_THEINE_PLATEAU] =
        {
            ['qm3'] = quest:progressEvent(207),

            onEventFinish =
            {
                [207] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.RAINBOW_RESONATOR)
                    -- if starting for the first time then begin the quest
                    if player:getQuestStatus(quest.areaId, quest.questId) == xi.questStatus.QUEST_AVAILABLE then
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    -- check for completing the quest the first time or subsequent times
    {
        check = function(player, status, vars)
            return (status == xi.questStatus.QUEST_ACCEPTED or
            status == xi.questStatus.QUEST_COMPLETED) and
            player:hasKeyItem(xi.ki.FADED_RUBY) and
            quest:getVar(player, 'completedThisWeek') == 0
        end,

        [xi.zone.LA_THEINE_PLATEAU] =
        {
            ['qm3'] = quest:progressEvent(208),

            onEventFinish =
            {
                [208] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        quest:setVar(player, 'completedThisWeek', 1, NextConquestTally())
                        player:delKeyItem(xi.ki.FADED_RUBY)

                        if quest:getVar(player, 'Option') == 0 then
                            player:addTitle(xi.title.DISTURBER_OF_SLUMBER)
                        else
                            player:addTitle(xi.title.INTERRUPTER_OF_DREAMS)
                        end
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return (status == xi.questStatus.QUEST_ACCEPTED or
            status == xi.questStatus.QUEST_COMPLETED) and
            player:hasKeyItem(xi.ki.EYE_OF_FLAMES) and
            player:hasKeyItem(xi.ki.EYE_OF_FROST) and
            player:hasKeyItem(xi.ki.EYE_OF_GALES) and
            player:hasKeyItem(xi.ki.EYE_OF_STORMS) and
            player:hasKeyItem(xi.ki.EYE_OF_TIDES) and
            player:hasKeyItem(xi.ki.EYE_OF_TREMORS) and
            player:hasKeyItem(xi.ki.RAINBOW_RESONATOR)
        end,

        [xi.zone.FULL_MOON_FOUNTAIN] =
        {
            onEventFinish =
            {
                [32001] = function(player, csid, option, npc)
                    if player:getLocalVar('battlefieldWin') == xi.battlefield.id.WAKING_THE_BEAST_FULLMOON then
                        player:delKeyItem(xi.ki.EYE_OF_FLAMES)
                        player:delKeyItem(xi.ki.EYE_OF_FROST)
                        player:delKeyItem(xi.ki.EYE_OF_GALES)
                        player:delKeyItem(xi.ki.EYE_OF_STORMS)
                        player:delKeyItem(xi.ki.EYE_OF_TIDES)
                        player:delKeyItem(xi.ki.EYE_OF_TREMORS)
                        player:delKeyItem(xi.ki.RAINBOW_RESONATOR)

                        npcUtil.giveKeyItem(player, xi.ki.FADED_RUBY)

                        if option == 0 then
                            quest:setVar(player, 'Option', 1)
                        else
                            quest:setVar(player, 'Option', 0)
                        end
                    end
                end,
            }
        }
    },

    {
        check = function(player, status, vars)
            return (status == xi.questStatus.QUEST_ACCEPTED or
            status == xi.questStatus.QUEST_COMPLETED) and
            player:hasKeyItem(xi.ki.RAINBOW_RESONATOR)
        end,

        [xi.zone.CLOISTER_OF_FLAMES] =
        {
            onEventFinish =
            {
                [32001] = function(player, csid, option, npc)
                    if player:getLocalVar('battlefieldWin') == xi.battlefield.id.WAKING_THE_BEAST_CLOISTER_OF_FLAMES then
                        npcUtil.giveKeyItem(player, xi.ki.EYE_OF_FLAMES)
                    end
                end,
            }
        },

        [xi.zone.CLOISTER_OF_FROST] =
        {
            onEventFinish =
            {
                [32001] = function(player, csid, option, npc)
                    if player:getLocalVar('battlefieldWin') == xi.battlefield.id.WAKING_THE_BEAST_CLOISTER_OF_FROST then
                        npcUtil.giveKeyItem(player, xi.ki.EYE_OF_FROST)
                    end
                end,
            }
        },

        [xi.zone.CLOISTER_OF_GALES] =
        {
            onEventFinish =
            {
                [32001] = function(player, csid, option, npc)
                    if player:getLocalVar('battlefieldWin') == xi.battlefield.id.WAKING_THE_BEAST_CLOISTER_OF_GALES then
                        npcUtil.giveKeyItem(player, xi.ki.EYE_OF_GALES)
                    end
                end,
            }
        },

        [xi.zone.CLOISTER_OF_STORMS] =
        {
            onEventFinish =
            {
                [32001] = function(player, csid, option, npc)
                    if player:getLocalVar('battlefieldWin') == xi.battlefield.id.WAKING_THE_BEAST_CLOISTER_OF_STORMS then
                        npcUtil.giveKeyItem(player, xi.ki.EYE_OF_STORMS)
                    end
                end,
            }
        },

        [xi.zone.CLOISTER_OF_TIDES] =
        {
            onEventFinish =
            {
                [32001] = function(player, csid, option, npc)
                    if player:getLocalVar('battlefieldWin') == xi.battlefield.id.WAKING_THE_BEAST_CLOISTER_OF_TIDES then
                        npcUtil.giveKeyItem(player, xi.ki.EYE_OF_TIDES)
                    end
                end,
            }
        },

        [xi.zone.CLOISTER_OF_TREMORS] =
        {
            onEventFinish =
            {
                [32001] = function(player, csid, option, npc)
                    if player:getLocalVar('battlefieldWin') == xi.battlefield.id.WAKING_THE_BEAST_CLOISTER_OF_TREMORS then
                        npcUtil.giveKeyItem(player, xi.ki.EYE_OF_TREMORS)
                    end
                end,
            }
        }
    }
}

return quest
