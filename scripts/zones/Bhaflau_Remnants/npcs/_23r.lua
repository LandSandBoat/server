-----------------------------------
-- NPC: Door
-- Area: Bhaflau Remnants
-- 3rd Floor South Central Entry
-- !pos -340 0 -440, 17084916
-----------------------------------
local ID = zones[xi.zone.BHAFLAU_REMNANTS]
-----------------------------------

---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if npc:getLocalVar('unSealed') == 1 then
        player:startEvent(300)
    else
        player:messageSpecial(ID.text.DOOR_IS_SEALED)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 300 and option == 1 then
        local instance = npc:getInstance()

        if instance and xi.salvage.onDoorOpen(npc) then
            xi.salvage.unsealDoors(instance, { ID.npc.DOOR_3_EAST_EXIT, ID.npc.DOOR_3_WEST_EXIT })
            local mobs =
            {
                utils.slice(ID.mob.ARCHAIC_GEARS, 1, 2),
                utils.slice(ID.mob.ARCHAIC_GEAR, 1, 16),
            }
            xi.salvage.spawnGroup(instance, mobs)
            GetNPCByID(ID.npc.SLOT, instance):setStatus(xi.status.NORMAL)
        else
            player:messageSpecial(ID.text.DOOR_IS_SEALED)
        end
    end
end

return entity
