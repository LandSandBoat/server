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
    local track_var = 'entered_'.. player:getName()
    if not (battlefield:getLocalVar(track_var) == 1) then
        battlefield:setLocalVar(track_var, 1)
        battlefield:setLocalVar('num_entrants', battlefield:getLocalVar('num_entrants') + 1)
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
        player:setCharVar("OmensProgress", 2)
    end
end