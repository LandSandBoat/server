-----------------------------------
-- NPC: Door
-- Area: Bhaflau Remnants
-- 1st Floor 1st door
-- !pos 340 14 -520
-----------------------------------
local ID = zones[xi.zone.BHAFLAU_REMNANTS]
-----------------------------------

---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(300)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 300 and option == 1 then
        local instance = npc:getInstance()

        if instance and xi.salvage.onDoorOpen(npc) then
            xi.salvage.unsealDoors(instance, { ID.npc.DOOR_1_EAST_ENTRANCE, ID.npc.DOOR_1_WEST_ENTRANCE })
        else
            player:messageSpecial(ID.text.DOOR_IS_SEALED)
        end
    end
end

return entity
