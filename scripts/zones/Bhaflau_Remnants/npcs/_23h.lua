-----------------------------------
-- NPC: Door
-- Area: Bhaflau Remnants
-- 2nd Floor Door to NW portal
-- !pos 260 2 320
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
        if xi.salvage.onDoorOpen(npc) then
            player:getInstance():setLocalVar('stageComplete', 2)
        else
            player:messageSpecial(ID.text.DOOR_IS_SEALED)
        end
    end
end

return entity
