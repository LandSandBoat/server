-----------------------------------
-- Area: Grand Palace of Hu'Xzoi
--   NM: Jailer of Temperance
-----------------------------------
local huxzoiGlobal = require("scripts/zones/Grand_Palace_of_HuXzoi/globals")
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------
local entity = {}

local chargeOptic = function(mob)
    mob:SetAutoAttackEnabled(false)
    mob:SetMobAbilityEnabled(false)

    if mob:getLocalVar("opticInduration") == 1 then
        mob:setLocalVar("opticInduration", 0)
        mob:SetAutoAttackEnabled(true)
        mob:SetMobAbilityEnabled(true)
        mob:timer(3000, function(mobArg)
            mobArg:useMobAbility(1465) -- JoT will use another Optic Induration shortly after using the first one.
        end)
    end
end

entity.onMobSpawn = function(mob)
    -- Set AnimationSub to 0, put it in pot form
    -- Change it's damage resists. Pot for take
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            {
                id = xi.jsa.MEIKYO_SHISUI,
                hpp = math.random(65, 75),
                endCode = function(mobArg)
                    mobArg:setLocalVar("twoHour", 1)
                end
            },
        },
    })

    -- Change animation to pot
    mob:setAnimationSub(0)
    -- Set the damage resists
    mob:setMod(xi.mod.HTH_SDT, 1000)
    mob:setMod(xi.mod.SLASH_SDT, 0)
    mob:setMod(xi.mod.PIERCE_SDT, 0)
    mob:setMod(xi.mod.IMPACT_SDT, 1000)
    -- Set the magic resists. It always takes no damage from direct magic
    mob:setMod(xi.mod.DMGMAGIC, -99)
    mob:SetAutoAttackEnabled(true)
    mob:SetMobAbilityEnabled(true)
end

entity.onMobEngaged = function(mob, target)
    mob:setLocalVar("changeTime", 0)
end

entity.onMobFight = function(mob)
    -- Forms: 0 = Pot  1 = Pot  2 = Poles  3 = Rings
    local randomTime = math.random(30, 180)
    local changeTime = mob:getLocalVar("changeTime")
    local isBusy = false

    -- If we're in a pot form, but going to change to either Rings/Poles
    if ((mob:getAnimationSub() == 0 or mob:getAnimationSub() == 1) and mob:getBattleTime() - changeTime > randomTime) then
        local aniChange = math.random(2, 3)
        mob:setAnimationSub(aniChange)

        local act = mob:getCurrentAction()
        if
            act == xi.act.MOBABILITY_START or
            act == xi.act.MOBABILITY_USING or
            act == xi.act.MOBABILITY_FINISH
        then
            isBusy = true -- we don't want to change forms while charging optic induration
        end

        -- We changed to Poles. Make it only take piercing.
        if aniChange == 2 then
            mob:setMod(xi.mod.HTH_SDT, 0)
            mob:setMod(xi.mod.SLASH_SDT, 0)
            mob:setMod(xi.mod.PIERCE_SDT, 1000)
            mob:setMod(xi.mod.IMPACT_SDT, 0)
            mob:setLocalVar("changeTime", mob:getBattleTime())
        else -- We changed to Rings. Make it only take slashing.
            mob:setMod(xi.mod.HTH_SDT, 0)
            mob:setMod(xi.mod.SLASH_SDT, 1000)
            mob:setMod(xi.mod.PIERCE_SDT, 0)
            mob:setMod(xi.mod.IMPACT_SDT, 0)
            mob:setLocalVar("changeTime", mob:getBattleTime())
        end
    -- We're in poles, but changing
    elseif
        mob:getAnimationSub() == 2 and
        mob:getBattleTime() - changeTime > randomTime and
        not isBusy
    then
        local aniChange = math.random(0, 1)

        -- Changing to Pot, only take Blunt damage
        if aniChange == 0 then
            mob:setAnimationSub(0)
            mob:setMod(xi.mod.HTH_SDT, 1000)
            mob:setMod(xi.mod.SLASH_SDT, 0)
            mob:setMod(xi.mod.PIERCE_SDT, 0)
            mob:setMod(xi.mod.IMPACT_SDT, 1000)
            mob:setLocalVar("changeTime", mob:getBattleTime())
        else -- Going to Rings, only take slashing
            mob:setAnimationSub(3)
            mob:setMod(xi.mod.HTH_SDT, 0)
            mob:setMod(xi.mod.SLASH_SDT, 1000)
            mob:setMod(xi.mod.PIERCE_SDT, 0)
            mob:setMod(xi.mod.IMPACT_SDT, 0)
            mob:setLocalVar("changeTime", mob:getBattleTime())
        end
    -- We're in rings, but going to change to pot or poles
    elseif
        mob:getAnimationSub() == 3 and
        mob:getBattleTime() - changeTime > randomTime and
        not isBusy
    then
        local aniChange = math.random(0, 2)
        mob:setAnimationSub(aniChange)

        -- We're changing to pot form, only take blunt damage.
        if
            aniChange == 0 or
            aniChange == 1
        then
            mob:setMod(xi.mod.HTH_SDT, 1000)
            mob:setMod(xi.mod.SLASH_SDT, 0)
            mob:setMod(xi.mod.PIERCE_SDT, 0)
            mob:setMod(xi.mod.IMPACT_SDT, 1000)
            mob:setLocalVar("changeTime", mob:getBattleTime())
        else -- Changing to poles, only take piercing
            mob:setMod(xi.mod.HTH_SDT, 0)
            mob:setMod(xi.mod.SLASH_SDT, 0)
            mob:setMod(xi.mod.PIERCE_SDT, 1000)
            mob:setMod(xi.mod.IMPACT_SDT, 0)
            mob:setLocalVar("changeTime", mob:getBattleTime())
        end
    end

    if mob:getHPP() < 40 and mob:getLocalVar("twoHour") == 1 then -- Jailer of Temperance uses second two hour around 40%
        mob:useMobAbility(730)
        mob:setLocalVar("twoHour", 2)
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    local skillID = skill:getID()
    if skillID == 1465 then
        local opticCounter = mob:getLocalVar("opticCounter")

        opticCounter = opticCounter +1
        mob:setLocalVar("opticCounter", opticCounter)

        if opticCounter > 0 then
            mob:setLocalVar("opticCounter", 0)
            mob:setLocalVar("opticInduration", 1)
            chargeOptic(mob)
        end
    end
end

entity.onMobDeath = function(mob, player, isKiller)
end

entity.onMobDespawn = function(mob)
    local ph = mob:getLocalVar("ph")
    DisallowRespawn(mob:getID(), true)
    DisallowRespawn(ph, false)
    GetMobByID(ph):setRespawnTime(GetMobRespawnTime(ph))
    mob:setLocalVar("pop", os.time() + 900) -- 15 mins
    huxzoiGlobal.pickTemperancePH()
end

return entity
