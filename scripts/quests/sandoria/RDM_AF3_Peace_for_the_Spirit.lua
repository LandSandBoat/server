-----------------------------------
-- Peace for the Spirit
-----------------------------------
-- Log ID: 0, Quest ID: 86
-- Curilla !gotoid 17731596
-- Sharzalion !gotoid 17719500
-- Daggo !gotoid 17719503
-- Miser Murphy !gotoid 17612849
-- Dry Fountain !gotoid 17613243
-- Oaken Box !gotoid 17596815
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/titles')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------
local ID = require('scripts/zones/FeiYin/IDs')
local gcID = require('scripts/zones/Garlaige_Citadel/IDs')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.PEACE_FOR_THE_SPIRIT)

quest.reward =
{
    item = xi.items.WARLOCKS_CHAPEAU,
    fame = 60,
    fameArea = xi.quest.fame_area.SANDORIA,
    title = xi.title.PARAGON_OF_RED_MAGE_EXCELLENCE,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.ENVELOPED_IN_DARKNESS) and
                player:getMainJob() == xi.job.RDM and
                player:getMainLvl() >= 50
        end,

        [xi.zone.CHATEAU_DORAGUILLE] =
        {
            ['Curilla'] = quest:progressEvent(109),

            onEventFinish =
            {
                [109] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.CHATEAU_DORAGUILLE] =
        {
            ['Curilla'] =
            {
                onTrigger = function(player, npc)
                    local progress = quest:getVar(player, 'Prog')

                    if progress >= 1 then
                        return quest:event(113)
                    else
                        return quest:event(108)
                    end
                end,
            },
        },

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Sharzalion'] =
            {
                onTrigger = function(player, npc)
                    local progress = quest:getVar(player, 'Prog')

                    if progress == 0 then
                        return quest:progressEvent(64)
                    elseif progress == 1 then
                        return quest:event(65)
                    elseif progress == 2 then
                        return quest:progressEvent(66)
                    elseif progress == 5 then
                        return quest:event(68)
                    --todo default dialog
                    end
                end,
            },

            ['Daggao'] =
            {
                onTrigger = function(player, npc)
                    local progress = quest:getVar(player, 'Prog')

                    if progress == 3 then
                        return quest:progressEvent(72)
                    elseif progress == 5 then
                        return quest:event(73)
                    end
                end,
            },

            onEventFinish =
            {
                [64] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

                [66] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,

                [72] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 4)
                end,
            },
        },

        [xi.zone.FEIYIN] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    local progress = quest:getVar(player, 'Prog')

                    if
                        progress == 1 and
                        not player:hasItem(xi.items.ANTIQUE_COIN)
                    then
                        SpawnMob(ID.mob.MISER_MURPHY)
                    end
                end,
            },

            ['Dry_Fountain'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.items.ANTIQUE_COIN) then
                        return quest:progressEvent(17)
                    end
                end,
            },

            onEventFinish =
            {
                [17] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                    player:confirmTrade()
                end,
            },
        },

        [xi.zone.GARLAIGE_CITADEL] =
        {
            ['Oaken_Box'] =
            {
                onTrigger = function(player, npc)
                    local progress = quest:getVar(player, 'Prog')

                    if
                        progress == 4 and
                        not player:hasItem(xi.items.NAIL_PULLER) and
                        npcUtil.popFromQM(player, npc, gcID.mob.GUARDIAN_STATUE, { claim = true, hide = 0 })
                    then
                        return quest:messageSpecial(gcID.text.SENSE_OF_FOREBODING)
                    else
                        return quest:messageSpecial(gcID.text.BOX_SCATTERED, xi.items.NAIL_PULLER)
                    end
                end,

                onTrade = function(player, npc, trade)
                    local progress = quest:getVar(player, 'Prog')

                    if
                        npcUtil.tradeHasExactly(trade, xi.items.NAIL_PULLER) and
                        progress == 4
                    then
                        return quest:progressEvent(14)
                    end
                end,
            },

            onEventFinish =
            {
                [14] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 5)
                    player:confirmTrade()
                end,
            },
        },

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    local progress = quest:getVar(player, 'Prog')

                    if progress == 5 then
                        return 49
                    end
                end,
            },

            onEventFinish =
            {
                [49] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.CHATEAU_DORAGUILLE] =
        {
            ['Curilla'] = quest:event(52):replaceDefault(),
        },

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Sharzalion'] = quest:event(69):replaceDefault(),
            ['Daggao'] = quest:event(60):replaceDefault(),
        },
    },
}

return quest
