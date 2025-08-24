-----------------------------------
-- Area: Western Altepa Desert (125)
--   NM: Celphie
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.WESTERN_ALTEPA_DESERT]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.CELPHIE - 1] = ID.mob.CELPHIE, -- 50.014 0.256 7.088
}

entity.onMobWeaponSkill = function(target, mob, skill)
    -- Celphie gains strong regen after hundred fists wears
    if skill:getID() == xi.jsa.HUNDRED_FISTS then
        mob:setLocalVar('regenTime', GetSystemTime() + 45)
    end
end

entity.onMobFight = function(mob, target)
    local regenTimer = mob:getLocalVar('regenTime')
    if
        regenTimer < GetSystemTime() and
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
