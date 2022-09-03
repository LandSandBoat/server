-----------------------------------
-- Zone: Gusgen Mines (196)
-----------------------------------
local ID = require('scripts/zones/Gusgen_Mines/IDs')
require('scripts/globals/conquest')
require('scripts/globals/treasure')
require('scripts/globals/helm')
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
    xi.treasure.initZone(zone)
    xi.helm.initZone(zone, xi.helm.type.MINING)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1

    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(100.007, -61.63, -237.441, 187)
    end

    return cs
end

zone_object.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zone_object.onRegionEnter = function(player, region)
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
end

zone_object.onGameHour = function(zone)
    local totd = VanadielTOTD()

    if totd == xi.time.NEW_DAY or totd == xi.time.MIDNIGHT then
        local ghost
        local ghostTable =
        {
            [1] = {id = ID.mob.ASPHYXIATED_AMSEL, nm = GetMobByID(ID.mob.ASPHYXIATED_AMSEL)},
            [2] = {id = ID.mob.BURNED_BERGMANN, nm = GetMobByID(ID.mob.BURNED_BERGMANN)},
            [3] = {id = ID.mob.CRUSHED_KRAUSE, nm = GetMobByID(ID.mob.CRUSHED_KRAUSE)},
            [4] = {id = ID.mob.PULVERIZED_PFEFFER, nm = GetMobByID(ID.mob.PULVERIZED_PFEFFER)},
            [5] = {id = ID.mob.SMOTHERED_SCHMIDT, nm = GetMobByID(ID.mob.SMOTHERED_SCHMIDT)},
            [6] = {id = ID.mob.WOUNDED_WURFEL, nm = GetMobByID(ID.mob.WOUNDED_WURFEL)},
        }

        for i = 1, 6 do
            ghost = ghostTable[i].nm
            if not ghost:isSpawned() and os.time() > ghost:getLocalVar("cooldown") then
                SpawnMob(ghostTable[i].id)
            end
        end
    end
end

return zone_object
