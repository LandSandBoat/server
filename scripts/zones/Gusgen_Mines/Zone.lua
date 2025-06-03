-----------------------------------
-- Zone: Gusgen Mines (196)
-----------------------------------
local ID = zones[xi.zone.GUSGEN_MINES]
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    xi.treasure.initZone(zone)
    xi.helm.initZone(zone, xi.helmType.MINING)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(45, -67, -340, 250)
    end

    return cs
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conquest.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

zoneObject.onGameHour = function(zone)
    local totd = VanadielTOTD()

    if totd == xi.time.NEW_DAY or totd == xi.time.MIDNIGHT then
        local ghost
        local ghostTable =
        {
            [1] = { id = ID.mob.ASPHYXIATED_AMSEL, nm = GetMobByID(ID.mob.ASPHYXIATED_AMSEL) },
            [2] = { id = ID.mob.BURNED_BERGMANN, nm = GetMobByID(ID.mob.BURNED_BERGMANN) },
            [3] = { id = ID.mob.CRUSHED_KRAUSE, nm = GetMobByID(ID.mob.CRUSHED_KRAUSE) },
            [4] = { id = ID.mob.PULVERIZED_PFEFFER, nm = GetMobByID(ID.mob.PULVERIZED_PFEFFER) },
            [5] = { id = ID.mob.SMOTHERED_SCHMIDT, nm = GetMobByID(ID.mob.SMOTHERED_SCHMIDT) },
            [6] = { id = ID.mob.WOUNDED_WURFEL, nm = GetMobByID(ID.mob.WOUNDED_WURFEL) },
        }

        for i = 1, 6 do
            ghost = ghostTable[i].nm
            if
                ghost and
                not ghost:isSpawned() and
                os.time() > ghost:getLocalVar('cooldown')
            then
                SpawnMob(ghostTable[i].id)
            end
        end
    end
end

return zoneObject
