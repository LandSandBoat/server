-----------------------------------
-- Area: Carpenters Landing
-- Mob:  Para
-----------------------------------
local ID = zones[xi.zone.CARPENTERS_LANDING]
-----------------------------------

local function spawnNextMob(player)
    local mobId = GetNPCByID(ID.npc.QM_PARA):getLocalVar('nextMob')

    if mobId ~= 0 then
        GetMobByID(mobId):setSpawn(player:getXPos()-1, player:getYPos()-1, player:getZPos(), player:getRotPos() - 180) -- spawn facing by player
        SpawnMob(mobId):updateEnmity(player)

        if mobId < ID.mob.PARA_OFFSET + 4 then
            GetNPCByID(ID.npc.QM_PARA):setLocalVar('nextMob', mobId + 1)
        else
            GetNPCByID(ID.npc.QM_PARA):setLocalVar('nextMob', 0)
        end
    end
end

local function AllParaDead()
    for i = 0, 4 do
        local mob = GetMobByID(ID.mob.PARA_OFFSET + i)
        if not mob:isDead() then
            return false
        end
    end

    return true
end

local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180) -- 3 min despawn
    --mob:addImmunity(xi.immunity.LIGHT_SLEEP) TODO: Mob is immune to light based sleep, but not dark
    mob:setMod(xi.mod.UDMGMAGIC, -4000)
    mob:setLocalVar('spawn', 0)
end

entity.onMobFight = function(mob, target)
    if
        mob:getLocalVar('spawn') < os.time() and
        mob:getLocalVar('spawn') ~= 0
    then
        spawnNextMob(target)
        mob:setLocalVar('spawn', 0)
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    local triggerSkills = { 310, 311, 312 }
    local skillID = skill:getID()
    if utils.contains(skillID, triggerSkills) then
        if math.random(1, 100) <= 90 then
            mob:setLocalVar('spawn', os.time() + 3) -- ~90% chance of replicating on shroom skill, need larger sample to hone in on this number but it isn't guaranteed
        end
    end

    return target
end

entity.onMobDeath = function(mob, player, optParams)
    mob:setLocalVar('died', 1)
    if AllParaDead() then
        GetNPCByID(ID.npc.QM_PARA):setLocalVar('engaged', os.time()) -- no time gate after death
    end
end

entity.onMobDespawn = function(mob)
    if
        AllParaDead() and
        mob:getLocalVar('died') ~= 1
    then
        GetNPCByID(ID.npc.QM_PARA):setLocalVar('engaged', os.time() + 180) -- time gate 3 min after despawn
    end
end

return entity
