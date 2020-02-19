-----------------------------------
-- Area: Navukgo Execution Chamber
-- BCNM: Omens
-----------------------------------
require("scripts/globals/battlefield")
local ID = require("scripts/zones/Navukgo_Execution_Chamber/IDs")
----------------------------------------

function onBattlefieldInitialise(battlefield)
end

function onBattlefieldTick(battlefield, tick)
    tpz.battlefield.onBattlefieldTick(battlefield, tick)
end

function onBattlefieldRegister(player, battlefield)
end

function onBattlefieldEnter(player, battlefield)
    local mobOffset = (battlefield:getArea() - 1) * 7  -- Offset to spawn correct mob depending on battlefieldNumber
    local players = battlefield:getPlayers()
    local flan2 = GetMobByID(ID.mob.IMMORTAL_FLAN2 + mobOffset)
    local flan3 = GetMobByID(ID.mob.IMMORTAL_FLAN3 + mobOffset)
    local flan4 = GetMobByID(ID.mob.IMMORTAL_FLAN4 + mobOffset)
    local flan5 = GetMobByID(ID.mob.IMMORTAL_FLAN5 + mobOffset)
    local flan6 = GetMobByID(ID.mob.IMMORTAL_FLAN6 + mobOffset)
    -- Spawns flans depending on party size. Flan1 always spawns by default
    if not flan6:isSpawned() and #players >= 16 then
        flan6:spawn()
    elseif not flan5:isSpawned() and #players >= 14 then
        flan5:spawn()
    elseif not flan4:isSpawned() and #players >= 12 then
        flan4:spawn()
    elseif not flan3:isSpawned() and #players >=  8 then
        flan3:spawn()
    elseif not flan2:isSpawned() and #players >=  4 then
        flan2:spawn()
    end
end

function onBattlefieldLeave(player, battlefield, leavecode)
    if leavecode == tpz.battlefield.leaveCode.WON then
        local name, clearTime, partySize = battlefield:getRecord()
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar("[cs]bit"), 0)
    elseif leavecode == tpz.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 32001 and player:getCharVar("OmensProgress") == 1 then
        player:setCharVar("OmensProgress",2)
    end
end