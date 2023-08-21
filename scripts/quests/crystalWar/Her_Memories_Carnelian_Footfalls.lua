-----------------------------------
-- Her Memories: Carnelian Footfalls
-----------------------------------
-- !addquest 7 69
-- Mainchelite : !pos -16 1 -30 80
-- qm3         : !pos 312.821 -30.495 -67.15 81
-- qm4         : !pos 541.425 -49.83 178.563 81
-- qm5         : !pos 380.015 -26.5 -22.525 81
-----------------------------------
require('scripts/missions/wotg/helpers')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.HER_MEMORIES_CARNELIAN_FOOTFALLS)

quest.reward =
{
    keyItem = xi.ki.LARGE_MEMORY_FRAGMENT4,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getCurrentMission(xi.mission.log_id.WOTG) == xi.mission.id.wotg.HER_MEMORIES and
                player:getCampaignAllegiance() == 1
        end,

        [xi.zone.SOUTHERN_SAN_DORIA_S] =
        {
            ['Mainchelite'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(171, 80, 90)
                    end
                end,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    if
                        prevZone == xi.zone.EAST_RONFAURE_S and
                        quest:getVar(player, 'Prog') == 0
                    then
                        return 170
                    end
                end,
            },

            onEventFinish =
            {
                [170] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

                [171] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.SOUTHERN_SAN_DORIA_S] =
        {
            ['Mainchelite'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Option') == 7 then
                        return quest:progressEvent(172, 1, 23, 1749)
                    else
                        return quest:event(173, 80, 3, 2964):oncePerZone()
                    end
                end,
            },

            onEventFinish =
            {
                [172] = function(player, csid, option, npc)
                    xi.wotg.helpers.checkMemoryFragments(player)
                    quest:complete(player)
                end,
            },
        },

        [xi.zone.EAST_RONFAURE_S] =
        {
            ['qm3'] =
            {
                onTrigger = function(player, npc)
                    if not quest:isVarBitsSet(player, 'Option', 0) then
                        return quest:progressEvent(13, 81, 0, 1756, 0, 0, 0, 3, 4095)
                    else
                        return quest:event(4)
                    end
                end,
            },

            ['qm4'] =
            {
                onTrigger = function(player, npc)
                    if not quest:isVarBitsSet(player, 'Option', 1) then
                        return quest:progressEvent(14, 81, 1, 1756, 0, 0, 0, 3, 4095)
                    else
                        return quest:event(5)
                    end
                end,
            },

            ['qm5'] =
            {
                onTrigger = function(player, npc)
                    if not quest:isVarBitsSet(player, 'Option', 2) then
                        return quest:progressEvent(15, 81, 0, 1756, 0, 0, 0, 3, 4095)
                    else
                        return quest:event(6)
                    end
                end,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    if
                        prevZone == xi.zone.SOUTHERN_SAN_DORIA_S and
                        quest:getVar(player, 'Prog') == 1
                    then
                        return 12
                    end
                end,
            },

            onEventFinish =
            {
                [12] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,

                [13] = function(player, csid, option, npc)
                    quest:setVarBit(player, 'Option', 0)
                end,

                [14] = function(player, csid, option, npc)
                    quest:setVarBit(player, 'Option', 1)
                end,

                [15] = function(player, csid, option, npc)
                    quest:setVarBit(player, 'Option', 2)
                end,
            },
        },
    },
}

return quest
