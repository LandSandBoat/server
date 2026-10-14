-----------------------------------
-- Area: Western Altepa Desert (125)
--   NM: Celphie
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobWeaponSkill = function(mob, target, skill, action)
    -- Celphie gains strong regen after hundred fists wears
    if skill:getID() == xi.mobSkill.HUNDRED_FISTS_1 then
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
end

return entity
