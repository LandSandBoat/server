-----------------------------------
-- Bombs Away
-----------------------------------
-- Log ID: 4, Quest ID: 96
-- Buffalostalker : !pos -380 -24 -180
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------
local quest = Quest:new(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.BOMBS_AWAY)

quest.reward =
{
    item = xi.items.CHUNK_OF_SHUMEYO_SALT,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
            player:getCurrentMission(xi.mission.log_id.COP) >= xi.mission.id.cop.THREE_PATHS
        end,

        [xi.zone.ULEGUERAND_RANGE] =
        {
            ['Buffalostalker_Dodzbraz'] = quest:progressEvent(6),

            onEventFinish =
            {
                [6] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                    end
                end,
            },
        },
    },
    {
        check = function(player, status, vars)
            return status ~= QUEST_AVAILABLE
        end,

        [xi.zone.ULEGUERAND_RANGE] =
        {
            ['Buffalostalker_Dodzbraz'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(7)
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, { { xi.items.CLUSTER_CORE, 2 } }) then
                        return quest:progressEvent(8)
                    end
                end,
            },

            onEventFinish =
            {
                [8] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                    end
                end,
            },
        },
    },
}

return quest
