-----------------------------------
--
-- Zone: Castle_Oztroja (151)
--
-----------------------------------
local CASTLE_OZTROJA = require("scripts/zones/Castle_Oztroja/globals")
local ID = require("scripts/zones/Castle_Oztroja/IDs")
require("scripts/globals/conquest")
require("scripts/globals/treasure")
require("scripts/globals/zone")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
    UpdateNMSpawnPoint(ID.mob.YAGUDO_AVATAR)
    if RESPAWN_SAVE_TIME then
        GetMobByID(ID.mob.YAGUDO_AVATAR):setRespawnTime(math.random(RESPAWN_SAVE_TIME_MIN, RESPAWN_SAVE_TIME_MAX))
    else
        GetMobByID(ID.mob.YAGUDO_AVATAR):setRespawnTime(math.random(900, 10800))
    end

    CASTLE_OZTROJA.pickNewCombo() -- update combination for brass door on floor 2
    CASTLE_OZTROJA.pickNewPassword() -- update password for trap door on floor 4

    xi.treasure.initZone(zone)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(-162.895, 22.136, -139.923, 2)
    end
    return cs
end

zone_object.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zone_object.onRegionEnter = function(player, region)
end

zone_object.onGameHour = function(zone)
    local VanadielHour = VanadielHour()

    -- every game day ...
    if VanadielHour % 24 == 0 then
        CASTLE_OZTROJA.pickNewCombo() -- update combination for brass door on floor 2
        CASTLE_OZTROJA.pickNewPassword() -- update password for trap door on floor 4
    end
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
end

return zone_object
