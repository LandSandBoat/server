-----------------------------------
-- Assault: Extermination
-----------------------------------
local ID = zones[xi.zone.ILRUSI_ATOLL]
-----------------------------------
local instanceObject = {}

instanceObject.afterInstanceRegister = function(player)
    local instance = player:getInstance()

    player:messageSpecial(ID.text.ASSAULT_43_START, 43)
    player:messageSpecial(ID.text.TIME_TO_COMPLETE, instance:getTimeLimit())
end

instanceObject.onInstanceCreated = function(instance)
    for i, v in pairs(ID.mob[43]) do
        SpawnMob(v, instance)
    end

    GetNPCByID(ID.npc.RUNE_OF_RELEASE, instance):setPos(290.857, -3.424, 132.339, 148)
    GetNPCByID(ID.npc.ANCIENT_LOCKBOX, instance):setPos(293.637, -3.376, 130.364, 148)
    GetNPCByID(ID.npc._1jo, instance):setAnimation(8)
    GetNPCByID(ID.npc._jj3, instance):setAnimation(8)
    GetNPCByID(ID.npc._jj5, instance):setAnimation(8)
    GetNPCByID(ID.npc._jjc, instance):setAnimation(8)
end

instanceObject.onInstanceCreatedCallback = function(player, instance)
    if instance then
        player:setInstance(instance)
        player:setPos(0, 0, 0, 0, instance:getZone():getID())
    end
end

instanceObject.onInstanceTimeUpdate = function(instance, elapsed)
    xi.instance.updateInstanceTime(instance, elapsed, ID.text)
end

instanceObject.onInstanceFailure = function(instance)
    local chars = instance:getChars()

    for i, v in pairs(chars) do
        v:messageSpecial(ID.text.MISSION_FAILED, 10, 10)
        v:startEvent(102)
    end
end

instanceObject.onInstanceProgressUpdate = function(instance, progress)
    if progress == 20 then
        instance:complete()
    end
end

instanceObject.onInstanceComplete = function(instance)
    local chars = instance:getChars()

    for i, v in pairs(chars) do
        v:messageSpecial(ID.text.RUNE_UNLOCKED_POS, 8, 8)
    end

    GetNPCByID(ID.npc.RUNE_OF_RELEASE, instance):setStatus(xi.status.NORMAL)
    GetNPCByID(ID.npc.ANCIENT_LOCKBOX, instance):setStatus(xi.status.NORMAL)
end

instanceObject.onEventUpdate = function(player, csid, option, npc)
end

instanceObject.onEventFinish = function(player, csid, option, npc)
end

return instanceObject
