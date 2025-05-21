-----------------------------------
-- Door
-- 1st Floor Beginning Door
-- !pos 400 -2 -560
-----------------------------------
local ID = zones[xi.zone.ZHAYOLM_REMNANTS]
-----------------------------------

---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(300)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 300 and option == 1 then
        local instance = player:getInstance()

        if instance and xi.salvage.onDoorOpen(npc) then
            local chars    = instance:getChars()

            instance:setLocalVar('allySize', #chars)
            xi.salvage.unsealDoors(instance, { ID.npc.DOOR_1_1, ID.npc.DOOR_1_2, ID.npc.DOOR_1_3, ID.npc.DOOR_1_4 })
        else
            player:messageSpecial(ID.text.DOOR_IS_SEALED)
        end
    end
end

return entity
