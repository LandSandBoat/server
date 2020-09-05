-----------------------------------
-- Area:  Misareaux Coast
--  NPC: Dilapidated Gate
--  Notes: Entrance to Misareaux Coast
-----------------------------------
require("scripts/globals/missions")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(553)
    return 1
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)


end
