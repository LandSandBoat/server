-----------------------------------
-- Get the Picture
-----------------------------------
-- Log ID: 6, Quest ID: 4
-- Balakaf                                                                                    !pos 25.505 -5.999 126.478 50
-- Wajaom qm7   | Picture 1   | Light Crystal | Scene 1 | Time: Any         Weather: Clouds | !pos -450.597 -26.218 414.071 51
-- Arrapago qm5 | Picture 2   | Light Crystal | Scene 2 | Time: Any         Weather: Snow   | !pos 326.021 -0.711 244.903 54
-- Arrapago qm5 | Picture 3   | Light Cluster | Scene 2 | Time: Any         Weather: Snow   | !pos 326.021 -0.711 244.903 54
-- Zhayolm qm11 | Picture 4   | Light Crystal | Scene 3 | Time: 16:00-20:00 Weather: Any    | !pos -608.573 -10.474 -183.494 61
-- Halvung qm5  | Picture 5   | Light Crystal | Scene 1 | Time: 4:00-10:00  Weather: Any    | !pos 103.016 13.999 20.867 62
-- Aydeewa qm4  | Picture 6   | Light Cluster | Scene 3 | Time: Any         Weather: Wind   | !pos -376.456 13.001 -424.754 68
-- Mamook qm3   | Picture 7   | Light Crystal | Scene 3 | Time: 7:00-11:00  Weather: Clear  | !pos -184.948 12.547 -184.718 65
-- Caedarva qm5 | Picture 8   | Light Cluster | Scene 1 | Time: 20:00-4:00  Weather: Any    | !pos -389.084 6.343 -597.228 79
-----------------------------------
local quest = Quest:new(xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.GET_THE_PICTURE)

quest.reward =
{
    item  = xi.item.IMPERIAL_SILVER_PIECE,
    title = xi.title.SCENIC_SNAPSHOTTER,
}

local pictureLocations =
{
    [0] = -- Picture 1: The volcano seen from Wajaom Woodlands during cloudy weather taken with a light crystal.
    {
        zone               = xi.zone.WAJAOM_WOODLANDS,
        sceneIndex         = 1,
        triggerEvent       = 505,
        tradeEvent         = 503,
        badConditionsEvent = 506,
        acceptedItems      = { [xi.item.LIGHT_CRYSTAL] = { correctChoice = 1 }, [xi.item.AURORA_CRYSTAL] = { underexposed = true } },
        validWeather       = { xi.weather.CLOUDS },
        goldLocation       = true,
    },

    [1] = -- Picture 2: The Lovers' Rocks in Arrapago Reef during snowy weather taken with a light crystal.
    {
        zone               = xi.zone.ARRAPAGO_REEF,
        sceneIndex         = 2,
        triggerEvent       = 209,
        tradeEvent         = 208,
        badConditionsEvent = 210,
        acceptedItems      = { [xi.item.LIGHT_CRYSTAL] = { correctChoice = 2 } },
        validWeather       = { xi.weather.SNOW, xi.weather.BLIZZARDS },
        goldLocation       = true,
    },

    [2] = -- Picture 3: The Lovers' Rocks again in Arrapago Reef, retaken with a light cluster during snowy weather.
    {
        zone               = xi.zone.ARRAPAGO_REEF,
        sceneIndex         = 2,
        triggerEvent       = 209,
        tradeEvent         = 208,
        badConditionsEvent = 210,
        acceptedItems      = { [xi.item.LIGHT_CLUSTER] = { correctChoice = 2, eventPhotoCodes = { [2] = 4 } } },
        validWeather       = { xi.weather.SNOW, xi.weather.BLIZZARDS },
    },

    [3] = -- Picture 4: The ruins seen from Mount Zhayolm between 16:00 and 20:00 taken with a light crystal.
    {
        zone               = xi.zone.MOUNT_ZHAYOLM,
        sceneIndex         = 3,
        triggerEvent       = 151,
        tradeEvent         = 150,
        badConditionsEvent = 152,
        acceptedItems      = { [xi.item.LIGHT_CRYSTAL] = { correctChoice = 3 }, [xi.item.AURORA_CRYSTAL] = { underexposed = true }, [xi.item.LIGHT_CLUSTER] = { eventPhotoCode = 4 } },
        validHours         = { 16, 20 },
    },

    [4] = -- Picture 5: The lava flows of Halvung between 4:00 and 10:00 taken with a light crystal.
    {
        zone               = xi.zone.HALVUNG,
        sceneIndex         = 4,
        triggerEvent       = 208,
        tradeEvent         = 2,
        badConditionsEvent = 209,
        acceptedItems      = { [xi.item.LIGHT_CRYSTAL] = { correctChoice = 1 }, [xi.item.AURORA_CRYSTAL] = { underexposed = true }, [xi.item.LIGHT_CLUSTER] = { eventPhotoCode = 4 } },
        validHours         = { 4, 10 },
        goldLocation       = true,
    },

    [5] = -- Picture 6: The wind-swept ruins in Aydeewa Subterrane during windy weather taken with a light cluster.
    {
        zone               = xi.zone.AYDEEWA_SUBTERRANE,
        sceneIndex         = 5,
        triggerEvent       = 5,
        tradeEvent         = 2,
        badConditionsEvent = 6,
        acceptedItems      = { [xi.item.LIGHT_CRYSTAL] = { underexposed = true }, [xi.item.AURORA_CRYSTAL] = { underexposed = true }, [xi.item.LIGHT_CLUSTER] = { correctChoice = 3 } },
        validWeather       = { xi.weather.WIND, xi.weather.GALES },
        goldLocation       = true,
    },

    [6] = -- Picture 7: The waterfall in Mamook between 7:00 and 11:00 with clear weather taken with a light crystal.
    {
        zone               = xi.zone.MAMOOK,
        sceneIndex         = 6,
        triggerEvent       = 209,
        tradeEvent         = 208,
        badConditionsEvent = 210,
        acceptedItems      = { [xi.item.LIGHT_CRYSTAL] = { correctChoice = 3 }, [xi.item.AURORA_CRYSTAL] = { underexposed = true }, [xi.item.LIGHT_CLUSTER] = { eventPhotoCode = 4 } },
        validHours         = { 7, 11 },
        validWeather       = { xi.weather.NONE, xi.weather.SUNSHINE },
        goldLocation       = true,
    },

    [7] = -- Picture 8: The graveyard in Caedarva Mire between 20:00 and 4:00 taken with a light cluster.
    {
        zone               = xi.zone.CAEDARVA_MIRE,
        sceneIndex         = 7,
        triggerEvent       = 137,
        tradeEvent         = 136,
        badConditionsEvent = 138,
        acceptedItems      = { [xi.item.LIGHT_CRYSTAL] = { underexposed = true }, [xi.item.AURORA_CRYSTAL] = { underexposed = true }, [xi.item.LIGHT_CLUSTER] = { correctChoice = 1 } },
        validHours         = { 20, 4 },
        goldLocation       = true,
    },
}

local lightSources = {}
for _, picture in pairs(pictureLocations) do
    for itemId in pairs(picture.acceptedItems) do
        lightSources[itemId] = true
    end
end

-----------------------------------
-- Shared Helpers
-----------------------------------
local function canTakePicture(player, picture)
    if picture.validHours then
        local hour               = VanadielHour()
        local startHour, endHour = picture.validHours[1], picture.validHours[2]
        local withinHours

        if startHour < endHour then
            withinHours = hour >= startHour and hour < endHour
        else
            withinHours = hour >= startHour or hour < endHour
        end

        if not withinHours then
            return false
        end
    end

    return not picture.validWeather or utils.contains(player:getWeather(true), picture.validWeather)
end

local function getCurrentPictureRequest(player)
    local picture = pictureLocations[quest:getVar(player, 'Prog')]

    if
        picture and
        picture.zone == player:getZoneID()
    then
        return picture
    end

    return nil
end

-- Replaces the default trigger with "<Player> takes in the surrounding scenery. ...The view is breathtaking." if the player is on this QMs picture request.
local function pictureSpotOnTrigger(player, npc)
    local picture = getCurrentPictureRequest(player)

    if picture then
        return quest:event(picture.triggerEvent)
    end
end

local function pictureSpotOnTrade(player, npc, trade)
    local picture = getCurrentPictureRequest(player)

    if
        not picture or
        quest:getVar(player, 'PhotoChoice') > 0 or
        not player:hasKeyItem(xi.ki.IMAGE_RECORDER)
    then
        return
    end

    local lightSource = nil
    for itemId in pairs(lightSources) do
        if npcUtil.tradeMatches(trade, { { itemId, 1 } }) then
            lightSource = itemId
            break
        end
    end

    if not lightSource then
        return
    end

    if not canTakePicture(player, picture) then
        return quest:event(picture.badConditionsEvent)
    elseif picture.acceptedItems[lightSource] then
        quest:setVar(player, 'LightSource', lightSource)
        return quest:progressEvent(picture.tradeEvent)
    end
end

-- Picture menu finished, records the players choice of vista.
local function pictureMenuOnFinish(player, csid, option, npc)
    local picture     = getCurrentPictureRequest(player)
    local lightSource = quest:getVar(player, 'LightSource')

    if
        not picture or
        not picture.acceptedItems[lightSource] or
        option < 1 or
        option > 3
    then
        return
    end

    player:tradeComplete()
    quest:setVar(player, 'PhotoChoice', option)
end

local function goldSpotOnTrigger(player, npc)
    local zoneId = player:getZoneID()

    if
        quest:getVar(player, 'GoldSpot') ~= zoneId or
        quest:getVar(player, 'GoldWait') ~= 0
    then
        return
    end

    player:messageSpecial(zones[zoneId].text.YOU_SEE_SOMETHING_SHINY)

    if npcUtil.giveItem(player, xi.item.IMPERIAL_GOLD_PIECE) then
        quest:setVar(player, 'GoldSpot', 0)
    end

    return quest:noAction()
end

quest.sections =
{
    -- Section: Quest available
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Balakaf'] = quest:progressEvent(545),

            onEventFinish =
            {
                [545] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:begin(player)
                        npcUtil.giveKeyItem(player, xi.ki.IMAGE_RECORDER)
                    end
                end,
            },
        },
    },

    -- Section: Taking the eight pictures
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Balakaf'] =
            {
                onTrigger = function(player, npc)
                    local pictureRequested = pictureLocations[quest:getVar(player, 'Prog')]
                    local photoChoice      = quest:getVar(player, 'PhotoChoice')
                    local waiting          = quest:getVar(player, 'Wait') == 1 or quest:getMustZone(player)

                    -- A photo is on the recorder, Balakaf checks it and decides if it is a good photo.
                    if photoChoice > 0 then
                        local lightSource = pictureRequested.acceptedItems[quest:getVar(player, 'LightSource')]
                        if not lightSource then
                            return
                        end

                        local eventPhotoCode = lightSource.eventPhotoCode or
                            (lightSource.eventPhotoCodes and lightSource.eventPhotoCodes[photoChoice]) or
                            photoChoice

                        return quest:progressEvent(546, 0, eventPhotoCode, lightSource.underexposed and 1 or 0, 0, pictureRequested.sceneIndex)

                    -- A failed shot ruined the lens, Balakaf tells the player they need a Ahriman Lens to repair it.
                    elseif quest:getVar(player, 'LensNeeded') == 1 then
                        return quest:event(555)

                    -- The recorder is being rebuilt until the waiting period is over.
                    elseif waiting then
                        if quest:getVar(player, 'RepairingCamera') == 1 then
                            return quest:event(558)
                        else
                            return quest:event(556)
                        end

                    -- Wait over: hand the image recorder back with the commission.
                    elseif not player:hasKeyItem(xi.ki.IMAGE_RECORDER) then
                        return quest:progressEvent(554, 0, pictureRequested.sceneIndex)

                    -- Reminder text, alternates explaining how to take a picture (553) with the location of the current shot (586).
                    elseif quest:getVar(player, 'Cycle') == 0 then
                        return quest:event(553)
                    else
                        return quest:event(586, 0, 0, 0, 0, pictureRequested.sceneIndex)
                    end
                end,

                onTrade = function(player, npc, trade)
                    if
                        quest:getVar(player, 'LensNeeded') == 1 and
                        npcUtil.tradeMatches(trade, { { xi.item.AHRIMAN_LENS, 1 } })
                    then
                        return quest:progressEvent(557)
                    end
                end,
            },

            onEventFinish =
            {
                [546] = function(player, csid, option, npc)
                    local questProgress     = quest:getVar(player, 'Prog')
                    local pictureRequested  = pictureLocations[questProgress]
                    local choiceSelected    = quest:getVar(player, 'PhotoChoice')
                    local lightSourceUsed   = pictureRequested.acceptedItems[quest:getVar(player, 'LightSource')]

                    if
                        option == utils.EVENT_CANCELLED_OPTION or
                        choiceSelected == 0 or
                        not lightSourceUsed
                    then
                        return
                    end

                    if choiceSelected == lightSourceUsed.correctChoice then
                        -- If this is the eighth picture, complete the quest and start the post-completion gold coin section.
                        if questProgress == 7 then
                            if quest:complete(player) then
                                player:delKeyItem(xi.ki.IMAGE_RECORDER)
                                quest:setTimedVar(player, 'Wait', JstMidnight()) -- Player must wait until the next JST midnight to hear about the lost gold piece.
                                quest:setMustZone(player)
                                quest:setVar(player, 'Post', 2)
                            end

                        -- If this is not the eighth picture, award a silver piece set a JST midnight wait to accept the next request.
                        elseif npcUtil.giveItem(player, xi.item.IMPERIAL_SILVER_PIECE) then
                            player:delKeyItem(xi.ki.IMAGE_RECORDER)
                            quest:setVar(player, 'PhotoChoice', 0)
                            quest:setVar(player, 'LightSource', 0)
                            quest:setVar(player, 'Prog', questProgress + 1)
                            quest:setTimedVar(player, 'Wait', JstMidnight())
                            quest:setMustZone(player)
                        end
                    else
                        -- Picture is no good and the player needs to bring an Ahriman Lens to have the camera repaired.
                        player:delKeyItem(xi.ki.IMAGE_RECORDER)
                        quest:setVar(player, 'PhotoChoice', 0)
                        quest:setVar(player, 'LightSource', 0)
                        quest:setVar(player, 'LensNeeded', 1)
                    end
                end,

                -- Reminder event, tells the player how to take a picture.
                [553] = function(player, csid, option, npc)
                    quest:setVar(player, 'Cycle', 1)
                end,

                -- Camera is repaired, the player receives the image recorder back.
                [554] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.IMAGE_RECORDER)
                    quest:setVar(player, 'RepairingCamera', 0)
                end,

                -- Player trades an Ahriman Lens to have the camera repaired.
                [557] = function(player, csid, option, npc)
                    player:tradeComplete()
                    quest:setVar(player, 'LensNeeded', 0)
                    quest:setVar(player, 'RepairingCamera', 1)
                    quest:setTimedVar(player, 'Wait', JstMidnight())
                    quest:setMustZone(player)
                end,

                -- Reminder event, tells the player where to go to take the next picture.
                [586] = function(player, csid, option, npc)
                    quest:setVar(player, 'Cycle', 0)
                end,
            },
        },

        -- Picture 1: The volcano seen from Wajaom Woodlands during cloudy weather taken with a light crystal.
        [xi.zone.WAJAOM_WOODLANDS] =
        {
            ['qm7'] =
            {
                onTrigger = pictureSpotOnTrigger,
                onTrade   = pictureSpotOnTrade,
            },

            onEventFinish =
            {
                [503] = pictureMenuOnFinish,
            },
        },

        -- Pictures 2 and 3: The Lovers' Rocks in Arrapago Reef during snowy weather, taken first with a light crystal and retaken with a light cluster.
        [xi.zone.ARRAPAGO_REEF] =
        {
            ['qm5'] =
            {
                onTrigger = pictureSpotOnTrigger,
                onTrade   = pictureSpotOnTrade,
            },

            onEventFinish =
            {
                [208] = pictureMenuOnFinish,
            },
        },

        -- Picture 4: The ruins seen from Mount Zhayolm between 16:00 and 20:00 taken with a light crystal.
        [xi.zone.MOUNT_ZHAYOLM] =
        {
            ['qm11'] =
            {
                onTrigger = pictureSpotOnTrigger,
                onTrade   = pictureSpotOnTrade,
            },

            onEventFinish =
            {
                [150] = pictureMenuOnFinish,
            },
        },

        -- Picture 5: The lava flows of Halvung between 4:00 and 10:00 taken with a light crystal.
        [xi.zone.HALVUNG] =
        {
            ['qm5'] =
            {
                onTrigger = pictureSpotOnTrigger,
                onTrade   = pictureSpotOnTrade,
            },

            onEventFinish =
            {
                [2] = pictureMenuOnFinish,
            },
        },

        -- Picture 6: The wind-swept ruins in Aydeewa Subterrane during windy weather taken with a light cluster.
        [xi.zone.AYDEEWA_SUBTERRANE] =
        {
            ['qm4'] =
            {
                onTrigger = pictureSpotOnTrigger,
                onTrade   = pictureSpotOnTrade,
            },

            onEventFinish =
            {
                [2] = pictureMenuOnFinish,
            },
        },

        -- Picture 7: The waterfall in Mamook between 7:00 and 11:00 with clear weather taken with a light crystal.
        [xi.zone.MAMOOK] =
        {
            ['qm3'] =
            {
                onTrigger = pictureSpotOnTrigger,
                onTrade   = pictureSpotOnTrade,
            },

            onEventFinish =
            {
                [208] = pictureMenuOnFinish,
            },
        },

        -- Picture 8: The graveyard in Caedarva Mire between 20:00 and 4:00 taken with a light cluster.
        [xi.zone.CAEDARVA_MIRE] =
        {
            ['qm5'] =
            {
                onTrigger = pictureSpotOnTrigger,
                onTrade   = pictureSpotOnTrade,
            },

            onEventFinish =
            {
                [136] = pictureMenuOnFinish,
            },
        },
    },

    -- Section: Quest completed - the lost Imperial Gold Piece
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Balakaf'] =
            {
                onTrigger = function(player, npc)
                    if
                        quest:getVar(player, 'Wait') == 0 and
                        not quest:getMustZone(player) and
                        quest:getVar(player, 'Post') > 0
                    then
                        return quest:event(560)
                    end

                    return quest:event(559)
                end,

                onTrade = function(player, npc, trade)
                    if
                        quest:getVar(player, 'Post') == 1 and
                        quest:getVar(player, 'GoldSpot') == 0 and
                        npcUtil.tradeMatches(trade, { { xi.item.IMPERIAL_GOLD_PIECE, 1 } })
                    then
                        return quest:progressEvent(561)
                    end
                end,
            },

            onEventFinish =
            {
                [560] = function(player, csid, option, npc)
                    if quest:getVar(player, 'Post') ~= 2 then
                        return
                    end

                    local goldLocations = {}
                    for pictureIndex = 0, #pictureLocations do
                        if pictureLocations[pictureIndex].goldLocation then
                            table.insert(goldLocations, pictureLocations[pictureIndex])
                        end
                    end

                    quest:setVar(player, 'GoldSpot', utils.randomEntry(goldLocations).zone)
                    quest:setTimedVar(player, 'GoldWait', JstMidnight())
                    quest:setVar(player, 'Post', 1)
                end,

                [561] = function(player, csid, option, npc)
                    quest:setVar(player, 'Post', 0)
                end,
            },
        },

        [xi.zone.WAJAOM_WOODLANDS] =
        {
            ['qm7'] = { onTrigger = goldSpotOnTrigger },
        },

        [xi.zone.ARRAPAGO_REEF] =
        {
            ['qm5'] = { onTrigger = goldSpotOnTrigger },
        },

        [xi.zone.HALVUNG] =
        {
            ['qm5'] = { onTrigger = goldSpotOnTrigger },
        },

        [xi.zone.AYDEEWA_SUBTERRANE] =
        {
            ['qm4'] = { onTrigger = goldSpotOnTrigger },
        },

        [xi.zone.MAMOOK] =
        {
            ['qm3'] = { onTrigger = goldSpotOnTrigger },
        },

        [xi.zone.CAEDARVA_MIRE] =
        {
            ['qm5'] = { onTrigger = goldSpotOnTrigger },
        },
    },
}

return quest
