-----------------------------------
-- Area: Spire of Holla
-- Mob: Cojitator
-- ENM: Simulant
-----------------------------------
mixins =
{
    require("scripts/mixins/families/empty_terroanima"),
}
-----------------------------------
local entity = {}

entity.onMobEngaged = function(mob)
    mob:setLocalVar("timer", os.time() + math.random(20, 90))
end

entity.onMobWeaponSkill = function(target, mob, skill)
    if skill:getID() == 1251 then
        mob:queue(3000, function(mobArg)
            mobArg:useMobAbility(1248)
        end)
    end
end

entity.onMobFight = function(mob, target)
    local id = mob:getID()
    local pos = mob:getPos()

    if mob:getLocalVar("timer") < os.time() and mob:getHPP() <= 55 then
        for i = 1, 3 do
            if not GetMobByID(id+i):isSpawned() then
                GetMobByID(id+i):setSpawn(pos.x, pos.y, pos.z)
                SpawnMob(id+i):updateEnmity(mob:getTarget())
                mob:setLocalVar("timer", os.time() + math.random(20,130))
                break
            end
        end
    end
end

entity.onMobDeath = function(mob, player, isKiller)
    local id = mob:getID()

    if isKiller then
        for i = 1, 3 do
            if GetMobByID(id+i):isAlive() then
                GetMobByID(id+i):setHP(0)
            end
        end
    end
end

return entity
