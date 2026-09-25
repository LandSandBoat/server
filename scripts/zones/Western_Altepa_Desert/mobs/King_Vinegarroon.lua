-----------------------------------
-- Area: Western Altepa Desert
--   NM: King Vinegarroon
-----------------------------------
---@type TMobEntity
local entity = {}

-- Table of single target skills KV will use after an AOE TP Move
local skillTable =
{
    [1] = xi.mobSkill.DEATH_SCISSORS,
    [2] = xi.mobSkill.CRITICAL_BITE,
    [3] = xi.mobSkill.VENOM_STING_1,
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
    mob:setRespawnTime(75600) -- Opens 21 hours after being defeated, or despawning.

    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)

    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)

    mob:addListener('WEATHER_CHANGE', 'KV_WEATHER_CHANGE', function(mobArg, weather, element)
        if not mobArg:isSpawned() then
            return
        end

        if mobArg:isEngaged() then
            return
        end

        if xi.data.element.getWeatherElement(element) ~= xi.element.EARTH then
            DespawnMob(mobArg:getID())
        end
    end)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.REGAIN, 35)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 250)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.PETRIFY, { chance = 100 })
end

entity.onMobRoam = function(mob)
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

entity.onMobSkillTarget = function(target, mob, mobskill)
    if mobskill:isAoE() then
        -- Chance for draw in to be single target or alliance
        if math.randomInt(0, 100) >= 50 then
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
        mob:useMobAbility(skillTable[math.randomInt(1, #skillTable)])
    end
end

entity.onMobDisengage = function(mob)
    if xi.data.element.getWeatherElement(mob:getWeather()) ~= xi.element.EARTH then
        DespawnMob(mob:getID())
    end
end

entity.onMobDeath = function(mob, player, optParams)
    if player then
        player:addTitle(xi.title.VINEGAR_EVAPORATOR)
    end
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(75600) -- Opens 21 hours after being defeated, or despawning.
end

return entity
