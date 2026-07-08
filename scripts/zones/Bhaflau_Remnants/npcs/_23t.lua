-----------------------------------
-- NPC: Door
-- Area: Bhaflau Remnants
-- 4th Floor West Door to Portal
-- !pos -360 -2 140
-----------------------------------
local ID = zones[xi.zone.BHAFLAU_REMNANTS]
-----------------------------------

---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local instance = npc:getInstance()
    if
        instance and
        instance:getStage() == 4 and
        instance:getProgress() == 1
    then
        player:startEvent(300)
    else
        player:messageSpecial(ID.text.DOOR_IS_SEALED)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 300 and option == 1 then
        if xi.salvage.onDoorOpen(npc) then
            player:getInstance():setLocalVar('stageComplete', 4)
        else
            player:messageSpecial(ID.text.DOOR_IS_SEALED)
        end
    end
end

return entity
