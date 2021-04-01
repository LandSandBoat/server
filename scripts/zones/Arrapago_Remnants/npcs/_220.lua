local ID = require("scripts/zones/Arrapago_Remnants/IDs")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onTrigger = function(entity, npc)
    entity:startEvent(300)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(entity, eventid, result, door)
    if (eventid == 300 and result == 1) then
        door:setAnimation(8)
        local instance = door:getInstance()
        -- spawn mobs, etc
        for i, v in pairs(ID.npc[1][2]) do
            local npc = GetNPCByID(v, instance)
            npc:setStatus(xi.status.NORMAL)
        end
        for id = ID.mob[1][2].mobs_start, ID.mob[1][2].mobs_end do
            SpawnMob(id, instance)
        end
        door:untargetable(true)
    end
end

return entity
