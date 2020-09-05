-----------------------------------
-- Area: Metalworks
-- Door: _6lg (Cornelia's Room)
-- !pos 114 -20 -7 237
-----------------------------------
require("scripts/globals/missions")
local ID = require("scripts/zones/Metalworks/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    if (player:hasCompletedMission(BASTOK, tpz.mission.id.bastok.ON_MY_WAY) and player:getCharVar("[B7-2]Cornelia") == 0) then
        player:startEvent(622)
    else
        player:messageSpecial(ID.text.ITS_LOCKED)
    end

    return 1
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 622) then
        player:setCharVar("[B7-2]Cornelia", 1)
    end

end
