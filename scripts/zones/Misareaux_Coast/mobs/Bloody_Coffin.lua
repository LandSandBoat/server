-----------------------------------
-- Area: Misareaux Coast
-- Mob: Bloody Coffin
-- Quest NM "Call of the Sea"
-----------------------------------
---@type TMobEntity
local entity = {}

local function usingAbility(mob)
    local action = mob:getCurrentAction()
    if
        action == xi.action.MAGIC_CASTING or
        action == xi.action.MAGIC_FINISH or
        action == xi.action.MOBABILITY_START or
        action == xi.action.MOBABILITY_USING
    then
        return true
    end

    return false
end

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addMod(xi.mod.SPELLINTERRUPT, 100) -- Was not observed in multiple captures ever getting interrupted
end

entity.onMobFight = function(mob, target)
    if usingAbility(mob) then
        mob:setMod(xi.mod.UDMGMAGIC, 0)
        mob:setMod(xi.mod.UDMGPHYS, 0)
    else
        -- 75% Damage Reduction
        mob:setMod(xi.mod.UDMGMAGIC, -7500)
        mob:setMod(xi.mod.UDMGPHYS, -7500)
    end
end

return entity
