-----------------------------------
-- Area: Spire of Holla
-- Mob: Envier
-- ENM: Playing Host
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

entity.onMobFight = function(mob, target)
    local id = mob:getID()
    local pos = mob:getPos()

    if mob:getLocalVar("timer") < os.time() and mob:getHPP() <= 75 then
        for i = 1, 3 do
            if not GetMobByID(id+i):isSpawned() then
                GetMobByID(id+i):setSpawn(pos.x, pos.y, pos.z)
                SpawnMob(id+i):updateEnmity(mob:getTarget())
                mob:setLocalVar("timer", os.time() + math.random(15,120))
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
