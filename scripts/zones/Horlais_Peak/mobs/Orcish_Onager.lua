-----------------------------------
-- Area: Horlais Peak
-- Mob: Orcish Onager
-- BCNM Fight: Dismemberment Brigade
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

local points =
{
    {
        { -396, 94, -65 },
        { -390, 94, -76 },
        { -409, 84, -70 },
        { -383, 94, -59 },
        { -401, 94, -51 },
    },
    {
        { -156, -25, 115.5 },
        { -150, -26, 103.3 },
        { -168, -25, 108.8 },
        { -143, -25, 120.5 },
        { -161, -26, 128.6 },
    },
    {
        { 83.8, -145, 295.5 },
        { 89.4, -146, 283.0 },
        { 71.6, -146, 288.5 },
        { 96.7, -146, 300.6 },
        { 78.4, -146, 308.1 },
    },
}

entity.onMobSpawn = function(mob)
    mob:setBehaviour(bit.bor(mob:getBehaviour(), xi.behavior.STANDBACK))
    mob:setMod(xi.mod.REGAIN, 1000)
    mob:setSpeed(90)
end

entity.onMobFight = function(mob)
    local party = mob:getBattlefield():getPlayers()
    local bfNum = mob:getBattlefield():getArea()

    if mob:getLocalVar("fleeTimer") < os.time() then
        for _, member in pairs(party) do
            if mob:checkDistance(member) < 7.0 then
                local dest = math.random(1,5)

                mob:castSpell(362, member)
                mob:pathTo(points[bfNum][dest][1], points[bfNum][dest][2], points[bfNum][dest][3], xi.path.flag.SCRIPT)
                mob:setLocalVar("fleeTimer", os.time() + 20)
            end
        end
    end

    if mob:getHPP() <= 50 and mob:getLocalVar("hpControl2") == 0 then
        mob:setLocalVar("hpControl2", 1)
        mob:setMod(xi.mod.REGAIN, 667)

    elseif mob:getHPP() <= 25 and mob:getLocalVar("hpControl3") == 0 then
        mob:setLocalVar("hpControl3", 1)
        mob:setMod(xi.mod.REGAIN, 334)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
