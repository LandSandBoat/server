-----------------------------------
-- Domain Invasion
-----------------------------------
xi = xi or {}
xi.domainInvasion = xi.domainInvasion or {}

-- Retail uses 13 as the GateId for Domain Invasion; exact meaning/variations unknown.
xi.domainInvasion.gateId = 13

-- Re-send the objective fence as a participant crosses its ring: their GateId on entry, 0 on exit.
-- The client only re-evaluates the render cull when it receives a 0x075.
-- fence = { pos = { x, z }, radius }
xi.domainInvasion.updateFence = function(player, fence, entering)
    if not player:hasStatusEffect(xi.effect.ELVORSEAL) then
        return
    end

    local gateId = entering and player:getStatusEffect(xi.effect.ELVORSEAL):getSubPower() or 0
    player:objectiveUtility({ fence = { pos = fence.pos, radius = fence.radius, blue = true, gateId = gateId } })
end
