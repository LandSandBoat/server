
local ID = zones[xi.zone.ARRAPAGO_REMNANTS]
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    if npc:getInstance():getStage() == 5 then
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
        instance:setStage(6)
        instance:setProgress(3)
        door:setAnimation(8)
        SpawnMob(ID.mob[5][2].chariot, instance)
        SpawnMob(ID.mob[5][2].astrologer, instance)
        for i, v in pairs(ID.npc[5][1]) do
            local npc = GetNPCByID(v, instance)
            npc:setUntargetable(true)
        end
    end
end

return entity
