-----------------------------------
-- Dances with Luopans
-- Geomancer unlock quest
-----------------------------------
-- !addquest 9 118
-- Sylvie : !pos 78.094 32.000 135.725 256
-----------------------------------

local quest = Quest:new(xi.questLog.ADOULIN, xi.quest.id.adoulin.DANCES_WITH_LUOPANS)

xi.dancesWithLuopans = {}

xi.dancesWithLuopans.onHealing = function(player)
    if
        quest:getLocalVar(player, 'LocusArea') == 1 and
        quest:getVar(player, 'Prog') == 0
    then
        local ID                = zones[player:getZoneID()]
        local maxRestSeconds    = 8 * 60
        local secondsPerTick    = xi.settings.map.HEALING_TICK_DELAY
        local minWaitTime       = math.min(3 * secondsPerTick, maxRestSeconds)
        local waitTimeInSeconds = math.randomInt(minWaitTime, maxRestSeconds)

        player:messageSpecial(ID.text.ENERGIES_COURSE)
        quest:setLocalVar(player, 'RestUntil', GetSystemTime() + waitTimeInSeconds)

        player:timer(waitTimeInSeconds * 1000, function(playerArg)
            local restUntil = quest:getLocalVar(playerArg, 'RestUntil')

            if
                restUntil > 0 and
                GetSystemTime() >= restUntil
            then
                playerArg:messageSpecial(ID.text.MYSTICAL_WARMTH)
                quest:setLocalVar(playerArg, 'RestUntil', 0)
                quest:setVar(playerArg, 'Prog', 1)
            end
        end)
    end
end

xi.dancesWithLuopans.onEffectLose = function(player)
    quest:setLocalVar(player, 'RestUntil', 0)
end

local function onLocusAreaEnter(player, triggerArea)
    if
        player:hasKeyItem(xi.ki.LUOPAN) and
        quest:getVar(player, 'Prog') == 0
    then
        local ID = zones[player:getZoneID()]
        player:messageSpecial(ID.text.UNCANNY_SENSATION)
        quest:setLocalVar(player, 'LocusArea', 1)
    end
end

local function onLocusAreaLeave(player, triggerArea)
    quest:setLocalVar(player, 'LocusArea', 0)
    quest:setLocalVar(player, 'RestUntil', 0)
end

local homelandSoilNation =
{
    [xi.zone.LA_THEINE_PLATEAU]    = xi.nation.SANDORIA,
    [xi.zone.KONSCHTAT_HIGHLANDS]  = xi.nation.BASTOK,
    [xi.zone.TAHRONGI_CANYON]      = xi.nation.WINDURST,
}

local function onHomelandSoilTrigger(player, npc)
    if
        player:getNation() == homelandSoilNation[player:getZoneID()] and
        not player:hasKeyItem(xi.ki.FISTFUL_OF_HOMELAND_SOIL) and
        not player:hasKeyItem(xi.ki.LUOPAN)
    then
        npcUtil.giveKeyItem(player, xi.ki.FISTFUL_OF_HOMELAND_SOIL)
    end
end

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getMainLvl() >= xi.settings.main.ADVANCED_JOB_LEVEL
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Sylvie'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Declined') == 1 then
                        return quest:progressEvent(32)
                    end

                    return quest:progressEvent(31)
                end,
            },

            onEventFinish =
            {
                [31] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                    else
                        quest:setVar(player, 'Declined', 1)
                    end
                end,

                [32] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:setVar(player, 'Declined', 0)
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.CEIZAK_BATTLEGROUNDS] =
        {
            onTriggerAreaEnter =
            {
                [1] = onLocusAreaEnter,
                [2] = onLocusAreaEnter,
            },

            onTriggerAreaLeave =
            {
                [1] = onLocusAreaLeave,
                [2] = onLocusAreaLeave,
            },
        },

        [xi.zone.LA_THEINE_PLATEAU] =
        {
            ['Ergon_Locus'] =
            {
                onTrigger = onHomelandSoilTrigger,
            },
        },

        [xi.zone.KONSCHTAT_HIGHLANDS] =
        {
            ['Ergon_Locus'] =
            {
                onTrigger = onHomelandSoilTrigger,
            },
        },

        [xi.zone.TAHRONGI_CANYON] =
        {
            ['Ergon_Locus'] =
            {
                onTrigger = onHomelandSoilTrigger,
            },
        },

        [xi.zone.YAHSE_HUNTING_GROUNDS] =
        {
            onTriggerAreaEnter =
            {
                [1] = onLocusAreaEnter,
            },

            onTriggerAreaLeave =
            {
                [1] = onLocusAreaLeave,
            },
        },

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Sylvie'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(36)
                    elseif player:hasKeyItem(xi.ki.LUOPAN) then
                        return quest:progressEvent(35)
                    end

                    return quest:progressEvent(33)
                end,

                onTrade = function(player, npc, trade)
                    if
                        player:hasKeyItem(xi.ki.FISTFUL_OF_HOMELAND_SOIL) and
                        npcUtil.tradeHas(trade, xi.item.PETRIFIED_LOG)
                    then
                        return quest:progressEvent(34)
                    end
                end,
            },

            onEventFinish =
            {
                [34] = function(player, csid, option, npc)
                    player:confirmTrade()
                    player:delKeyItem(xi.ki.FISTFUL_OF_HOMELAND_SOIL)
                    npcUtil.giveKeyItem(player, xi.ki.LUOPAN)
                end,

                [36] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, { xi.item.PLATE_OF_INDI_POISON, xi.item.MATRE_BELL }) then
                        player:unlockJob(xi.job.GEO)
                        player:messageSpecial(zones[xi.zone.WESTERN_ADOULIN].text.YOU_CAN_NOW_BECOME, 0)
                        npcUtil.giveKeyItem(player, xi.ki.JOB_GESTURE_GEOMANCER)
                        quest:complete(player)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Sylvie'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:getMainJob() == xi.job.GEO and
                        not player:hasItem(xi.item.MATRE_BELL)
                    then
                        quest:setLocalVar(player, 'MatreBellPayment', 0)
                        return quest:event(37):replaceDefault()
                    end

                    return quest:event(39):replaceDefault()
                end,
            },

            onEventUpdate =
            {
                [37] = function(player, csid, option, npc)
                    if option ~= 1 and option ~= 2 then
                        return
                    end

                    quest:setLocalVar(player, 'MatreBellPayment', 0)

                    local eventUpdateParam = 0
                    if player:getFreeSlotsCount() < 1 then
                        eventUpdateParam = 2
                    elseif
                        (option == 1 and player:getGil() >= 300000) or
                        (option == 2 and player:getCurrency('bayld') >= 150000)
                    then
                        quest:setLocalVar(player, 'MatreBellPayment', option)
                        eventUpdateParam = 1
                    end

                    player:updateEvent(0, 0, 0, 0, 0, 0, 0, eventUpdateParam)
                end,
            },

            onEventFinish =
            {
                [37] = function(player, csid, option, npc)
                    local paymentOption = quest:getLocalVar(player, 'MatreBellPayment')
                    if paymentOption == 0 then
                        return
                    end

                    quest:setLocalVar(player, 'MatreBellPayment', 0)

                    if option ~= 1 then
                        return
                    end

                    if npcUtil.giveItem(player, { xi.item.MATRE_BELL }) then
                        if paymentOption == 1 then
                            player:delGil(300000)
                        elseif paymentOption == 2 then
                            player:delCurrency('bayld', 150000)
                        end
                    end
                end,
            },
        },
    },
}

return quest
