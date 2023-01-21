-----------------------------------
-- Healing the Land
-----------------------------------
-- !addquest 0 82
-- Eperdur: !pos 129 -6 96 231
-----------------------------------
require('scripts/globals/interaction/quest')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/zone')
local ID = require("scripts/zones/Northern_San_dOria/IDs")
local ID2 = require("scripts/zones/Gusgen_Mines/IDs")
-----------------------------------

local quest = Quest:new(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.HEALING_THE_LAND)

quest.reward =
{
    fame = 30,
    fameArea = xi.quest.fame_area.SANDORIA,
    item = xi.items.SCROLL_OF_TELEPORT_HOLLA,
    title = xi.title.PILGRIM_TO_HOLLA,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getFameLevel(xi.quest.fame_area.SANDORIA) >= 4 and
                player:getMainLvl() >= 10
        end,

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Eperdur'] = quest:progressEvent(681),

            onEventFinish =
            {
                [681] = function(player, csid, option, npc)
                    quest:begin(player)
                    npcUtil.giveKeyItem(player, xi.ki.SEAL_OF_BANISHING)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Eperdur'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.SEAL_OF_BANISHING) then
                        return quest:event(682)
                    elseif not player:hasKeyItem(xi.ki.SEAL_OF_BANISHING) then
                        return quest:progressEvent(683)
                    else
                        return quest:event(684)
                    end
                end,
            },

            onEventFinish =
            {
                [683] = function(player, csid, option, npc)
                    quest:complete(player)
                    player:needToZone(true)
                end,
            },
        },

        [xi.zone.GUSGEN_MINES] =
        {
            ['qm3'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.SEAL_OF_BANISHING) then
                        player:messageSpecial(ID2.text.FOUND_LOCATION_SEAL, xi.ki.SEAL_OF_BANISHING)
                        player:delKeyItem(xi.ki.SEAL_OF_BANISHING)
                        return quest:noAction()
                    elseif not player:hasKeyItem(xi.ki.SEAL_OF_BANISHING) then
                        player:messageSpecial(ID2.text.IS_ON_THIS_SEAL, xi.ki.SEAL_OF_BANISHING)
                        return quest:noAction()
                    end
                end,
            },
        },
    },
}

return quest
