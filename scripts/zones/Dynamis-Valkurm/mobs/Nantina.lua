-----------------------------------
-- Area: Dynamis - Valkurm
--  Mob: Nantina
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:setMobSkillAttack(2011)
    mob:setLocalVar('nantina_skill_count', 0)
end

entity.onMobWeaponSkillPrepare = function(mob, target)
    -- Blow x9 > Uppercut x3 > Attractant
    local skillCount = mob:getLocalVar('nantina_skill_count')

    if skillCount < 9 then
        mob:setLocalVar('nantina_skill_count', skillCount + 1)

        return 1617 -- blow
    elseif skillCount < 12 then
        mob:setLocalVar('nantina_skill_count', skillCount + 1)

        return 1618 -- uppercut
    else
        mob:setLocalVar('nantina_skill_count', 0) -- Reset skill count

        return 1619 -- attractant
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
