-----------------------------------
-- Area: Jugner_Forest
--   NM: Fradubio
-----------------------------------
local ID = zones[xi.zone.JUGNER_FOREST]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.FRADUBIO - 1] = ID.mob.FRADUBIO, -- Confirmed on retail
}

local updateRegen = function(mob)
    local hour = VanadielHour()
    if hour >= 4 and hour < 20 then
        mob:setMod(xi.mod.REGEN, 25)
    else
        mob:setMod(xi.mod.REGEN, 0)
    end
end

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1)
end

entity.onMobSpawn = function(mob)
    updateRegen(mob)
end

entity.onMobRoam = function(mob)
    updateRegen(mob)
end

entity.onMobFight = function(mob)
    updateRegen(mob)
end

entity.onMobWeaponSkill = function(mob, target, skill, action)
    if skill:getID() == 329 then
        for i = ID.mob.FRADUBIO + 1, ID.mob.FRADUBIO + 5 do
            local pet = GetMobByID(i)
            if pet and not pet:isSpawned() then
                pet:setSpawn(mob:getXPos() + 1, mob:getYPos(), mob:getZPos())
                pet:spawn()

                local mobTarget = mob:getTarget()
                if mobTarget then
                    pet:updateEnmity(mobTarget)
                end

                break
            end
        end
    end
end

entity.onMobDisengage = function(mob)
    -- Clear any summoned Duessa when Fradubio resets so they do not linger after the fight.
    for i = ID.mob.FRADUBIO + 1, ID.mob.FRADUBIO + 5 do
        DespawnMob(i)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    -- Duessa (Fradubio's summoned adds) die with him the moment he falls, not when he later despawns.
    if optParams.isKiller or optParams.noKiller then
        for i = ID.mob.FRADUBIO + 1, ID.mob.FRADUBIO + 5 do
            GetMobByID(i):setHP(0)
        end
    end
end

return entity
