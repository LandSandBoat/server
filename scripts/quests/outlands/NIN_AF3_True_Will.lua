-----------------------------------
-- True Will
-----------------------------------
-- Log ID: 5, Quest ID: 145
-- Kuftal Coffer: !gotoid 17490304
-- Leodarion: !gotoid 17788983
-- qm3: !pos 203 0.1 82 124
-- Ryoma: !gotoid 17809466
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/titles')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------
local ID = require("scripts/zones/Yhoator_Jungle/IDs")
local rabaoID = require("scripts/zones/Rabao/IDs")
-----------------------------------
local quest = Quest:new(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.TRUE_WILL)

quest.reward =
{
    fameArea = xi.quest.fame_area.NORG,
    fame = 75,
    item = xi.items.NINJA_CHAINMAIL,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
            player:getMainJob() == xi.job.NIN and
            player:getMainLvl() >= xi.settings.main.AF3_QUEST_LEVEL and
            player:getQuestStatus(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.I_LL_TAKE_THE_BIG_BOX) == QUEST_COMPLETED
        end,

        [xi.zone.NORG] =
        {
            ['Ryoma'] = quest:progressEvent(136),

            onEventFinish =
            {
                [136] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.YHOATOR_JUNGLE] =
        {
            ['qm3'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.OLD_TRICK_BOX) then
                        if quest:getVar(player, 'nmKilled') > 0 then
                            npcUtil.giveKeyItem(player, xi.ki.OLD_TRICK_BOX)
                            quest:setVar(player, 'nmKilled', 0)
                        else
                            npcUtil.popFromQM(player, npc, { ID.mob.KAPPA_AKUSO, ID.mob.KAPPA_BONZE, ID.mob.KAPPA_BIWA }, { hide = 0 })
                        end
                    end
                end,
            },

            ['Kappa_Akuso'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if
                        GetMobByID(ID.mob.KAPPA_BIWA):isDead() and
                        GetMobByID(ID.mob.KAPPA_BONZE):isDead() and
                        quest:getVar(player, 'nmKilled') == 0
                    then
                        quest:setVar(player, 'nmKilled', 1)
                    end
                end,
            },

            ['Kappa_Biwa'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if
                        GetMobByID(ID.mob.KAPPA_AKUSO):isDead() and
                        GetMobByID(ID.mob.KAPPA_BONZE):isDead() and
                        quest:getVar(player, 'nmKilled') == 0
                    then
                        quest:setVar(player, 'nmKilled', 1)
                    end
                end,
            },

            ['Kappa_Bonze'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if
                        GetMobByID(ID.mob.KAPPA_BIWA):isDead() and
                        GetMobByID(ID.mob.KAPPA_AKUSO):isDead() and
                        quest:getVar(player, 'nmKilled') == 0
                    then
                        quest:setVar(player, 'nmKilled', 1)
                    end
                end,
            },
        },

        [xi.zone.NORG] =
        {
            ['Ryoma'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:hasKeyItem(xi.ki.OLD_TRICK_BOX) and
                        quest:getVar(player, 'Prog') == 0
                    then
                        return quest:progressEvent(137)
                    elseif quest:getVar(player, 'Prog') == 1 then
                        return quest:event(138)
                    end
                end,
            },

            onEventFinish =
            {
                [137] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },

        [xi.zone.RABAO] =
        {
            ['Leodarion'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(97)
                    elseif
                        quest:getVar(player, 'Prog') == 2 and
                        not player:hasKeyItem(xi.ki.LARGE_TRICK_BOX)
                    then
                        return quest:event(98)
                    elseif player:hasKeyItem(xi.ki.LARGE_TRICK_BOX) then
                        return quest:progressEvent(99)
                    end
                end,
            },

            onEventFinish =
            {
                [97] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                    player:delKeyItem(xi.ki.OLD_TRICK_BOX)
                    player:messageSpecial(rabaoID.text.KEYITEM_LOST, xi.ki.OLD_TRICK_BOX)
                end,

                [99] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.LARGE_TRICK_BOX)
                        player:messageSpecial(rabaoID.text.KEYITEM_LOST, xi.ki.LARGE_TRICK_BOX)
                    end
                end,
            },
        },
    },
}

return quest
