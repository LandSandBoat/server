-----------------------------------
-- Door
-- 6th Floor Exit to Portal
-- !pos -340 -2 160
-----------------------------------
local ID = zones[xi.zone.ZHAYOLM_REMNANTS]
-----------------------------------

---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local instance = npc:getInstance()

    if instance and instance:getLocalVar('6th Door') >= 13 then
        player:startEvent(300)
    else
        player:messageSpecial(ID.text.DOOR_IS_SEALED_MYSTERIOUS)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 300 and option == 1 then
        npc:setAnimation(xi.animation.OPEN_DOOR)
        npc:setUntargetable(true)
        player:getInstance():setLocalVar('stageComplete', 6)
    end
end

return entity
