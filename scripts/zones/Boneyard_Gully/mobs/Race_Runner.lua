-----------------------------------
-- Area: Boneyard Gully
--  Mob: Race Runner
--  ENM: Like the Wind
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

local pathNodes =
{
    {
        { -588.6, -5.0, -458.5 },
        { -577.5,  0.0, -454.3 },
        { -559.6,  0.0, -470.4 },
        { -539.0,  1.0, -482.1 },
        { -540.6,  0.0, -451.0 },
        { -564.2,  3.5, -433.4 },
        { -547.5,  1.5, -418.2 },
        { -579.4,  1.0, -423.0 },
    },
    {
        { -28.2, -5.0, 101.2 },
        {  -0.3,  0.3,  88.1 },
        {  22.0,  0.9,  77.7 },
        {  18.4,  0.3, 109.0 },
        {  -2.2,  3.5, 125.7 },
        {  12.2,  1.4, 142.8 },
        { -17.4,  1.2, 137.5 },
        { -17.3,  0.0, 107.1 },
    },
    {
        { 451.2, -4.8, 581.3 },
        { 479.3,  0.3, 563.8 },
        { 500.6,  0.9, 558.1 },
        { 498.7,  0.1, 590.5 },
        { 479.5,  3.5, 606.2 },
        { 494.2,  1.2, 623.3 },
        { 460.6,  1.0, 619.3 },
        { 436.1, -0.1, 587.0 },
    },
}

entity.onMobSpawn = function(mob)
    mob:setBehaviour(bit.bor(mob:getBehaviour(), xi.behavior.STANDBACK))
    mob:setLocalVar("hitsRequired", math.random(1, 10))
    mob:setMod(xi.mod.TRIPLE_ATTACK, 20)
    mob:setMod(xi.mod.UDMGMAGIC, -4000)
    mob:setMod(xi.mod.REGAIN, 1000)
    mob:setSpeed(70)
    mob:setMagicCastingEnabled(true)
    mob:setMobAbilityEnabled(true)

    mob:addListener("TAKE_DAMAGE", "RUNNER_TAKE_DAMAGE", function(mobArg, amount, attacker, attackType, damageType)
        if
            amount > 0 and
            attacker and
            not attacker:isPet()
        then
            mobArg:setLocalVar("currHits", mobArg:getLocalVar("currHits") + 1)
        end

        if mob:getLocalVar("currHits") >= mobArg:getLocalVar("hitsRequired") then
            mob:setLocalVar("hitsRequired", math.random(1, 10))
            mob:setLocalVar("runControl", 1)
            mob:setLocalVar("currHits", 0)
            mob:setMagicCastingEnabled(false)
            mob:setMobAbilityEnabled(false)
        end
    end)
end

entity.onMobRoam = function(mob)
end

entity.onMobWeaponSkillPrepare = function(mob, target)
    if target:isPet() then
        target = target:getMaster()
    end
end

entity.onMobMagicPrepare = function(mob, target)
    if target:isPet() then
        target = target:getMaster()
    end
end

entity.onMobFight = function(mob, target)
    local bfNum = mob:getBattlefield():getArea()

    if target:isPet() then
        target = target:getMaster()
    end

    if mob:getLocalVar("runControl") == 1 then
        local point = math.random(1, 8)
        mob:setLocalVar("runControl", 0)

        mob:pathTo(pathNodes[bfNum][point][1], pathNodes[bfNum][point][2], pathNodes[bfNum][point][3], xi.path.flag.SCRIPT)

        mob:timer(5000, function(mobArg)
            mobArg:setMagicCastingEnabled(true)
            mobArg:setMobAbilityEnabled(true)
        end)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
