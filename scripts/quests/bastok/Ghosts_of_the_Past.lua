-----------------------------------
-- Ghosts of the Past
-----------------------------------
-- Log ID: 1, Quest ID: 51
-- Oggbi : !pos -159 -7 5 236
-- qm4   : !pos -174 0 369 196
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------
local gusgenMinesID = require('scripts/zones/Gusgen_Mines/IDs')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.BASTOK, xi.quest.id.bastok.GHOSTS_OF_THE_PAST)

quest.reward =
{
    fame     = 20,
    fameArea = xi.quest.fame_area.BASTOK,
    item     = xi.items.BEAT_CESTI,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getMainJob() == xi.job.MNK and
                player:getMainLvl() >= 40
        end,

        [xi.zone.PORT_BASTOK] =
        {
            ['Oggbi'] = quest:progressEvent(231),

            onEventFinish =
            {
                [231] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.GUSGEN_MINES] =
        {
            ['qm4'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, xi.items.PICKAXE) and
                        not player:hasItem(xi.items.MINERS_PENDANT) and
                        not GetMobByID(gusgenMinesID.mob.WANDERING_GHOST):isSpawned()
                    then
                        player:confirmTrade()
                        SpawnMob(gusgenMinesID.mob.WANDERING_GHOST):updateClaim(player)

                        -- TODO: Determine if this spawn has a message associated with it.
                        return quest:noAction()
                    end
                end,
            },
        },

        [xi.zone.PORT_BASTOK] =
        {
            ['Oggbi'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.items.MINERS_PENDANT) then
                        return quest:progressEvent(232)
                    end
                end,
            },

            onEventFinish =
            {
                [232] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()

                        xi.quest.setMustZone(player, xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_FIRST_MEETING)
                    end
                end,
            },
        },
    },
}

return quest
