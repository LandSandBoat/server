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
        door:setAnimation(xi.animation.OPEN_DOOR)
        local instance = door:getInstance()
        door:setUntargetable(true)
        instance:setStage(2)
        instance:setProgress(0)
    end
end

return entity
