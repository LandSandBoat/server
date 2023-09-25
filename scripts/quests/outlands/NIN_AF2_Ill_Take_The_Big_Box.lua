-----------------------------------
-- I'll Take the Big Box
-----------------------------------
-- Log ID: 5, Quest ID: 144
-- Kagetora: !gotoid 17743879
-- Enetsu: !gotoid 17743909
-- qm2 Spiders: !gotoid 17486241
-- Ryoma: !gotoid 17809466
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/titles')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------
local ID = require('scripts/zones/Selbina/IDs')
-----------------------------------
local quest = Quest:new(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.I_LL_TAKE_THE_BIG_BOX)

quest.reward =
{
    fameArea = xi.quest.fame_area.NORG,
    fame = 75,
    item = xi.items.NINJA_HAKAMA,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
            player:getMainJob() == xi.job.NIN and
            player:getMainLvl() >= xi.settings.main.AF2_QUEST_LEVEL and
            player:getQuestStatus(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.TWENTY_IN_PIRATE_YEARS) == QUEST_COMPLETED and
            not player:needToZone()
        end,

        [xi.zone.NORG] =
        {
            ['Ryoma'] = quest:progressEvent(135),

            onEventFinish =
            {
                [135] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.PORT_BASTOK] =
        {
            ['Ensetsu'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(264)
                    elseif quest:getVar(player, 'Prog') == 1 then
                        return quest:event(265)
                    end
                end,
            },

            onEventFinish =
            {
                [264] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },

        [xi.zone.RABAO] =
        {
            ['Leodarion'] =
            {
                onTrigger = function(player, npc)
                    local progress = quest:getVar(player, 'Prog')

                    if progress == 1 then
                        return quest:progressEvent(90)
                    elseif progress == 2 then
                        return quest:event(91)
                    elseif
                        progress == 3 and
                        quest:getVar(player, 'Timer') >= VanadielUniqueDay()
                    then
                        return quest:event(93)
                    elseif progress == 3 then
                        return quest:progressEvent(94)
                    elseif progress == 4 then
                        return quest:event(95)
                    end
                end,

                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, xi.items.OAK_POLE) and
                        quest:getVar(player, 'Prog') == 2
                    then
                        return quest:progressEvent(92)
                    end
                end,
            },

            onEventFinish =
            {
                [90] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,

                [92] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                    quest:setVar(player, 'Timer', VanadielUniqueDay() + 1)
                    player:tradeComplete()
                end,

                [94] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 4)
                    npcUtil.giveKeyItem(player, xi.ki.SEANCE_STAFF)
                    quest:setVar(player, 'Timer', 0)
                end,
            },
        },

        [xi.zone.SELBINA] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if quest:getVar(player, 'nmKilled') == 1 then
                        return 1101
                    end
                end,
            },

            onEventFinish =
            {
                [1101] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.SEANCE_STAFF)
                        return quest:messageSpecial(ID.text.KEYITEM_LOST, xi.ki.SEANCE_STAFF)
                    end
                end,
            },
        },

        [xi.zone.SHIP_BOUND_FOR_SELBINA] =
        {
            ['Enagakure'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if
                        player:hasKeyItem(xi.ki.SEANCE_STAFF) and
                        quest:getVar(player, 'nmKilled') == 0
                    then
                        quest:setVar(player, 'nmKilled', 1)
                    end
                end,
            },
        },

        [xi.zone.SHIP_BOUND_FOR_SELBINA_PIRATES] =
        {
            ['Enagakure'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if
                        player:hasKeyItem(xi.ki.SEANCE_STAFF) and
                        quest:getVar(player, 'nmKilled') == 0
                    then
                        quest:setVar(player, 'nmKilled', 1)
                    end
                end,
            },
        },
    },
}

return quest
