-----------------------------------
-- Area: Ghelsba Outpost
-- Mob: Toadcushion
-- BCNM: Toadal Recall
-----------------------------------
local entity = {}

local shroomAbilities =
{
    {310, 0}, -- queasyshroom
    {311, 1}, -- numbshroom
    {312, 2}, -- shakeshroom
}

entity.onMobSpawn = function(mob)
    mob:setLocalVar("control", 0)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
    mob:setMobMod(xi.mobMod.SUPERLINK, 1)
    mob:setMobMod(xi.mobMod.SOUND_RANGE, 15)
end

entity.onMobEngaged = function(mob)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
    mob:setLocalVar("timer", os.time() + math.random(5,20))
end

entity.onMobFight = function(mob, target)
    if mob:getLocalVar("control") == 0 and mob:getAnimationSub() == 3 then
        mob:setLocalVar("control", 1)
        mob:timer(1000 * math.random(60,120), function(mobArg)
            mobArg:useMobAbility(626)
            mobArg:setLocalVar("control", 0)
            mobArg:setAnimationSub(0)
            mob:setLocalVar("timer", os.time() + math.random(5,20))
        end)
    end

    if mob:getLocalVar("timer") < os.time() and mob:getAnimationSub() ~= 3 then
        for _, v in pairs(shroomAbilities) do
            if mob:getAnimationSub() == v[2] then
                mob:queue(0, function(mobArg)
                    mobArg:useMobAbility(v[1])
                    mob:setLocalVar("timer", os.time() + math.random(5,20))
                end)
                break
            end
        end
    end
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
