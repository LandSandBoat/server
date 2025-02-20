-----------------------------------
-- Zone: Castle_Oztroja (151)
-----------------------------------
local oztrojaGlobal = require('scripts/zones/Castle_Oztroja/globals')
local ID = zones[xi.zone.CASTLE_OZTROJA]
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    UpdateNMSpawnPoint(ID.mob.YAGUDO_AVATAR)
    GetMobByID(ID.mob.YAGUDO_AVATAR):setRespawnTime(math.random(900, 10800))

    oztrojaGlobal.pickNewCombo() -- update combination for brass door on floor 2
    oztrojaGlobal.pickNewPassword() -- update password for trap door on floor 4

    xi.treasure.initZone(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(-239.447, -1.813, -19.98, 250)
    end

    return cs
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conquest.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onGameHour = function(zone)
    local vanadielHour = VanadielHour()

    -- every game day
    if vanadielHour % 24 == 0 then
        oztrojaGlobal.pickNewCombo() -- update combination for brass door on floor 2
        oztrojaGlobal.pickNewPassword() -- update password for trap door on floor 4
    end
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

return zoneObject
