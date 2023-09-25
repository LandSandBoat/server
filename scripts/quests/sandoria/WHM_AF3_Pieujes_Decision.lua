-----------------------------------
-- Pieujes Decision
-- !addquest: 0 89
-- Prince Regent's Rm: !gotoid 17731625
-- Narcheral: !gotoid 17723585
-- qm1: !gotoid 17613245
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/interaction/quest')
-----------------------------------
local feiyinID = require("scripts/zones/FeiYin/IDs")
-----------------------------------

local quest = Quest:new(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.PIEUJE_S_DECISION)

quest.reward =
{
    item     = xi.items.HEALERS_BRIAULT,
    fame     = 60,
    fameArea = xi.quest.fame_area.SANDORIA,
    title    = xi.title.PARAGON_OF_WHITE_MAGE_EXCELLENCE,
}

quest.sections =
{
    -- Section: Quest available.
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getMainJob() == xi.job.WHM and
                player:getMainLvl() >= xi.settings.main.AF3_QUEST_LEVEL and
                player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.PRELUDE_OF_BLACK_AND_WHITE) == QUEST_COMPLETED
        end,

        [xi.zone.CHATEAU_DORAGUILLE] =
        {
            ['_6h1'] = quest:progressEvent(552), -- Prince Regent's Rm

            onEventFinish =
            {
                [552] = function(player, csid, option, npc)
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

        [xi.zone.FEIYIN] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if
                        player:hasItem(xi.items.TAVNAZIA_BELL) and
                        quest:getVar(player, 'Prog') == 0
                    then
                        return 19
                    end
                end,
            },

            ['qm1'] = -- original location as of https://ffxiclopedia.fandom.com/wiki/Altedour_I_Tavnazia?direction=next&oldid=365634
            {
                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, xi.items.TAVNAZIA_BELL) and
                        not player:hasItem(xi.items.TAVNAZIAN_MASK) and
                        npcUtil.popFromQM(player, npc, feiyinID.mob.ALTEDOUR_I_TAVNAZIA, { hide = 900 })
                    then
                        player:confirmTrade()
                        return quest:messageSpecial(feiyinID.text.CONSPICUOUSLY_EVIL_PRESENCE)
                    elseif
                        npcUtil.tradeHasExactly(trade, xi.items.TAVNAZIA_BELL) and
                        player:hasItem(xi.items.TAVNAZIAN_MASK)
                    then
                        return player:messageSpecial(feiyinID.text.NOTHING_OUT_OF_ORDINARY)
                    end
                end,
            },

            onEventFinish =
            {
                [19] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                    player:setPos (-180, -24, -195, 199)-- seems the inital CS release point is behind the zone line - added pos to negate this.
                end,
            },
        },

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Narcheral'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, { xi.items.TAVNAZIAN_MASK }) then
                        return quest:progressEvent(692)
                    end
                end,

                onTrigger = function(player, npc)
                    return quest:event(688)
                end,
            },

            onEventFinish =
            {
                [692] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                    end
                end,
            },
        },
    },
}

return quest
