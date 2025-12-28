-----------------------------------
-- Zone: Phomiuna_Aqueducts (27)
-----------------------------------
local ID = zones[xi.zone.PHOMIUNA_AQUEDUCTS]
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    GetNPCByID(ID.npc.QM_TAVNAZIAN_COOKBOOK):addPeriodicTrigger(0, 250, 0) -- QM moves every 10 minutes

    -- Eba or Mahisha spawn on zone initialization
    local mahisha = GetMobByID(ID.mob.MAHISHA)
    local eba     = GetMobByID(ID.mob.EBA)

    if mahisha and eba then
        if math.random(1, 100) <= 50 then
            DisallowRespawn(eba:getID(), true)
            mahisha:setRespawnTime(math.random(28800, 43200)) -- 8 to 12 hours
        else
            DisallowRespawn(mahisha:getID(), true)
            eba:setRespawnTime(math.random(28800, 43200)) -- 8 to 12 hours
        end
    end
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conquest.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(260.02, -2.12, -290.461, 192)
    end

    return cs
end

zoneObject.afterZoneIn = function(player)
    -- ZONE WIDE LEVEL RESTRICTION
    if xi.settings.main.ENABLE_COP_ZONE_CAP == 1 then
        player:addStatusEffect(xi.effect.LEVEL_RESTRICTION, 40, 0, 0)
    end
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

return zoneObject
