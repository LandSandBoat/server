-----------------------------------
-- Area: Western Altepa Desert
--  NPC: _3h0 (Altepa Gate)
-- !pos -19 12 131 125
-----------------------------------
local ID = require("scripts/zones/Western_Altepa_Desert/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if npc:getAnimation() == tpz.anim.CLOSE_DOOR then
        if player:getZPos() > 137 then
            npc:openDoor(3.2)
        else
            player:messageSpecial(ID.text.THE_DOOR_IS_LOCKED)
        end
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
