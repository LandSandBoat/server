-----------------------------------
-- Door
-- 2nd Floor North West Room Exit
-- !pos 320 -2 20
-----------------------------------
local ID = zones[xi.zone.ZHAYOLM_REMNANTS]
-----------------------------------

---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local instance = npc:getInstance()

    if instance then
        local progress = instance:getProgress()

        if npc:getLocalVar('unSealed') == 1 or progress == 4 then
            player:startEvent(300)
        else
            player:messageSpecial(ID.text.DOOR_IS_SEALED)
        end
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 300 and option == 1 then
        npc:setAnimation(xi.animation.OPEN_DOOR)
        npc:setUntargetable(true)
        player:getInstance():setLocalVar('stageComplete', 2)
    end
end

return entity
