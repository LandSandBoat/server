-----------------------------------
--
-- Zone: Misareaux_Coast (25)
--
-----------------------------------
require("scripts/globals/conquest")
require("scripts/globals/helm")
require("scripts/zones/Misareaux_Coast/IDs")
-----------------------------------

function onInitialize(zone)
    tpz.helm.initZone(zone, tpz.helm.type.LOGGING)
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onZoneIn(player,prevZone)
    local cs = -1
    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(567.624,-20,280.775,120)
    end
    return cs
end

function onRegionEnter(player,region)
end

function onGameHour(zone)
    local ZIPHIUS_QM_BASE  = 16879919
    if VanadielHour() == 22 then  -- Spawn traps for Ziphius
        for i = ZIPHIUS_QM_BASE, ZIPHIUS_QM_BASE+5, 1 do
            GetNPCByID(i):setStatus(tpz.status.NORMAL)
        end
    elseif VanadielHour() == 7 then  -- Despawn traps for Ziphius
        for i = ZIPHIUS_QM_BASE, ZIPHIUS_QM_BASE+5, 1 do
            GetNPCByID(i):setStatus(tpz.status.DISAPPEAR)
            GetNPCByID(i):setLocalVar("[Ziphius]Bait Trap", 0)
        end
    elseif VanadielHour() == 4 then  -- Despawn non-baited traps
        for i = ZIPHIUS_QM_BASE, ZIPHIUS_QM_BASE+5, 1 do
            if (GetNPCByID(i):getLocalVar("[Ziphius]Bait Trap") == 0) then
                GetNPCByID(i):setStatus(tpz.status.DISAPPEAR)
            end
        end
    end
end

function onEventUpdate(player,csid,option)
end

function onEventFinish(player,csid,option)
end
