-----------------------------------
-- Ayame and Kaede
-----------------------------------
-- Log ID: 1, Quest ID: 60
-- Kaede : !gotoid 17743910
-- Kagetora: !gotoid 17743879
-- Enetsu: !gotoid 17743909
-- qm2 Leeches: !gotoid 17486241
-- Ryoma: !gotoid 17809466
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------
local korrolokaID  = require("scripts/zones/Korroloka_Tunnel/IDs")
local norgID       = require("scripts/zones/Norg/IDs")
local portBastokID = require("scripts/zones/Port_Bastok/IDs")
-----------------------------------
local quest = Quest:new(xi.quest.log_id.BASTOK, xi.quest.id.bastok.AYAME_AND_KAEDE)

quest.reward =
{
    fame     = 30,
    fameArea = xi.quest.fame_area.BASTOK,
    title    = xi.title.SHADOW_WALKER,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
            player:getMainLvl() >= 30
        end,

        [xi.zone.PORT_BASTOK] =
        {
            ['Kaede'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'preCS') == 0 then
                        return quest:progressEvent(240)
                    end
                end,
            },

            ['Kagetora'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'preCS') == 1 then
                        return quest:progressEvent(241)
                    end
                end,
            },

            ['Ensetsu'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'preCS') == 2 then
                        return quest:progressEvent(242)
                    end
                end,
            },

            onEventFinish =
            {
                [240] = function(player, csid, option, npc)
                    quest:setVar(player, 'preCS', 1) -- quest does not appear in log until speaking to Ensetsu.
                end,

                [241] = function(player, csid, option, npc)
                    quest:setVar(player, 'preCS', 2) -- quest does not appear in log until speaking to Ensetsu.
                end,

                [242] = function(player, csid, option, npc)
                    quest:setVar(player, 'preCS', 0)
                    quest:begin(player)
                    quest:setVar(player, 'Prog', 2)-- due to previous writer not making quest accepted at this stage, charvars are misaligned.
                    -- Skipping over 1 makes it easy for servers with players to transition to IF and use sql statements to adjust charvars who maybe in the middle of quest
                    -- in this instance
                    -- UPDATE char_vars SET varname = 'Quest[1][60]Prog' WHERE varname = "AyameAndKaede_Event";
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.KORROLOKA_TUNNEL] =
        {
            ['qm2'] =
            {
                onTrigger = function(player, npc)
                    if
                        quest:getVar(player, 'Prog') == 2 and
                        quest:getVar(player, 'nmKilled') == 0 and
                        not player:hasKeyItem(xi.ki.STRANGELY_SHAPED_CORAL) and
                        npcUtil.popFromQM(player, npc, { korrolokaID.mob.KORROLOKA_LEECH_I, korrolokaID.mob.KORROLOKA_LEECH_II, korrolokaID.mob.KORROLOKA_LEECH_III }, { claim = true, hide = 0 })
                    then
                        return quest:messageSpecial(korrolokaID.text.SENSE_OF_FOREBODING)
                    elseif quest:getVar(player, 'nmKilled') == 1 then
                        npcUtil.giveKeyItem(player, xi.ki.STRANGELY_SHAPED_CORAL)
                        quest:setVar(player, 'nmKilled', 0)
                        return quest:noAction()
                    end
                end,
            },

            ['Korroloka_Leech'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if
                        GetMobByID(korrolokaID.mob.KORROLOKA_LEECH_I):isDead() and
                        GetMobByID(korrolokaID.mob.KORROLOKA_LEECH_II):isDead() and
                        GetMobByID(korrolokaID.mob.KORROLOKA_LEECH_III):isDead() and
                        quest:getVar(player, 'Prog') == 2
                    then
                        quest:setVar(player, 'nmKilled', 1)
                    end
                end,
            },
        },

        [xi.zone.PORT_BASTOK] =
        {
            ['Ensetsu'] =
            {
                onTrigger = function(player, npc)
                    if
                        quest:getVar(player, 'Prog') == 2 and
                        not player:hasKeyItem(xi.ki.STRANGELY_SHAPED_CORAL)
                    then
                        return quest:event(242)
                    elseif player:hasKeyItem(xi.ki.STRANGELY_SHAPED_CORAL) then
                        return quest:progressEvent(245)
                    elseif player:hasKeyItem(xi.ki.SEALED_DAGGER) then
                        return quest:progressEvent(246, xi.ki.SEALED_DAGGER)
                    end
                end,
            },

            ['Kagetora'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') > 2 then
                        return quest:event(244)
                    end
                end,
            },

            onEventFinish =
            {
                [245] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,

                [246] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.SEALED_DAGGER)
                        player:unlockJob(xi.job.NIN)
                        player:messageSpecial(portBastokID.text.KEYITEM_LOST, xi.ki.SEALED_DAGGER) -- not able to do 2 return message specials?
                        player:messageSpecial(portBastokID.text.UNLOCK_NINJA)
                    end
                end,
            },
        },

        [xi.zone.NORG] =
        {
            ['Ryoma'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 3 then
                        return quest:progressEvent(95)
                    end
                end,
            },

            onEventFinish =
            {
                [95] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.SEALED_DAGGER)
                    player:delKeyItem(xi.ki.STRANGELY_SHAPED_CORAL)
                    return quest:messageSpecial(norgID.text.KEYITEM_LOST, xi.ki.STRANGELY_SHAPED_CORAL)
                end,
            },
        },
    },
}

return quest
