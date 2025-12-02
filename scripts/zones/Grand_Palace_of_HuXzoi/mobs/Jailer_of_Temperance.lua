-----------------------------------
-- Area: Grand Palace of Hu'Xzoi
--   NM: Jailer of Temperance
-----------------------------------
local huxzoiGlobal = require('scripts/zones/Grand_Palace_of_HuXzoi/globals')
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

-- Damage resistance configurations
local resistConfigs = {
    [0] = { HTH = 0, SLASH = -10000, PIERCE = -10000, IMPACT = 0 }, -- Pot Idle
    [1] = { HTH = 0, SLASH = -10000, PIERCE = -10000, IMPACT = 0 }, -- Pot Combat
    [2] = { HTH = -10000, SLASH = -10000, PIERCE = 0, IMPACT = -10000 }, -- Poles
    [3] = { HTH = -10000, SLASH = 0, PIERCE = -10000, IMPACT = -10000 }  -- Rings
}

entity.spawnPoints =
{
    { x = -426.739, y = -0.500, z =  687.728 }
}

local function applyResistances(mob, form)
    local config = resistConfigs[form]
    mob:setMod(xi.mod.HTH_SDT, config.HTH)
    mob:setMod(xi.mod.SLASH_SDT, config.SLASH)
    mob:setMod(xi.mod.PIERCE_SDT, config.PIERCE)
    mob:setMod(xi.mod.IMPACT_SDT, config.IMPACT)
end

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.BLIND)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.ELEGY)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.PARALYZE)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:addImmunity(xi.immunity.SLOW)
    mob:addImmunity(xi.immunity.STUN)
    mob:addImmunity(xi.immunity.TERROR)
end

entity.onMobSpawn = function(mob)
    mob:addMobMod(xi.mobMod.WEAPON_BONUS, 13) -- 100 total weapon damage
    mob:addMod(xi.mod.EVA, 10)
    mob:addMod(xi.mod.MDEF, 20)
    mob:addMod(xi.mod.ATT, mob:getMod(xi.mod.ATT) * 0.65) -- Increase attack by 65%
    mob:delMod(xi.mod.DEF, 50)

    -- Change animation to pot
    mob:setAnimationSub(0)
    applyResistances(mob, 0)

    -- Two usages of Meikyo at specific HP thresholds
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.jsa.MEIKYO_SHISUI, hpp = math.random(65, 70) },
            { id = xi.jsa.MEIKYO_SHISUI, hpp = math.random(35, 40) },
        },
    })

    -- Set the magic resists. It always takes no damage from direct magic
    for element = xi.element.FIRE, xi.element.DARK do
        mob:setMod(xi.data.element.getElementalMEVAModifier(element), 0)
        mob:setMod(xi.data.element.getElementalSDTModifier(element), -10000)
    end

    mob:setLocalVar('changeTime', GetSystemTime() + math.random(30, 180))
end

entity.onMobFight = function(mob)
    local currentTime = GetSystemTime()
    local changeTime = mob:getLocalVar('changeTime')
    local currentForm = mob:getAnimationSub()

    -- Apply the form change
    if currentTime >= changeTime then
        local newForm = math.random(1, 3)

        while newForm == currentForm do
            newForm = math.random(1, 3)
        end

        -- Briefly transition to animationSub 1, then change to new form
        mob:setAnimationSub(1)

        -- Schedule the actual form change after a brief delay
        mob:timer(2000, function(mobArg)
            if mobArg then
                mobArg:setAnimationSub(newForm)
                applyResistances(mobArg, newForm)
            end
        end)

        mob:setLocalVar('changeTime', currentTime + math.random(30, 390))
    end
end

entity.onMobDespawn = function(mob)
    local ph = mob:getLocalVar('ph')
    DisallowRespawn(mob:getID(), true)
    DisallowRespawn(ph, false)
    GetMobByID(ph):setRespawnTime(GetMobRespawnTime(ph))
    mob:setLocalVar('pop', GetSystemTime() + 900) -- 15 mins
    huxzoiGlobal.pickTemperancePH()
end

return entity
