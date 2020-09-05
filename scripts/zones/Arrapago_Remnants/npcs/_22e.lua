
local ID = require("scripts/zones/Arrapago_Remnants/IDs")

function onTrigger(entity, npc)
    if (npc:getInstance():getStage() == 5) then
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
        instance:setStage(6)
        instance:setProgress(2)
        door:setAnimation(8)
        SpawnMob(ID.mob[5][1].chariot, instance)
        SpawnMob(ID.mob[5][1].astrologer, instance)
        for i, v in pairs(ID.npc[5][1]) do
            local npc = instance:getEntity(bit.band(v, 0xFFF), tpz.objType.NPC)
            npc:untargetable(true)
        end
    end
end
