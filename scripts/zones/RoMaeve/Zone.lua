-----------------------------------
--
-- Zone: RoMaeve (122)
--
-----------------------------------
local ID = require("scripts/zones/RoMaeve/IDs")
require("scripts/globals/conquest")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
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
    local vanadielHour = VanadielHour()
    
    -- Make Ro'Maeve come to life between 6pm and 6am during a full moon
    if IsMoonFull() and (vanadielHour >= 18 or vanadielHour < 6) then
        local moongate1 = GetNPCByID(ID.npc.MOONGATE_OFFSET)
        local moongate2 = GetNPCByID(ID.npc.MOONGATE_OFFSET + 1)

        if moongate1:getLocalVar("romaeveActive") == 0 then
            -- Loop over the affected NPCs: Moongates, bridges and fountain
            for i = ID.npc.MOONGATE_OFFSET, ID.npc.MOONGATE_OFFSET + 7 do
                GetNPCByID(i):setAnimation(tpz.anim.OPEN_DOOR) -- Open them
            end
            moongate2:untargetable(true)
            moongate1:untargetable(true)
            moongate1:setLocalVar("romaeveActive", 1) -- Make this loop unavailable after firing
        end

    -- Clean up at 6am
    elseif vanadielHour == 6 then
        local moongate1 = GetNPCByID(ID.npc.MOONGATE_OFFSET)
        local moongate2 = GetNPCByID(ID.npc.MOONGATE_OFFSET + 1)

        if moongate1:getLocalVar("romaeveActive") == 1 then
            for i = ID.npc.MOONGATE_OFFSET, ID.npc.MOONGATE_OFFSET + 7 do
                GetNPCByID(i):setAnimation(tpz.anim.CLOSE_DOOR)
            end
            moongate2:untargetable(false)
            moongate1:untargetable(false)
            moongate1:setLocalVar("romaeveActive", 0) -- Make loop available again
        end
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end