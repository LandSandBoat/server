-----------------------------------
-- Door
-- 1st Floor South East Path to Portal
-- !pos 380 -22 -520
-----------------------------------
local ID = zones[xi.zone.ZHAYOLM_REMNANTS]
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
        local instance = player:getInstance()

        if instance and xi.salvage.onDoorOpen(npc) then
            xi.salvage.sealDoors(instance, { ID.npc.DOOR_1_1, ID.npc.DOOR_1_2, ID.npc.DOOR_1_3, ID.npc.DOOR_1_4 })
            instance:setLocalVar('stageComplete', 1)
        else
            player:messageSpecial(ID.text.DOOR_IS_SEALED)
        end
    end
end

return entity
