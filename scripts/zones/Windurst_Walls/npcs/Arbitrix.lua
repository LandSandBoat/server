-----------------------------------
-- Area: Windurst Woods
--  NPC: Arbitrix
-- Gobbie Mystery Box
-- !pos -215.5 0.0 -147.3
-----------------------------------
local ID = require("scripts/zones/Windurst_Walls/IDs")
require("scripts/globals/settings")
-----------------------------------

function onTrigger(player, npc)
    local playerAgeDays = (os.time() - player:getTimeCreated()) / 86400

    local dailyTallyPoints = player:getCurrency("daily_tally")
    local firstVisit = dailyTallyPoints == -1

    local gobbieBoxUsed = player:getCharVar("gobbieBoxUsed")
    local specialDialUsed = 1
    local adoulinDialUsed = 1
    local pictlogicaDialUsed = 1
    local wantedDialUsed = 1

    local adoulinOptionOff = 0x80
    local pictlogicaOptionOff = 0x100
    local wantedOptionOff = 0x1000
    local hideOptionFlags = adoulinOptionOff + pictlogicaOptionOff + wantedOptionOff

    if playerAgeDays >= GOBBIE_BOX_MIN_AGE and firstVisit then
        player:startEvent(519)
    elseif playerAgeDays >= GOBBIE_BOX_MIN_AGE then
        player:startEvent(520, specialDialUsed, adoulinDialUsed, pictlogicaDialUsed, wantedDialUsed, 0, 0, hideOptionFlags, dailyTallyPoints)
    else
        player:messageSpecial(ID.text.YOU_MUST_WAIT_ANOTHER_N_DAYS, GOBBIE_BOX_MIN_AGE - playerAgeDays)
    end
end

function onEventUpdate(player, csid, option)
    local dailyTallyPoints = player:getCurrency("daily_tally")

    if csid == 520 and option == 4 then -- Peek items
        player:updateEvent(200, 200, 200)
    elseif csid == 520 and option == 9 then
        player:updateEvent(1, 1, (dailyTallyPoints >= 10) or 1)
    elseif csid == 520 and option == 10 then
        -- Deliver Dial 1
    end
end

function onEventFinish(player, csid, option)
    if csid == 519 then
        player:setCurrency("daily_tally", 50)
    end
end
