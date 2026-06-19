-----------------------------------
-- Instance: Silver Sea Remnants
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(300)
end

entity.onEventFinish = function(player, csid, option, door)
    if csid == 300 and option == 1 then
        local instance = door:getInstance()
        if not instance then
            return
        end

        door:setAnimation(xi.animation.OPEN_DOOR)
        door:setUntargetable(true)
        instance:setProgress(3)
    end
end

return entity
