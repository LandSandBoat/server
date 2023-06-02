-----------------------------------
-- The Prankster
-- Ahaadah, Whitegate, !pos 93 -68 -6 106
-- qm4, Bhaflau Thicket, !pos 460 -14 256
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/quests')
require('scripts/globals/npc_util')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------
local ID = require("scripts/zones/Bhaflau_Thickets/IDs")

local quest = Quest:new(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.THE_PRANKSTER)

quest.reward =
{
    keyitem = xi.ki.MAP_OF_CAEDARVA_MIRE,
}

quest.sections =
{
    -- Section: Quest available
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Ahaadah'] = quest:progressEvent(1),

            onEventFinish =
            {
                [1] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    -- Section: Quest accepted
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Ahaadah'] =
            {
                onTrigger = function(player, npc)
                    local prog = quest:getVar(player, 'Prog')

                    if prog == 0 then
                        return quest:event(15)
                    elseif prog == 1 then
                        return quest:event(16)
                    elseif prog == 2 then
                        return quest:event(17)
                    end
                end,
            },

            onTriggerAreaEnter =
            {

                [10] = function(player, triggerArea)
                    print(1)
                    return quest:progressEvent(2)
                end,

                [11] = function(player, triggerArea)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(3)
                    end
                end,
            },

            onEventFinish =
            {
                [2] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:setVar(player, 'Prog', 1)
                    end
                end,

                [3] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:setVar(player, 'Prog', 2)
                    end
                end,
            },
        },

        [xi.zone.BHAFLAU_THICKETS] =
        {
            ['qm4'] =
            {
                onTrigger = function(player, npc)
                    if
                        not GetMobByID(ID.mob.PLAGUE_CHIGOE):isSpawned() and
                        quest:getVar(player, 'Prog') == 2
                    then
                        return quest:progressEvent(1)
                    elseif quest:getVar(player, 'Prog') == 3 then
                        return quest:progressEvent(2)
                    end
                end,
            },

            ['Plague_Chigoe'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if
                        quest:getVar(player, 'Prog') == 2 and
                        optParams.isKiller
                    then
                        quest:setVar(player, 'Prog', 3)
                    end
                end
            },

            onEventFinish =
            {
                [1] = function(player, csid, option, npc)
                    npcUtil.popFromQM(player, npc, ID.mob.PLAGUE_CHIGOE, { hide = 0, claim = true, })
                end,

                [2] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:complete(player)
                    end
                end,
            },
        },
    },
}

return quest
