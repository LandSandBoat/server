-----------------------------------
-- Area: Ship_bound_for_Mhaura
--  NPC: Sahn
-- Notes: Tells ship ETA time
-- !pos 0.278 -14.707 -1.411 221
-----------------------------------
local ID = require("scripts/zones/Ship_bound_for_Mhaura/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local vHour = VanadielHour()
    local vMin  = VanadielMinute()

    while vHour >= 6 do
        vHour = vHour - 8
    end

    vHour = vHour - (vHour - 3) * 2

    if vHour == 8 and vMin <= 40 then
        vHour = 0
    end

    local vMinutes = (vHour * 60) + 40 - vMin

    vHour = math.floor(vMinutes / 60 + 0.5)

    local message = ID.text.ON_WAY_TO_MHAURA

    if vMinutes <= 30 then
        message = ID.text.ARRIVING_SOON_MHAURA
    elseif vMinutes < 60 then
        vHour = 0
    end

    if vHour > 7 then -- Normal players can't be on the boat longer than 7 Vanadiel hours. This is for GMs.
        vHour = 7
    end

    player:messageSpecial(message, math.abs(math.floor((2.4 * ((vHour * 60) + 40 - vMin)) / 60)), vHour)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
