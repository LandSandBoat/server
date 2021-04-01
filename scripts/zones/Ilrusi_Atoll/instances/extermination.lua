-----------------------------------
-- Assault: Extermination
-----------------------------------
require("scripts/globals/instance")
local ID = require("scripts/zones/Ilrusi_Atoll/IDs")
-----------------------------------
local instance_object = {}

instance_object.afterInstanceRegister = function(player)
    local instance = player:getInstance()

    player:messageSpecial(ID.text.ASSAULT_43_START, 43)
    player:messageSpecial(ID.text.TIME_TO_COMPLETE, instance:getTimeLimit())
end

instance_object.onInstanceCreated = function(instance)

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

instance_object.onInstanceTimeUpdate = function(instance, elapsed)
    xi.instance.updateInstanceTime(instance, elapsed, Ilrusi.text)
end

instance_object.onInstanceFailure = function(instance)

    local chars = instance:getChars()

    for i, v in pairs(chars) do
        v:messageSpecial(ID.text.MISSION_FAILED, 10, 10)
        v:startEvent(102)
    end
end

instance_object.onInstanceProgressUpdate = function(instance, progress)

    if progress == 20 then
        instance:complete()
    end
end

instance_object.onInstanceComplete = function(instance)

    local chars = instance:getChars()

    for i, v in pairs(chars) do
        v:messageSpecial(ID.text.RUNE_UNLOCKED_POS, 8, 8)
    end

    GetNPCByID(ID.npc.RUNE_OF_RELEASE, instance):setStatus(NORMAL)
    GetNPCByID(ID.npc.ANCIENT_LOCKBOX, instance):setStatus(NORMAL)

end

instance_object.onEventUpdate = function(player, csid, option)
end

instance_object.onEventFinish = function(player, csid, option)
end

return instance_object
