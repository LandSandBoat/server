-----------------------------------
-- Area: Carpenters' Landing
-- NM: Para
-- Quest: Elderly Pursuits
-----------------------------------
local ID = zones[xi.zone.CARPENTERS_LANDING]
-----------------------------------
---@type TMobEntity
local entity = {}

local checkIfShouldClone = function(hpp, skillId)
    if
        (xi.mobSkill.QUEASYSHROOM == skillId or
        xi.mobSkill.NUMBSHROOM == skillId or
        xi.mobSkill.SHAKESHROOM == skillId) and
        hpp < 50
    then
        return true
    else
        return false
    end
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180) -- 3 minutes

    local para = GetMobByID(ID.mob.PARA)

    if para == nil then
        return
    end

    if para:getLocalVar('spawnAdds') < 5 then
        para:setLocalVar('spawnAdds', para:getLocalVar('spawnAdds') + 1)
    end
end

entity.onMobFight = function(mob, target)
end

-- If Para uses TP specific TP moves move under 50% HP then it will spawn a clone.
-- Will only spawn 4 adds total.
-- Adds will spawn ontop of the player.
-- TP moves that spawned a clone in the capture: 310 - Queezyshroom, 311- Numbshroom, 312 - Shakeshroom
-- No reports or captures if the clones can respawn.
-- Reports from players saying only the original needs to be killed.
entity.onMobWeaponSkill = function(target, mob, skill, player)
    local hpp   = mob:getHPP()
    local skillId = skill:getID()
    local para = GetMobByID(ID.mob.PARA)

    if para == nil then
        return
    end

    if
        not checkIfShouldClone(hpp, skillId) or
        para:getLocalVar('spawnAdds') >= 5
    then
        return
    end

    local pos = target:getPos()
    local clone = GetMobByID(ID.mob.PARA + para:getLocalVar('spawnAdds'))

    if clone == nil then
        return
    end

    clone:setSpawn(pos.x, pos.y, pos.z)
    SpawnMob(ID.mob.PARA + para:getLocalVar('spawnAdds'))
    clone:updateClaim(target)
    clone:updateEnmity(target)
end

-- Clones do not despawn when original is killed. Consistent with capture.
entity.onMobDeath = function(mob, player, optParams)
end

return entity
