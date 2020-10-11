-----------------------------------
-- Area: East Sarutabaruta
--  NPC: Signpost
-----------------------------------
local ID = require("scripts/zones/East_Sarutabaruta/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    local X = player:getXPos()
    local Z = player:getZPos()

    if ((X > 83.9 and X < 96.7) and (Z < -339.8 and Z > -352.6)) then
        player:messageSpecial(ID.text.SIGNPOST_OFFSET)
    elseif ((X > 191.5 and X < 204.3) and (Z < -265.03 and Z > -277.13)) then
        player:messageSpecial(ID.text.SIGNPOST_OFFSET+1)
    elseif ((X > 212.9 and X < 225) and (Z < -24.8 and Z > -37.7)) then
        player:messageSpecial(ID.text.SIGNPOST_OFFSET+2)
    elseif ((X > -0.4 and X < 12.6) and (Z < -42.9 and Z > -54.9)) then
        player:messageSpecial(ID.text.SIGNPOST_OFFSET+3)
    elseif ((X > -135.3 and X < -122.3) and (Z < -55.04 and Z > -67.14)) then
        player:messageSpecial(ID.text.SIGNPOST_OFFSET+4)
    elseif ((X > -80.5 and X < -67.4) and (Z < 454.8 and Z > 442.7)) then
        player:messageSpecial(ID.text.SIGNPOST_OFFSET+5)
    elseif ((X > 144.1 and X < 157.1) and (Z < 386.7 and Z > 374.6)) then
        player:messageSpecial(ID.text.SIGNPOST_OFFSET+6)
    elseif ((X > -94.9 and X < -82.9) and (Z < -279.5 and Z > -292.4)) then
        player:messageSpecial(ID.text.SIGNPOST_OFFSET+7)
    elseif ((X > -55.8 and X < -43.8) and (Z < -120.5 and Z > -133.5)) then
        player:messageSpecial(ID.text.SIGNPOST_OFFSET+8)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
