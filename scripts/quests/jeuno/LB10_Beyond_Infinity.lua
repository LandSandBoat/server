-----------------------------------
-- Beyond Infinity
-----------------------------------
-- Log ID: 3, Quest ID: 137
-- Nomad Moogle : !pos 10.012 1.453 121.883 243
-----------------------------------
local ruludeID = zones[xi.zone.RULUDE_GARDENS]
-----------------------------------

local quest = Quest:new(xi.questLog.JEUNO, xi.quest.id.jeuno.BEYOND_INFINITY)

quest.reward =
{
    fame = 50,
    fameArea = xi.fameArea.JEUNO,
    title = xi.title.BUSHIN_ASPIRANT,
}

local atoriBattlefieldIds =
{
    [xi.zone.BALGAS_DAIS]      = xi.battlefield.id.BEYOND_INFINITY_BALGAS_DAIS,
    [xi.zone.HORLAIS_PEAK]     = xi.battlefield.id.BEYOND_INFINITY_HORLAIS_PEAK,
    [xi.zone.QUBIA_ARENA]      = xi.battlefield.id.BEYOND_INFINITY,
    [xi.zone.WAUGHROON_SHRINE] = xi.battlefield.id.BEYOND_INFINITY_WAUGHROON_SHRINE,
}

local atoriBattlefieldZone =
{
    onEventFinish =
    {
        [32001] = function(player, csid, option, npc)
            local battlefieldWin = player:getLocalVar('battlefieldWin')

            if battlefieldWin == atoriBattlefieldIds[player:getZoneID()] then
                npcUtil.giveItem(player, xi.item.SCROLL_OF_INSTANT_WARP)
                quest:setVar(player, 'Prog', 1)
            end
        end,
    },
}

quest.sections =
{
    -- Section: Quest available.
    -- Note: This step only happens with one, very specific option in the previous quest.
    -- In most cases, the quest will already be accepted.
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.PRELUDE_TO_PUISSANCE) and
                player:getLevelCap() == 95
        end,

        [xi.zone.RULUDE_GARDENS] =
        {
            ['Nomad_Moogle'] =
            {
                onTrigger = function(player, npc)
                    local playerLevel     = player:getMainLvl()
                    local limitBreaker    = player:hasKeyItem(xi.ki.LIMIT_BREAKER) and 1 or 2
                    local lastQuestNumber = 0
                    local lastQuestStage  = 0
                    local rejectedOffer   = 0
                    if
                        xi.settings.main.MAX_LEVEL > 95 and
                        limitBreaker == 1 and
                        playerLevel > 90
                    then
                        lastQuestNumber = 5
                        rejectedOffer   = player:getLocalVar('rejectedStartLB10')
                    end

                    return quest:progressEvent(10045, playerLevel, limitBreaker, lastQuestNumber, lastQuestStage, rejectedOffer)
                end,
            },

            onEventFinish =
            {
                [10045] = function(player, csid, option, npc)
                    -- This options start quest.
                    if
                        option == 13 or
                        option == 14 or
                        option == 19 or
                        option == 20 or
                        option == 21
                    then
                        quest:begin(player)
                    end

                    -- This options also warp you to a BCNM. Note that the quest "Beyond Infinity" is already activated.
                    if option == 14 then
                        player:setPos(-511.459, 159.004, -210.543, 10, xi.zone.HORLAIS_PEAK)
                    elseif option == 19 then
                        player:setPos(-349.899, 104.213, -260.150, 0, xi.zone.WAUGHROON_SHRINE)
                    elseif option == 20 then
                        player:setPos(299.316, -123.591, 353.760, 66, xi.zone.BALGAS_DAIS)
                    elseif option == 21 then
                        player:setPos(-225.146, -24.250, 20.057, 255, xi.zone.QUBIA_ARENA)
                    end
                end,
            },
        },
    },

    -- Section: Quest accepted.
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
                vars.Prog == 0 and
                player:hasKeyItem(xi.ki.SOUL_GEM_CLASP)
        end,

        [xi.zone.RULUDE_GARDENS] =
        {
            ['Nomad_Moogle'] =
            {
                onTrigger = function(player, npc)
                    local playerLevel     = player:getMainLvl()
                    local limitBreaker    = player:hasKeyItem(xi.ki.LIMIT_BREAKER) and 1 or 2
                    local lastQuestNumber = 5
                    local lastQuestStage  = 1

                    return quest:event(10045, playerLevel, limitBreaker, lastQuestNumber, lastQuestStage)
                end,
            },

            ['Maat'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(10193)
                end,
            },

            onEventFinish =
            {
                [10045] = function(player, csid, option, npc)
                    if option == 16 then
                        player:setPos(-511.459, 159.004, -210.543, 10, xi.zone.HORLAIS_PEAK)
                    elseif option == 22 then
                        player:setPos(-349.899, 104.213, -260.150, 0, xi.zone.WAUGHROON_SHRINE)
                    elseif option == 23 then
                        player:setPos(299.316, -123.591, 353.760, 66, xi.zone.BALGAS_DAIS)
                    elseif option == 24 then
                        player:setPos(-225.146, -24.250, 20.057, 255, xi.zone.QUBIA_ARENA)
                    end
                end,
            },
        },
    },

    -- BCNM Win Events.  Soul Gem Clasp is required for entry, and removed
    -- after.  Separate section to not confuse with the failed event.
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and vars.Prog == 0
        end,

        [xi.zone.BALGAS_DAIS]      = atoriBattlefieldZone,
        [xi.zone.HORLAIS_PEAK]     = atoriBattlefieldZone,
        [xi.zone.QUBIA_ARENA]      = atoriBattlefieldZone,
        [xi.zone.WAUGHROON_SHRINE] = atoriBattlefieldZone,
    },

    -- Section: Quest accepted. We failed BCNM.
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
                vars.Prog == 0 and
                not player:hasKeyItem(xi.ki.SOUL_GEM_CLASP)
        end,

        [xi.zone.RULUDE_GARDENS] =
        {
            ['Nomad_Moogle'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, { { xi.item.HIGH_KINDREDS_CREST, 5 } }) then
                        return quest:progressEvent(10195, 1)
                    end
                end,

                onTrigger = function(player, npc)
                    local playerLevel     = player:getMainLvl()
                    local limitBreaker    = player:hasKeyItem(xi.ki.LIMIT_BREAKER) and 1 or 2
                    local lastQuestNumber = 5
                    local lastQuestStage  = 3 -- I guess failing is considered a new stage.
                    local meritCost       = player:getMeritCount() >= 1 and 1 or 0

                    return quest:progressEvent(10045, playerLevel, limitBreaker, lastQuestNumber, lastQuestStage, 0, 0, meritCost)
                end,
            },

            onEventUpdate =
            {
                [10045] = function(player, csid, option, npc)
                    if option == 9 then
                        local numMerits = player:getMeritCount()

                        if numMerits >= 1 then
                            player:setMerits(numMerits - 1)
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [10045] = function(player, csid, option, npc)
                    if option ~= 0 then
                        npcUtil.giveKeyItem(player, xi.ki.SOUL_GEM_CLASP)
                    end

                    if option == 17 then
                        player:setPos(-511.459, 159.004, -210.543, 10, xi.zone.HORLAIS_PEAK)
                    elseif option == 25 then
                        player:setPos(-349.899, 104.213, -260.150, 0, xi.zone.WAUGHROON_SHRINE)
                    elseif option == 26 then
                        player:setPos(299.316, -123.591, 353.760, 66, xi.zone.BALGAS_DAIS)
                    elseif option == 27 then
                        player:setPos(-225.146, -24.250, 20.057, 255, xi.zone.QUBIA_ARENA)
                    end
                end,

                [10195] = function(player, csid, option, npc)
                    player:confirmTrade()
                    npcUtil.giveKeyItem(player, xi.ki.SOUL_GEM_CLASP)

                    if option == 16 then
                        player:setPos(-511.459, 159.004, -210.543, 10, xi.zone.HORLAIS_PEAK)
                    elseif option == 22 then
                        player:setPos(-349.899, 104.213, -260.150, 0, xi.zone.WAUGHROON_SHRINE)
                    elseif option == 23 then
                        player:setPos(299.316, -123.591, 353.760, 66, xi.zone.BALGAS_DAIS)
                    elseif option == 24 then
                        player:setPos(-225.146, -24.250, 20.057, 255, xi.zone.QUBIA_ARENA)
                    end
                end,
            },
        },
    },

    -- Section: Quest accepted. We beated the BCNM.
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
                vars.Prog == 1
        end,

        [xi.zone.RULUDE_GARDENS] =
        {
            ['Nomad_Moogle'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(10139, 75, 1)
                end,
            },

            onEventFinish =
            {
                [10139] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:setLevelCap(99)
                        player:messageSpecial(ruludeID.text.YOUR_LEVEL_LIMIT_IS_NOW_99)
                    end
                end,
            },
        },
    },

    -- Section: Quest completed.
    -- TODO: Move all of this to "martial mastery" quest
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.RULUDE_GARDENS] =
        {
            ['Nomad_Moogle'] =
            {
                onTrigger = function(player, npc)
                    local playerLevel  = player:getMainLvl()
                    local limitBreaker = player:hasKeyItem(xi.ki.LIMIT_BREAKER) and 1 or 2

                    if
                        player:getMainLvl() >= 99 and
                        not player:hasKeyItem(xi.ki.JOB_BREAKER)
                    then
                        return quest:progressEvent(10240, playerLevel, limitBreaker)
                    else
                        return quest:event(10045, playerLevel, limitBreaker, 0, 0)
                    end
                end,
            },

            onEventFinish =
            {
                [10240] = function(player, csid, option, npc)
                    if option == 28 then
                        npcUtil.giveKeyItem(player, xi.ki.JOB_BREAKER)
                    end
                end,
            },
        },
    },
}

return quest
