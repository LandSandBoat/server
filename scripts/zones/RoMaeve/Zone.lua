-----------------------------------
--
-- Zone: RoMaeve (122)
--
-----------------------------------
local ID = require("scripts/zones/RoMaeve/IDs")
require("scripts/globals/conquest")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
require("scripts/globals/weather")
require("scripts/globals/status")
-----------------------------------

function onInitialize(zone)
    local newPosition = npcUtil.pickNewPosition(ID.npc.BASTOK_7_1_QM, ID.npc.BASTOK_7_1_QM_POS, true)
    GetNPCByID(ID.npc.BASTOK_7_1_QM):setPos(newPosition.x, newPosition.y, newPosition.z)
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onZoneIn(player, prevZone)
    local cs = -1
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(-0.008, -33.595, 123.478, 62)
    end
    if player:getCurrentMission(WINDURST) == tpz.mission.id.windurst.VAIN and player:getCharVar("MissionStatus") ==1 then
        cs = 3 -- doll telling "you're in the right area"
    end
    return cs
end

function onRegionEnter(player, region)
end

function onGameHour(zone)
    local hour = VanadielHour()

    if IsMoonFull() and hour == 18 then
        for i = ID.npc.MOONGATE_OFFSET, ID.npc.MOONGATE_OFFSET+7 do
            GetNPCByID(i):openDoor(1728)
            GetNPCByID(i):untargetable(true)
        end
    elseif hour == 6 then
        for i = ID.npc.MOONGATE_OFFSET, ID.npc.MOONGATE_OFFSET+7 do
            GetNPCByID(i):untargetable(false)
        end
    end
end


function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end