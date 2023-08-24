-----------------------------------
-- Messenger from Beyond
-- !addquest: 0 87
-- Narcheral: !gotoid 17723585
-- qm2      : !gotoid 17199727
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/interaction/quest')
-----------------------------------
local valkID = require("scripts/zones/Valkurm_Dunes/IDs")
-----------------------------------

local quest = Quest:new(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.MESSENGER_FROM_BEYOND)

quest.reward =
{
    item     = xi.items.BLESSED_HAMMER,
    fame     = 20,
    fameArea = xi.quest.fame_area.SANDORIA,
}

quest.sections =
{
    -- Section: Quest available.
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getMainJob() == xi.job.WHM and
                player:getMainLvl() >= xi.settings.main.AF1_QUEST_LEVEL
        end,

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Narcheral'] = quest:progressEvent(689),

            onEventFinish =
            {
                [689] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    -- Section: Quest accepted
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.VALKURM_DUNES] =
        {
            ['qm2'] =
            {
                onTrigger = function(player, npc)
                    if
                        not player:hasItem(xi.items.TAVNAZIA_PASS) and
                        npcUtil.popFromQM(player, npc, valkID.mob.MARCHELUTE, { claim = true, hide = 0 })
                    then
                        return quest:messageSpecial(valkID.text.FOUL_PRESENSE)
                    else
                        return quest:messageSpecial(valkID.text.NOTHING_OUT_OF_ORDINARY)
                    end
                end,
            },
        },

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Narcheral'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.items.TAVNAZIA_PASS) then
                        return quest:progressEvent(690) -- Finish quest.
                    end
                end,

                onTrigger = function(player, npc)
                    return quest:event(688) -- Only dialog available outside of other quests...
                end,
            },

            onEventFinish =
            {
                [690] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                    end
                end,
            },
        },
    },
}

return quest
