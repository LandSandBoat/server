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

function onInitialize(zone)
    UpdateNMSpawnPoint(ID.mob.YAGUDO_AVATAR)
    GetMobByID(ID.mob.YAGUDO_AVATAR):setRespawnTime(math.random(900, 10800))

    CASTLE_OZTROJA.pickNewCombo() -- update combination for brass door on floor 2
    CASTLE_OZTROJA.pickNewPassword() -- update password for trap door on floor 4

    tpz.treasure.initZone(zone)
end

function onZoneIn(player, prevZone)
    local cs = -1
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(-162.895, 22.136, -139.923, 2)
    end
    return cs
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onRegionEnter(player, region)
end

function onGameHour(zone)
    local VanadielHour = VanadielHour()

    -- every game day ...
    if VanadielHour % 24 == 0 then
        CASTLE_OZTROJA.pickNewCombo() -- update combination for brass door on floor 2
        CASTLE_OZTROJA.pickNewPassword() -- update password for trap door on floor 4
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
