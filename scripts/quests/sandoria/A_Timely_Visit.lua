-----------------------------------
-- A Timely Visit
-----------------------------------
-- Log ID: 0, Quest ID: 105
-- Deraquien !pos -98.698 -2.0 32.056
-- Narvecaint !pos -261.936 23.144 127.61
-- Phillone !pos -208.832 -2.949 67.189
-- qm1 !pos -310.882 -0.139 407.377
-----------------------------------
local jugnerID = zones[xi.zone.JUGNER_FOREST]
-----------------------------------

local quest = Quest:new(xi.questLog.SANDORIA, xi.quest.id.sandoria.A_TIMELY_VISIT)

quest.reward =
{
    fame = 60,
    fameArea = xi.fameArea.SANDORIA,
    item = xi.item.MEDIEVAL_COLLAR,
    title = xi.title.OBSIDIAN_STORM,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getFameLevel(xi.fameArea.SANDORIA) >= 4
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Deraquien'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Option') == 0 then
                        return quest:progressEvent(33)
                    else
                        return quest:progressEvent(47)
                    end
                end,
            },

            onEventFinish =
            {
                [33] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                    else
                        quest:setVar(player, 'Option', 1) -- Player declined to start quest, and flags the secondary dialogue to start quest
                    end
                end,

                [47] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                        quest:setVar(player, 'Option', 0) -- Resets variable
                    end
                end,
            },
        },
    },

    -- Pre NM Fight
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
                vars.Stage == 0
        end,

        [xi.zone.CHATEAU_DORAGUILLE] =
        {
            ['Halver'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 2 then
                        return quest:progressEvent(112)
                    end
                end,
            },

            onEventFinish =
            {
                [112] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,
            },
        },

        [xi.zone.LA_THEINE_PLATEAU] =
        {
            ['Narvecaint'] =
            {
                onTrigger = function(player, npc)
                    local progress = quest:getVar(player, 'Prog')

                    if progress == 0 then
                        return quest:progressEvent(0)
                    elseif progress <= 2 then
                        return quest:event(6):setPriority(101)
                    elseif progress <= 5 then
                        return quest:event(7):setPriority(101)
                    end
                end,
            },

            onEventFinish =
            {
                [0] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Deraquien'] =
            {
                onTrigger = function(player, npc)
                    local progress = quest:getVar(player, 'Prog')

                    if progress == 0 then
                        return quest:event(34):setPriority(101)
                    elseif progress == 1 then
                        return quest:progressEvent(80)
                    elseif progress == 2 then
                        return quest:event(20):setPriority(101)
                    elseif progress == 3 then
                        return quest:progressEvent(87)
                    elseif progress == 4 then
                        return quest:event(30):setPriority(101)
                    elseif progress == 5 then
                        return quest:progressEvent(38)
                    end
                end,
            },

            ['Phillone'] =
            {
                onTrigger = function(player, npc)
                    local progress = quest:getVar(player, 'Prog')

                    if progress == 4 then
                        return quest:progressEvent(78)
                    elseif progress == 5 then
                        return quest:event(91):setPriority(101)
                    end
                end,
            },

            onEventFinish =
            {

                [38] = function(player, csid, option, npc)
                    quest:setVar(player, 'Stage', 1)
                end,

                [78] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 5)
                end,

                [80] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,

                [87] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 4)
                end,
            },
        },
    },

    -- NM fight to end
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
                vars.Stage == 1
        end,

        [xi.zone.JUGNER_FOREST] =
        {
            ['qm1'] =
            {
                onTrigger = function(player, npc)
                    local hour = VanadielHour()
                    local progress = quest:getVar(player, 'Prog')
                    local mobsSpawned = (GetMobByID(jugnerID.mob.GIOLLEMITTE):isSpawned() or GetMobByID(jugnerID.mob.GIOLLEMITTE + 1):isSpawned())
                    local waitOver = GetSystemTime() >= npc:getLocalVar('Wait')
                    local isDaytime = (hour >= 6 and hour <= 17)

                    if player:getLocalVar('NMKilled') == 1 and progress == 5 and not mobsSpawned then
                        return quest:progressEvent(18)
                    elseif progress == 5 and waitOver and not mobsSpawned and not isDaytime then
                        for i = 0, 1 do
                            SpawnMob(jugnerID.mob.GIOLLEMITTE + i):updateClaim(player)
                        end

                        return quest:messageSpecial(jugnerID.text.SENSE_OF_FOREBODING)
                    elseif progress == 5 and isDaytime then
                        return quest:messageSpecial(jugnerID.text.UNABLE_TO_INVESTIGATE)
                    end
                end,
            },

            onEventFinish =
            {

                [18] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 6)
                end,
            },

            -- Player can kill EITHER NM to progress
            ['Giollemitte_B_Feroun'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if
                        mob:getID() == jugnerID.mob.GIOLLEMITTE and
                        quest:getVar(player, 'Prog') == 5
                    then
                        player:setLocalVar('NMKilled', 1)
                    end
                end,
            },

            -- Player can kill EITHER NM to progress
            ['Skeleton_Esquire_NM'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if
                        mob:getID() == jugnerID.mob.GIOLLEMITTE + 1 and
                        quest:getVar(player, 'Prog') == 5
                    then
                        player:setLocalVar('NMKilled', 1)
                    end
                end,
            },
        },

        [xi.zone.LA_THEINE_PLATEAU] =
        {
            ['Narvecaint'] =
            {
                onTrigger = function(player, npc)
                    local progress = quest:getVar(player, 'Prog')

                    if progress <= 6 then
                        return quest:event(7):setPriority(101)
                    elseif progress == 7 then
                        return quest:progressEvent(1)
                    else
                        return quest:event(8):setPriority(101)
                    end
                end,
            },

            onEventFinish =
            {

                [1] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 8)
                end,
            },
        },

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Deraquien'] = quest:event(27):setPriority(101),

            ['Phillone'] =
            {
                onTrigger = function(player, npc)
                    local progress = quest:getVar(player, 'Prog')

                    if progress <= 5 then
                        return quest:event(48):setPriority(101)
                    elseif progress == 6 then
                        return quest:progressEvent(21)
                    elseif progress == 8 then
                        return quest:progressEvent(14)
                    else
                        return quest:event(49):setPriority(101)
                    end
                end,
            },

            onEventFinish =
            {

                [14] = function(player, csid, option, npc)
                    quest:complete(player)
                end,

                [21] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 7)
                end,
            },
        },
    },

    {
    check = function(player, status, vars)
        return status == xi.questStatus.QUEST_COMPLETED
    end,

    [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Phillone'] = quest:event(28):replaceDefault(),
        },
    },
}

return quest
