-----------------------------------
-- I'll Take the Big Box (NIN AF2)
-----------------------------------
-- Log ID: 5, Quest ID: 144
-- !addquest 5 144
-- Ryoma     : !pos -26 0 -8 252
-- Ensetsu   : !pos 32 -7 69 236
-- Leodarion : !pos -50 8 41 247
-----------------------------------
-- Leodarion finishes the trap overnight: the seance staff is handed over once the
-- Vana'diel day has changed since the oak pole was traded.
-- Enagakure only appears aboard the Selbina-bound ferry at night. Its spawn stays in
-- the ship zones because the framework has no game hour handler.
-- The completion cutscene spawns its own actors, so retail sends it with the zone's
-- NPCs hidden: cutscene flags 0x0013.
-----------------------------------

local quest = Quest:new(xi.questLog.OUTLANDS, xi.quest.id.outlands.I_LL_TAKE_THE_BIG_BOX)

quest.reward =
{
    fame     = 20,
    fameArea = xi.fameArea.NORG,
    item     = xi.item.NINJA_HAKAMA,
}

quest.sections =
{
    -- Section: Quest is available.
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.questLog.OUTLANDS, xi.quest.id.outlands.TWENTY_IN_PIRATE_YEARS)
        end,

        [xi.zone.NORG] =
        {
            ['Ryoma'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:getMainJob() ~= xi.job.NIN or
                        player:getMainLvl() < xi.settings.main.AF2_QUEST_LEVEL or
                        player:needToZone()
                    then
                        return
                    end

                    return quest:progressEvent(135)
                end,
            },

            onEventFinish =
            {
                [135] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    -- Section: Quest accepted.
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.PORT_BASTOK] =
        {
            ['Ensetsu'] =
            {
                onTrigger = function(player, npc)
                    local progress = quest:getVar(player, 'Prog')

                    if progress == 0 then
                        return quest:progressEvent(264)
                    elseif progress == 1 then
                        return quest:event(265) -- Reminder: Mitsunari's grandson lives in the Altepa Desert.
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
                onTrade = function(player, npc, trade)
                    if
                        quest:getVar(player, 'Prog') == 2 and
                        npcUtil.tradeMatches(trade, { { xi.item.OAK_POLE, 1 } })
                    then
                        return quest:progressEvent(92)
                    end
                end,

                onTrigger = function(player, npc)
                    local progress = quest:getVar(player, 'Prog')

                    if progress == 1 then
                        return quest:progressEvent(90)
                    elseif progress == 2 then
                        return quest:event(91) -- Reminder: bring an oak pole.
                    elseif progress == 3 then
                        if VanadielUniqueDay() < quest:getVar(player, 'Timer') then
                            return quest:event(93) -- Reminder: the trap is not finished yet.
                        end

                        return quest:progressEvent(94)
                    elseif progress == 4 then
                        return quest:event(95) -- Reminder: sail the Bastore Sea from east to west at night.
                    end
                end,
            },

            onEventFinish =
            {
                [90] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,

                [92] = function(player, csid, option, npc)
                    player:tradeComplete()
                    quest:setVar(player, 'Timer', VanadielUniqueDay() + 1)
                    quest:setVar(player, 'Prog', 3)
                end,

                [94] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.SEANCE_STAFF)
                    quest:setVar(player, 'Prog', 4)
                end,
            },
        },

        [xi.zone.SELBINA] =
        {
            onZoneIn = function(player, prevZone)
                if quest:getVar(player, 'Prog') == 5 then
                    return { 1101, -1, bit.bor(xi.cutsceneFlag.RESET_CAMERA, xi.cutsceneFlag.NO_PCS, xi.cutsceneFlag.NO_NPCS) }
                end
            end,

            onEventFinish =
            {
                [1101] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.SEANCE_STAFF)
                    end
                end,
            },
        },

        [xi.zone.SHIP_BOUND_FOR_SELBINA] =
        {
            ['Enagakure'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if quest:getVar(player, 'Prog') == 4 then
                        quest:setVar(player, 'Prog', 5)
                    end
                end,
            },
        },

        [xi.zone.SHIP_BOUND_FOR_SELBINA_PIRATES] =
        {
            ['Enagakure'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if quest:getVar(player, 'Prog') == 4 then
                        quest:setVar(player, 'Prog', 5)
                    end
                end,
            },
        },
    },
}

return quest
