-----------------------------------
-- Area: Western Altepa Desert (125)
--   NM: Celphie
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobWeaponSkill = function(target, mob, skill)
    -- Celphie gains strong regen after hundred fists wears
    if skill:getID() == xi.jsa.HUNDRED_FISTS then
        mob:setLocalVar('regenTime', os.time() + 45)
    end
end

entity.onMobFight = function(mob, target)
    local regenTimer = mob:getLocalVar('regenTime')
    if
        regenTimer < os.time() and
        regenTimer ~= 0 and
        mob:getMod(xi.mod.REGEN) == 0
    then
        mob:setMod(xi.mod.REGEN, 40)
    end
end

entity.onMobDespawn = function(mob)
    mob:setMod(xi.mod.REGEN, 0)
    UpdateNMSpawnPoint(mob:getID())
end

return entity
