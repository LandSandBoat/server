-----------------------------------
-- Area: Castle Oztroja
--  NPC: _47c (Handle)
-- Notes: Opens Trap Door (_47a) or Brass Door (_470)
-- !pos 17.717 -1.087 -14.320 151
-----------------------------------
local ID = require("scripts/zones/Castle_Oztroja/IDs")
require("scripts/globals/missions")
require("scripts/globals/status")
-----------------------------------

function onTrigger(player, npc)
    local X = player:getXPos()
    local Z = player:getZPos()
    local trapDoor  = GetNPCByID(npc:getID() - 2)
    local brassDoor = GetNPCByID(npc:getID() - 3)

    if X < 21.6 and X > 18 and Z > -15.6 and Z < -12.4 then
        if VanadielDayOfTheYear() % 2 == 0 then
            if brassDoor:getAnimation() == tpz.anim.CLOSE_DOOR and npc:getAnimation() == tpz.anim.CLOSE_DOOR then
                npc:openDoor(8)
                -- wait 1 second delay goes here
                brassDoor:openDoor(6)
            end
        else
            if trapDoor:getAnimation() == tpz.anim.CLOSE_DOOR and npc:getAnimation() == tpz.anim.CLOSE_DOOR then
                npc:openDoor(8)
                -- wait 1 second delay goes here
                trapDoor:openDoor(6)
            end
            if player:getCurrentMission(WINDURST) == tpz.mission.id.windurst.TO_EACH_HIS_OWN_RIGHT and player:getCharVar("MissionStatus") == 3 then
                player:startEvent(43)
            end
        end
    else
        player:messageSpecial(ID.text.CANNOT_REACH_TARGET)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 43 then
        player:setCharVar("MissionStatus", 4)
    end
end
