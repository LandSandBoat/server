-----------------------------------
-- A Timely Visit
-----------------------------------
-- Log ID: 0, Quest ID: 105
-- Deraquien !pos -98 -2 32 230
-- Narvecaint !pos -261 23 127 102
-- Phillone !pos -208 -2 67 230
-- ??? !pos -310 0 407 104
-----------------------------------
local jugnerID = zones[xi.zone.JUGNER_FOREST]
-----------------------------------
local fomor = jugnerID.mob.GIOLLEMITTE_B_FEROUN
local skeleton = jugnerID.mob.GIOLLEMITTE_B_FEROUN + 1
local quest = Quest:new(xi.questLog.SANDORIA, xi.quest.id.sandoria.A_TIMELY_VISIT)

quest.reward =
{
    item     = xi.item.MEDIEVAL_COLLAR,
    fame     = 60,
    fameArea = xi.fameArea.SANDORIA,
    title    = xi.title.OBSIDIAN_STORM,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getFameLevel(xi.fameArea.SANDORIA) >= 3
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Deraquien'] = quest:progressEvent(33),

            onEventFinish =
            {
                [33] = function(player, csid, option, npc)
                    if option == 1 then
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

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Deraquien'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 0 then
                        return quest:event(34)
                    elseif questProgress == 1 then
                        return quest:progressEvent(80)
                    elseif questProgress == 2 then
                        return quest:event(20) -- Additional Dialogue
                    elseif questProgress == 3 then
                        return quest:progressEvent(87)
                    elseif questProgress == 5 then
                        return quest:progressEvent(38)
                    end
                end,
            },

            ['Phillone'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 4 then
                        return quest:progressEvent(78)
                    elseif questProgress == 8 then
                        return quest:progressEvent(21)
                    elseif questProgress == 10 then
                        return quest:progressEvent(14)
                    end
                end,
            },

            onEventFinish =
            {
                [14] = function(player, csid, option, npc)
                    quest:complete(player)
                end,

                [21] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 9)
                end,

                [38] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 6)
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
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 0 then
                        return quest:progressEvent(0)
                    elseif questProgress == 1 then
                        return quest:event(6) -- Additional Dialogue
                    elseif questProgress == 9 then
                        return quest:progressEvent(1)
                    end
                end,
            },

            onEventFinish =
            {
                [0] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

                [1] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 10)
                end,
            },
        },

        [xi.zone.JUGNER_FOREST] =
        {
            ['qm1'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 6 then
                        if
                            (VanadielHour() <= 6 or VanadielHour() >= 18) and
                            npcUtil.popFromQM(player, npc, { fomor, fomor + 1 }, { hide = 0 })
                        then
                            return quest:message(jugnerID.text.FOREBODING)
                        end
                    elseif
                        questProgress == 7 and
                        not GetMobByID(skeleton):isSpawned() -- make sure skeleton is dead
                    then
                        return quest:progressEvent(18)
                    else
                        return quest:message(jugnerID.text.PRETERNATURAL_FORCES)
                    end
                end,
            },

            ['Giollemitte_B_Feroun'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if quest:getVar(player, 'Prog') == 6 then
                        quest:setVar(player, 'Prog', 7)
                    end
                end,
            },

            onEventFinish =
            {
                [18] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 8)
                end,
            },
        },
    },
}

return quest
