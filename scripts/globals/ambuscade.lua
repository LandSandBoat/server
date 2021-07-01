-----------------------------------
-- Ambuscade
-----------------------------------
-- Ambuscade_Tome : !pos -28.030 -15.500 52.279 249
-- Gorpa-Masorpa  : !pos -27.584 -15.990 52.565 249
-----------------------------------
require("scripts/globals/utils")
local mhauraID = require("scripts/zones/Mhaura/IDs")
local maquetteID = require("scripts/zones/Maquette_Abdhaljs-Legion_B/IDs")
-----------------------------------
xi = xi or {}
xi.ambuscade = {}

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
        -- Regular menu
        player:startEvent(386, 1, 0, 0, 29334, 8, 0, 0, 0)
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

xi.ambuscade.onEventUpdateGorpaMasorpa = function(player, csid, option)
end

xi.ambuscade.onEventFinishGorpaMasorpa = function(player, csid, option)
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
    local currentPage = 735

    -- Register
    --player:startEvent(374, 10, 119, 109, currentPage, 5, 0, 0, 0)

    -- Enter
    --player:startEvent(378)
end

xi.ambuscade.onEventUpdateTome = function(player, csid, option)
    if csid == 374 and option == 10 then
        player:updateEvent(10, 249, 255, 736, 67108863, 32424508, 4095, 0)
    end
end

xi.ambuscade.onEventFinishTome = function(player, csid, option)
    if csid == 378 and option == 1 then
        -- Enter
    end
end
