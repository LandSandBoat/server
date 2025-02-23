-----------------------------------
-- NPC: Door
-- Area: Bhaflau Remnants
-- 3rd Floor Central East Door to Portal
-- !pos -220 -6 -480
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
            xi.salvage.sealDoors(instance, ID.npc.DOOR_3_WEST_EXIT)
            instance:setLocalVar('stageComplete', 3)
        else
            player:messageSpecial(ID.text.DOOR_IS_SEALED)
        end
    end
end

return entity
