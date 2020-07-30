local ID = require("scripts/zones/Arrapago_Remnants/IDs")
require("scripts/globals/status")

function onTrigger(entity, npc)
    entity:startEvent(300)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(entity, eventid, result, door)
    if (eventid == 300 and result == 1) then
        door:setAnimation(8)
        local instance = door:getInstance()
        -- spawn mobs, etc
        for i, v in pairs(ID.npc[1][2]) do
            local npc = instance:getEntity(bit.band(v, 0xFFF), tpz.objType.NPC)
            npc:setStatus(tpz.status.NORMAL)
        end
        for id = ID.mob[1][2].mobs_start, ID.mob[1][2].mobs_end do
            SpawnMob(id, instance)
        end
        door:untargetable(true)
    end
end
