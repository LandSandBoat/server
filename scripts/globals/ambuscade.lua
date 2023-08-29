-----------------------------------
-- Ambuscade
-----------------------------------
-- Ambuscade_Tome : !pos -28.030 -15.500 52.279 249
-- Gorpa-Masorpa  : !pos -27.584 -15.990 52.565 249
-----------------------------------
require('scripts/globals/utils')
-- local mhauraID = require('scripts/zones/Mhaura/IDs')
-- local maquetteID = zones[xi.zone.MAQUETTE_ABDHALJS_LEGION_B]
-----------------------------------
xi = xi or {}
xi.ambuscade = {}

local startingIntenseDifficulty = 119
local startingRegularDifficulty = 109

-- Tables organised by difficulty (VE, E, N, D, VD)
local intenseHallmarks = { 200, 600, 1200, 2400, 3600 }
-- local regularHallmarks = { 100, 150,  200,  250,  300 }

-- Gallantry is later multiplied by the size of your party
local intenseGallantry = { 20, 80, 180, 240, 300 }
-- local regularGallantry = { 10, 15,  20,  25,  30 }

-----------------------------------
-- Gorpa-Masorpa
-----------------------------------
xi.ambuscade.onTradeGorpaMasorpa = function(player, npc, trade)
    if player:getEminenceCompleted(499) then
        -- TODO
    end
end

xi.ambuscade.onTriggerGorpaMasorpa = function(player, npc)
    -- RoE Record #499 - Stepping into an Ambuscade
    if player:getEminenceCompleted(499) then
        -- local hideRewards              = 1
        -- local hideAmbusade             = 2
        -- local hideNothingInParticular  = 4
        local mainMenuOptions = 0 -- Made up of above options

        local currentHallmarks = player:getCurrency('current_hallmarks')
        local totalHallmarks = player:getCurrency('total_hallmarks')
        local gallantry = player:getCurrency('gallantry')

        -- Regular menu
        player:startEvent(386, mainMenuOptions, currentHallmarks, totalHallmarks, 0, 8, gallantry, 0, 0)
    else
        if player:getEminenceProgress(499) then
            -- Intro CS
            player:startEvent(385)
        else
            -- Reminder to set RoE
            player:startEvent(384)
        end
    end
end

xi.ambuscade.onEventUpdateGorpaMasorpa = function(player, csid, option, npc)
    if csid == 386 then
        -- Present Hallmarks menu
        if option == 1 then
            player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0)
        -- ?
        elseif option == 2 then
            player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0)
        -- Present Total Hallmarks menu
        elseif option == 5 then
            player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0)
        -- Update Hallmarks and Total Hallmarks menu
        elseif option == 6 then
            player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0)
        -- Present Gallantry menu
        elseif option == 9 then
            player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0)
        -- Update Gallantry menu
        elseif option == 10 then
            player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0)
        -- Update player
        else
            player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0)
        end
    end
end

xi.ambuscade.onEventFinishGorpaMasorpa = function(player, csid, option, npc)
    if csid == 385 then
        xi.roe.onRecordTrigger(player, 499)
    end
end

-----------------------------------
-- Ambuscade Tome
-----------------------------------
xi.ambuscade.onTradeTome = function(player, npc, trade)
end

xi.ambuscade.onTriggerTome = function(player, npc)
    -- local hideNoAmbuscadeForNow = 1
    -- local hideIntenseAmbuscade = not player:hasKeyItem(xi.ki.AMBUSCADE_PRIMER_VOLUME_ONE) and 2 or 0
    -- local hideRegularAmbuscade = not player:hasKeyItem(xi.ki.AMBUSCADE_PRIMER_VOLUME_TWO) and 4 or 0
    -- local hideLightAmbuscade = 8
    -- local hideToggleAutoTransport = 16

    -- NOTE: Hard coded for now
    local menuOptions = 4 + 8

    local currentPage = 735
    local arg5 = 5
    local arg6 = 0
    local arg7 = 0
    local arg8 = 0

    -- Register
    player:startEvent(374, menuOptions, startingIntenseDifficulty, startingRegularDifficulty, currentPage, arg5, arg6, arg7, arg8)

    -- Enter
    --player:startEvent(378)
end

xi.ambuscade.onEventUpdateTome = function(player, csid, option, npc)
    -- Options
    -- Intense VD : 1
    -- Intense D  : 2
    -- Intense N  : 3
    -- Intense E  : 4
    -- Intense VE : 5
    -- Regular VD : 6
    -- Regular D  : 7
    -- Regular N  : 8
    -- Regular E  : 9
    -- Regular VE : 10
    -- Light      : 11
    if csid == 374 then
        --TODO
    end
end

xi.ambuscade.onEventFinishTome = function(player, csid, option, npc)
    if csid == 374 and option == 5 then
        player:createInstance(30000)
    elseif csid == 378 then
        -- TODO
    end
end

-----------------------------------
-- Ambuscade Tome
-----------------------------------
xi.ambuscade.onInstanceComplete = function(instance)
    local chars    = instance:getChars()
    local numChars = #chars
    local difficulty = 1 -- TODO
    --local version = 1 -- 1: Intense, 2: Regular -- TODO
    for _, player in pairs(chars) do
        -- Hallmarks -- TODO: Message
        local hallmarksEarned = intenseHallmarks[difficulty] * numChars
        player:addCurrency('current_hallmarks', hallmarksEarned)

        -- Total Hallmarks -- TODO: Message
        player:addCurrency('total_hallmarks', hallmarksEarned)

        -- Gallantry -- TODO: Message
        if numChars > 1 then
            local multiplier = numChars - 1
            player:addCurrency('gallantry', intenseGallantry[difficulty] * multiplier)
        end

        -- Remove KI
        -- TODO: Message
        if difficulty == 1 then
            player:delKeyItem(xi.ki.AMBUSCADE_PRIMER_VOLUME_ONE)
        elseif difficulty == 2 then
            player:delKeyItem(xi.ki.AMBUSCADE_PRIMER_VOLUME_TWO)
        end

        -- TODO: Remove Abdhaljs Seal
        --v:delStatusEffect(xi.effect.ABDHALJS_SEAL)

        -- Exit event
        player:startEvent(10001)
    end
end

xi.ambuscade.onInstanceFailure = function(instance)
    local chars = instance:getChars()
    for _, player in pairs(chars) do
        player:startEvent(10001)
    end
end
