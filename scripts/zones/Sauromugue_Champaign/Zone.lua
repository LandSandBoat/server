-----------------------------------
--
-- Zone: Sauromugue_Champaign (120)
--
-----------------------------------
local ID = require("scripts/zones/Sauromugue_Champaign/IDs")
require("scripts/quests/i_can_hear_a_rainbow")
require("scripts/globals/chocobo_digging")
require("scripts/globals/conquest")
require("scripts/globals/missions")
require("scripts/globals/zone")
-----------------------------------

function onChocoboDig(player, precheck)
    return tpz.chocoboDig.start(player, precheck)
end

function onInitialize(zone)
    UpdateNMSpawnPoint(ID.mob.ROC)
    GetMobByID(ID.mob.ROC):setRespawnTime(math.random(900, 10800))
    GetNPCByID(ID.npc.QM2 + math.random(0, 5)):setLocalVar("[QM]Select", 1) -- Determine which QM is active today for THF AF2
end

function onZoneIn( player, prevZone)
    local cs = -1

    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(-103.991, -25.956, -425.221, 190)
    end

    if quests.rainbow.onZoneIn(player) then
        cs = 3
    elseif player:getCurrentMission(WINDURST) == tpz.mission.id.windurst.VAIN and player:getCharVar("MissionStatus") == 1 then
        cs = 5
    end

    return cs
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onRegionEnter(player, region)
end

function onGameDay(zone)
    for i = ID.npc.QM2, ID.npc.QM2+5 do
        GetNPCByID(i):resetLocalVars()
    end
    GetNPCByID(ID.npc.QM2 + math.random(0, 5)):setLocalVar("[QM]Select", 1) -- Determine which QM is active today for THF AF2
end

function onEventUpdate(player, csid, option)
    if csid == 3 then
        quests.rainbow.onEventUpdate(player)
    elseif csid == 5 then
        if player:getPreviousZone() == tpz.zone.GARLAIGE_CITADEL then
            player:updateEvent(0, 0, 0, 0, 0, 2)
        elseif player:getPreviousZone() == tpz.zone.MERIPHATAUD_MOUNTAINS then
            player:updateEvent(0, 0, 0, 0, 0, 4)
        elseif player:getPreviousZone() == tpz.zone.ROLANBERRY_FIELDS or player:getPreviousZone() == tpz.zone.PORT_JEUNO then
            player:updateEvent(0, 0, 0, 0, 0, 3)
        end
    end
end

function onEventFinish( player, csid, option)
end
