-----------------------------------
-- A Job for the Consortium
-----------------------------------
-- Log ID: 0, Quest ID: 67
-----------------------------------
-- Portaure :      !pos -22 -4 -106 232
-- _6u2 :          !pos -61.0 6.451 57.998
-- Haubijoux :     !pos -61 8 58 246
-- Yin Pocanakhu : !pos 35 4 -46 245
-----------------------------------
local juenoPortID  = zones[xi.zone.PORT_JEUNO]
local lowerID = zones[xi.zone.LOWER_JEUNO]
local sandyPortID = zones[xi.zone.PORT_SAN_DORIA]
-----------------------------------

local quest = Quest:new(xi.questLog.SANDORIA, xi.quest.id.sandoria.A_JOB_FOR_THE_CONSORTIUM)

local packageCondition =
{
    NORMAL      = 0,
    CONFISCATED = 1,
    DAMAGED     = 2,
}

local checkSmuggle = function()
    local caughtSmuggling = false
    local hour = VanadielHour()

    if
        hour > 5 and
        hour < 18 and
        math.random(1, 100) <= 25
    then
        caughtSmuggling = true
    end

    return caughtSmuggling
end

quest.sections =
{
    {
        check = function(player, status, vars)
            return vars.Stage == 0 and
                quest:getVar(player, 'Option') == 0 and
                player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.A_JOB_FOR_THE_CONSORTIUM) == xi.questStatus.QUEST_AVAILABLE
        end,

        [xi.zone.PORT_SAN_DORIA] =
        {
            ['Portaure'] = quest:event(571):importantOnce(), -- This is a single time dialogue. It only ever plays once and is never seen again.

            onEventFinish =
            {
                [571] = function(player, csid, option, npc)
                    quest:setVar(player, 'Option', 1)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return vars.Stage == 0 and
                player:hasKeyItem(xi.ki.TENSHODO_MEMBERS_CARD) and
                player:getFameLevel(xi.fameArea.SANDORIA) >= 5 and
                player:getFameLevel(xi.fameArea.NORG) >= 1
        end,

        [xi.zone.PORT_SAN_DORIA] =
        {
            ['Portaure'] =
            {
                onTrigger = function(player, npc)
                    local firstTime = player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.A_JOB_FOR_THE_CONSORTIUM) == xi.questStatus.QUEST_AVAILABLE and 0 or 1

                    if player:getVar('[AIRSHIP]suspended') >= GetSystemTime() then
                        return quest:messageText(sandyPortID.text.LAY_LOW)
                    else
                        return quest:event(651, { [0] = firstTime })
                    end
                end,
            },

            onEventFinish =
            {
                [651] = function(player, csid, option, npc)
                    if option == 1 and npcUtil.giveKeyItem(player, xi.ki.BRUGAIRE_GOODS) then
                        quest:begin(player)
                        -- Set as damaged, going through customs reverses it.
                        quest:setVar(player, 'Prog', packageCondition.DAMAGED)
                        quest:setVar(player, 'Stage', 1)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return vars.Stage == 1 and
            player:hasKeyItem(xi.ki.BRUGAIRE_GOODS)
        end,

        [xi.zone.PORT_SAN_DORIA] =
        {
            ['Portaure'] = quest:event(652),
        },

        [xi.zone.PORT_JEUNO] =
        {
            ['_6u2'] =
            {
                onTrigger = function(player, npc)
                    local caught = checkSmuggle()
                    local param = 0

                    if caught then
                        quest:setVar(player, 'Prog', packageCondition.CONFISCATED)
                        param = 1
                    end

                    return quest:progressEvent(54, param)
                end,
            },

            ['Haubijoux'] =
            {
                onTrigger = function(player, npc)
                    local caught = checkSmuggle()
                    local param = 0

                    if caught then
                        quest:setVar(player, 'Prog', packageCondition.CONFISCATED)
                        param = 1
                    end

                    return quest:progressEvent(54, param)
                end,
            },

            onEventFinish =
            {
                [54] = function(player, csid, option, npc)
                    if option == 1 then
                        if quest:getVar(player, 'Prog') == packageCondition.CONFISCATED then
                            player:delKeyItem(xi.ki.BRUGAIRE_GOODS)
                            player:setVar('[AIRSHIP]suspended', JstMidnight())
                            player:messageSpecial(juenoPortID.text.CONFISCATED, xi.ki.BRUGAIRE_GOODS)
                        else
                            player:messageSpecial(juenoPortID.text.CLEARED_CUSTOMS)
                            quest:setVar(player, 'Prog', packageCondition.NORMAL)
                        end
                    end
                end,
            },
        },

        [xi.zone.LOWER_JEUNO] =
        {
            ['Yin_Pocanakhu'] =
            {
                onTrigger = function(player, npc)
                    local damaged = quest:getVar(player, 'Prog') == packageCondition.DAMAGED and true or false

                    if damaged then
                        return quest:progressEvent(218)
                    else
                        return quest:progressEvent(219)
                    end
                end,
            },

            onEventFinish =
            {
                [218] = function(player, csid, option, npc)
                    player:messageSpecial(lowerID.text.DAMANGED_PACKAGE_DELIVERED, xi.ki.BRUGAIRE_GOODS)
                    player:delKeyItem(xi.ki.BRUGAIRE_GOODS)
                end,

                [219] = function(player, csid, option, npc)
                    player:messageSpecial(lowerID.text.PACKAGE_DELIVERED, xi.ki.BRUGAIRE_GOODS)
                    player:delKeyItem(xi.ki.BRUGAIRE_GOODS)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return vars.Stage == 1 and
            not player:hasKeyItem(xi.ki.BRUGAIRE_GOODS)
        end,

        [xi.zone.PORT_SAN_DORIA] =
        {
            ['Portaure'] =
            {
                onTrigger = function(player, npc)
                    local result = quest:getVar(player, 'Prog')
                    -- 0 delivered, 1 = confiscated, 2 = damaged
                    return quest:progressEvent(653 + result)
                end,
            },

            onEventFinish =
            {
                [653] = function(player, csid, option, npc)
                    quest:complete(player)
                    npcUtil.giveCurrency(player, 'gil', 1000)
                    player:addFame(xi.fameArea.NORG, 30)
                end,

                [654] = function(player, csid, option, npc)
                    quest:complete(player)
                end,

                [655] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },
    },

    -- Actions for Airship travels in Jeuno when suspended.
    {
        check = function(player, status, vars)
            return player:getVar('[AIRSHIP]suspended') >= GetSystemTime()
        end,

        [xi.zone.PORT_JEUNO] =
        {
            ['_6u4'] = quest:event(42):setPriority(200), -- Sandy
            ['_6u8'] = quest:event(41):setPriority(200), -- Kazahm
            ['_6ua'] = quest:event(40):setPriority(200), -- Bastok
            ['_6ue'] = quest:event(43):setPriority(200), -- Windurst
            ['Illauvolahaut'] = quest:event(41):setPriority(200), -- Kazahm
            ['Omiro-Zamiro']  = quest:event(43):setPriority(200), -- Windurst
            ['Purequane']     = quest:event(42):setPriority(200), -- Sandy
            ['Zedduva']       = quest:event(40):setPriority(200), -- Bastok
        },
    },
}

return quest
