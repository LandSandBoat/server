-----------------------------------
-- In Search of the Truth
-----------------------------------
-- Log ID: 4, Quest ID: 80
-----------------------------------
require('scripts/globals/moghouse')
require('scripts/globals/quests')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------
local ID = require("scripts/zones/Tavnazian_Safehold/IDs")
-----------------------------------
local quest = Quest:new(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.IN_SEARCH_OF_THE_TRUTH)

quest.reward =
{
    item = xi.items.GRAMARY_CAPE,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
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
            return status == QUEST_ACCEPTED and
            quest:getVar(player, 'Prog') == 0
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Tressia'] =
            {
                onTrigger = function(player, npc)
                    if quest:isVarBitsSet(player, 'Option', 1, 2, 3, 4) then
                        return quest:progressEvent(557)
                    else
                        return quest:progressEvent(556)
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
                        quest:unsetVarBit(player, 'Option', 1, 2, 3, 4)
                        quest:setVar(player, 'Prog', 1)
                    end
                end,
            },
        },
    },

    {
        -- Second portion of quest
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and
            quest:getVar(player, 'Prog') == 1
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Tressia'] =
            {
                onTrigger = function(player, npc)
                    if quest:isVarBitsSet(player, 'Option', 1, 2) then
                        return quest:progressEvent(565, 0, 0)
                    end
                end,
            },

            ['Mengrenaux'] = quest:progressEvent(560),

            ['Chemioue'] = quest:progressEvent(561),

            onEventFinish =
            {
                [560] = function(player, csid, option, npc)
                    quest:setVarBit(player, 'Option', 1)
                end,
                [561] = function(player, csid, option, npc)
                    quest:setVarBit(player, 'Option', 2)
                end,
                [565] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:unsetVarBit(player, 'Option', 1, 2)
                        quest:setVar(player, 'Prog', 2)
                    end
                end,
            },
        },
    },

    {
        -- Third portion of quest
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and
            quest:getVar(player, 'Prog') == 2
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Tressia'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Option') >= 1 then
                        return quest:progressEvent(562)
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

            ['qm1_in_search_of_truth'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.SHADED_CRUSE) and not quest:getVar(player, 'Option') == 0 then
                        player:addKeyItem(xi.ki.SHADED_CRUSE)
                        return quest:messageSpecial(ID.text.CRUSE_ON_THE_GROUND, xi.ki.SHADED_CRUSE)
                    else
                        return quest:message(ID.text.TRAIL_OF_WATER)
                    end
                end,
            },
            ['qm2_in_search_of_truth'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.SHADED_CRUSE) then
                        return quest:message(ID.text.TRAIL_OF_WATER)
                    end
                end,
            },
            ['qm3_in_search_of_truth'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.SHADED_CRUSE) then
                        return quest:message(ID.text.TRAIL_OF_WATER)
                    end
                end,
            },
            ['qm4_in_search_of_truth'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.SHADED_CRUSE) then
                        return quest:message(ID.text.TRAIL_OF_WATER)
                    end
                end,
            },
            ['qm5_in_search_of_truth'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.SHADED_CRUSE) then
                        return quest:progressEvent(558, { [1] = xi.ki.SHADED_CRUSE })
                    end
                end,
            },

            onEventFinish =
            {
                [558] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.SHADED_CRUSE)
                    quest:setVar(player, 'Option', 1)
                end,
                [562] = function(player, csid, option, npc)
                    quest:setVar(player, 'Option', 2)
                end,
                [559] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },
    },
}

return quest
