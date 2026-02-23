-----------------------------------
-- Area: Uleguerand Range
--  MOB: Black Coney
-- Note: uses normal rabbit attacks. has double/triple attack.
-----------------------------------
local ID = zones[xi.zone.ULEGUERAND_RANGE]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.TRIPLE_ATTACK, 10)
    mob:setMod(xi.mod.STORETP, 30)
    mob:setMod(xi.mod.ICE_RES_RANK, 4)
    mob:setMod(xi.mod.PARALYZE_RES_RANK, 4)
    mob:setMod(xi.mod.BIND_RES_RANK, 4)
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    local skillList =
    {
        xi.mobSkill.SNOW_CLOUD_1,
        xi.mobSkill.FOOT_KICK_1,
        xi.mobSkill.WHIRL_CLAWS_1
    }

    return skillList[math.random(1, #skillList)]
end

entity.onMobDespawn = function(mob)
    GetNPCByID(ID.npc.RABBIT_FOOTPRINT):setLocalVar('activeTime', GetSystemTime() + math.random(60 * 9, 60 * 15))
end

return entity
