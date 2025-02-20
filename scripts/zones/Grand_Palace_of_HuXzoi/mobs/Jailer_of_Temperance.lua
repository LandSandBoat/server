-----------------------------------
-- Area: Grand Palace of Hu'Xzoi
--   NM: Jailer of Temperance
-----------------------------------
local huxzoiGlobal = require('scripts/zones/Grand_Palace_of_HuXzoi/globals')
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
end

entity.onMobSpawn = function(mob)
    -- Set AnimationSub to 0, put it in pot form
    -- Change it's damage resists. Pot for take

    -- Change animation to pot
    mob:setAnimationSub(0)
    -- Set the damage resists
    mob:setMod(xi.mod.HTH_SDT, 1000)
    mob:setMod(xi.mod.SLASH_SDT, 0)
    mob:setMod(xi.mod.PIERCE_SDT, 0)
    mob:setMod(xi.mod.IMPACT_SDT, 1000)

    -- Set the magic resists. It always takes no damage from direct magic
    for element = xi.element.FIRE, xi.element.DARK do
        mob:setMod(xi.combat.element.getElementalMEVAModifier(element), 0)
        mob:setMod(xi.combat.element.getElementalSDTModifier(element), 10000)
    end
end

entity.onMobFight = function(mob)
    -- Forms: 0 = Pot  1 = Pot  2 = Poles  3 = Rings
    local randomTime = math.random(30, 180)
    local changeTime = mob:getLocalVar('changeTime')

    -- If we're in a pot form, but going to change to either Rings/Poles
    if
        (mob:getAnimationSub() == 0 or mob:getAnimationSub() == 1) and
        mob:getBattleTime() - changeTime > randomTime
    then
        local aniChange = math.random(2, 3)
        mob:setAnimationSub(aniChange)

        -- We changed to Poles. Make it only take piercing.
        if aniChange == 2 then
            mob:setMod(xi.mod.HTH_SDT, 0)
            mob:setMod(xi.mod.SLASH_SDT, 0)
            mob:setMod(xi.mod.PIERCE_SDT, 1000)
            mob:setMod(xi.mod.IMPACT_SDT, 0)
            mob:setLocalVar('changeTime', mob:getBattleTime())
        else -- We changed to Rings. Make it only take slashing.
            mob:setMod(xi.mod.HTH_SDT, 0)
            mob:setMod(xi.mod.SLASH_SDT, 1000)
            mob:setMod(xi.mod.PIERCE_SDT, 0)
            mob:setMod(xi.mod.IMPACT_SDT, 0)
            mob:setLocalVar('changeTime', mob:getBattleTime())
        end
    -- We're in poles, but changing
    elseif
        mob:getAnimationSub() == 2 and
        mob:getBattleTime() - changeTime > randomTime
    then
        local aniChange = math.random(0, 1)

        -- Changing to Pot, only take Blunt damage
        if aniChange == 0 then
            mob:setAnimationSub(0)
            mob:setMod(xi.mod.HTH_SDT, 1000)
            mob:setMod(xi.mod.SLASH_SDT, 0)
            mob:setMod(xi.mod.PIERCE_SDT, 0)
            mob:setMod(xi.mod.IMPACT_SDT, 1000)
            mob:setLocalVar('changeTime', mob:getBattleTime())
        else -- Going to Rings, only take slashing
            mob:setAnimationSub(3)
            mob:setMod(xi.mod.HTH_SDT, 0)
            mob:setMod(xi.mod.SLASH_SDT, 1000)
            mob:setMod(xi.mod.PIERCE_SDT, 0)
            mob:setMod(xi.mod.IMPACT_SDT, 0)
            mob:setLocalVar('changeTime', mob:getBattleTime())
        end
    -- We're in rings, but going to change to pot or poles
    elseif
        mob:getAnimationSub() == 3 and
        mob:getBattleTime() - changeTime > randomTime
    then
        local aniChange = math.random(0, 2)
        mob:setAnimationSub(aniChange)

        -- We're changing to pot form, only take blunt damage.
        if aniChange == 0 or aniChange == 1 then
            mob:setMod(xi.mod.HTH_SDT, 1000)
            mob:setMod(xi.mod.SLASH_SDT, 0)
            mob:setMod(xi.mod.PIERCE_SDT, 0)
            mob:setMod(xi.mod.IMPACT_SDT, 1000)
            mob:setLocalVar('changeTime', mob:getBattleTime())
        else -- Changing to poles, only take piercing
            mob:setMod(xi.mod.HTH_SDT, 0)
            mob:setMod(xi.mod.SLASH_SDT, 0)
            mob:setMod(xi.mod.PIERCE_SDT, 1000)
            mob:setMod(xi.mod.IMPACT_SDT, 0)
            mob:setLocalVar('changeTime', mob:getBattleTime())
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    local ph = mob:getLocalVar('ph')
    DisallowRespawn(mob:getID(), true)
    DisallowRespawn(ph, false)
    GetMobByID(ph):setRespawnTime(GetMobRespawnTime(ph))
    mob:setLocalVar('pop', os.time() + 900) -- 15 mins
    huxzoiGlobal.pickTemperancePH()
end

return entity
