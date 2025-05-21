-----------------------------------
--  Area: Rolanberry Fields [S]
--    NM: Dyinyinga
-- https://www.bg-wiki.com/ffxi/Dyinyinga
--  TODO: Gradually builds enfeebling resistance
-- Dyinyanga tries to stand directly on top of the player and inficts a 0.5 yalm silence amnesia aura.
-- Has en-slow that overwrites and prevents Haste 2.
-- When slow is active on the player, the NM moves out to melee at a normal range and stops trying to stand on them until it wears. Aura ceases at this time too.
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setBaseSpeed(100)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMod(xi.mod.AURA_SIZE, -575) -- 6.25 + (-575) / 100 = .5'
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.SLOW, { chance = 15, duration = 45, power = 30 })
end

entity.onMobFight = function(mob, target)
    if target:getStatusEffect(xi.effect.SLOW) then
        -- No aura and steps back (if too close)
        if mob:getMobMod(xi.mobMod.TARGET_DISTANCE_OFFSET) ~= 0 then
            mob:setMobMod(xi.mobMod.TARGET_DISTANCE_OFFSET, 0)
            mob:delStatusEffectSilent(xi.effect.COLURE_ACTIVE)
            mob:delStatusEffectSilent(xi.effect.NONE)
            local targetDistance = mob:checkDistance(target)
            if targetDistance < 2 then
                -- step back a bit
                local tarX,       tarZ = target:getXPos(),                target:getZPos()
                local newX, newY, newZ = mob:getXPos(),    mob:getYPos(), mob:getZPos()

                if targetDistance > .25 then
                    -- away from target
                    newX = newX + (newX > tarX and 1 or -1) * math.random(1, 3)
                    newZ = newZ + (newZ > tarZ and 1 or -1) * math.random(1, 3)
                else
                    -- random direction
                    newX = newX + (math.random(1, 100) <= 50 and 1 or -1) * math.random(1, 3)
                    newZ = newZ + (math.random(1, 100) <= 50 and 1 or -1) * math.random(1, 3)
                end

                mob:pathTo(newX, newY, newZ)
            end
        end
    else
        -- Aura and closes the gap
        mob:setMobMod(xi.mobMod.TARGET_DISTANCE_OFFSET, 50)
        mob:addStatusEffectEx(xi.effect.COLURE_ACTIVE, xi.effect.COLURE_ACTIVE, 6, 3, 0, xi.effect.AMNESIA, 50, xi.auraTarget.ENEMIES, xi.effectFlag.AURA)
        mob:addStatusEffectEx(xi.effect.NONE,          xi.effect.NONE,          6, 3, 0, xi.effect.SILENCE, 50, xi.auraTarget.ENEMIES, xi.effectFlag.AURA)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 511)
end

return entity
