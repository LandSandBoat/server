-----------------------------------
-- Instance: Silver Sea Remnants
-----------------------------------
local ID = zones[xi.zone.SILVER_SEA_REMNANTS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local instance = npc:getInstance()
    if instance:getProgress() == 9 then
        player:startEvent(300)
    else
        player:messageSpecial(ID.text.DOOR_IS_SEALED)
    end
end

entity.onEventFinish = function(player, csid, option, door)
    if csid == 300 and option == 1 then
        local instance = door:getInstance()
        if not instance then
            return
        end

        door:setAnimation(xi.animation.OPEN_DOOR)
        door:setUntargetable(true)
        instance:setProgress(10)
    end
end

return entity
