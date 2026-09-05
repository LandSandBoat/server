-----------------------------------
-- Searching for the Right Words
-----------------------------------
-- Log ID: 3, Quest ID: 66
-- Kurou-Morou : !pos -4 -6 -28 245
-- Chululu     : !pos -13 -6 -42 245
-- Ilumida     : !pos -75 -1 58 244
-- qm2 (???)   : !pos 34.651 -20.183 -61.647 153
-----------------------------------
local boyahdaID = zones[xi.zone.THE_BOYAHDA_TREE]
-----------------------------------

local quest = Quest:new(xi.questLog.JEUNO, xi.quest.id.jeuno.SEARCHING_FOR_THE_RIGHT_WORDS)

quest.reward =
{
    gil  = 3000,
    item = xi.item.SCROLL_OF_SLEEPGA_II,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.A_CANDLELIGHT_VIGIL) and
                player:hasCompletedQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.RUBBISH_DAY) and
                player:hasCompletedQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.NEVER_TO_RETURN) and
                player:getFameLevel(xi.fameArea.JEUNO) >= 6 and
                not quest:getMustZone(player)
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Kurou-Morou'] =
            {
                onTrigger = function(player, npc)
                    local progress = quest:getVar(player, 'Prog')

                    if progress == 0 then
                        return quest:progressEvent(17) -- Runga-Kopunga visits, Kurou-Morou asks for advice
                    elseif progress == 1 then
                        return quest:event(38) -- 'Oh, what should I do!?'
                    elseif progress == 2 then
                        return quest:event(36) -- Hint about the moonlight in the Boyahda Tree
                    end
                end,
            },

            ['Chululu'] =
            {
                onTrigger = function(player, npc)
                    local progress = quest:getVar(player, 'Prog')

                    if
                        progress == 1 or
                        progress == 2
                    then
                        return quest:event(57) -- 'Oh, what should I do...?'
                    end
                end,
            },

            onEventFinish =
            {
                [17] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:setVar(player, 'Prog', 1)
                    end
                end,
            },
        },

        [xi.zone.UPPER_JEUNO] =
        {
            ['Ilumida'] =
            {
                onTrigger = function(player, npc)
                    local progress = quest:getVar(player, 'Prog')

                    if progress == 1 then
                        return quest:progressEvent(197) -- Quest offered.
                    elseif progress == 2 then
                        return quest:progressEvent(201) -- Quest offered again. (Happens if you decline initially)
                    end
                end,
            },

            onEventFinish =
            {
                [197] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                        quest:setVar(player, 'Prog', 3)
                    elseif option == 0 then
                        quest:setVar(player, 'Prog', 2)
                    end
                end,

                [201] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                        quest:setVar(player, 'Prog', 3)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Kurou-Morou'] = quest:event(39), -- 'You've got to go to the Boyahda Tree and get that moondrop!'
            ['Chululu']     = quest:event(57), -- 'Oh, what should I do...?'
        },

        [xi.zone.UPPER_JEUNO] =
        {
            ['Ilumida'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.MOONDROP) then
                        return quest:progressEvent(198) -- Quest complete
                    else
                        return quest:event(199) -- Reminder
                    end
                end,
            },

            onEventFinish =
            {
                [198] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.MOONDROP)
                        player:addFame(xi.fameArea.SANDORIA, 23)
                        player:addFame(xi.fameArea.BASTOK, 23)
                        player:addFame(xi.fameArea.WINDURST, 23)
                        quest:setVar(player, 'Post', 1)
                    end
                end,
            },
        },

        [xi.zone.THE_BOYAHDA_TREE] =
        {
            ['qm2'] =
            {
                onTrigger = function(player, npc)
                    local currentHour = VanadielHour()

                    if getVanadielMoonCycle() == xi.moonCycle.NEW_MOON then
                        return
                    end

                    if
                        currentHour < 19 and
                        currentHour >= 4
                    then
                        return
                    end

                    if player:hasKeyItem(xi.ki.MOONDROP) then
                        return
                    end

                    local agas = GetMobByID(boyahdaID.mob.AGAS)
                    if not agas then
                        return
                    end

                    if agas:isSpawned() then
                        return
                    end

                    local progress = quest:getVar(player, 'Prog')

                    if progress == 4 then
                        return quest:progressEvent(14) -- Agas defeated, obtain the Moondrop
                    elseif progress == 3 then
                        SpawnMob(boyahdaID.mob.AGAS):updateClaim(player) -- Spawn Agas
                        return quest:messageSpecial(boyahdaID.text.SOMETHING_NOT_RIGHT):replaceDefault()
                    end
                end,
            },

            ['Agas'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if quest:getVar(player, 'Prog') == 3 then
                        quest:setVar(player, 'Prog', 4)
                    end
                end,
            },

            onEventFinish =
            {
                [14] = function(player, csid, option, npc)
                    if
                        option == 0 and
                        npcUtil.giveKeyItem(player, xi.ki.MOONDROP)
                    then
                        quest:setVar(player, 'Prog', 5)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Kurou-Morou'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Post') == 1 then
                        return quest:progressEvent(154) -- Kurou-Morou confesses to Chululu
                    else
                        return quest:event(37) -- 'So, do you think she understood how I feel?'
                    end
                end,
            },

            ['Chululu'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Post') == 0 then
                        return quest:event(56) -- 'Boy, was I surprised when he told me he...'
                    end
                end,
            },

            onEventFinish =
            {
                [154] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:setVar(player, 'Post', 0)
                    end
                end,
            },
        },

        [xi.zone.UPPER_JEUNO] =
        {
            ['Ilumida'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Post') == 0 then
                        return quest:event(196):replaceDefault() -- 'Our little friend was able to express his feelings?'
                    else
                        return quest:event(200):replaceDefault() -- 'Thank you again for all of your help.'
                    end
                end,
            },
        },
    },
}

return quest
