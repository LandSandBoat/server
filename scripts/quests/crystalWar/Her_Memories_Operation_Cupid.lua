-----------------------------------
-- Her Memories: Operation Cupid
-----------------------------------
-- !addquest 7 68
-- Bulwark Gate : !pos -447.174 -1.831 342.417 98
-- Leadavox     : !pos 206 -32 316 83
-----------------------------------
require('scripts/missions/wotg/helpers')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.HER_MEMORIES_OPERATION_CUPID)

quest.reward =
{
    keyItem = xi.ki.LARGE_MEMORY_FRAGMENT3,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getCurrentMission(xi.mission.log_id.WOTG) == xi.mission.id.wotg.HER_MEMORIES
        end,

        [xi.zone.BATALLIA_DOWNS_S] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if prevZone == xi.zone.JUGNER_FOREST_S then
                        return 23
                    end
                end,
            },

            onEventFinish =
            {
                [23] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.SAUROMUGUE_CHAMPAIGN_S] =
        {
            ['Bulwark_Gate'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if player:hasKeyItem(xi.ki.POT_OF_MARTIAL_RELISH) then
                        return quest:progressEvent(13)
                    elseif questProgress == 0 then
                        return quest:progressEvent(11)
                    elseif questProgress == 2 then
                        return quest:event(14):oncePerZone()
                    else
                        return quest:event(12):oncePerZone()
                    end
                end,
            },

            onEventFinish =
            {
                [11] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

                [13] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                    player:delKeyItem(xi.ki.POT_OF_MARTIAL_RELISH)
                end,
            },
        },

        [xi.zone.VUNKERL_INLET_S] =
        {
            ['Leadavox'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        not player:hasKeyItem(xi.ki.POT_OF_MARTIAL_RELISH) and
                        npcUtil.tradeHasExactly(trade, { xi.item.BOTTLE_OF_RICE_VINEGAR, xi.item.JAR_OF_GROUND_WASABI, xi.item.SPRIG_OF_HOLY_BASIL }) and
                        quest:getVar(player, 'Prog') == 1
                    then
                        return quest:progressEvent(4)
                    end
                end,

                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.POT_OF_MARTIAL_RELISH) then
                        return quest:event(5):oncePerZone()
                    end
                end,
            },

            onEventFinish =
            {
                [4] = function(player, csid, option, npc)
                    player:confirmTrade()
                    npcUtil.giveKeyItem(player, xi.ki.POT_OF_MARTIAL_RELISH)
                end,
            },
        },

        [xi.zone.BATALLIA_DOWNS_S] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if
                        prevZone == xi.zone.ROLANBERRY_FIELDS_S and
                        quest:getVar(player, 'Prog') == 2
                    then
                        return 24
                    end
                end,
            },

            onEventFinish =
            {
                [24] = function(player, csid, option, npc)
                    xi.wotg.helpers.checkMemoryFragments(player)
                    quest:complete(player)
                end,
            },
        },
    },
}

return quest
