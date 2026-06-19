-----------------------------------
-- Instance: Silver Sea Remnants
-----------------------------------
local ID = zones[xi.zone.SILVER_SEA_REMNANTS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(300)
end

entity.onEventFinish = function(player, csid, option, door)
    if csid == 300 and option == 1 then
        local instance = door:getInstance()
        if not instance then
            return
        end

        door:setAnimation(xi.animation.OPEN_DOOR)
        for id = ID.mob[1][2].mobs_start, ID.mob[1][2].mobs_end do
            SpawnMob(id, instance)
        end

        instance:setProgress(2)
        local door2 = GetNPCByID(ID.npc[1][2].DOOR3, instance)
        if door2 then
            door2:setUntargetable(true)
        end

        door:setUntargetable(true)
    end
end

return entity
