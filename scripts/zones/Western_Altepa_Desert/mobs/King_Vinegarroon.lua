-----------------------------------
-- Area: Western Altepa Desert
--   NM: King Vinegarroon
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -239.000, y = -0.226, z = -650.000 },
    { x = -261.324, y =  0.933, z = -637.908 },
    { x = -244.369, y =  0.020, z = -635.194 },
    { x = -224.005, y =  0.594, z = -648.294 },
    { x = -232.115, y =  0.192, z = -637.890 },
    { x = -228.974, y =  0.349, z = -641.211 },
    { x = -242.678, y =  0.092, z = -645.864 },
    { x = -233.937, y =  0.767, z = -655.708 },
    { x = -243.049, y =  0.613, z = -654.179 },
    { x = -261.630, y =  0.518, z = -630.288 },
    { x = -203.942, y =  0.728, z = -655.320 },
    { x = -256.311, y =  0.815, z = -642.751 },
    { x = -232.802, y =  0.158, z = -640.158 },
    { x = -240.441, y =  0.402, z = -652.088 },
    { x = -226.952, y =  0.226, z = -652.052 },
    { x = -229.016, y =  0.222, z = -648.687 },
    { x = -242.659, y =  0.955, z = -660.882 },
    { x = -225.576, y =  0.548, z = -659.382 },
    { x = -256.645, y =  0.468, z = -626.716 },
    { x = -226.979, y =  1.000, z = -665.418 },
    { x = -240.012, y =  0.808, z = -656.175 },
    { x = -227.395, y =  0.704, z = -661.855 },
    { x = -245.280, y =  0.461, z = -655.033 },
    { x = -260.260, y =  0.986, z = -640.404 },
    { x = -242.145, y =  0.827, z = -656.544 },
    { x = -209.696, y =  0.602, z = -656.084 },
    { x = -245.207, y =  0.059, z = -641.675 },
    { x = -232.252, y =  0.787, z = -661.674 },
    { x = -216.112, y =  0.144, z = -663.042 },
    { x = -228.641, y =  0.365, z = -644.196 },
    { x = -248.542, y = -0.021, z = -649.309 },
    { x = -245.147, y =  0.599, z = -626.252 },
    { x = -238.658, y =  0.817, z = -663.646 },
    { x = -240.234, y =  0.303, z = -650.101 },
    { x = -213.032, y =  0.493, z = -658.491 },
    { x = -221.848, y =  0.602, z = -655.343 },
    { x = -227.448, y =  0.165, z = -650.454 },
    { x = -223.500, y =  0.605, z = -656.289 },
    { x = -262.421, y =  0.478, z = -629.148 },
    { x = -206.680, y =  0.424, z = -651.336 },
    { x = -252.847, y =  0.235, z = -646.125 },
    { x = -250.837, y =  0.417, z = -630.897 },
    { x = -255.686, y =  0.602, z = -628.061 },
    { x = -237.494, y =  0.577, z = -613.816 },
    { x = -233.545, y =  0.121, z = -639.868 },
    { x = -244.574, y =  0.071, z = -646.048 },
    { x = -237.054, y =  0.964, z = -660.702 },
    { x = -208.925, y =  0.517, z = -661.646 },
    { x = -246.296, y =  0.036, z = -634.473 },
    { x = -238.409, y =  0.703, z = -664.933 }
}

local function mobRegen(mob)
    local hour = VanadielHour()

    if hour >= 6 and hour <= 20 then
        mob:setMod(xi.mod.REGEN, 150)
    else
        mob:setMod(xi.mod.REGEN, 300)
    end
end

entity.onMobInitialize = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(75600) -- Opens 21 hours after being defeated, or despawning.

    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)

    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.REGAIN, 35)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 250)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.PETRIFY, { chance = 100 })
end

entity.onMobRoam = function(mob)
    local weather = mob:getWeather()
    if
        weather ~= xi.weather.DUST_STORM and
        weather ~= xi.weather.SAND_STORM
    then
        DespawnMob(mob:getID())
    end

    mobRegen(mob)
end

entity.onMobFight = function(mob, target)
    local drawInTable =
    {
        conditions =
        {
            target:getZPos() > -540,
            target:getXPos() < -350,
        },
        position = mob:getPos(),
        wait = 3,
    }

    for _, condition in ipairs(drawInTable.conditions) do
        if condition then
            mob:setMobMod(xi.mobMod.NO_MOVE, 1)
            utils.drawIn(target, drawInTable)
            break
        else
            mob:setMobMod(xi.mobMod.NO_MOVE, 0)
        end
    end

    mobRegen(mob)
end

-- Table of single target skills KV will use after an AOE TP Move
local skillTable =
{
    [1] = xi.mobSkill.DEATH_SCISSORS,
    [2] = xi.mobSkill.CRITICAL_BITE,
    [3] = xi.mobSkill.VENOM_STING_1,
}

entity.onMobSkillTarget = function(target, mob, mobskill)
    if mobskill:isAoE() then
        -- Chance for draw in to be single target or alliance
        if math.random(0, 100) >= 50 then
            mob:drawIn()
        else
            -- If target is a pet, get the master for alliance lookup
            local allianceTarget = target
            if target:getObjType() ~= xi.objType.PC then
                local master = target:getMaster()
                if master and master:getObjType() == xi.objType.PC then
                    allianceTarget = master
                else
                    return
                end
            end

            for _, member in ipairs(allianceTarget:getAlliance()) do
                mob:drawIn(member, 0, 0)
            end
        end

        -- KV always does an AOE TP move followed by a single target TP move
        mob:useMobAbility(skillTable[math.random(1, #skillTable)])
    end
end

entity.onMobDeath = function(mob, player, optParams)
    if player then
        player:addTitle(xi.title.VINEGAR_EVAPORATOR)
    end
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(75600) -- Opens 21 hours after being defeated, or despawning.
end

return entity
