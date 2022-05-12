-----------------------------------
-- CatsEyeXI Custom NPCs
-----------------------------------
local m = Module:new("remove_limbus_lockout")

m:addOverride("xi.zones.Port_Jeuno.npcs.Sagheera.getCOSMO_CLEANSETime", function(player)
    local cosmoWaitTime = 0
    local lastCosmoTime = player:getCharVar("Cosmo_Cleanse_TIME")

    if lastCosmoTime ~= 0 then
        lastCosmoTime = lastCosmoTime + cosmoWaitTime
    end

    if lastCosmoTime <= os.time() then
        return COSMO_READY
    end

    return (lastCosmoTime - 1009843200) - 39600 -- (os.time number - BITMASK for the event) - 11 hours in seconds. Only works in this format (strangely).
end)

return m 