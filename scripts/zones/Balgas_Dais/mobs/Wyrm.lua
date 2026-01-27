-----------------------------------
-- Area: Balga's Dais
--  Mob: Wyrm
-- KSNM: Early Bird Catches the Wyrm
-----------------------------------
---@type TMobEntity
local entity = {}

-- Phases
-----------------------------------
-- 1 = Ground (Wings Down)        (AnimationSub(0))
-- 2 = Airborne                   (AnimationSub(1))
-- 3 = Ground (Wings Up, Enraged) (AnimationSub(2))
-----------------------------------

-----------------------------------
-- Enter/Exit Flight Functions
-----------------------------------
local function enterFlight(mob)
    mob:setMobSkillAttack(1146)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
    mob:addStatusEffectEx(xi.effect.ALL_MISS, 0, 1, 0, 0)
    mob:setBehavior(bit.band(mob:getBehavior(), bit.bnot(xi.behavior.NO_TURN)))
    mob:setAnimationSub(1)
end

local function exitFlight(mob)
    mob:setMobSkillAttack(0)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
    mob:useMobAbility(xi.mobSkill.TOUCHDOWN_1)
    mob:delStatusEffect(xi.effect.ALL_MISS)
    mob:setBehavior(bit.bor(mob:getBehavior(), xi.behavior.NO_TURN))
    mob:setAnimationSub(2)
end

-----------------------------------
-- Enrage - Happens in 3rd phase after landing @ 33% HP
-----------------------------------
local function enrage(mob)
    -- JP Wiki claims it gains 10 levels https://wiki.ffo.jp/html/8145.html TODO: Verify actual level change with dLVL testing, for now this is 10 levels worth of stats. Damage matches up almost exactly.
    mob:setMobMod(xi.mobMod.WEAPON_BONUS, 10)
    mob:setMod(xi.mod.ATT, 396)
    mob:setMod(xi.mod.ACC, 361)
    mob:setMod(xi.mod.EVA, 334)
    mob:setMod(xi.mod.DEF, 369)
    mob:setMod(xi.mod.STR, 11)
    mob:setMod(xi.mod.DEX, 11)
    mob:setMod(xi.mod.VIT, 10)
    mob:setMod(xi.mod.AGI, 11)
    mob:setMod(xi.mod.MND, 11)
    mob:setMod(xi.mod.INT, 10)
    mob:setMod(xi.mod.CHR, 9)
end

-----------------------------------
-- Arena Centers - Used for pathing correctly to center before taking flight
-----------------------------------
local arenaCenters =
{
    [1] = { x = -139.0, y =  56.5, z = -224.4 },
    [2] = { x =  -21.0, y =  -3.4, z =  -24.3 },
    [3] = { x =  181.0, y = -63.5, z =  175.7 },
}

-----------------------------------
-- Draw In Handler
-----------------------------------
local function handleDrawIn(mob, target, battlefield)
    -- Early return: Distance from target check.
    if mob:checkDistance(target) < 19.5 then
        return
    end

    -- Early return: No battlefield.
    if not battlefield then
        return
    end

    -- Early return: No center.
    local center = arenaCenters[battlefield:getArea()]
    if not center then
        return
    end

    -- Early return: Distance from center check.
    if target:checkDistance(center.x, center.y, center.z) <= 22 then
        return
    end

    local drawInPosition =
    {
        x   = center.x,
        y   = center.y,
        z   = center.z + 3.0,
        rot = 194,
    }

    -----------------------------------
    -- Draw in all players to the draw in position, skip players already within 5 yalms
    -----------------------------------
    for _, player in pairs(battlefield:getPlayers()) do
        local distanceFromDrawIn = player:checkDistance(drawInPosition.x, drawInPosition.y, drawInPosition.z)
        if distanceFromDrawIn > 5 then
            mob:drawIn(player, 0, 0, drawInPosition)
        end
    end
end

-----------------------------------
-- onMobInitialize
-----------------------------------
entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.PARALYZE)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PLAGUE)
end

-----------------------------------
-- onMobSpawn
-----------------------------------
entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.REGEN, 30)
    mob:setMod(xi.mod.REGAIN, 100)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 0)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 300)
    mob:setBehavior(bit.bor(mob:getBehavior(), xi.behavior.NO_TURN))
    mob:setTP(3000)
    mob:setAnimationSub(0)
    mob:setMobSkillAttack(0)
    mob:setLocalVar('forceFlight', 0)
end

-----------------------------------
-- onMobEngage - Check if we need to enter flight, in case a wipe during air phase.
-----------------------------------
entity.onMobEngage = function(mob, target)
    if
        mob:getAnimationSub() ~= 1 and
        mob:getLocalVar('forceFlight') == 1
    then
        enterFlight(mob)
        mob:setLocalVar('forceFlight', 0)
    end
end

-----------------------------------
-- onMobFight
-----------------------------------
entity.onMobFight = function(mob, target)
    -- Check for Draw In
    local battlefield = mob:getBattlefield()
    if not battlefield then
        return
    end

    handleDrawIn(mob, target, battlefield)

    -- Early return: Landed.
    local animationSub = mob:getAnimationSub()
    if animationSub == 2 then
        return
    end

    -- Early return: Entity is busy.
    if xi.combat.behavior.isEntityBusy(mob) then
        return
    end

    -- Flight at 66% HP
    if animationSub == 0 then
        if mob:getHPP() > 66 then
            return
        end

        local center           = arenaCenters[battlefield:getArea()]
        local distanceToCenter = mob:checkDistance(center.x, center.y, center.z)
        if distanceToCenter < 1 then
            enterFlight(mob)
        else
            mob:pathTo(center.x, center.y, center.z)
        end
    end

    -- Land at 33% HP
    if animationSub == 1 then
        if mob:getHPP() > 33 then
            return
        end

        exitFlight(mob)
        enrage(mob)
    end
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    if skillId == xi.mobSkill.FLAME_BLAST_ATTACK then
        return 0
    end

    local skillList = {}

    -- Mid-flight.
    if mob:getAnimationSub() == 1 then
        table.insert(skillList, xi.mobSkill.FLAME_BLAST_1)
        table.insert(skillList, xi.mobSkill.HURRICANE_WING_FLYING)

    -- Ground.
    else
        table.insert(skillList, xi.mobSkill.HURRICANE_WING_1)
        table.insert(skillList, xi.mobSkill.SPIKE_FLAIL_1)
        table.insert(skillList, xi.mobSkill.DRAGON_BREATH_1)
        table.insert(skillList, xi.mobSkill.ABSOLUTE_TERROR_1)
        table.insert(skillList, xi.mobSkill.HORRID_ROAR_1)
    end

    return skillList[math.random(1, #skillList)]
end

-----------------------------------
-- onMobDisengage - If in flight during disengage, exit flight
-----------------------------------
entity.onMobDisengage = function(mob)
    if mob:getAnimationSub() == 1 then
        exitFlight(mob)
        mob:setLocalVar('forceFlight', 1)
    end
end

return entity
