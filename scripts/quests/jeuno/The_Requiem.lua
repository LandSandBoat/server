-----------------------------------
-- The Requiem
-----------------------------------
-- Log ID: 3, Quest ID: 64
-- !addquest 3 64
-- Bki Tbujhja : !pos -22 0 -60 245
-- Mataligeat  : !pos -24 0 -60 245
-- Sarcophagus : !pos -421 6.5 503 195
-----------------------------------
-- The bard's sarcophagus is fixed: the fourth of the five in the crypt room (first ID + 3).
-- Trading the flask of holy water to any other sarcophagus does nothing.
-----------------------------------
local ID = zones[xi.zone.THE_ELDIEME_NECROPOLIS]
-----------------------------------

local quest = Quest:new(xi.questLog.JEUNO, xi.quest.id.jeuno.THE_REQUIEM)

quest.reward =
{
    item = xi.item.CHORAL_SLIPPERS,
}

quest.sections =
{
    -- Section: Quest is available.
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.PAINFUL_MEMORY) and
                player:getMainJob() == xi.job.BRD and
                player:getMainLvl() >= xi.settings.main.AF2_QUEST_LEVEL
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Bki_Tbujhja'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Option') == 0 then
                        return quest:progressEvent(145)
                    else
                        return quest:progressEvent(148) -- Short offer after the player declined once.
                    end
                end,
            },

            onEventFinish =
            {
                [145] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                    elseif option == 0 then
                        quest:setVar(player, 'Option', 1) -- Player declined.
                    end
                end,

                [148] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    -- Section: Quest accepted.
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Bki_Tbujhja'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        quest:getVar(player, 'Prog') == 0 and
                        npcUtil.tradeMatches(trade, { { xi.item.FLASK_OF_HOLY_WATER, 1 } })
                    then
                        return quest:progressEvent(151) -- Bki blesses the flask and hands it back.
                    end
                end,

                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.STAR_RING1) then
                        return quest:progressEvent(150)
                    elseif quest:getVar(player, 'Prog') == 0 then
                        return quest:event(146)
                    elseif math.randomInt(1, 100) <= 50 then
                        return quest:event(147)
                    else
                        return quest:event(149)
                    end
                end,
            },

            ['Mataligeat'] =
            {
                onTrigger = function(player, npc)
                    if
                        quest:getVar(player, 'Prog') >= 1 and
                        not player:hasKeyItem(xi.ki.STAR_RING1)
                    then
                        return quest:event(142)
                    end
                end,
            },

            onEventFinish =
            {
                [150] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:addFame(xi.fameArea.SANDORIA, 7)
                        player:addFame(xi.fameArea.BASTOK, 7)
                        player:addFame(xi.fameArea.WINDURST, 7)
                    end
                end,

                [151] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:setVar(player, 'Prog', 1)
                    end
                end,
            },
        },

        [xi.zone.THE_ELDIEME_NECROPOLIS] =
        {
            ['Sarcophagus'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        npc:getID() == ID.npc.SARCOPHAGUS_OFFSET + 3 and
                        quest:getVar(player, 'Prog') == 1 and
                        quest:getVar(player, 'Popped') == 0 and
                        npcUtil.tradeMatches(trade, { { xi.item.FLASK_OF_HOLY_WATER, 1 } }) and
                        npcUtil.popFromQM(player, npc, { ID.mob.YUM_KIMIL, ID.mob.YUM_KIMIL + 1, ID.mob.YUM_KIMIL + 2 }, { hide = 0 })
                    then
                        player:tradeComplete()
                        quest:setVar(player, 'Popped', 1)
                        return quest:noAction() -- No message. The guardians spawn and immediately aggro.
                    end
                end,

                onTrigger = function(player, npc)
                    if npc:getID() ~= ID.npc.SARCOPHAGUS_OFFSET + 3 then
                        return
                    end

                    if quest:getVar(player, 'Prog') == 2 then
                        return quest:progressEvent(46)
                    elseif
                        quest:getVar(player, 'Prog') == 1 and
                        quest:getVar(player, 'Popped') == 1 and
                        npcUtil.popFromQM(player, npc, { ID.mob.YUM_KIMIL, ID.mob.YUM_KIMIL + 1, ID.mob.YUM_KIMIL + 2 }, { hide = 0 })
                    then
                        return quest:noAction() -- Repop after a wipe. No message.
                    end
                end,
            },

            ['Yum_Kimil'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if quest:getVar(player, 'Prog') == 1 then
                        quest:setVar(player, 'Prog', 2)
                    end
                end,
            },

            onEventFinish =
            {
                [46] = function(player, csid, option, npc)
                    if option == 0 then
                        npcUtil.giveKeyItem(player, xi.ki.STAR_RING1) -- Kept after completion. The Circle of Time consumes it.
                    end
                end,
            },
        },
    },

    -- Section: Quest completed.
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Bki_Tbujhja'] = quest:event(134):replaceDefault(),
        },
    },
}

return quest
