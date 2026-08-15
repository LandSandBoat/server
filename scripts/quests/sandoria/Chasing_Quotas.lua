-----------------------------------
-- Chasing Quotas (DRG AF2)
-----------------------------------
-- Log ID: 0, Quest ID: 95
-- !addquest 0 95
-- Ceraulian : !pos 0 -8 -122 232
-- Miaux     : !pos -169.127 2.999 158.677 231
-- Ardea     : !pos -198 -6 -69 235
-- Esca      : !pos -624.231 -51.499 278.369 100
-- qm2 (???) : !pos 145.373 16.462 -548.560 105
-----------------------------------
-- Brugaire is mugged one minute after the gold hairpin is traded to Ceraulian.
-- The ??? grants Ranchuriome's legacy on the first click after Sturmtiger dies.
-----------------------------------
local batalliaID = zones[xi.zone.BATALLIA_DOWNS]
-----------------------------------

local quest = Quest:new(xi.questLog.SANDORIA, xi.quest.id.sandoria.CHASING_QUOTAS)

quest.reward =
{
    fame     = 20,
    fameArea = xi.fameArea.SANDORIA,
    item     = xi.item.DRACHEN_BRAIS,
}

quest.sections =
{
    -- Section: Quest is available.
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.questLog.SANDORIA, xi.quest.id.sandoria.A_CRAFTSMANS_WORK)
        end,

        [xi.zone.PORT_SAN_DORIA] =
        {
            ['Ceraulian'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:getMainJob() ~= xi.job.DRG or
                        player:getMainLvl() < xi.settings.main.AF2_QUEST_LEVEL
                    then
                        return
                    end

                    if quest:getVar(player, 'Declined') == 0 then
                        return quest:progressEvent(18)
                    end

                    return quest:progressEvent(14)
                end,
            },

            onEventFinish =
            {
                [14] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:setVar(player, 'Declined', 0)
                        quest:begin(player)
                    end
                end,

                [18] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:setVar(player, 'Declined', 1)
                    elseif option ~= utils.EVENT_CANCELLED_OPTION then
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

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Ardea'] =
            {
                onTrigger = function(player, npc)
                    local progress = quest:getVar(player, 'Prog')

                    if progress == 3 then
                        return quest:progressEvent(264)
                    elseif progress == 4 then
                        return quest:event(265) -- Reminder: return the earring to Esca.
                    end
                end,
            },

            onEventFinish =
            {
                [264] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 4)
                end,
            },
        },

        [xi.zone.BATALLIA_DOWNS] =
        {
            ['qm2'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Killed') == 1 then
                        quest:setVar(player, 'Prog', 6)
                        quest:setVar(player, 'Killed', 0)
                        return quest:keyItem(xi.ki.RANCHURIOMES_LEGACY)
                    end

                    -- Retail sends both lines as speakerless npc text (flag unset, type 6).
                    if
                        quest:getVar(player, 'Prog') == 5 and
                        npcUtil.popFromQM(player, npc, batalliaID.mob.STURMTIGER, { hide = 0 })
                    then
                        player:messageText(npc, batalliaID.text.SENSE_AN_EVIL_PRESENCE, false, 6)
                    else
                        player:messageText(npc, batalliaID.text.SOMEONE_DUG, false, 6)
                    end

                    return quest:noAction()
                end,
            },

            ['Sturmtiger'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if quest:getVar(player, 'Prog') == 5 then
                        quest:setVar(player, 'Killed', 1)
                    end
                end,
            },
        },

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Miaux'] =
            {
                onTrigger = function(player, npc)
                    local progress = quest:getVar(player, 'Prog')

                    if progress == 2 then
                        return quest:progressEvent(67)
                    elseif progress == 3 or progress == 4 then
                        return quest:event(68)
                    elseif progress == 5 or progress == 6 then
                        return quest:event(66)
                    end
                end,
            },

            onEventFinish =
            {
                [67] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.SHINY_EARRING)
                    quest:setVar(player, 'Prog', 3)
                end,
            },
        },

        [xi.zone.PORT_SAN_DORIA] =
        {
            ['Ceraulian'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        quest:getVar(player, 'Prog') == 0 and
                        npcUtil.tradeMatches(trade, { { xi.item.GOLD_HAIRPIN, 1 } })
                    then
                        return quest:progressEvent(17)
                    end
                end,

                onTrigger = function(player, npc)
                    local progress = quest:getVar(player, 'Prog')

                    if progress == 0 then
                        return quest:event(13) -- Reminder: bring the gold hairpin.
                    elseif progress == 1 then
                        if GetSystemTime() < quest:getVar(player, 'Wait') then
                            return quest:event(3) -- Nothing new until the wait passes.
                        end

                        return quest:progressEvent(7)
                    elseif progress == 2 then
                        return quest:event(8) -- Reminder: investigate the mugging.
                    elseif progress == 3 then
                        return quest:event(6) -- Optional. Ceraulian sizes up the earring.
                    elseif progress == 4 or progress == 5 then
                        return quest:event(9) -- Nothing new until the armor is recovered.
                    elseif progress == 6 then
                        return quest:progressEvent(15)
                    end
                end,
            },

            onEventFinish =
            {
                [7] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,

                [15] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.RANCHURIOMES_LEGACY)
                    end
                end,

                [17] = function(player, csid, option, npc)
                    player:tradeComplete()
                    quest:setVar(player, 'Prog', 1)
                    quest:setVar(player, 'Wait', GetSystemTime() + 60) -- 1 minute wait time.
                end,
            },
        },

        [xi.zone.WEST_RONFAURE] =
        {
            ['Esca'] =
            {
                onTrigger = function(player, npc)
                    local progress = quest:getVar(player, 'Prog')

                    if progress == 4 then
                        return quest:progressEvent(137)
                    elseif progress == 5 then
                        return quest:event(138) -- Reminder: the armor is buried past the Eldieme Necropolis.
                    end
                end,
            },

            onEventFinish =
            {
                [137] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.SHINY_EARRING)
                    quest:setVar(player, 'Prog', 5)
                end,
            },
        },
    },
}

return quest
