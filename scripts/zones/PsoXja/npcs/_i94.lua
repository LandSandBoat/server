-----------------------------------
-- Area: Pso'Xja
--  NPC: _i94 (Stone Gate)
-- Notes: Blue Bracelet Door
-- !pos -330.000 14.074 -261.600 9
-----------------------------------
local ID = require("scripts/zones/PsoXja/IDs")
require("scripts/globals/keyitems")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    local Z=player:getZPos()

    if (Z >= -261) then
        if (player:hasKeyItem(tpz.ki.BLUE_BRACELET) == true) then -- Blue Bracelet
            player:startEvent(61)
        else
            player:messageSpecial(ID.text.ARCH_GLOW_BLUE)
        end
    elseif (Z <= -262) then
        player:messageSpecial(ID.text.CANNOT_OPEN_SIDE)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option, npc)
end
