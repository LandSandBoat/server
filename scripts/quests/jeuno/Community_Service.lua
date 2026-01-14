-----------------------------------
-- Community Service
-----------------------------------
-- Log ID: 3, Quest ID: 15
-----------------------------------
local ID = zones[xi.zone.LOWER_JEUNO]
-----------------------------------

local quest = Quest:new(xi.questLog.JEUNO, xi.quest.id.jeuno.COMMUNITY_SERVICE)

quest.reward =
{
    fame = 30,
    fameArea = xi.fameArea.JEUNO,
    title = xi.title.TORCHBEARER,
}

-- Lights the lamps
local lightLamp = function(npc, option, player, questObj, zone)
    local remaining = questObj:getVar(player, 'Count')

    if option == 1 then
        npc:setAnimation(xi.anim.OPEN_DOOR)
        questObj:setVar(player, 'Count', remaining - 1)
        if remaining == 0 then
            player:messageSpecial(ID.text.YOU_LIGHT_THE_LAMP)
            player:messageSpecial(ID.text.LAMP_MSG_OFFSET)
            questObj:setVar(player, 'Prog', 2)
            zone:setLocalVar('allLightsLit', 1)
        else
            player:messageSpecial(ID.text.YOU_LIGHT_THE_LAMP)
            player:messageSpecial(ID.text.LAMP_MSG_OFFSET + 1, remaining)
        end
    end
end

-- Determines which parameter is passed when a player checks a light
local lampCs = function(npc, player, questObj)
    local hour         = VanadielHour()
    local date         = VanadielUniqueDay()
    local timer        = questObj:getVar(player, 'Timer')
    local npcAnimation = npc:getAnimation()

    if questObj:getVar(player, 'Prog') == 1 then
        if
            (timer == date and hour >= 18) or -- Same day flagged
            (timer + 1 == date and hour < 1)  -- Day after it was flagged
        then
            if npcAnimation == xi.anim.OPEN_DOOR then
                return 2 -- The lamp is already lit.
            elseif npcAnimation == xi.anim.CLOSE_DOOR then
                return 1 -- Light the lamp? Yes/No
            end
        elseif
            (timer + 1 < date) or
            (timer + 1 == date and hour >= 1)
        then
            return 3
        end
    elseif npcAnimation == xi.anim.OPEN_DOOR then
        return 5 -- The lamp is lit.
    else
        return 6 -- You examine the lamp. It seems that it must be lit manually
    end
end

-- Stores the player name to be called lader as a string
local encodeToVars = function(pName, zone)
    local stored = { 0, 0, 0, 0 }
    local chunk  = 1

    for i = 1, #pName, 4 do
        local v = 0

        for j = 1, 4 do
            local idx = i + j - 1
            local c = string.byte(pName, idx)
            if not c then
                break
            end

            v = bit.bor(v, bit.lshift(c, (j - 1) * 8))
        end

        stored[chunk] = v
        chunk = chunk + 1
        if chunk > 4 then
            break
        end
    end

    for i, v in ipairs(stored) do
        zone:setLocalVar('commServPlayer' .. i, v)
    end
end

-- Returns the stored player name and concats it together into a single string
local decodeFromVars = function(zone)
    local chars = {}

    for chunk = 1, 4 do
        local v = zone:getLocalVar('commServPlayer' .. chunk)
        if v == 0 then
            break
        end

        for j = 1, 4 do
            local c = bit.band(bit.rshift(v, (j - 1) * 8), 0xFF)
            if c == 0 then
                return table.concat(chars)
            end

            chars[#chars + 1] = string.char(c)
        end
    end

    return table.concat(chars)
end

quest.sections =
{
    {
        check = function(player, status, vars)
            return vars.Prog >= 0
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Zauko'] =
            {
                onTrigger = function(player, npc)
                    local date            = VanadielUniqueDay()
                    local doneCommService = (player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.COMMUNITY_SERVICE) == xi.questStatus.QUEST_COMPLETED) and 1 or 0
                    local hour            = VanadielHour()
                    local member          = player:hasKeyItem(xi.ki.LAMP_LIGHTERS_MEMBERSHIP_CARD) and 1 or 0
                    local progress        = quest:getVar(player, 'Prog')
                    local questCompleted  = npc:getLocalVar('commServiceComp') -- Either 1 or 0
                    local questStarted    = npc:getLocalVar('commServiceStart') -- Either 1 or 0
                    local timer           = quest:getVar(player, 'Timer')
                    local zone            = player:getZone()
                    local playerString    = decodeFromVars(zone)

                    if not zone then
                        return
                    end

                    if
                    -- Offers the quest
                        hour >= 18 and
                        hour < 23 and
                        questStarted == 0 -- Only 1 person per night can flag the quest
                    then
                        return quest:progressEvent(116, doneCommService)
                    elseif progress == 2 then
                        -- Completes the quest
                        return quest:progressEvent(117, doneCommService, member) -- 0 0 = First time, 1 0 Quest completed before and does not have KI., 1 1 Has completed quest and has KI
                    elseif
                    -- Player has the quest flagged and failed
                        progress == 1 and
                        ((timer + 1 == date and hour >= 1) or -- Day after quest flagged
                        (timer + 1 < date))  -- Day after it was flagged or later
                    then
                        return quest:progressEvent(119)
                    elseif progress == 1 then
                        -- Player is on the quest and has not failed/completed it yet
                        return quest:event(114)
                    elseif questCompleted == 1 then
                        -- Someone has completed the quest today and turned it in
                        if npc:getLocalVar('commServicePlayer') == player:getID() then
                            return quest:event(113)
                        else
                            return quest:event(113, { [0] = questCompleted, ['strings'] = { [0] = playerString } })
                        end
                    elseif zone:getLocalVar('allLightsLit') == 1 then
                        -- Another player is on the quest and has lit all the lamps but has not turned it in yet
                        return quest:event(113)
                    elseif
                        -- Asks a player with the KI if they would like to keep it. Only asks once per day.
                        hour >= 5 and
                        hour < 18 and
                        player:hasKeyItem(xi.ki.LAMP_LIGHTERS_MEMBERSHIP_CARD) and
                        quest:getVar(player, 'Wait') < VanadielUniqueDay()
                    then
                        return quest:event(118, 1)
                    end
                end,
            },

            ['_l00'] =
            {
                onTrigger = function(player, npc)
                    local lampVar = lampCs(npc, player, quest)

                    return quest:progressEvent(120, lampVar)
                end
            },

            ['_l01'] =
            {
                onTrigger = function(player, npc)
                    local lampVar = lampCs(npc, player, quest)

                    return quest:progressEvent(121, lampVar, 1)
                end
            },

            ['_l02'] =
            {
                onTrigger = function(player, npc)
                    local lampVar = lampCs(npc, player, quest)

                    return quest:progressEvent(122, lampVar, 2)
                end
            },

            ['_l03'] =
            {
                onTrigger = function(player, npc)
                    local lampVar = lampCs(npc, player, quest)

                    return quest:progressEvent(123, lampVar, 3)
                end
            },

            ['_l04'] =
            {
                onTrigger = function(player, npc)
                    local lampVar = lampCs(npc, player, quest)

                    return quest:progressEvent(124, lampVar, 4)
                end
            },

            ['_l05'] =
            {
                onTrigger = function(player, npc)
                    local lampVar = lampCs(npc, player, quest)

                    return quest:progressEvent(125, lampVar, 5)
                end
            },

            ['_l06'] =
            {
                onTrigger = function(player, npc)
                    local lampVar = lampCs(npc, player, quest)

                    return quest:progressEvent(126, lampVar, 6)
                end
            },

            ['_l07'] =
            {
                onTrigger = function(player, npc)
                    local lampVar = lampCs(npc, player, quest)

                    return quest:progressEvent(127, lampVar, 7)
                end
            },

            ['_l08'] =
            {
                onTrigger = function(player, npc)
                    local lampVar = lampCs(npc, player, quest)

                    return quest:progressEvent(128, lampVar, 8)
                end
            },

            ['_l09'] =
            {
                onTrigger = function(player, npc)
                    local lampVar = lampCs(npc, player, quest)

                    return quest:progressEvent(129, lampVar, 9)
                end
            },

            ['_l10'] =
            {
                onTrigger = function(player, npc)
                    local lampVar = lampCs(npc, player, quest)

                    return quest:progressEvent(130, lampVar, 10)
                end
            },

            ['_l11'] =
            {
                onTrigger = function(player, npc)
                    local lampVar = lampCs(npc, player, quest)

                    return quest:progressEvent(131, lampVar, 11)
                end
            },

            onEventUpdate =
            {
                [116] = function(player, csid, option, npc)
                    local hour            = VanadielHour()
                    local doneCommService = (player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.COMMUNITY_SERVICE) == xi.questStatus.QUEST_COMPLETED) and 1 or 0
                    local questStarted    = npc:getLocalVar('commServiceStart') -- Either 1 or 0
                    local zone            = player:getZone()

                    -- Verifies if no one has accepted the quest/time has changed to too late
                    if
                        hour >= 18 and
                        hour < 23 and
                        questStarted == 0
                    then
                        encodeToVars(player:getName(), zone)
                        npc:setLocalVar('commServiceStart', 1)
                        quest:begin(player)
                        quest:setVar(player, 'Prog', 1)
                        quest:setVar(player, 'Count', 11)
                        quest:setVar(player, 'Timer', VanadielUniqueDay())
                        player:updateEvent(1, doneCommService)
                    else
                        player:updateEvent(0, doneCommService) -- Someone else flagged this before they hit ok, or time ticked past the cut off.
                    end
                end,
            },

            onEventFinish =
            {
                [117] = function(player, csid, option, npc)
                    npc:setLocalVar('commServiceComp', 1)
                    npc:setLocalVar('commServicePlayer', player:getID())
                    quest:complete(player)
                    if option == 1 then
                        npcUtil.giveKeyItem(player, xi.ki.LAMP_LIGHTERS_MEMBERSHIP_CARD)
                    end
                end,

                [118] = function(player, csid, option, npc)
                    quest:setVar(player, 'Wait', VanadielUniqueDay())
                    if option == 1 then
                        player:delKeyItem(xi.ki.LAMP_LIGHTERS_MEMBERSHIP_CARD)
                        player:messageSpecial(ID.text.YOU_RETURN_THE, xi.ki.LAMP_LIGHTERS_MEMBERSHIP_CARD)
                    end
                end,

                [119] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 0)
                    player:setVar('Option', 0) -- Clears the local var incase the player never zones after failing
                end,

                [120] = function(player, csid, option, npc)
                    local zone = player:getZone()

                    lightLamp(npc, option, player, quest, zone)
                end,

                [121] = function(player, csid, option, npc)
                    local zone = player:getZone()

                    lightLamp(npc, option, player, quest, zone)
                end,

                [122] = function(player, csid, option, npc)
                    local zone = player:getZone()

                    lightLamp(npc, option, player, quest, zone)
                end,

                [123] = function(player, csid, option, npc)
                    local zone = player:getZone()

                    lightLamp(npc, option, player, quest, zone)
                end,

                [124] = function(player, csid, option, npc)
                    local zone = player:getZone()

                    lightLamp(npc, option, player, quest, zone)
                end,

                [125] = function(player, csid, option, npc)
                    local zone = player:getZone()

                    lightLamp(npc, option, player, quest, zone)
                end,

                [126] = function(player, csid, option, npc)
                    local zone = player:getZone()

                    lightLamp(npc, option, player, quest, zone)
                end,

                [127] = function(player, csid, option, npc)
                    local zone = player:getZone()

                    lightLamp(npc, option, player, quest, zone)
                end,

                [128] = function(player, csid, option, npc)
                    local zone = player:getZone()

                    lightLamp(npc, option, player, quest, zone)
                end,

                [129] = function(player, csid, option, npc)
                    local zone = player:getZone()

                    lightLamp(npc, option, player, quest, zone)
                end,

                [130] = function(player, csid, option, npc)
                    local zone = player:getZone()

                    lightLamp(npc, option, player, quest, zone)
                end,

                [131] = function(player, csid, option, npc)
                    local zone = player:getZone()

                    lightLamp(npc, option, player, quest, zone)
                end,
            },
        },
    },
}

return quest
