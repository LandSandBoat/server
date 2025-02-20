-----------------------------------
-- In Search of the Truth
-----------------------------------
-- Log ID: 4, Quest ID: 80
-----------------------------------
-- CoP Mission 3-5 Darkness Named Completed
-----------------------------------
-- Tavnazian Safehold           !zone 26
-- Tressia                      !pos 87.527 -33.991 70.481
-- Raminey                      !pos 82.396 -35.972 49.707
-- Zadant                       !pos -10.532 -21.996 -15.71
-- Fouagine                     !pos 25.313 -35.911 -20.944
-- Noam                         !pos -70.17 -11.264 6.788
-- Mengrenaux                   !pos 72.844 -34.25 63.924
-- Chemioue                     !pos 82.041 -33.964 67.636
-- Ondieulix                    !pos 6.775 -24.955 65.399
-- qm1_in_search_of_truth       !pos -73.005 -11.123 11.842
-- qm2_in_search_of_truth       !pos -80.654 -19.988 65.902
-- qm3_in_search_of_truth       !pos -61.469 -22.007 44.123
-- qm4_in_search_of_truth       !pos -26.099 -21.955 26.298
-- qm5_in_search_of_truth       !pos -4.733 -22.733 23.587
-- KI Shaded Cruse              718
-----------------------------------
local ID = zones[xi.zone.TAVNAZIAN_SAFEHOLD]
-----------------------------------

local quest = Quest:new(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.IN_SEARCH_OF_THE_TRUTH)

quest.reward =
{
    item = xi.item.GRAMARY_CAPE,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
            player:getCurrentMission(xi.mission.log_id.COP) > xi.mission.id.cop.DARKNESS_NAMED
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Tressia'] = quest:progressEvent(544, { [1] = xi.ki.SHADED_CRUSE }),

            onEventFinish =
            {
                [544] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        -- First portion of quest
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
            quest:getVar(player, 'Prog') == 0
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Tressia'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Option') == 30 then
                        return quest:progressEvent(557)
                    else
                        return quest:event(556)
                    end
                end,
            },

            ['Raminey'] =
            {
                onTrigger = function(player, npc)
                    if not quest:isVarBitsSet(player, 'Option', 1) then
                        return quest:progressEvent(549)
                    end
                end,
            },
            ['Zadant'] =
            {
                onTrigger = function(player, npc)
                    if not quest:isVarBitsSet(player, 'Option', 2) then
                        return quest:progressEvent(551)
                    end
                end,
            },
            ['Fouagine'] =
            {
                onTrigger = function(player, npc)
                    if not quest:isVarBitsSet(player, 'Option', 3) then
                        return quest:progressEvent(553)
                    end
                end,
            },
            ['Noam'] =
            {
                onTrigger = function(player, npc)
                    if not quest:isVarBitsSet(player, 'Option', 4) then
                        return quest:progressEvent(555)
                    end
                end,
            },

            onEventFinish =
            {
                [549] = function(player, csid, option, npc)
                    quest:setVarBit(player, 'Option', 1)
                end,

                [551] = function(player, csid, option, npc)
                    quest:setVarBit(player, 'Option', 2)
                end,

                [553] = function(player, csid, option, npc)
                    quest:setVarBit(player, 'Option', 3)
                end,

                [555] = function(player, csid, option, npc)
                    quest:setVarBit(player, 'Option', 4)
                end,

                [557] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:setVar(player, 'Option', 0)
                        quest:setVar(player, 'Prog', 1)
                    end
                end,
            },
        },
    },

    {
        -- Second portion of quest
        -- Does not care if you talked to Mengrenaux or Chemioue. Will progress if you enter the correct order after talking to Tressia.
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
            quest:getVar(player, 'Prog') == 1
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Tressia'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(565)
                end,
            },

            ['Mengrenaux'] = quest:event(560),

            ['Chemioue'] = quest:event(561),

            onEventFinish =
            {
                [565] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,
            },
        },
    },

    {
        -- Third portion of quest
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
            quest:getVar(player, 'Prog') == 2
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Tressia'] =
            {
                onTrigger = function(player, npc)
                    local options = quest:getVar(player, 'Option')
                    if options == 1 then
                        return quest:progressEvent(562)
                    elseif options == 0 then
                        return quest:event(566)
                    end
                end,
            },

            -- ???'s for the trail must be checked in order.
            ['qm1_in_search_of_truth'] =
            {
                onTrigger = function(player, npc)
                    if
                        not player:hasKeyItem(xi.ki.SHADED_CRUSE) and
                        quest:getVar(player, 'Option') == 0
                    then
                        player:addKeyItem(xi.ki.SHADED_CRUSE)
                        quest:setVar(player, 'Water', 1)
                        return quest:messageSpecial(ID.text.CRUSE_ON_THE_GROUND, xi.ki.SHADED_CRUSE)
                    elseif player:hasKeyItem(xi.ki.SHADED_CRUSE) then
                        return quest:message(ID.text.TRAIL_OF_WATER)
                    end
                end,
            },

            ['qm2_in_search_of_truth'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:hasKeyItem(xi.ki.SHADED_CRUSE) and
                        quest:getVar(player, 'Water') >= 1
                    then
                        quest:setVar(player, 'Water', 2)
                        return quest:message(ID.text.TRAIL_OF_WATER)
                    end
                end,
            },

            ['qm3_in_search_of_truth'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:hasKeyItem(xi.ki.SHADED_CRUSE) and
                        quest:getVar(player, 'Water') >= 2
                    then
                        quest:setVar(player, 'Water', 3)
                        return quest:message(ID.text.TRAIL_OF_WATER)
                    end
                end,
            },

            ['qm4_in_search_of_truth'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:hasKeyItem(xi.ki.SHADED_CRUSE) and
                        quest:getVar(player, 'Water') >= 3
                    then
                        quest:setVar(player, 'Water', 4)
                        return quest:message(ID.text.TRAIL_OF_WATER)
                    end
                end,
            },

            ['qm5_in_search_of_truth'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:hasKeyItem(xi.ki.SHADED_CRUSE) and
                        quest:getVar(player, 'Water') == 4
                    then
                        return quest:progressEvent(558, { [1] = xi.ki.SHADED_CRUSE })
                    end
                end,
            },

            onEventFinish =
            {
                [558] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.SHADED_CRUSE)
                    quest:setVar(player, 'Option', 1)
                    quest:setVar(player, 'Water', 0)
                    player:completeQuest(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.IN_SEARCH_OF_THE_TRUTH)
                end,
            },
        },
    },

    {
        -- Post Final Cutscene Stuff including getting the reward
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Tressia'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Option') >= 1 then
                        return quest:progressEvent(562)
                    else
                        return quest:event(314):replaceDefault()
                    end
                end,
            },

            ['Ondieulix'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Option') == 2 then
                        return quest:progressEvent(559)
                    end
                end,
            },

            onEventFinish =
            {
                [559] = function(player, csid, option, npc)
                    quest:setVar(player, 'Option', 0)
                    quest:complete(player)
                end,

                [562] = function(player, csid, option, npc)
                    quest:setVar(player, 'Option', 2)
                end,
            },
        },
    },
}

return quest
