-----------------------------------
-- NPC: Door
-- Area: Bhaflau Remnants
-- 2nd Floor 1st Door opens East Wing, locks West Wing
-- !pos 400 -6 260
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

        if instance and xi.salvage.onDoorOpen(npc, nil, 1) then
            xi.salvage.sealDoors(instance, ID.npc.DOOR_2_WEST_ENTRANCE)
            xi.salvage.unsealDoors(instance, { ID.npc.DOOR_2_SE_ENTRANCE, ID.npc.DOOR_2_NE_ENTRANCE })
            local mobs =
            {
                utils.slice(ID.mob.SULFUR_SCORPION, 4, 12),
                utils.slice(ID.mob.TROLL_SMELTER, 1, 3),
                utils.slice(ID.mob.TROLL_IRONWORKER, 3, 5),
            }
            xi.salvage.spawnGroup(instance, mobs)
            if math.random(100) >= 50 then
                GetNPCByID(ID.npc.SOCKET, instance):setPos(458, 0, 260)
                GetMobByID(ID.mob.FLUX_FLAN, instance):setSpawn(455, -0.5, 260, 0)
                GetNPCByID(ID.npc.SOCKET, instance):setStatus(xi.status.NORMAL)
            end
        else
            player:messageSpecial(ID.text.DOOR_IS_SEALED)
        end
    end
end

return entity
