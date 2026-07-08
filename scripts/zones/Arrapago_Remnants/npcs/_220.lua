local ID = zones[xi.zone.ARRAPAGO_REMNANTS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(300)
end

entity.onEventFinish = function(player, csid, option, door)
    if csid == 300 and option == 1 then
        door:setAnimation(8)

        local instance = door:getInstance()
        if not instance then
            return
        end

        -- spawn mobs, etc
        for _, v in pairs(ID.npc[1][2]) do
            local npc = GetNPCByID(v, instance)

            if npc then
                npc:setStatus(xi.status.NORMAL)
            end
        end

        for id = ID.mob[1][2].mobs_start, ID.mob[1][2].mobs_end do
            SpawnMob(id, instance)
        end

        door:setUntargetable(true)
    end
end

return entity
