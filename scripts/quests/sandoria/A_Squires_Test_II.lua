-----------------------------------
--  A Squires Test II
--  NPC: Balasiel
--  !pos -136 -11 64 230
--  !addquest 0 19
--  Chanpau !pos -152 -2 55 230
--  Morjean !pos 99 0 116 231
--  qm2 !pos -94 1 273 193
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/interaction/quest')
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
local ordellesID = require("scripts/zones/Ordelles_Caves/IDs")
-----------------------------------

local quest = Quest:new(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.A_SQUIRE_S_TEST_II)

quest.reward =
{
    fame     = 30,
    fameArea = xi.quest.fame_area.SANDORIA,
    title    = xi.title.SPELUNKER,
}

quest.sections =
{
    -- Section: Quest available.
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.A_SQUIRE_S_TEST) == QUEST_COMPLETED and
                player:getMainLvl() >= 10
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Balasiel'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(625)
                end,
            },

            onEventFinish =
            {
                [625] = function(player, csid, option, npc)
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

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Balasiel'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem (xi.ki.STALACTITE_DEW) then
                        return quest:event (630)
                    elseif player:hasKeyItem (xi.ki.STALACTITE_DEW) then
                        return quest:progressEvent (626)
                    end
                end,
            },

            ['Chanpau'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(629)
                end,
            },

            onEventFinish =
            {
                [626] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        npcUtil.giveKeyItem(player, xi.ki.SQUIRE_CERTIFICATE)
                        player:delKeyItem(xi.ki.STALACTITE_DEW)
                    end
                end,
            },

        },

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Morjean'] =
            {
                onTrigger = function(player, npc)
                    if player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.A_SQUIRE_S_TEST_II) == QUEST_ACCEPTED then
                        return quest:event(602)
                    end
                end,
            },
        },

        [xi.zone.ORDELLES_CAVES] =
        {
            ['qm2'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.STALACTITE_DEW) then
                        quest:setVar(player, 'Prog', os.time())
                        return quest:messageSpecial(ordellesID.text.A_SQUIRE_S_TEST_II_DIALOG_I)
                    else
                        return quest:messageSpecial(ordellesID.text.NOTHING_OUT_OF_ORDINARY)
                    end
                end,
            },

            ['qm3'] =
            {
                onTrigger = function(player, npc)
                    if
                        os.time() - quest:getVar(player, 'Prog') <= 60 and
                        not player:hasKeyItem(xi.ki.STALACTITE_DEW)
                    then
                        npcUtil.giveKeyItem(player, xi.ki.STALACTITE_DEW)
                    elseif
                        os.time() - quest:getVar(player, 'Prog') > 60 and
                        not player:hasKeyItem(xi.ki.STALACTITE_DEW)
                    then
                        quest:setVar(player, 'Prog', 0)
                        return quest:messageSpecial(ordellesID.text.A_SQUIRE_S_TEST_II_DIALOG_II)
                    elseif player:hasKeyItem(xi.ki.STALACTITE_DEW) then
                        return quest:messageSpecial(ordellesID.text.A_SQUIRE_S_TEST_II_DIALOG_III)
                    else
                        return quest:messageSpecial(ordellesID.text.NOTHING_OUT_OF_ORDINARY)
                    end
                end,
            },
        },
    },
}

return quest
