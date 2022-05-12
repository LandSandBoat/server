-----------------------------------
-- CatsEyeXI Custom NPCs
-----------------------------------

m:addOverride("xi.zones.Port_Jeuno.Sagheera.getCOSMO_CLEANSETime" = local function(player)
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
