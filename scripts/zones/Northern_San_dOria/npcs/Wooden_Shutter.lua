-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Door : Wooden Shutter
-- Working 100%
-----------------------------------
require("scripts/globals/settings")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(5)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if option == 1 then
        player:setPos(-480, -5.65, 669, 70, 2)
    end
end
