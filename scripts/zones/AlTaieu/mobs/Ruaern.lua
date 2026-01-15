-----------------------------------
-- Area: Al'Taieu
--   NM: Ru'aern
-- Note: Spawned by Rubious Crystals for PM 8-1
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

local function activateBracelets(mob)
    local originalAcc = mob:getLocalVar('originalACC')
    mob:setLocalVar('braceletTimer', GetSystemTime() + 30)
    mob:setAnimationSub(6)
    mob:setMod(xi.mod.ACC, originalAcc + 40)
    mob:setMod(xi.mod.ATTP, 30)
    mob:setMod(xi.mod.DELAYP, -33)
end

local function deactivateBracelets(mob)
    local originalAcc = mob:getLocalVar('originalACC')
    mob:setLocalVar('braceletTimer', GetSystemTime() + math.random(60, 80))
    mob:setAnimationSub(5)
    mob:setMod(xi.mod.ACC, originalAcc)
    mob:setMod(xi.mod.ATTP, 0)
    mob:setMod(xi.mod.DELAYP, 0)
end

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar('originalACC', mob:getMod(xi.mod.ACC))

    if mob:getAnimationSub() == 6 then
        deactivateBracelets(mob)
    end
end

entity.onMobEngage = function(mob, target)
    mob:setLocalVar('braceletTimer', GetSystemTime() + math.random(60, 80))
end

entity.onMobFight = function(mob, target)
    if xi.combat.behavior.isEntityBusy(mob) then
        return
    end

    if GetSystemTime() > mob:getLocalVar('braceletTimer') then
        if mob:getAnimationSub() == 5 then
            activateBracelets(mob)
        else
            deactivateBracelets(mob)
        end
    end
end

entity.onMobDisengage = function(mob)
    -- Reset bracelets when out of combat
    if mob:getAnimationSub() == 6 then
        deactivateBracelets(mob)
    end
end

return entity
