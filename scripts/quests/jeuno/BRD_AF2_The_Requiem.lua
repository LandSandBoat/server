-----------------------------------
-- THE_REQUIEM
-----------------------------------
-- Log ID: 3, Quest ID: 64
-- Bki Tbujhja       : !gotoid 17780766
-- Waters_of_Oblivion: !gotoid 17457346
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/interaction/quest')
-----------------------------------
local ID = require("scripts/zones/The_Eldieme_Necropolis/IDs")
-----------------------------------

local quest = Quest:new(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.THE_REQUIEM)

quest.reward =
{
    fame = 30,
    fameArea = xi.quest.fame_area.JEUNO,
    item  = xi.items.CHORAL_SLIPPERS,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
            player:getMainLvl() >= xi.settings.main.AF2_QUEST_LEVEL and
            player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.PAINFUL_MEMORY) == QUEST_COMPLETED and
            player:getMainJob() == xi.job.BRD
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Bki_Tbujhja'] =
            {
                onTrigger = function(player, npc)
                    if  quest:getVar(player, 'initialCS') == 0 then
                        return quest:progressEvent(145)
                    elseif quest:getVar(player, 'initialCS') == 1 then
                        return quest:progressEvent(148)
                    end
                end,
            },

            onEventFinish =
            {
                [145] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                        quest:setVar(player, 'initialCS', 0)
                        quest:setVar(player, 'Prog ', 2)
                    else
                        quest:setVar(player, 'initialCS', 1)
                    end
                end,

                [148] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                        quest:setVar(player, 'initialCS ', 0)
                        quest:setVar(player, 'Prog ', 2)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Bki_Tbujhja'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, { xi.items.FLASK_OF_HOLY_WATER }) then
                        return quest:progressEvent(151)
                    end
                end,

                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 2 then
                        return quest:event(146)
                    elseif
                        quest:getVar(player, 'Prog') == 3 and
                        not player:hasKeyItem(xi.ki.STAR_RING1)
                    then
                        if math.random(1, 2) == 1 then
                            return quest:event(147) -- oh, did you take the holy water and play the requiem? you must do both!
                        else
                            return quest:event(149) -- his stone sarcophagus is deep inside the eldieme necropolis.
                        end
                    elseif player:hasKeyItem(xi.ki.STAR_RING1) then
                        return quest:progressEvent(150) -- Finish Quest "The Requiem"
                    end
                end,
            },

            onEventFinish =
            {
                [150] = function(player, csid, option, npc)
                    quest:complete(player)
                end,

                [151] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog ', 3)
                    quest:setVar(player, 'pickSarcophagus ', math.random(1, 5))
                    player:messageSpecial(ID.text.ITEM_OBTAINED, xi.items.FLASK_OF_HOLY_WATER)
                end,
            },
        },

        [xi.zone.THE_ELDIEME_NECROPOLIS] =
        {
            ['Sarcophagus'] =
            {
                onTrade = function(player, npc, trade)
                    local offset = npc:getID() - ID.npc.SARCOPHAGUS_OFFSET

                    if
                        quest:getVar(player, 'Prog') == 3 and
                        quest:getVar(player, 'nmKilled') == 0 and
                        npcUtil.tradeHasExactly(trade, { xi.items.FLASK_OF_HOLY_WATER }) and
                        offset == quest:getVar(player, 'pickSarcophagus') - 1 and
                        npcUtil.popFromQM(player, npc, { ID.mob.YUM_KIMIL, ID.mob.YUM_KIMIL + 1, ID.mob.YUM_KIMIL + 2 }, { hide = 0 })
                    then
                        player:confirmTrade()
                        quest:setVar(player, 'nmPopped', 1)
                        return quest:messageSpecial(ID.text.SENSE_OF_FOREBODING)
                    else
                        return quest:messageSpecial(ID.text.NOTHING_HAPPENED)
                    end
                end,

                onTrigger = function(player, npc)
                    local offset = npc:getID() - ID.npc.SARCOPHAGUS_OFFSET

                    if offset == quest:getVar(player, 'pickSarcophagus') - 1 then
                        if quest:getVar(player, 'nmKilled') == 1 then
                            return quest:progressEvent(46)
                        elseif
                            quest:getVar('nmPopped') == 1 and
                            npcUtil.popFromQM(player, npc, { ID.mob.YUM_KIMIL, ID.mob.YUM_KIMIL + 1, ID.mob.YUM_KIMIL + 2 }, { hide = 0 })
                        then
                            return quest:messageSpecial(ID.text.SENSE_OF_FOREBODING)
                        end
                    end
                end,
            },

            ['Yum_Kimil'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if quest:getVar(player, 'Prog') == 3 then
                        quest:setVar(player, 'nmKilled', 1)
                    end
                end,
            },

            onEventFinish =
            {
                [46] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 0)
                    quest:setVar(player, 'nmKilled', 0)
                    quest:setVar(player, 'pickSarcophagus', 0)
                    quest:setVar(player, 'nmPopped', 0)
                    npcUtil.giveKeyItem(player, xi.ki.STAR_RING1)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Bki_Tbujhja'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(134):importantOnce()
                end,
            },
        },
    },
}

return quest
