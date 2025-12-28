-----------------------------------
-- NPC: Door
-- Area: Bhaflau Remnants
-- 2nd Floor 1st Door opens West Wing, locks East Wing
-- !pos 280 -6 260
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

        if instance and xi.salvage.onDoorOpen(npc, nil, 2) then
            xi.salvage.sealDoors(instance, ID.npc.DOOR_2_EAST_ENTRANCE)
            xi.salvage.unsealDoors(instance, { ID.npc.DOOR_2_SW_ENTRANCE, ID.npc.DOOR_2_NW_ENTRANCE })
            local mobs =
            {
                utils.slice(ID.mob.WANDERING_WAMOURA, 4, 12),
                utils.slice(ID.mob.TROLL_ENGRAVER, 1, 3),
                utils.slice(ID.mob.TROLL_IRONWORKER, 6, 8),
            }
            xi.salvage.spawnGroup(instance, mobs)

            if math.random(100) >= 50 then
                GetNPCByID(ID.npc.SOCKET, instance):setPos(222, 0, 260)
                GetMobByID(ID.mob.FLUX_FLAN, instance):setSpawn(225, -0.5, 260, 0)
                GetNPCByID(ID.npc.SOCKET, instance):setStatus(xi.status.NORMAL)
            end
        else
            player:messageSpecial(ID.text.DOOR_IS_SEALED)
        end
    end
end

return entity
