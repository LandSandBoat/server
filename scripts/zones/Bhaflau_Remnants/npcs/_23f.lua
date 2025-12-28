-----------------------------------
-- NPC: Door
-- Area: Bhaflau Remnants
-- 2nd Floor 2nd Door East Wing, opens NE section, locks SE Wing
-- !pos 500 -2 320
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
            xi.salvage.sealDoors(instance, ID.npc.DOOR_2_SE_ENTRANCE)
            xi.salvage.unsealDoors(instance, ID.npc.DOOR_2_NE_EXIT)
            local mobs =
            {
                utils.slice(ID.mob.TROLL_SMELTER, 4, 5),
                utils.slice(ID.mob.TROLL_STONEWORKER, 1, 2),
                utils.slice(ID.mob.TROLL_CAMEIST, 1, 2),
                utils.slice(ID.mob.SULFUR_SCORPION, 13, 16),
            }
            xi.salvage.spawnGroup(instance, mobs)
        else
            player:messageSpecial(ID.text.DOOR_IS_SEALED)
        end
    end
end

return entity
