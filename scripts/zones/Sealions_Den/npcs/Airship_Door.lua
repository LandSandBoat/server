-----------------------------------
-- Area: Sealion's Den
--  NPC: Airship_Door
-----------------------------------
local ID = require("scripts/zones/Sealions_Den/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local offset = npc:getID() - ID.npc.AIRSHIP_DOOR_OFFSET
    player:startEvent(32003, offset + 1)
end

function onEventUpdate(player, csid, option)
    local battlefield = player:getBattlefield()
    local inst = battlefield:getArea()

    -- spawn omega for given instance
    if csid == 1 and option == 0 then
        local omegaId = ID.mob.ONE_TO_BE_FEARED_OFFSET + (7 * (inst - 1)) + 5
        if omegaId and not GetMobByID(omegaId):isSpawned() then
            SpawnMob(omegaId)
        end

    -- spawn ultima for given instance
    elseif csid == 2 and option == 0 then
        local ultimaId = ID.mob.ONE_TO_BE_FEARED_OFFSET + (7 * (inst - 1)) + 6
        if ultimaId and not GetMobByID(ultimaId):isSpawned() then
            SpawnMob(ultimaId)
            battlefield:setLocalVar("phaseChange", 0)
        end
    end
end

function onEventFinish(player, csid, option)
    if csid == 32003 and option >= 100 and option <= 102 then
        local inst = option - 99
        player:startEvent(player:getLocalVar("[OTBF]cs"), inst)
    end
end
