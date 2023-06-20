-----------------------------------
-- Transporting
-----------------------------------
-- !addquest 9 82
-- Vaulois          : !pos 20 0 85 256
-- Kongramm         : !pos 61 32 138 256
-- qm_sluice_gate_6 : !pos -563 -5.768 61.5 258
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/interaction/quest')
-----------------------------------
local ralaID = require('scripts/zones/Rala_Waterways/IDs')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.ADOULIN, xi.quest.id.adoulin.TRANSPORTING)

quest.reward =
{
    fameArea = xi.quest.fame_area.ADOULIN,
    xp       = 1000,
    bayld    = 300,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getFameLevel(xi.quest.fame_area.ADOULIN) >= 2
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Vaulois'] = quest:progressEvent(2590),

            onEventFinish =
            {
                [2590] = function(player, csid, option, npc)
                    quest:begin(player)
                    npcUtil.giveKeyItem(player, xi.ki.MISDELIVERED_PARCEL)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Kongramm'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(2592)
                    end
                end,
            },

            ['Vaulois'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 2 then
                        return quest:progressEvent(2591)
                    end
                end,
            },

            onEventFinish =
            {
                [2591] = function(player, csid, option, npc)
                    quest:complete(player)
                end,

                [2592] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },

        [xi.zone.RALA_WATERWAYS] =
        {
            ['qm_sluice_gate_6'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(2802)
                    end
                end,
            },

            onEventFinish =
            {
                [2802] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.MISDELIVERED_PARCEL)
                    player:messageSpecial(ralaID.text.KEYITEM_LOST, xi.ki.MISDELIVERED_PARCEL)

                    quest:setVar(player, 'Prog', 2)
                end,
            },
        },
    },
}

return quest
