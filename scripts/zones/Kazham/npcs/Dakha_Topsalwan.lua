-----------------------------------
-- Area: Kazham
--  NPC: Dakha Topsalwan
-- !zone 250
-----------------------------------
require("scripts/globals/settings")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    Z = player:getZPos()

    if (Z >= -20 and Z <= -16) then
        player:startEvent(66)
    else
        player:startEvent(121)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
