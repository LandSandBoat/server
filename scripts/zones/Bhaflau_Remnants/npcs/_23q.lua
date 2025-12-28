-----------------------------------
-- NPC: Door
-- Area: Bhaflau Remnants
-- 3rd Floor SE door
-- !pos -280 0 -500, 17084915
-----------------------------------
local ID = zones[xi.zone.BHAFLAU_REMNANTS]
-----------------------------------

---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local instance = npc:getInstance()
    if
        instance and
        instance:getStage() == 3 and
        instance:getProgress() == 4
    then
        player:startEvent(300)
    else
        player:messageSpecial(ID.text.DOOR_IS_SEALED)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 300 and option == 1 then
        local instance = npc:getInstance()

        if instance and xi.salvage.onDoorOpen(npc, nil, 6) then
            xi.salvage.unsealDoors(instance, ID.npc.DOOR_3_SOUTH_CENTER)
            xi.salvage.spawnGroup(instance, utils.slice(ID.mob.BLACK_PUDDING, 15, 24))
        else
            player:messageSpecial(ID.text.DOOR_IS_SEALED)
        end
    end
end

return entity
