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
        for id = ID.mob[1][3].mobs_start, ID.mob[1][3].mobs_end do
            SpawnMob(id, instance)
        end

        door:setUntargetable(true)
    end
end

return entity
