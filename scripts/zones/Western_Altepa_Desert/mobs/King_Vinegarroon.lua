-----------------------------------
-- Area: Western Altepa Desert
--   NM: King Vinegarroon
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/world")
require("scripts/globals/mobs")
require("scripts/globals/status")
local ID = require("scripts/zones/Western_Altepa_Desert/IDs")
-----------------------------------
local entity = {}

local updateRegen = function(mob)
    local hour = VanadielHour()
    local regen = mob:getMod(xi.mod.REGEN)

    if hour > 3 and hour < 20 then -- daytime between 4:00 and 20:00
        if regen ~= 125 then
            mob:setMod(xi.mod.REGEN, 125)
        end
    else
        if regen ~= 250 then
            mob:setMod(xi.mod.REGEN, 250)
        end
    end
end

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:addMod(xi.mod.REGAIN, 50)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.PETRIFY, { chance = 100 })
end

entity.onMobDisengage = function(mob, weather)
    if not (mob:getWeather() == xi.weather.DUST_STORM or mob:getWeather() == xi.weather.SAND_STORM) then
        DespawnMob(mob:getID())
    end
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.VINEGAR_EVAPORATOR)
end

entity.onMobWeaponSkill = function(target, mob, skill)
    local drawInWait = mob:getLocalVar("DrawInWait")

    -- Every time KV performs a TP move, he will draw in either his target or the entire alliance randomly
    if (skill:getID() == 354 or skill:getID() == 355 or skill:getID() == 722 or skill:getID() == 723) and os.time() > drawInWait then
        local chance = math.random(1, 2)
        if chance == 1 then
            mob:triggerDrawIn(mob, true, 1, 35, target)
        else
            mob:triggerDrawIn(mob, false, 1, 35, target)
        end

        -- KV always does an AOE TP move followed by a single target TP move
        mob:useMobAbility(({ 353, 350, 720 })[math.random(1, 3)])
        mob:setLocalVar("DrawInWait", os.time() + 2)
    end
end

entity.onMobDespawn = function(mob)
    local respawn = 75600
    SetServerVariable("KING_V_RESPAWN", os.time() + respawn) -- 21 hours
    xi.mob.nmTODPersist(mob, respawn)
    DisallowRespawn(mob:getID(), true)
end

entity.onMobFight = function(mob, target)
    updateRegen(mob)

    local drawInWait = mob:getLocalVar("DrawInWait")

    if target:getZPos() > -540 and os.time() > drawInWait then -- Northern Draw In
        local rot = target:getRotPos()
        target:setPos(target:getXPos(), target:getYPos(), -542, rot)
        mob:messageBasic(232, 0, 0, target)
        mob:setLocalVar("DrawInWait", os.time() + 2)
    elseif target:getXPos() < -350 and os.time() > drawInWait then  -- Southern Draw In
        local rot = target:getRotPos()
        target:setPos(-348, target:getYPos(), target:getZPos(), rot)
        mob:messageBasic(232, 0, 0, target)
        mob:setLocalVar("DrawInWait", os.time() + 2)
    end
end

entity.onMobRoam = function(mob)
    updateRegen(mob)

    if not (mob:getWeather() == xi.weather.DUST_STORM or mob:getWeather() == xi.weather.SAND_STORM) then
        DespawnMob(mob:getID())
    end
end

return entity
