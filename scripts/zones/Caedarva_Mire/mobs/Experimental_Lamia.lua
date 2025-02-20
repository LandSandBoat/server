-----------------------------------
-- Area: Caedarva Mire (79)
--  ZNM: Experimental Lamia
-- !pos -773.369 -11.824 322.298 79
-----------------------------------
local ID = zones[xi.zone.CAEDARVA_MIRE]
-----------------------------------
---@type TMobEntity
local entity = {}

local function spawnMinions(mob, target)
    mob:setLocalVar('spawnedMinions', 1)

    local x = mob:getXPos()
    local y = mob:getYPos()
    local z = mob:getZPos()

    for i = ID.mob.EXPERIMENTAL_LAMIA + 1, ID.mob.EXPERIMENTAL_LAMIA + 3 do
        local minion = GetMobByID(i)

        if minion then
            minion:setSpawn(x + math.random(-2, 2), y, z + math.random(-2, 2))
            minion:spawn()
            minion:updateEnmity(target)
        end
    end
end

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
end

entity.onMobFight = function(mob, target)
    if mob:getHPP() < 75 and mob:getLocalVar('spawnedMinions') == 0 then
        spawnMinions(mob, target)
    end

    -- make sure minions have a target
    for i = ID.mob.EXPERIMENTAL_LAMIA + 1, ID.mob.EXPERIMENTAL_LAMIA + 3 do
        local minion = GetMobByID(i)
        if
            minion and
            minion:getCurrentAction() == xi.act.ROAMING
        then
            minion:updateEnmity(target)
        end
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    if mob:getLocalVar('spawnedMinions') == 0 then
        spawnMinions(mob, target)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
