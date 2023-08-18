
local ID = zones[xi.zone.ARRAPAGO_REMNANTS]
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    if
        npc:getInstance():getStage() == 6 and
        npc:getInstance():getProgress() >= 11
    then
        player:startEvent(300)
    else
        player:messageSpecial(ID.text.DOOR_IS_SEALED)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, door)
    if csid == 300 and option == 1 then
        local instance = door:getInstance()
        instance:setStage(7)
        instance:setProgress(0)
        SpawnMob(ID.mob[6].rampart3, instance)
        SpawnMob(ID.mob[6].rampart4, instance)
        door:setAnimation(8)
        door:setUntargetable(true)
    end
end

return entity
