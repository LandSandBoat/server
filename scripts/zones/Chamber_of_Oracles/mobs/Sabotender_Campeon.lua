-----------------------------------
-- Area: Chamber of Oracles
--  Mob: Sabotender Campeon
-- KSNM: Cactuar Suave
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

local destinations =
{
    {
        {   0,100,-240 }, -- center
        {   0,100,-252 }, -- front
        { -12,100,-240 }, -- left
        {  12,100,-240 }, -- right
        {   0,100,-239 }, -- back
    },
    {
        {   1,0,  1 }, -- center
        {   1,0,-13 }, -- front
        { -13,0,  1 }, -- left
        {  13,0,  1 }, -- right
        {   1,0, 10 }, -- back
    },
    {
        {   0,-100,240 }, -- center
        {   0,-100,228 }, -- front
        { -12,-100,240 }, -- left
        {  12,-100,240 }, -- right
        {   0,-100,249 }, -- back
    },
}

local function atPoint(mob, bfNum, target)
    local pos = mob:getPos()
    local x = destinations[bfNum][target][1]
    local y = destinations[bfNum][target][2]
    local z = destinations[bfNum][target][3]

    return x == pos.x and y == pos.y and z == pos.z
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar("target", math.random(1,5))
    mob:setMod(xi.mod.REGEN, 50)
    mob:setSpeed(60)
end

entity.onMobEngaged = function(mob)
    mob:setLocalVar("runTimer", os.time() + math.random(30, 45))
end

entity.onMobFight = function(mob, target)
    local bfNum = mob:getBattlefield():getArea()
    local dest = mob:getLocalVar("target")

    if mob:getLocalVar("runTimer") < os.time() and mob:getLocalVar("control") == 0 then
        mob:setLocalVar("control", 1)
        mob:setLocalVar("needleControl", 0)
        mob:timer(1000 * math.random(30,45), function(mobArg)
            mobArg:setLocalVar("runTimer", os.time() + math.random(30,45))
            mobArg:setLocalVar("control", 0)
        end)
    end

    if mob:getLocalVar("runTimer") > os.time() then
        if atPoint(mob, bfNum, dest) then
            mob:setLocalVar("target", math.random(1,5))
            dest = mob:getLocalVar("target")
        end
        mob:pathThrough(destinations[bfNum][dest], xi.path.flag.SCRIPT)
    elseif mob:getLocalVar("needleControl") == 0 and mob:checkDistance(target) < 10 then
        mob:setLocalVar("needleControl", 1)
        mob:queue(0, function(mobArg)
            mobArg:useMobAbility(322)
        end)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
