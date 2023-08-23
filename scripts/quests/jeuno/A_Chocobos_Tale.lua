-----------------------------------
-- A Chocobo's Tale
-----------------------------------
-- Log ID: 3, Quest ID: 72
-- Nevela       : !pos -60.114 0 81.125 244
-- Wobke        : !pos 29.028 -0.126 -111.626 234
-- Outpost Gate : !pos 473.566 23.421 413.134 109
-- qm           : !pos -39.370 -11.093 307.285 105
-----------------------------------
local batalliaID = zones[xi.zone.BATALLIA_DOWNS]
-----------------------------------

local quest = Quest:new(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.A_CHOCOBOS_TALE)

quest.reward =
{
    fame     = 30,
    fameArea = xi.quest.fame_area.JEUNO,
    gil      = 5200,
    title    = xi.title.CHOCOBO_LOVE_GURU,
}

local function isNMSpawned()
    for nmId = batalliaID.mob.BADSHAH_OFFSET, batalliaID.mob.BADSHAH_OFFSET + 4 do
        if GetMobByID(nmId):isSpawned() then
            return true
        end
    end

    return false
end

local function isNMDefeated()
    for nmId = batalliaID.mob.BADSHAH_OFFSET, batalliaID.mob.BADSHAH_OFFSET + 4 do
        local nmMob = GetMobByID(nmId)

        if nmMob:isDead() or not nmMob:isSpawned() then
            return true
        end
    end

    return false
end

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.A_VESSEL_WITHOUT_A_CAPTAIN)
        end,

        [xi.zone.UPPER_JEUNO] =
        {
            ['Nevela'] = quest:progressEvent(10015),

            onEventFinish =
            {
                [10015] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.UPPER_JEUNO] =
        {
            ['Nevela'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 5 then
                        return quest:progressEvent(10017)
                    else
                        return quest:event(10016)
                    end
                end,
            },

            onEventFinish =
            {
                [10017] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.SILVER_COMETS_COLLAR)
                    end
                end,
            },
        },

        [xi.zone.BASTOK_MINES] =
        {
            ['Wobke'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 0 then
                        return quest:progressEvent(245)
                    elseif questProgress <= 2 then
                        return quest:event(246)
                    elseif questProgress == 3 then
                        return quest:progressEvent(247, 0, xi.item.BOTTLE_OF_WARDING_OIL)
                    else
                        return quest:event(248)
                    end
                end,
            },

            onEventFinish =
            {
                [245] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

                [247] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 4)
                end,
            },
        },

        [xi.zone.PASHHOW_MARSHLANDS] =
        {
            ['Outpost_Gate'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, { { xi.item.BOTTLE_OF_WARDING_OIL, 3 } }) and
                        quest:getVar(player, 'Prog') == 2
                    then
                        return quest:progressEvent(22)
                    end
                end,

                onTrigger = function(player, npc)
                    -- TODO: The followup after CS 21 may be different, and needs capture.

                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(21, 0, xi.item.BOTTLE_OF_WARDING_OIL)
                    end
                end,
            },

            onEventFinish =
            {
                [21] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,

                [22] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,
            },
        },

        [xi.zone.BATALLIA_DOWNS] =
        {
            ['qm_chocobotale'] =
            {
                onTrigger = function(player, npc)
                    if
                        not isNMSpawned() and
                        quest:getVar(player, 'Prog') == 4
                    then
                        if quest:getLocalVar(player, 'nmDefeated') == 1 then
                            quest:setVar(player, 'Prog', 5)

                            return quest:keyItem(xi.ki.SILVER_COMETS_COLLAR)
                        else
                            for nmId = batalliaID.mob.BADSHAH_OFFSET, batalliaID.mob.BADSHAH_OFFSET + 4 do
                                SpawnMob(nmId):updateClaim(player)
                            end

                            return quest:messageSpecial(batalliaID.text.YOU_ARE_BEING_ATTACKED)
                        end
                    end
                end,
            },

            ['Badshah'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if
                        isNMDefeated() and
                        quest:getVar(player, 'Prog') == 4
                    then
                        quest:setLocalVar(player, 'nmDefeated', 1)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.UPPER_JEUNO] =
        {
            ['Nevela'] = quest:event(10018):replaceDefault(),
        },
    },
}

return quest
