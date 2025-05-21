-----------------------------------
-- NPC: Door
-- Area: Bhaflau Remnants
-- 1st Floor Door Exit to Portal
-- !pos 340 -2 -400
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
            player:getInstance():setLocalVar('stageComplete', 1)
        else
            player:messageSpecial(ID.text.DOOR_IS_SEALED)
        end
    end
end

return entity
