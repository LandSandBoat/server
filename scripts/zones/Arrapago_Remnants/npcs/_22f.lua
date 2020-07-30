
local ID = require("scripts/zones/Arrapago_Remnants/IDs")

function onTrigger(entity, npc)
    if (npc:getInstance():getStage() == 6) and (npc:getInstance():getProgress() >= 11) then
        entity:startEvent(300)
    else
        entity:messageSpecial(ID.text.DOOR_IS_SEALED)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(entity, eventid, result, door)
    if (eventid == 300 and result == 1) then
        local instance = door:getInstance()
        instance:setStage(7)
        instance:setProgress(0)
        SpawnMob(ID.mob[6].rampart3, instance)
        SpawnMob(ID.mob[6].rampart4, instance)
        door:setAnimation(8)
        door:untargetable(true)
    end
end
