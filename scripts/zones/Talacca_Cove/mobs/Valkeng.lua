-----------------------------------
-- Area: Talacca Cove
--  Mob: Valkeng (PUP AF3 Battlefield)
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.NO_DROPS, 1)
    mob:setLocalVar('lastFrameChange', 0)
    mob:setLocalVar('currentFrame', 0) -- 0 = Harlequin, 1 = Valoredge, 2 = Sharpshot, 3 = Stormwaker
end

entity.onMobFight = function(mob, target)
    local now = mob:getBattleTime()
    local lastChange = mob:getLocalVar('lastFrameChange')
    local currentFrame = mob:getLocalVar('currentFrame')

    -- Change frame every 60 seconds, cycling through frames
    if now - lastChange >= 60 and currentFrame < 3 then
        local newFrame = currentFrame + 1
        mob:setLocalVar('currentFrame', newFrame)
        mob:setLocalVar('lastFrameChange', now)

        if newFrame == 1 then
            -- Valoredge: high physical resist, strong melee
            mob:setMod(xi.mod.UDMGPHYS, -5000)
            mob:setMod(xi.mod.UDMGMAGIC, 0)
            mob:setMod(xi.mod.ATT, 100)
            mob:setMod(xi.mod.ACC, 50)
        elseif newFrame == 2 then
            -- Sharpshot: high evasion
            mob:setMod(xi.mod.UDMGPHYS, 0)
            mob:setMod(xi.mod.UDMGMAGIC, 0)
            mob:setMod(xi.mod.ATT, 0)
            mob:setMod(xi.mod.ACC, 100)
            mob:setMod(xi.mod.EVA, 100)
        elseif newFrame == 3 then
            -- Stormwaker: high magic resist
            mob:setMod(xi.mod.UDMGPHYS, 0)
            mob:setMod(xi.mod.UDMGMAGIC, -5000)
            mob:setMod(xi.mod.ATT, 0)
            mob:setMod(xi.mod.ACC, 0)
            mob:setMod(xi.mod.EVA, 0)
            mob:setMod(xi.mod.MDEF, 100)
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
