-----------------------------------
-- Door
-- 7th Floor Beginning Door
-- !pos -340 -2 480
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
        if not xi.salvage.onDoorOpen(npc) then
            player:messageSpecial(ID.text.DOOR_IS_SEALED)
        end
    end
end

return entity
