-----------------------------------
-- Area: The Garden of Ru'Hmet
--  Mob: Kf'ghrah WHM
-----------------------------------
local ID = zones[xi.zone.THE_GARDEN_OF_RUHMET]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
    mob:setMobMod(xi.mobMod.SUPERLINK, GetMobByID(ID.mob.JAILER_OF_FORTITUDE):getTargID())
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.PARALYZE)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:setMod(xi.mod.STORETP, 45)
end

entity.onMobSpawn = function(mob)
    -- Spawns in ball form.
    mob:setAutoAttackEnabled(false)
    mob:setMagicCastingEnabled(true)
    mob:setAnimationSub(0)
    mob:setLocalVar('desiredForm', 0)
end

entity.onMobFight = function(mob, target)
    local currentForm = mob:getAnimationSub()
    local desiredForm = mob:getLocalVar('desiredForm')

    -- If current form is the same as the desired form, do nothing.
    if currentForm == desiredForm then
        return
    end

    if desiredForm == 0 then -- Ball
        mob:setAutoAttackEnabled(false)
        mob:setMagicCastingEnabled(true)
        mob:setDelay(240)
        mob:setAnimationSub(0)
    elseif desiredForm == 2 then -- Spider
        mob:setAutoAttackEnabled(true)
        mob:setMagicCastingEnabled(false)
        mob:setDelay(240)
        mob:setAnimationSub(2)
    elseif desiredForm == 3 then -- Bird
        mob:setAutoAttackEnabled(true)
        mob:setMagicCastingEnabled(false)
        mob:setDelay(180)
        mob:setAnimationSub(3)
    end
end

return entity
