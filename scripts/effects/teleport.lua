-----------------------------------
-- xi.effect.TELEPORT
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    local destination = effect:getPower()

    if target:isMob() then
        DespawnMob(target:getID())
    elseif destination == xi.teleport.id.WARP then
        target:warp()
    elseif destination == xi.teleport.id.ESCAPE then
        xi.teleport.escape(target)
    elseif destination == xi.teleport.id.OUTPOST then
        local region = effect:getSubPower()
        xi.teleport.toOutpost(target, region)
    elseif destination == xi.teleport.id.LEADER then
        xi.teleport.toLeader(target)
    elseif destination == xi.teleport.id.HOME_NATION then
        xi.teleport.toHomeNation(target)
    elseif destination == xi.teleport.id.RETRACE then
        xi.teleport.toAlliedNation(target)
    elseif destination == xi.teleport.id.CAMPAIGN then
        local campaignDestination = effect:getSubPower()
        xi.teleport.toCampaign(target, campaignDestination)
    elseif destination == xi.teleport.id.TIDAL_TALISMAN then
        xi.teleport.tidalTeleport(target)
    else
        xi.teleport.to(target, destination)
    end
end

return effectObject
